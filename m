Return-Path: <linux-arch+bounces-9840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71AA18210
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DBB188A314
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B11F3FFD;
	Tue, 21 Jan 2025 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fz8cQTU8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF01F03D8;
	Tue, 21 Jan 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477460; cv=none; b=utX4/wrKEjtobppy6bhePAdpdhNMPzO3eXK43K/m3vHX2BMbXaMpmaYL+dP9G+KPR0Y7nmNQGUzveVxuRkXA2z1xPYzWrWSvGOASVlbLAnWz7/rjL1FUgsUys3FmSVF3DdSOvsBl152NV5rJOTyvd+cqp/MhmOKvs2wDVqab6JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477460; c=relaxed/simple;
	bh=2Bll/kQz90Tn4jHBA7WS0kX/UcVPGVgEgqRQA0g7Tpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2qRHTE5M7Muz8YWu9hYK5Fm/jDogKAJbRyNmo9T4eqKPTyJtpkgttJg9hpXvBEvlEcA8n/ZezfjIB0AxKmixVJmdvNjrJ5T86U4KnRMLvspXxMxkVoS4dZZCtlS7ewFK0JJQ2YMn9qT2erDc0ShA1u8X7urf0APZ9XNag7QtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fz8cQTU8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFdu2e007924;
	Tue, 21 Jan 2025 16:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rk7YrE6UBezqaR/fdDYkZZ8HhhiqPd
	u23Nnd1oC9law=; b=fz8cQTU8PvP8JVPbKU6Ynem/RjPPMY4uzRJefS9/1Tx/qT
	LzhhVSjzTVTggodrGdoC7U7DKDLLylgyhVs2FXbeQ7/tfYw6bKUuWYwWuOif/J55
	axSnjLRVcxlX4rVFmGjI9yaNmgps2TdyXZGRxYJBxyypnf4KKtSpIijUn0tx2sG2
	UQkEtTDltlKN8Af1rd91bT/prAvISQdM/HX80B8iBN3U4iv/2IgONEpJfBHX5Mtz
	927QozGW/1WX1WRlYYGSfytKSwEZp1r05DyTHoaBZJKMtMvgB8PB502t9kcSNrkN
	9ZetdoZIDddF9W2j5/S1Aryn/L+NhiQXTESjl6tQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aee188u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 16:37:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LDIAgN024307;
	Tue, 21 Jan 2025 16:37:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y45w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 16:37:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LGbZgU57803258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 16:37:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB61420040;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F9B220043;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Date: Tue, 21 Jan 2025 17:37:33 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, loongarch@lists.linux.dev,
        x86@kernel.org
Subject: Re: [PATCH v2 6/6] mm: Introduce ctor/dtor at PGD level
Message-ID: <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <20250103184415.2744423-7-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103184415.2744423-7-kevin.brodsky@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: owdc1hfezV5r1qMyZ-PJv6g9U8L_bBb5
X-Proofpoint-GUID: owdc1hfezV5r1qMyZ-PJv6g9U8L_bBb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=494 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210134

On Fri, Jan 03, 2025 at 06:44:15PM +0000, Kevin Brodsky wrote:

Hi Kevin,
...
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 5fced6d3c36b..b19b6ed2ab53 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -130,11 +130,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> -	return (pgd_t *) crst_table_alloc(mm);
> +	unsigned long *table = crst_table_alloc(mm);
> +
> +	if (!table)
> +		return NULL;

I do not know status of this series, but FWIW, this call is missed:

	crst_table_init(table, _REGION1_ENTRY_EMPTY); 

> +	pagetable_pgd_ctor(virt_to_ptdesc(table));
> +
> +	return (pgd_t *) table;
>  }
>  
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> +	pagetable_dtor(virt_to_ptdesc(pgd));
>  	crst_table_free(mm, (unsigned long *) pgd);
>  }

...

Thanks!

