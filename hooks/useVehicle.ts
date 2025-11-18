import { Prisma } from "@/generated/prisma/client";
import api from "@/lib/fetcher";
import { CreateVehicleSchema } from "@/schema/vehicleSchema";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useRouter } from "next/router";
import { toast } from "sonner";
import z from "zod";

type VehicleWithAsset = Prisma.VehicleGetPayload<{
  include: { asset: true };
}>;

// get all vehicle
export const useGetAllVehicle = () => {
  return useQuery<VehicleWithAsset[]>({
    queryKey: ["vehicles"],
    queryFn: async () => {
      const res = await api.get(`/vehicles`);
      return res.data.data;
    },
  });
};

// create Vehicle
export const useCreateVehicle = () => {
  const router = useRouter();
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (data: z.infer<typeof CreateVehicleSchema>) => {
      const res = await api.post(`/vehicles`, data);
      return res.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["vehicles"] });
      toast.success("Asset created successfully");
      router.push("/admin/assets?asset=chassis");
      setTimeout(() => {
        router.reload();
      }, 1000);
    },
    onError: () => {
      toast.error("Failed to create Asset");
    },
  });
};
