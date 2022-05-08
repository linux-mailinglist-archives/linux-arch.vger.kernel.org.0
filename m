Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE951ED4B
	for <lists+linux-arch@lfdr.de>; Sun,  8 May 2022 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiEHMFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 8 May 2022 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEHMFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 08:05:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9E22F;
        Sun,  8 May 2022 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652011316; x=1683547316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B29fm9Qc12WmthZtrBe2ibvFN8obi9nil9m3sX/y7iE=;
  b=AkBpyqXZU+4MjpGA56CJhuOkL0k2Mt+B36tuUOsb5KaXZwjtbiCOSbip
   24Gn0e/MPgRSRxECBX2GqfxqNdvtTHsHM66RgETaBOb/eglqVefOgkhlO
   R6Ew8XFDT9DL8G9gK7HuazaUDTIw4EJuZ/dE2JHbEvnWypCE/o8tmhjjx
   pP31Js/RvijVhbcU97/AjMAnJ2Yq5LeWMtclLUTY8Gdnr9bPMFb1e/Fw7
   Ghs3fM8ZqMzTQIfZnO8rCh/wBbhtCN54S8iWylAW2c0rXNbnHeqW5oawP
   dUk07EABFYvv575OIV0ISxUhyHhkFK4+cHa4A91EvrySIfIgfRUI4cUb1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="331841187"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="331841187"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 05:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="737688168"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2022 05:01:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnfbf-000FSd-Os;
        Sun, 08 May 2022 12:01:47 +0000
Date:   Sun, 8 May 2022 20:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     kbuild-all@lists.01.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue
 when migration
