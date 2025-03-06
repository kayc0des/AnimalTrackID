import { Search } from "lucide-react";

const SearchInput = () => {
  return (
    <div>
      <div className="searchInputTwo w-[350px] bg-transparent p-4 rounded-lg border border-gray-200 flex items-center">
        <Search strokeWidth={1.3} />
        <input type="search" name="" placeholder="Search by username" id="" className="bg-transparent outline-none ps-2" />
      </div>
    </div>
  );
};

export default SearchInput;
