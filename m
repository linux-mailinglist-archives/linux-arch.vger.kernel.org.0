Return-Path: <linux-arch+bounces-9849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52955A18D11
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 08:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281477A3766
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F991C173D;
	Wed, 22 Jan 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WKfRRI1l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BD28EC;
	Wed, 22 Jan 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532240; cv=none; b=ZQx/9NafyJYtlK+MBl6X/ya6Du8vH/i33X0TFCpLXG+oRbgQuHxgSAyWEYp8RrwSk0iZ4pfZmJyHn0+QFuFdDdRbU40kzs8KZHMnFtyBXLqwK8VLMG8bpVj2coU7jR4BmZuuEDh2X4GS+92RtAPzah+zR8b6dYlOYoo/V3gGUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532240; c=relaxed/simple;
	bh=IEhcvheF4V81iZY+p0ALVQuZPTmOS4DOoc5c5f3Go8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Weh6X46oLsD8r7CM037wijSYWke/zVmZ3jBLT9dw6IlBUEh+0r+1cLXU0sfzWSByIFcjXUUF0pC2BEy8HZyaBNwUhWyfg/MFTm5IH57HTKsSIySMMQtTkZz6eG9eAJ40WOoNgSXqD4jDhRXVqIEucsNlC52UMdVzmOxMtmBtZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WKfRRI1l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M2A4Je009705;
	Wed, 22 Jan 2025 07:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YOmEKaCYp7BVYdSA921evwSGcBIDRQ
	EOB9Qf7IL5hrk=; b=WKfRRI1lHye/PfeRq0CM+invZscqmJxiyfMJj6RqKDo+k0
	oHw8bxFR10u4InxfkGzbtPQRnmjjRIxYD+e4Hdc6VNWvxRNBhElChMEKYTQww/ne
	kooQLVgHcJbjlXo8YwFiHbBQ8lYIn1j20/tkdmwE9rGrifbH6of2GaRERifgPxvN
	e6jGjgMPTSpOWNSK//eRAMpTyDt03PLcgP0/2Qj42QpNbLO975g3w4J/8kekr9qF
	dPd8DDCPlAQUGXVLnf/2L8EUh+BlP8RuxoA5walvWUcYL4qLgoLMxpcBdMKwAzI/
	K9cmGJQE5Hsas24CZr5x5+mJxBXMWUxPL2+9HvXg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aee1bs75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 07:49:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50M4kx3X019330;
	Wed, 22 Jan 2025 07:49:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsfk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 07:49:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50M7nu1d48300472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 07:49:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B223620040;
	Wed, 22 Jan 2025 07:49:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B9362004B;
	Wed, 22 Jan 2025 07:49:56 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jan 2025 07:49:56 +0000 (GMT)
Date: Wed, 22 Jan 2025 08:49:54 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20250122074954.8685-A-hca@linux.ibm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <20250103184415.2744423-7-kevin.brodsky@arm.com>
 <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qTola2ylJwUaTSt4IdPRfZSdT02Tio3Q
X-Proofpoint-GUID: qTola2ylJwUaTSt4IdPRfZSdT02Tio3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=674 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220053

On Tue, Jan 21, 2025 at 05:37:33PM +0100, Alexander Gordeev wrote:
> On Fri, Jan 03, 2025 at 06:44:15PM +0000, Kevin Brodsky wrote:
> 
> Hi Kevin,
> ...
> > diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> > index 5fced6d3c36b..b19b6ed2ab53 100644
> > --- a/arch/s390/include/asm/pgalloc.h
> > +++ b/arch/s390/include/asm/pgalloc.h
> > @@ -130,11 +130,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
> >  
> >  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> >  {
> > -	return (pgd_t *) crst_table_alloc(mm);
> > +	unsigned long *table = crst_table_alloc(mm);
> > +
> > +	if (!table)
> > +		return NULL;
> 
> I do not know status of this series, but FWIW, this call is missed:
> 
> 	crst_table_init(table, _REGION1_ENTRY_EMPTY); 

Why is that missing?

A pgd table can be a Region1, Region2, or Region3 table. The only caller of
this function is mm_init() via mm_alloc_pgd(); and right after mm_alloc_pgd()
there is a call to init_new_context() which will initialize the pgd correctly.

I guess what really gets odd, and might be broken (haven't checked yet) is
what happens on dynamic upgrade of page table levels (->crst_table_upgrade()).

With that a pgd may become a pud, and with that we get an imbalance with
the ctor/dtor calls for the various page table levels when they get freed
again. Plus, at first glance, it looks also broken that we have open-coded
crst_alloc() calls instead of using the "proper" page table allocation API
within crst_table_upgrade(), which again would cause an imbalance.

