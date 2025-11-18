import AssetForm from "@/components/assets/AssetForm";
import AdminLayout from "@/components/layout/admin";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

const CreateAssetPage: React.FC = () => {
  return (
    <AdminLayout>
      <div className="grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-3">
        <Card className="w-full">
          <CardHeader>
            <CardTitle>Tambah Aset</CardTitle>
          </CardHeader>
          <CardContent>
            <AssetForm />
          </CardContent>
        </Card>
      </div>
    </AdminLayout>
  );
};

export default CreateAssetPage;
