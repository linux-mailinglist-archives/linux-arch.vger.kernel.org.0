Return-Path: <linux-arch+bounces-9598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E4A0230C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 11:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6773D3A4721
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BF1D517B;
	Mon,  6 Jan 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UNSjWw3i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1F2BAEC;
	Mon,  6 Jan 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159645; cv=none; b=OJz+oPKXLBfpUFOsNvZ/tdQMmV6uFHG3IFDFuugAfIwz5rnfa9gXiUCo7Js4ZOSyQwek2dWBHh9pU03fSGG92LrD72pywKBu9dwsKS6IYxYlPszooyvg89KnrU0FapyNLsKAkMBpanZUa7GldidGOG6f0ANjHyfGXtvvBFGbn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159645; c=relaxed/simple;
	bh=nzcOPOfstjKJI6V8ldWdOiXMruNTjZucXWDM21V/f7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3ZFqSaFIrDw2bFgTiX6CVWq3KASHx6aBiaXbfDPb3Z83lx/ByMAJ0ygJ1HQl9DMVlQ0rzu7NRLN73quOkHT+UdVI5w/m16o0IutM+VRNE5eKYU8/fl/J80F8+QFdUKHOPPG9jrbCQ+4Ee3LS4cYp+sClizic/L7FMxzJaLqhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UNSjWw3i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505NaE33006668;
	Mon, 6 Jan 2025 10:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=T/dIATF0B0cb2CjV4kpJjZfFPga/hC
	k4zk30iJIHW7w=; b=UNSjWw3irJn0V+Dm8j5t3FNW5/wXx/WChR9S+1E2fwnee6
	3YnxLlHQxOWH5zrs+0j3Lht+s4UrTI6g7Yg1KPB8FMCugDt75nNJJWZKMmbDbPht
	aD4e1ztejD6AY9RigrcvvmP08x+kE9ZPTuYPeo60tFTmnQ8k4Cpe4cZrulHW0baX
	bOFNUKH9z8P8+JW+mRFxmH7ld8nXAdzH+SB/wWVmxjkHXf+l7Q0PcRAwggyYoIXJ
	RPu2iCOjOnvWnlY1gzTc7zEiBMqw+MBx8ifutL9cQhg4trkc8IU7fa53qIVbDErN
	zLxsI17bxYOGqDtgLVqTsRSbTQbHdK5UUjCL9AUQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4403waj0t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:33:02 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506AX1FB005709;
	Mon, 6 Jan 2025 10:33:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4403waj0sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:33:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 506A0LB9008869;
	Mon, 6 Jan 2025 10:33:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyndxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:33:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506AWwE135127994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 10:32:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC1920049;
	Mon,  6 Jan 2025 10:32:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 535C720040;
	Mon,  6 Jan 2025 10:32:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 10:32:56 +0000 (GMT)
Date: Mon, 6 Jan 2025 11:32:54 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
        tglx@linutronix.de, david@redhat.com, jannh@google.com,
        hughd@google.com, yuzhao@google.com, willy@infradead.org,
        muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D
 level page table
Message-ID: <Z3uxVkg3i7zXI92e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3z7EZUf66yDmnmtJgcHtcRdfzcBMN59A
X-Proofpoint-ORIG-GUID: jOq3BOzX-nfrjMJZAlUBmLDYevP81AVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=650
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060093

On Mon, Dec 30, 2024 at 05:07:41PM +0800, Qi Zheng wrote:
> Like PMD and PTE level page table, also add statistics for PUD and P4D
> page table.
...
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index e95b2c8081eb8..b946964afce8e 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -110,24 +110,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>  	tlb_remove_ptdesc(tlb, pmd);
>  }
>  
> -/*
> - * p4d_free_tlb frees a pud table and clears the CRSTE for the
> - * region second table entry from the tlb.
> - * If the mm uses a four level page table the single p4d is freed
> - * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
> - * to avoid the double free of the p4d in this case.
> - */
> -static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> -				unsigned long address)
> -{
> -	if (mm_p4d_folded(tlb->mm))
> -		return;
> -	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> -	tlb->mm->context.flush_mm = 1;
> -	tlb->freed_tables = 1;
> -	tlb_remove_ptdesc(tlb, p4d);
> -}
> -
>  /*
>   * pud_free_tlb frees a pud table and clears the CRSTE for the
>   * region third table entry from the tlb.
> @@ -140,11 +122,30 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  {
>  	if (mm_pud_folded(tlb->mm))
>  		return;
> +	pagetable_pud_dtor(virt_to_ptdesc(pud));
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_p4ds = 1;
>  	tlb_remove_ptdesc(tlb, pud);
>  }
>  
> +/*
> + * p4d_free_tlb frees a p4d table and clears the CRSTE for the
> + * region second table entry from the tlb.
> + * If the mm uses a four level page table the single p4d is freed
> + * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
> + * to avoid the double free of the p4d in this case.
> + */
> +static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> +				unsigned long address)
> +{
> +	if (mm_p4d_folded(tlb->mm))
> +		return;
> +	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
> +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> +	tlb->mm->context.flush_mm = 1;
> +	tlb->freed_tables = 1;
> +	tlb_remove_ptdesc(tlb, p4d);
> +}

I understand that you want to sort p.._free_tlb() routines, but please
do not move the code around or make a separate follow-up patch.

Thanks!

