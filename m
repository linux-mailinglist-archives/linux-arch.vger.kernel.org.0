Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967B8194518
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZRIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 13:08:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11492 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZRIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2020 13:08:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7ce16a0001>; Thu, 26 Mar 2020 10:07:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Mar 2020 10:08:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Mar 2020 10:08:41 -0700
Received: from [10.2.169.181] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 17:08:37 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <x86@kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] mm/debug: Add tests validating arch page table
 helpers for core features
Date:   Thu, 26 Mar 2020 13:08:34 -0400
X-Mailer: MailMate (1.13.1r5680)
Message-ID: <CEB780BF-ECB6-4304-8C04-3DCBAF931492@nvidia.com>
In-Reply-To: <5b188e44-73d5-673c-8df1-f2c42b556cf9@arm.com>
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
 <1585027375-9997-2-git-send-email-anshuman.khandual@arm.com>
 <89E72C74-A32F-4A5B-B5F3-8A63428507A5@nvidia.com>
 <5b188e44-73d5-673c-8df1-f2c42b556cf9@arm.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_2ACBE892-258B-474F-BA87-40148258F45E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585242475; bh=BwfOtD07idSpmJyy+vvL0tN3O7NJQEs+p7kB7u/XKe0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=XCHGyHXTrciWgn4hhrAArAkDizTNQ5oimD1MYGqqCVi9MwP/e19yTLd9sETkgDpy2
         WwCCnIGl9XY8oUofP95CbGwz2gKEai3i7yvHL1kHCCaq/F8xviikO3AlcQHDhNXWZV
         NYAiYM5+39HNU5efw66SB9d2cP8AGoA/RF6a1dplpFgnVpyNLDhH3VHdKLxE0sEWTO
         w2IdcvddX5jqXCtLrXpfEM/mC8ozh0jWxzjuKGVcFOrFpyYIPhTm/4EqSYZgcrMUoe
         TnZjOk7iVlWLNX83evNjzYxARN+95+Wb0QtZtoYqpT+Q1lqgp+0WEMVBgu4LQWk80n
         4jMAPs7pUcNUw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=_MailMate_2ACBE892-258B-474F-BA87-40148258F45E_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25 Mar 2020, at 22:18, Anshuman Khandual wrote:

