Return-Path: <linux-arch+bounces-10214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A2A3B72F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 10:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744857A6FC9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3E1C3C00;
	Wed, 19 Feb 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FBjrR0s/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A31C4A06;
	Wed, 19 Feb 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956073; cv=none; b=r5ehBYefZ1ixEnCBAVDDiRGbnNYI2LxRWlBba00vECgvwdMY4S77zFbM/IEh90UohzwGGYXg84MAZTnKQua3jsDJYqDoCklMb1al70y1WyyyBilLcXtLOFC/a2Hi8LJu/NQRRm90WXNoBtGIEC7M1kzEgLzPAgiSoYtJGXJsW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956073; c=relaxed/simple;
	bh=u01G88+/c6I9zCbNALfE0OVyAr6Ezaff9OvkymsU8pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk4EE4KQ4bChcAZeSyWt0S5z5bPkovhCGkwu+D0qaJ6/XEd3JpcbhwLBLjKB7syroR75wCY4k63mFFxp/gAzHyyNfpsvMO1SD1xT8qS2zyc1B6PMG7zBa36rUIT3qS6kQ2IEKh9BfCB1kCqQ7CP77dBZUvhSEvSxW+/u5KzIJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FBjrR0s/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7WiEE002845;
	Wed, 19 Feb 2025 09:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ryfr0CU36vN7+jmzrOyt57Ph/Uv1z6
	uRDIAhIKlsULY=; b=FBjrR0s/QNsCmVCSuEP7i/53obfYBs/I2MBFXEICWNjEdn
	vphgR3aGnO1T8iLmK+14DsPyJD9wxaoA+5CTGTw2OlLamCTD6VGjiHOtyWAlNFUN
	YYZT7jDNumAF75ada+/wnCkBpEf+xHbE6aRBBr6JoGc3G70rFk0ZHFDCiB1G3hsY
	gFead0eedT6XQdUW4gRJ+qAH+Ctnl9apL2VgAeZtfaEO7v9IbQEsiod6ytR8SWdf
	09SN3Aq4sBOGtYXleXw7UTeN8Yv5Li4l/2zbZtx3lFMl0gVuahhaKYehI8Nqoz/h
	jfofbcP0XgZjR4bt9907Vu+Z7aDMW9rthjW057JQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0nrdrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:07:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J70NCq005776;
	Wed, 19 Feb 2025 09:07:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xb5vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:07:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J97cMe50921894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:07:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE232004E;
	Wed, 19 Feb 2025 09:07:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AAA520040;
	Wed, 19 Feb 2025 09:07:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 09:07:38 +0000 (GMT)
Date: Wed, 19 Feb 2025 10:07:36 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 2/7] mm: Introduce a common definition of mk_pte()
Message-ID: <Z7WfWLAvX5fn90aN@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217190836.435039-3-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XeW0LQaSRH8r_Q5pce4tEmQwYdTmhkwx
X-Proofpoint-GUID: XeW0LQaSRH8r_Q5pce4tEmQwYdTmhkwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=547
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190071

On Mon, Feb 17, 2025 at 07:08:29PM +0000, Matthew Wilcox (Oracle) wrote:
> Most architectures simply call pfn_pte().  Centralise that as the normal
> definition and remove the definition of mk_pte() from the architectures
> which have either that exact definition or something similar.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
...
>  arch/s390/include/asm/pgtable.h          | 5 -----
...
>  include/linux/mm.h                       | 9 +++++++++
>  22 files changed, 10 insertions(+), 99 deletions(-)
> 
...
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3ee495b5171e..db932beabc87 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1449,11 +1449,6 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
>  	return pte_mkyoung(__pte);
>  }
>  
> -static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> -{
> -	return mk_pte_phys(page_to_phys(page), pgprot);
> -}
> -
>  #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
>  #define p4d_index(address) (((address) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
>  #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
...
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..3ef11ff3922f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1916,6 +1916,15 @@ static inline struct folio *pfn_folio(unsigned long pfn)
>  	return page_folio(pfn_to_page(pfn));
>  }
>  
> +#ifndef mk_pte
> +#ifdef CONFIG_MMU
> +static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> +{
> +	return pfn_pte(page_to_pfn(page), pgprot);
> +}
> +#endif
> +#endif
> +
>  /**
>   * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
>   * @folio: The folio.

For s390:

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

