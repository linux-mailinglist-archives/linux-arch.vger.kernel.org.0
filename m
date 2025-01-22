Return-Path: <linux-arch+bounces-9856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAABA19A46
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 22:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266C93AC3EC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299FF1C5D68;
	Wed, 22 Jan 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MD/1i4r7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA761C232B;
	Wed, 22 Jan 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580787; cv=none; b=nsUus/0LdjiA7Dw8HeBb+pm4UPdL58s4V9G10MjMnKBz5UblcAoxb+a84DapM347OVTw1Zbu2dr0KThFzEngD5D5/ZXR+l4x3wjCp6qtk0KYzgdj8kLYao95wuyBJIxpy3zgKAEkHSJlZmWxecNQu++oMzrD/gnQEUOx0SDzZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580787; c=relaxed/simple;
	bh=GqP6QXYud4OFUY8hX1TkxW/BI1wPl7mETljhzkHTP/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwBbDpk5VYBM4E6dYeLmRs8BuPrN1UEJyX9M0g6+Lz0rwuXy5ob/bQYfCxxj53Jo42Uhw3jTeCaa0MlYh9NbLcUei+2ZtJNqabiXD0DZ5UPYYK0o6jJXpiBwWlMfZj8bp9qUqKggxwFnszcyCNYwp2gwFAOap3nzwrHyidt822M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MD/1i4r7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHQxkg012829;
	Wed, 22 Jan 2025 21:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=esFAzaN6g7njZiCCkaClyDhZIQCDyB
	L4ZttyeT6NCzw=; b=MD/1i4r7lMchVZDMxCd4+OmTL+gqvz4EsoCc3lhjzl61q/
	dWCbk7Dc9E+/mkxibxIfcO+5M2miNjCQj+Zb6N7aFJSgK9pEAqx6PGNDi1udxJ2D
	5GRkpG+GUOuS40Gu4kk1nLVzuQ6b0Ms8Wu06boltLFfDgJ845roakAZxLi7ece1K
	21P0Y61Gf0j8zaE10R3dSPAxGJBBECX5J1pPuXnnL27yt6dWzGu7RpbRMXnWFft4
	1i9lfntcbQEcz44pnsvGFWB7JR/kgZ5jistInR187FAC2imqV46/9k08iOuxZ7q0
	9o0IVrdT0Bd2ZHNbMuzwATcn0fOtey6n4VrpyBow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp3s7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:17:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKlol5019223;
	Wed, 22 Jan 2025 21:17:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsjk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MLH4Kc13697392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:17:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C62A2004D;
	Wed, 22 Jan 2025 21:17:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40CD20043;
	Wed, 22 Jan 2025 21:17:00 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.77.114])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jan 2025 21:17:00 +0000 (GMT)
Date: Wed, 22 Jan 2025 22:16:58 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Kevin Brodsky <kevin.brodsky@arm.com>
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
Message-ID: <Z5FgSn0y/c9pItED@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <20250103184415.2744423-7-kevin.brodsky@arm.com>
 <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20250122074954.8685-A-hca@linux.ibm.com>
 <Z5D7TSR3AttkC0Jf@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5D7TSR3AttkC0Jf@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lJbHIFaitD84VbMmVKAwv1LP_Khu2fra
X-Proofpoint-GUID: lJbHIFaitD84VbMmVKAwv1LP_Khu2fra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=925 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220151

On Wed, Jan 22, 2025 at 03:06:05PM +0100, Alexander Gordeev wrote:

Hi Kevin,

> On Wed, Jan 22, 2025 at 08:49:54AM +0100, Heiko Carstens wrote:
> > > >  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> > > >  {
> > > > -	return (pgd_t *) crst_table_alloc(mm);
> > > > +	unsigned long *table = crst_table_alloc(mm);
> > > > +
> > > > +	if (!table)
> > > > +		return NULL;
> > > 
> > > I do not know status of this series, but FWIW, this call is missed:
> > > 
> > > 	crst_table_init(table, _REGION1_ENTRY_EMPTY); 
> > 
> > Why is that missing?
> 
> Because the follow-up pagetable_pgd_ctor() is called against uninitialized
> page table, while other pagetable_pXd_ctor() variants are called against
> initialized one. I could imagine complications as result of that.
> 
> Whether Region1 table is the right choice is a big question though, as you
> noticed below.

As discussed with Heiko, we do not want to add the extra crst_table_init() call
at least due to performance impact. So please ignore my comment.

> > A pgd table can be a Region1, Region2, or Region3 table. The only caller of
> > this function is mm_init() via mm_alloc_pgd(); and right after mm_alloc_pgd()
> > there is a call to init_new_context() which will initialize the pgd correctly.
> 
> init_new_context() is in a way a constructor as well, so whole thing looks odd
> to me. But I do not immedeately see a better way :(
> 
> > I guess what really gets odd, and might be broken (haven't checked yet) is
> > what happens on dynamic upgrade of page table levels (->crst_table_upgrade()).
> 
> Hmm, that is a good point.
> 
> > With that a pgd may become a pud, and with that we get an imbalance with
> > the ctor/dtor calls for the various page table levels when they get freed
> 
> The ctor/dtor mismatch should not be a problem, as pagetable_pgd|p4d|pud_ctor()
> are the same and there is one pagetable_dtor() for all top levels as of now.
> But if it ever comes to separate implementations, then we are in the world
> of pain.
> 
> > again. Plus, at first glance, it looks also broken that we have open-coded
> > crst_alloc() calls instead of using the "proper" page table allocation API
> > within crst_table_upgrade(), which again would cause an imbalance.
> 
> This is a good point too.

The below bits are seems to be missed. We will test it and send a patch.

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index a4e761902093..d33f55b7ee98 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 		if (unlikely(!p4d))
 			goto err_p4d;
 		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
+		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
 	}
 	if (end > _REGION1_SIZE) {
 		pgd = crst_table_alloc(mm);
 		if (unlikely(!pgd))
 			goto err_pgd;
 		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
+		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
 	}
 
 	spin_lock_bh(&mm->page_table_lock);
@@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 	return 0;
 
 err_pgd:
+	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, p4d);
 err_p4d:
 	return -ENOMEM;

Thanks!