> External email: Use caution opening links or attachments
>
>
> On 03/24/2020 06:59 PM, Zi Yan wrote:
>> On 24 Mar 2020, at 1:22, Anshuman Khandual wrote:
>>
>>> This adds new tests validating arch page table helpers for these foll=
owing
>>> core memory features. These tests create and test specific mapping ty=
pes at
>>> various page table levels.
>>>
>>> 1. SPECIAL mapping
>>> 2. PROTNONE mapping
>>> 3. DEVMAP mapping
>>> 4. SOFTDIRTY mapping
>>> 5. SWAP mapping
>>> 6. MIGRATION mapping
>>> 7. HUGETLB mapping
>>> 8. THP mapping
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: linux-snps-arc@lists.infradead.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-s390@vger.kernel.org
>>> Cc: linux-riscv@lists.infradead.org
>>> Cc: x86@kernel.org
>>> Cc: linux-arch@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  mm/debug_vm_pgtable.c | 291 ++++++++++++++++++++++++++++++++++++++++=
+-
>>>  1 file changed, 290 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 98990a515268..15055a8f6478 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -289,6 +289,267 @@ static void __init pmd_populate_tests(struct mm=
_struct *mm, pmd_t *pmdp,
>>>      WARN_ON(pmd_bad(pmd));
>>>  }
>>>
>>> +static void __init pte_special_tests(unsigned long pfn, pgprot_t pro=
t)
>>> +{
>>> +    pte_t pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
>>> +            return;
>>> +
>>> +    WARN_ON(!pte_special(pte_mkspecial(pte)));
>>> +}
>>> +
>>> +static void __init pte_protnone_tests(unsigned long pfn, pgprot_t pr=
ot)
>>> +{
>>> +    pte_t pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>>> +            return;
>>> +
>>> +    WARN_ON(!pte_protnone(pte));
>>> +    WARN_ON(!pte_present(pte));
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t pr=
ot)
>>> +{
>>> +    pmd_t pmd =3D pfn_pmd(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>>> +            return;
>>> +
>>> +    WARN_ON(!pmd_protnone(pmd));
>>> +    WARN_ON(!pmd_present(pmd));
>>> +}
>>> +#else
>>> +static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t pr=
ot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>>> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot=
)
>>> +{
>>> +    pte_t pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_devmap(pte_mkdevmap(pte)));
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot=
)
>>> +{
>>> +    pmd_t pmd =3D pfn_pmd(pfn, prot);
>>> +
>>> +    WARN_ON(!pmd_devmap(pmd_mkdevmap(pmd)));
>>> +}
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot=
)
>>> +{
>>> +    pud_t pud =3D pfn_pud(pfn, prot);
>>> +
>>> +    WARN_ON(!pud_devmap(pud_mkdevmap(pud)));
>>> +}
>>> +#else
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +#endif
>>> +#else
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +#endif
>>> +#else
>>> +static void __init pte_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +static void __init pmd_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +static void __init pud_devmap_tests(unsigned long pfn, pgprot_t prot=
) { }
>>> +#endif
>>> +
>>> +static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t =
prot)
>>> +{
>>> +    pte_t pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
>>> +            return;
>>> +
>>> +    WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
>>> +    WARN_ON(pte_soft_dirty(pte_clear_soft_dirty(pte)));
>>> +}
>>> +
>>> +static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgpr=
ot_t prot)
>>> +{
>>> +    pte_t pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
>>> +            return;
>>> +
>>> +    WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
>>> +    WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
>>> +}
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t =
prot)
>>> +{
>>> +    pmd_t pmd =3D pfn_pmd(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
>>> +            return;
>>> +
>>> +    WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
>>> +    WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
>>> +}
>>> +
>>> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgpr=
ot_t prot)
>>> +{
>>> +    pmd_t pmd =3D pfn_pmd(pfn, prot);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY) ||
>>> +            !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
>>> +            return;
>>> +
>>> +    WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
>>> +    WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
>>> +}
>>> +#else
>>> +static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t =
prot) { }
>>> +static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgpr=
ot_t prot)
>>> +{
>>> +}
>>> +#endif
>>> +
>>> +static void __init pte_swap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    swp_entry_t swp;
>>> +    pte_t pte;
>>> +
>>> +    pte =3D pfn_pte(pfn, prot);
>>> +    swp =3D __pte_to_swp_entry(pte);
>>> +    WARN_ON(!pte_same(pte, __swp_entry_to_pte(swp)));
>>> +}
>>> +
>>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    swp_entry_t swp;
>>> +    pmd_t pmd;
>>> +
>>> +    pmd =3D pfn_pmd(pfn, prot);
>>> +    swp =3D __pmd_to_swp_entry(pmd);
>>> +    WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
>>> +}
>>> +#else
>>> +static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) =
{ }
>>> +#endif
>>> +
>>> +static void __init swap_migration_tests(void)
>>> +{
>>> +    struct page *page;
>>> +    swp_entry_t swp;
>>> +
>>> +    if (!IS_ENABLED(CONFIG_MIGRATION))
>>> +            return;
>>> +    /*
>>> +     * swap_migration_tests() requires a dedicated page as it needs =
to
>>> +     * be locked before creating a migration entry from it. Locking =
the
>>> +     * page that actually maps kernel text ('start_kernel') can be r=
eal
>>> +     * problematic. Lets allocate a dedicated page explicitly for th=
is
>>> +     * purpose that will be freed subsequently.
>>> +     */
>>> +    page =3D alloc_page(GFP_KERNEL);
>>> +    if (!page) {
>>> +            pr_err("page allocation failed\n");
>>> +            return;
>>> +    }
>>> +
>>> +    /*
>>> +     * make_migration_entry() expects given page to be
>>> +     * locked, otherwise it stumbles upon a BUG_ON().
>>> +     */
>>> +    __SetPageLocked(page);
>>> +    swp =3D make_migration_entry(page, 1);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(!is_write_migration_entry(swp));
>>> +
>>> +    make_migration_entry_read(&swp);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(is_write_migration_entry(swp));
>>> +
>>> +    swp =3D make_migration_entry(page, 0);
>>> +    WARN_ON(!is_migration_entry(swp));
>>> +    WARN_ON(is_write_migration_entry(swp));
>>> +    __ClearPageLocked(page);
>>> +    __free_page(page);
>>> +}
>>> +
>>> +#ifdef CONFIG_HUGETLB_PAGE
>>> +static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t p=
rot)
>>> +{
>>> +    struct page *page;
>>> +    pte_t pte;
>>> +
>>> +    /*
>>> +     * Accessing the page associated with the pfn is safe here,
>>> +     * as it was previously derived from a real kernel symbol.
>>> +     */
>>> +    page =3D pfn_to_page(pfn);
>>> +    pte =3D mk_huge_pte(page, prot);
>>> +
>>> +    WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
>>> +    WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte)=
)));
>>> +    WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))=
));
>>> +
>>> +#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>>> +    pte =3D pfn_pte(pfn, prot);
>>> +
>>> +    WARN_ON(!pte_huge(pte_mkhuge(pte)));
>>> +#endif
>>> +}
>>> +#else
>>> +static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t p=
rot) { }
>>> +#endif
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static void __init pmd_thp_tests(unsigned long pfn, pgprot_t prot)
>>> +{
>>> +    pmd_t pmd;
>>> +
>>> +    /*
>>> +     * pmd_trans_huge() and pmd_present() must return positive
>>> +     * after MMU invalidation with pmd_mknotpresent().
>>> +     */
>>> +    pmd =3D pfn_pmd(pfn, prot);
>>> +    WARN_ON(!pmd_trans_huge(pmd_mkhuge(pmd)));
>>> +
>>> +#ifndef __HAVE_ARCH_PMDP_INVALIDATE
>>> +    WARN_ON(!pmd_trans_huge(pmd_mknotpresent(pmd_mkhuge(pmd))));
>>> +    WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd))));
>>> +#endif
>>
>> I think we need a better comment here, because requiring pmd_trans_hug=
e() and
>> pmd_present() returning true after pmd_mknotpresent() is not straightf=
orward.
>
> Thats right.
>
>>
>> According to Andrea Arcangeli=E2=80=99s email (https://lore.kernel.org=
/linux-mm/20181017020930.GN30832@redhat.com/),
>> This behavior is an optimization for transparent huge page.
>> pmd_trans_huge() must be true if pmd_page() returns you a valid THP to=
 avoid
