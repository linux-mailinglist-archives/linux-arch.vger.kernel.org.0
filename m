Return-Path: <linux-arch+bounces-15686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB4ECFD05F
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C0B300AB35
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73542FFDE3;
	Wed,  7 Jan 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpLvpO0F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A842FD1DC;
	Wed,  7 Jan 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779226; cv=none; b=kkmBvsrT04QEL/DJNGHoXjfF5G7ATrSVH/wBJyUNBsLtCo++ygHyerC/ofhFZ3Kfl6KyLruitWLB3meDlGV4Q0+DWV/kLGG4iG0WsUznLGtFWTQjlTG1I/btNYdIv0VX7EFDKYRhCpk+c2OqT1Ym46Qd1YoVRKXCkazrbrOtgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779226; c=relaxed/simple;
	bh=a83o+wX7r90L4ywH9PsTkkN4tbWjpPaE9B8Y5qgLNgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLd97EWEwv92ggPQus95aACnnPPWATtKiSfNFqfC05wLXCxVCKcn1btXxeZ8YkOOQPRDVFM/v/86n7/0Cjq9Bm+tO65rniCkiWFVSTgT9xeF6SOgjKlgrUm+07ek0inswsb/ru7g6mcl9hDvetaflHL3rHS6G+/ncC6WeXhula4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpLvpO0F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767779225; x=1799315225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a83o+wX7r90L4ywH9PsTkkN4tbWjpPaE9B8Y5qgLNgE=;
  b=LpLvpO0FbMnjCeZG7Y8CiIhwI054s5+GRBtkv4R4Q6N/a/fi/ouXwB2M
   1nnwBebep1kb/NgYMjGEqrtO5d12/jfTDK0J0L1C2OMqxkafrqYt9fiW9
   nfGz4gBy/G6qIR0Vhqlhkwy8mnMbd3eCU1g/BNrhAsRjbLTMhlB8s60yT
   lZDRZV5Dv5DqY6Lu0AW+zm+jIrl+m3A37yAEKjaAyuDny59OpGqa5lXTQ
   reNYRPW0hmFmUdCMY3hhm5oEWDkwPFaDPd/YVspIkSCwPnmmc8IlIAqZZ
   Shr3o1dEbs4LgYDtqBgXR01Jw/nkQqfcPJybLMoH9gofMIswHhA8Ge/hx
   A==;
X-CSE-ConnectionGUID: 6vH4R3ulRqSl9KGEnhtFHw==
X-CSE-MsgGUID: BI+Vy6EnQd+K+MVDz5bI8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69194214"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="69194214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 01:47:04 -0800
X-CSE-ConnectionGUID: jZSHIXi8QfuiQFR7GjwoYQ==
X-CSE-MsgGUID: tChYKJK2Qp6DUXgcZ++UGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="202899201"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 07 Jan 2026 01:46:57 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdQ7y-000000001Xg-3SbX;
	Wed, 07 Jan 2026 09:46:54 +0000
Date: Wed, 7 Jan 2026 10:46:12 +0100
From: kernel test robot <lkp@intel.com>
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, david@kernel.org, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com,
	riel@surriel.com, jannh@google.com, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	ioworker0@gmail.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH RESEND v3 2/2] mm: introduce pmdp_collapse_flush_sync()
 to skip redundant IPI
Message-ID: <202601071005.oEsmtf0J-lkp@intel.com>
References: <20260106120303.38124-3-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106120303.38124-3-lance.yang@linux.dev>

