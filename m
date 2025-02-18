Return-Path: <linux-arch+bounces-10198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC7A3A2A9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8FF3B04BD
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADCB26F443;
	Tue, 18 Feb 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cq837tT1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E81A5B9F;
	Tue, 18 Feb 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895647; cv=none; b=JjzDsrlgrGK18+1PxjJZFxNG1aT3IXpz01D8Sd6ARhNDHyMjW8RmXFq7YuDYJCt4fAYuldTv8Redy54rx3faE0PnF/fYjGVAiGdr8TKQWeVkRCOrq2MKbCOpGl1ceEiRt8+IoJB2+5fXEXV81+6Kkw63+rvcR2ANhvFi4nuI4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895647; c=relaxed/simple;
	bh=oDz5UomVdEYONBQWvHCbIKbkgX7hvDglQwgo/HwFV/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgdb+5uD6D1tk7N+wQc0nxRW/Wkpud60NAtNSZC3+FjFoB4mN9RnPM+qmcHTsoCbrtdwANPT+oUBA0ZqZLXaYv26+ihi81DVVol1eYESEuFMZRFwybJGjD2BXS5Cj/T7+9Tm1quwMVYDWyj1iKLBDJoS2KmnCYLPjdSEbpjUQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cq837tT1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IG934F009895;
	Tue, 18 Feb 2025 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=psCROh/u4XmmWnXZwEf+kEObSVmJ4+
	iZ2KgCVphV0Bc=; b=Cq837tT1QEabHYlI9JkZ6FlnIMYHMyZWQHN+crU7BS2D7P
	EeImSs1ujqHvOsE9vgr1xvUMk9PbhHEbJdgMfpSQbu2TmqdxEj6lO1eSYViHbW5Y
	Xiom5hy7LO4i/BqYFt38C9nlWQJhP8VYuXnZAAKW1nIlOoPPEco27JwBgxv9ffR3
	NlIOfJv+iYVaEUrwQ1lMgkTJpvp+ngQ+8ipeGn0JF2qrJKa4yO5fecVy7mLOu5tE
	LEkHqfi1P0grKaZmha+Wt8mRFcyvPUJQLMOoTmXGw98I+fKkd7X21LFbm52G85pL
	2EPK0W1SQKJqqFC3oyXyG7bg6P7OIjZtHX2MOnWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpjhpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:20:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEEF6P013325;
	Tue, 18 Feb 2025 16:20:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkkuum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:20:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IGKV6B9109868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:20:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1775420043;
	Tue, 18 Feb 2025 16:20:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7297520040;
	Tue, 18 Feb 2025 16:20:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.88.119])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Feb 2025 16:20:30 +0000 (GMT)
Date: Tue, 18 Feb 2025 17:20:28 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217190836.435039-2-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KfuzgK7HnCFLppKRBSZ3W5dKc20FQNnF
X-Proofpoint-ORIG-GUID: KfuzgK7HnCFLppKRBSZ3W5dKc20FQNnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=290 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180116

On Mon, Feb 17, 2025 at 07:08:28PM +0000, Matthew Wilcox (Oracle) wrote:

Hi Matthew,

> If the first access to a folio is a read that is then followed by a
> write, we can save a page fault.  s390 implemented this in their
> mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
> bits"), but other architectures can also benefit from this.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/s390/include/asm/pgtable.h | 7 +------
>  mm/memory.c                     | 2 ++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3ca5af4cfe43..3ee495b5171e 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
>  
>  static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
>  {
> -	unsigned long physpage = page_to_phys(page);
> -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> -
> -	if (pte_write(__pte) && PageDirty(page))
> -		__pte = pte_mkdirty(__pte);
> -	return __pte;
> +	return mk_pte_phys(page_to_phys(page), pgprot);
>  }

With the above the implicit dirtifying of hugetlb PTEs (as result of
mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:

static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
		bool try_mkwrite)
{
	...
	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
					 vma->vm_page_prot)));
	} else {
		entry = huge_pte_wrprotect(mk_huge_pte(page,
					   vma->vm_page_prot));
	}
	...
}

What is your take on this?

>  #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..4330560eee55 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5124,6 +5124,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>  
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	else if (pte_write(entry) && folio_test_dirty(folio))
> +		entry = pte_mkdirty(entry);
>  	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
>  		entry = pte_mkuffd_wp(entry);
>  	/* copy-on-write page */

Thanks!