Message-ID: <202205081910.mStoC5rj-lkp@intel.com>
References: <1ec8a987be1a5400e077260a300d0079564b1472.1652002221.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec8a987be1a5400e077260a300d0079564b1472.1652002221.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Baolin,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220506]
[cannot apply to hnaz-mm/master arm64/for-next/core linus/master v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220508-174036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220508/202205081910.mStoC5rj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/907981b27213707fdb2f8a24c107d6752a09a773
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baolin-Wang/Fix-CONT-PTE-PMD-size-hugetlb-issue-when-unmapping-or-migrating/20220508-174036
        git checkout 907981b27213707fdb2f8a24c107d6752a09a773
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/rmap.c: In function 'try_to_migrate_one':
>> mm/rmap.c:1931:34: error: implicit declaration of function 'huge_ptep_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
    1931 |                         pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
         |                                  ^~~~~~~~~~~~~~~~~~~~~
         |                                  ptep_clear_flush
>> mm/rmap.c:1931:34: error: incompatible types when assigning to type 'pte_t' from type 'int'
>> mm/rmap.c:2023:41: error: implicit declaration of function 'set_huge_pte_at'; did you mean 'set_huge_swap_pte_at'? [-Werror=implicit-function-declaration]
    2023 |                                         set_huge_pte_at(mm, address, pvmw.pte, pteval);
         |                                         ^~~~~~~~~~~~~~~
         |                                         set_huge_swap_pte_at
   cc1: some warnings being treated as errors


vim +1931 mm/rmap.c

  1883	
  1884			/* Unexpected PMD-mapped THP? */
  1885			VM_BUG_ON_FOLIO(!pvmw.pte, folio);
  1886	
  1887			subpage = folio_page(folio,
  1888					pte_pfn(*pvmw.pte) - folio_pfn(folio));
  1889			address = pvmw.address;
  1890			anon_exclusive = folio_test_anon(folio) &&
  1891					 PageAnonExclusive(subpage);
  1892	
  1893			if (folio_test_hugetlb(folio)) {
  1894				/*
  1895				 * huge_pmd_unshare may unmap an entire PMD page.
  1896				 * There is no way of knowing exactly which PMDs may
  1897				 * be cached for this mm, so we must flush them all.
  1898				 * start/end were already adjusted above to cover this
  1899				 * range.
  1900				 */
  1901				flush_cache_range(vma, range.start, range.end);
  1902	
  1903				if (!folio_test_anon(folio)) {
  1904					/*
  1905					 * To call huge_pmd_unshare, i_mmap_rwsem must be
  1906					 * held in write mode.  Caller needs to explicitly
  1907					 * do this outside rmap routines.
  1908					 */
  1909					VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
  1910	
  1911					if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
  1912						flush_tlb_range(vma, range.start, range.end);
  1913						mmu_notifier_invalidate_range(mm, range.start,
  1914									      range.end);
  1915	
  1916						/*
  1917						 * The ref count of the PMD page was dropped
  1918						 * which is part of the way map counting
  1919						 * is done for shared PMDs.  Return 'true'
  1920						 * here.  When there is no other sharing,
  1921						 * huge_pmd_unshare returns false and we will
  1922						 * unmap the actual page and drop map count
  1923						 * to zero.
  1924						 */
  1925						page_vma_mapped_walk_done(&pvmw);
  1926						break;
  1927					}
  1928				}
  1929	
  1930				/* Nuke the hugetlb page table entry */
> 1931				pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
  1932			} else {
  1933				flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
  1934				/* Nuke the page table entry. */
  1935				pteval = ptep_clear_flush(vma, address, pvmw.pte);
  1936			}
  1937	
  1938			/* Set the dirty flag on the folio now the pte is gone. */
  1939			if (pte_dirty(pteval))
  1940				folio_mark_dirty(folio);
  1941	
  1942			/* Update high watermark before we lower rss */
  1943			update_hiwater_rss(mm);
  1944	
  1945			if (folio_is_zone_device(folio)) {
  1946				unsigned long pfn = folio_pfn(folio);
  1947				swp_entry_t entry;
  1948				pte_t swp_pte;
  1949	
  1950				if (anon_exclusive)
  1951					BUG_ON(page_try_share_anon_rmap(subpage));
  1952	
  1953				/*
  1954				 * Store the pfn of the page in a special migration
  1955				 * pte. do_swap_page() will wait until the migration
  1956				 * pte is removed and then restart fault handling.
  1957				 */
  1958				entry = pte_to_swp_entry(pteval);
  1959				if (is_writable_device_private_entry(entry))
  1960					entry = make_writable_migration_entry(pfn);
  1961				else if (anon_exclusive)
  1962					entry = make_readable_exclusive_migration_entry(pfn);
  1963				else
  1964					entry = make_readable_migration_entry(pfn);
  1965				swp_pte = swp_entry_to_pte(entry);
  1966	
  1967				/*
  1968				 * pteval maps a zone device page and is therefore
  1969				 * a swap pte.
  1970				 */
  1971				if (pte_swp_soft_dirty(pteval))
  1972					swp_pte = pte_swp_mksoft_dirty(swp_pte);
  1973				if (pte_swp_uffd_wp(pteval))
  1974					swp_pte = pte_swp_mkuffd_wp(swp_pte);
  1975				set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
  1976				trace_set_migration_pte(pvmw.address, pte_val(swp_pte),
  1977							compound_order(&folio->page));
  1978				/*
  1979				 * No need to invalidate here it will synchronize on
  1980				 * against the special swap migration pte.
  1981				 *
  1982				 * The assignment to subpage above was computed from a
  1983				 * swap PTE which results in an invalid pointer.
  1984				 * Since only PAGE_SIZE pages can currently be
  1985				 * migrated, just set it to page. This will need to be
  1986				 * changed when hugepage migrations to device private
  1987				 * memory are supported.
  1988				 */
  1989				subpage = &folio->page;
  1990			} else if (PageHWPoison(subpage)) {
  1991				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  1992				if (folio_test_hugetlb(folio)) {
  1993					hugetlb_count_sub(folio_nr_pages(folio), mm);
  1994					set_huge_swap_pte_at(mm, address,
  1995							     pvmw.pte, pteval,
  1996							     vma_mmu_pagesize(vma));
  1997				} else {
  1998					dec_mm_counter(mm, mm_counter(&folio->page));
  1999					set_pte_at(mm, address, pvmw.pte, pteval);
  2000				}
  2001	
  2002			} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
  2003				/*
  2004				 * The guest indicated that the page content is of no
  2005				 * interest anymore. Simply discard the pte, vmscan
  2006				 * will take care of the rest.
  2007				 * A future reference will then fault in a new zero
  2008				 * page. When userfaultfd is active, we must not drop
  2009				 * this page though, as its main user (postcopy
  2010				 * migration) will not expect userfaults on already
  2011				 * copied pages.
  2012				 */
  2013				dec_mm_counter(mm, mm_counter(&folio->page));
  2014				/* We have to invalidate as we cleared the pte */
  2015				mmu_notifier_invalidate_range(mm, address,
  2016							      address + PAGE_SIZE);
  2017			} else {
  2018				swp_entry_t entry;
  2019				pte_t swp_pte;
  2020	
  2021				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
  2022					if (folio_test_hugetlb(folio))
> 2023						set_huge_pte_at(mm, address, pvmw.pte, pteval);
  2024					else
  2025						set_pte_at(mm, address, pvmw.pte, pteval);
  2026					ret = false;
  2027					page_vma_mapped_walk_done(&pvmw);
  2028					break;
  2029				}
  2030				VM_BUG_ON_PAGE(pte_write(pteval) && folio_test_anon(folio) &&
  2031					       !anon_exclusive, subpage);
  2032				if (anon_exclusive &&
  2033				    page_try_share_anon_rmap(subpage)) {
  2034					if (folio_test_hugetlb(folio))
  2035						set_huge_pte_at(mm, address, pvmw.pte, pteval);
  2036					else
  2037						set_pte_at(mm, address, pvmw.pte, pteval);
  2038					ret = false;
  2039					page_vma_mapped_walk_done(&pvmw);
  2040					break;
  2041				}
  2042	
  2043				/*
  2044				 * Store the pfn of the page in a special migration
  2045				 * pte. do_swap_page() will wait until the migration
  2046				 * pte is removed and then restart fault handling.
  2047				 */
  2048				if (pte_write(pteval))
  2049					entry = make_writable_migration_entry(
  2050								page_to_pfn(subpage));
  2051				else if (anon_exclusive)
  2052					entry = make_readable_exclusive_migration_entry(
  2053								page_to_pfn(subpage));
  2054				else
  2055					entry = make_readable_migration_entry(
  2056								page_to_pfn(subpage));
  2057	
  2058				swp_pte = swp_entry_to_pte(entry);
  2059				if (pte_soft_dirty(pteval))
  2060					swp_pte = pte_swp_mksoft_dirty(swp_pte);
  2061				if (pte_uffd_wp(pteval))
  2062					swp_pte = pte_swp_mkuffd_wp(swp_pte);
  2063				if (folio_test_hugetlb(folio))
  2064					set_huge_swap_pte_at(mm, address, pvmw.pte,
  2065							     swp_pte, vma_mmu_pagesize(vma));
  2066				else
  2067					set_pte_at(mm, address, pvmw.pte, swp_pte);
  2068				trace_set_migration_pte(address, pte_val(swp_pte),
  2069							compound_order(&folio->page));
  2070				/*
  2071				 * No need to invalidate here it will synchronize on
  2072				 * against the special swap migration pte.
  2073				 */
  2074			}
  2075	
  2076			/*
  2077			 * No need to call mmu_notifier_invalidate_range() it has be
  2078			 * done above for all cases requiring it to happen under page
  2079			 * table lock before mmu_notifier_invalidate_range_end()
  2080			 *
  2081			 * See Documentation/vm/mmu_notifier.rst
  2082			 */
  2083			page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
  2084			if (vma->vm_flags & VM_LOCKED)
  2085				mlock_page_drain_local();
  2086			folio_put(folio);
  2087		}
  2088	
  2089		mmu_notifier_invalidate_range_end(&range);
  2090	
  2091		return ret;
  2092	}
  2093	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