>> taking the pmd_lock when others walk over non transhuge pmds (i.e. the=
re are no
>> THP allocated). Especially when we split a THP, removing the present b=
it from
>> the pmd, pmd_trans_huge() still needs to return true. pmd_present() sh=
ould
>> be true whenever pmd_trans_huge() returns true.
>
> Sure, will modify the existing comment here like this.
>
>         /*
>          * pmd_trans_huge() and pmd_present() must return positive afte=
r
>          * MMU invalidation with pmd_mknotpresent(). This behavior is a=
n
>          * optimization for transparent huge page. pmd_trans_huge() mus=
t
>          * be true if pmd_page() returns a valid THP to avoid taking th=
e
>          * pmd_lock when others walk over non transhuge pmds (i.e. ther=
e
>          * are no THP allocated). Especially when splitting a THP and
>          * removing the present bit from the pmd, pmd_trans_huge() stil=
l
>          * needs to return true. pmd_present() should be true whenever
>          * pmd_trans_huge() returns true.
>          */
>
>>
>> I think it is also worth either putting Andres=E2=80=99s email or the =
link to it
>> in the rst file in your 3rd patch. It is a good documentation for this=
 special
>> case.
>
> Makes sense. Will update Andrea's email link in the .rst file as well.
>

Look good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2ACBE892-258B-474F-BA87-40148258F45E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl584ZIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKdy4P/3ofw7nekR6lj+F67bUoA1kamVe7nB1GPlMF
gplxJACEyMz8W/H+UrHswz53iUk5KgB1Bbi1M2ZPJ7iYPGj0CvHyNTKqCMHHz0aW
Bokl7IHbH04B5ISX11DtWPe6BJvH0VU8rVoLAI4HIASjFm3MpyJ/ZfeO9b4/LInH
1P2gusknbYf2e8L7e5vm9miYGny0a9Tab2PQHB3CNRAORcyYUOON8z2Y3hZpuuXY
pZDvALP7JzmSlZVsvQvPzfnefIqj7tTOD5/lTEHC3Y1HDbwMKqzmTWqgehHm2nux
IkVja3DFoDDkRxxSYSH2hiBl5x0Z+qluDV9SAMZD6Jj3XGkpVrjgNAhlah6SXjGp
UjW1XnXCrsCGvF+UykRAVT02MopL+VdNBv4r66+Z8OEAV2olX3V2TdHzxwdITf7a
GL/dQ+I8di+wjOCqKHnfKBoqSHbP1P1P7UtRogKsXU47Fn4or1Uxqj/XB6TyYCYB
I0A1cIFWyIPO4TuvpGsHXM1IewapQWf4Pv4T4xPG0Fs9Gk4dKBstEbfxrATQ1wNr
OTliq9iSeRIhXnsAgENPcZjk1ZBGCw7ZdZ71eI5kZYmanGAoha+mONcnixD6aVQ8
mCyt/2qwFsNJ2ZmCGjvGHYbf6u0fkPSSVGzarakQyrkVfdfCy6LGBC1GIcP18lOD
ySDekypB
=GWeO
-----END PGP SIGNATURE-----

--=_MailMate_2ACBE892-258B-474F-BA87-40148258F45E_=--