Hi Lance,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20260107]
[cannot apply to tip/x86/core tip/x86/mm arnd-asm-generic/master linus/master v6.19-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lance-Yang/mm-tlb-skip-redundant-IPI-when-TLB-flush-already-synchronized/20260106-200505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260106120303.38124-3-lance.yang%40linux.dev
patch subject: [PATCH RESEND v3 2/2] mm: introduce pmdp_collapse_flush_sync() to skip redundant IPI
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260107/202601071005.oEsmtf0J-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260107/202601071005.oEsmtf0J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601071005.oEsmtf0J-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/khugepaged.c: In function 'collapse_huge_page':
>> mm/khugepaged.c:1180:16: error: implicit declaration of function 'pmdp_collapse_flush_sync'; did you mean 'pmdp_collapse_flush'? [-Wimplicit-function-declaration]
    1180 |         _pmd = pmdp_collapse_flush_sync(vma, address, pmd);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                pmdp_collapse_flush


vim +1180 mm/khugepaged.c

  1092	
  1093	static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long address,
  1094						   int referenced, int unmapped,
  1095						   struct collapse_control *cc)
  1096	{
  1097		LIST_HEAD(compound_pagelist);
  1098		pmd_t *pmd, _pmd;
  1099		pte_t *pte;
  1100		pgtable_t pgtable;
  1101		struct folio *folio;
  1102		spinlock_t *pmd_ptl, *pte_ptl;
  1103		enum scan_result result = SCAN_FAIL;
  1104		struct vm_area_struct *vma;
  1105		struct mmu_notifier_range range;
  1106	
  1107		VM_BUG_ON(address & ~HPAGE_PMD_MASK);
  1108	
  1109		/*
  1110		 * Before allocating the hugepage, release the mmap_lock read lock.
  1111		 * The allocation can take potentially a long time if it involves
  1112		 * sync compaction, and we do not need to hold the mmap_lock during
  1113		 * that. We will recheck the vma after taking it again in write mode.
  1114		 */
  1115		mmap_read_unlock(mm);
  1116	
  1117		result = alloc_charge_folio(&folio, mm, cc);
  1118		if (result != SCAN_SUCCEED)
  1119			goto out_nolock;
  1120	
  1121		mmap_read_lock(mm);
  1122		result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
  1123		if (result != SCAN_SUCCEED) {
  1124			mmap_read_unlock(mm);
  1125			goto out_nolock;
  1126		}
  1127	
  1128		result = find_pmd_or_thp_or_none(mm, address, &pmd);
  1129		if (result != SCAN_SUCCEED) {
  1130			mmap_read_unlock(mm);
  1131			goto out_nolock;
  1132		}
  1133	
  1134		if (unmapped) {
  1135			/*
  1136			 * __collapse_huge_page_swapin will return with mmap_lock
  1137			 * released when it fails. So we jump out_nolock directly in
  1138			 * that case.  Continuing to collapse causes inconsistency.
  1139			 */
  1140			result = __collapse_huge_page_swapin(mm, vma, address, pmd,
  1141							     referenced);
  1142			if (result != SCAN_SUCCEED)
  1143				goto out_nolock;
  1144		}
  1145	
  1146		mmap_read_unlock(mm);
  1147		/*
  1148		 * Prevent all access to pagetables with the exception of
  1149		 * gup_fast later handled by the ptep_clear_flush and the VM
  1150		 * handled by the anon_vma lock + PG_lock.
  1151		 *
  1152		 * UFFDIO_MOVE is prevented to race as well thanks to the
  1153		 * mmap_lock.
  1154		 */
  1155		mmap_write_lock(mm);
  1156		result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
  1157		if (result != SCAN_SUCCEED)
  1158			goto out_up_write;
  1159		/* check if the pmd is still valid */
  1160		vma_start_write(vma);
  1161		result = check_pmd_still_valid(mm, address, pmd);
  1162		if (result != SCAN_SUCCEED)
  1163			goto out_up_write;
  1164	
  1165		anon_vma_lock_write(vma->anon_vma);
  1166	
  1167		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
  1168					address + HPAGE_PMD_SIZE);
  1169		mmu_notifier_invalidate_range_start(&range);
  1170	
  1171		pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
  1172		/*
  1173		 * This removes any huge TLB entry from the CPU so we won't allow
  1174		 * huge and small TLB entries for the same virtual address to
  1175		 * avoid the risk of CPU bugs in that area.
  1176		 *
  1177		 * Parallel GUP-fast is fine since GUP-fast will back off when
  1178		 * it detects PMD is changed.
  1179		 */
> 1180		_pmd = pmdp_collapse_flush_sync(vma, address, pmd);
  1181		spin_unlock(pmd_ptl);
  1182		mmu_notifier_invalidate_range_end(&range);
  1183	
  1184		pte = pte_offset_map_lock(mm, &_pmd, address, &pte_ptl);
  1185		if (pte) {
  1186			result = __collapse_huge_page_isolate(vma, address, pte, cc,
  1187							      &compound_pagelist);
  1188			spin_unlock(pte_ptl);
  1189		} else {
  1190			result = SCAN_NO_PTE_TABLE;
  1191		}
  1192	
  1193		if (unlikely(result != SCAN_SUCCEED)) {
  1194			if (pte)
  1195				pte_unmap(pte);
  1196			spin_lock(pmd_ptl);
  1197			BUG_ON(!pmd_none(*pmd));
  1198			/*
  1199			 * We can only use set_pmd_at when establishing
  1200			 * hugepmds and never for establishing regular pmds that
  1201			 * points to regular pagetables. Use pmd_populate for that
  1202			 */
  1203			pmd_populate(mm, pmd, pmd_pgtable(_pmd));
  1204			spin_unlock(pmd_ptl);
  1205			anon_vma_unlock_write(vma->anon_vma);
  1206			goto out_up_write;
  1207		}
  1208	
  1209		/*
  1210		 * All pages are isolated and locked so anon_vma rmap
  1211		 * can't run anymore.
  1212		 */
  1213		anon_vma_unlock_write(vma->anon_vma);
  1214	
  1215		result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
  1216						   vma, address, pte_ptl,
  1217						   &compound_pagelist);
  1218		pte_unmap(pte);
  1219		if (unlikely(result != SCAN_SUCCEED))
  1220			goto out_up_write;
  1221	
  1222		/*
  1223		 * The smp_wmb() inside __folio_mark_uptodate() ensures the
  1224		 * copy_huge_page writes become visible before the set_pmd_at()
  1225		 * write.
  1226		 */
  1227		__folio_mark_uptodate(folio);
  1228		pgtable = pmd_pgtable(_pmd);
  1229	
  1230		spin_lock(pmd_ptl);
  1231		BUG_ON(!pmd_none(*pmd));
  1232		pgtable_trans_huge_deposit(mm, pmd, pgtable);
  1233		map_anon_folio_pmd_nopf(folio, pmd, vma, address);
  1234		spin_unlock(pmd_ptl);
  1235	
  1236		folio = NULL;
  1237	
  1238		result = SCAN_SUCCEED;
  1239	out_up_write:
  1240		mmap_write_unlock(mm);
  1241	out_nolock:
  1242		if (folio)
  1243			folio_put(folio);
  1244		trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
  1245		return result;
  1246	}
  1247	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

