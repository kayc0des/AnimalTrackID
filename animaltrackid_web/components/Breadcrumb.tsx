import Link from "next/link";

export interface BreadcrumbProps {
    title: string;
}

const Breadcrumb = ({title}: BreadcrumbProps) => {
    return ( <div>
        <span className="text-2xl font-semibold u-text-black">{title}</span>
        <div className="flex items-center">
            <Link href="/">AnimalTrackID</Link>
            <span className="block mx-2 w-[5px] h-[5px] rounded-full bg-black">&nbsp;</span>
            <span className="u-text-primary">{title}</span>
        </div>
    </div> );
}
 
export default Breadcrumb;