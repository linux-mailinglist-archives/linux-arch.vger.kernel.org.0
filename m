Return-Path: <linux-arch+bounces-10210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09361A3B280
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 08:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8243B13F2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE11C2325;
	Wed, 19 Feb 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T5J3Utws"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE81C3C11;
	Wed, 19 Feb 2025 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950399; cv=none; b=mNknXk43p31fMZzw1d1xJZr72/ZsF0UzRpY/rgksvQx/wUvFVpNKzAoch/1v9pJgUxGIM9L/s/8rV7hM8rm4yZI231/+kOu05S/PJj1fhS31pa2HNY8ZqtbrilYFyWZE78ucgtvMqfSrXFi71ZJElyBtmRYB1QcH0PHzfhk+VSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950399; c=relaxed/simple;
	bh=Z3n7x6SnvMsPHVOiEXoNIRIljW6yVPEBvgfWeH7kiOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYASymWYzrbzfQ9Lp99qtPWJVTf68WRP4ZHBdwJVevcRwMzyroBCBJ1J5uU8Cc3CtY4z8og15UL/sd8nCpqbUtfZX6zV5MUTksIWzexiLUnQO/oHFjOhELW8pWee1sAqm6fEkB7XhDjOLzq6x/vPvbd9BDnpD+mFjrp2oNPrNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T5J3Utws; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7Wi4A002885;
	Wed, 19 Feb 2025 07:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MFnKFNb9jMXEzDrSQsUz5lOpmEOrxZ
	Yw2EdDJ3aUXXs=; b=T5J3UtwsyEg+dsJ1SDMdehm3hiBaxkNsRkQYYA4p4MxLHw
	bxYeiF2aJQCtuUp5FBJwQmDKE24uyPJLvSRKZZ8cJQlD7kB3WNl5Z1zyaDzn0y5p
	NLOkkC3K2mrO14KXGrLC7KM0SvqbTMn16iIjomtiLGRVip+eIfz+1XDKBDpEwZ/f
	k3M4HqT9EqwOptmG2BebgL0tJG1I+ENXt+s2wQqsOzKud9MYxa4XlWdhuc9/LNob
	T+AH6vp/sAqWKyJoAofDfVNY1Uf1ZgGvbMUAjNvOeY3EJmT2dviUtHvY9xqWLPKG
	PcdgULu3KRbIK4vhZSbOsgJSmUtAW2MXDW1Av3lg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0nr01j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:33:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J72mXe002364;
	Wed, 19 Feb 2025 07:33:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03x2s7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:33:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J7X5Lt41156976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 07:33:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A0020040;
	Wed, 19 Feb 2025 07:33:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11A9020043;
	Wed, 19 Feb 2025 07:33:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 07:33:04 +0000 (GMT)
Date: Wed, 19 Feb 2025 08:33:03 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-ORIG-GUID: m5ucgOXnZP2-CVF7bdX2ZteYDEClPNi4
X-Proofpoint-GUID: m5ucgOXnZP2-CVF7bdX2ZteYDEClPNi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=477
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190057

On Mon, Feb 17, 2025 at 07:08:28PM +0000, Matthew Wilcox (Oracle) wrote:
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
>  
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

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

