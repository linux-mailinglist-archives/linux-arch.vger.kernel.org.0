Return-Path: <linux-arch+bounces-6529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180D95B7FE
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B27A1F240C5
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2741CB121;
	Thu, 22 Aug 2024 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lu8L21yG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA661C9ECF;
	Thu, 22 Aug 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335678; cv=none; b=ZNB6/GX//J6seX67EQ+mnyTVJN2Rc9EYei/d0Prxl3Q0N4XmST2pdHdIM6QOe1GvneVOqdOkOw7HdMJ9+PJEyKc6vCL44yPV+LjX+UUO0CB0/ro25/XDYCFuZb94SdAL91H79lE6U8T/3K1rooP9rLbItuGlvow2ZaQ8wTL7cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335678; c=relaxed/simple;
	bh=QByrmwhUg4P8JjcbA4eO6Y4AzmowyvnxUj7zxC3xOL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qC86nir7nw4BRwuZQSciwDx4wZ+CiA+XXzFdsj+LcMoBIZhFVWpKcyd3I7436WECitxULptG9lDDzedynPFXrQbEv6o8b3tyByspTaD5zd+SY6EAjVFZifVmw3S1o8z5c4/aQyr9RMLmIHe+4MrrB4avYx79WTd6Ib4K/PHzbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lu8L21yG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M578Q1027428;
	Thu, 22 Aug 2024 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=012mDUm2fCWZDcYIJ2hFYZSZaAj
	p60g7PcWojz+2NIk=; b=lu8L21yGqnD+aEH/XD4Frt5dOHPwym/cMrn1uj3GVa4
	kzuO1DKexUdezI3Lef1EROsNR0YJHwQ+cuoVaJlf9cJi1Tbga4uqgXuWbGE6Fmi0
	UyFcLtbb+vfxAU9jq0xiHCPPxFfSSEq74r8E6OH3h1tTvu16J5LgXVWzoWUpMySt
	tAEU8oFkFXuJWypIdR9T8o28/Ataz5dxpWlr5GJi4t7iHP3djTrVp/arawkT39Wg
	JYtfqueMjZdj7SFCZfXa0UKh1s/hxbFRXw3/CrBYFdntLsM5EPyegxcQ1XstMtsl
	PDly7cy4minOakIdflJ8HE3Wjg09J6vaTyHLbaWCfhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y20ptv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 14:07:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47MC1itj017651;
	Thu, 22 Aug 2024 14:07:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3cr2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 14:07:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ME6wj655837100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 14:07:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60A5820043;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6C320040;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Date: Thu, 22 Aug 2024 16:06:56 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Message-ID: <ZsdGAHP5rwG5yLr8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240814154427.162475-1-willy@infradead.org>
 <20240814154427.162475-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-5-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K53dTj0IefNPmG9sfYv2aFJl57u7cE44
X-Proofpoint-ORIG-GUID: K53dTj0IefNPmG9sfYv2aFJl57u7cE44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_07,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=312 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220105

On Wed, Aug 14, 2024 at 04:44:24PM +0100, Matthew Wilcox (Oracle) wrote:

Hi Matthew,

> I believe the test for PageDirty() is no longer needed.  The
> commit adding it was abf09bed3cce with the rationale that this
> avoided faults for tmpfs and shmem pages.  shmem does not mark
> newly allocated folios as dirty since 2016 (commit 75edd345e8ed)
> so this test has been ineffective since then.

The PageDirty() test you suggest to remove is still entered.
I initially thought that test could also be useful for other
architectures as an optimization, but at least one path we
take for shmem mapping is raising eyebrow, because it is a
read accesss:

handle_pte_fault() -> do_pte_missing() -> do_fault() ->
do_read_fault() -> finish_fault() -> set_pte_range() -> mk_pte()

A read fault causing the PTE dirtifying is something strange
and your patch alone could be a nice cleanup.

As other architectures do not do such a trick suggests that
mk_pte() + pte_mkdirty() is called from the same handler
or pte_mkdirty() is expected to be called from a follow-up
write handler.

I could not identify locations where that would not be the case,
but may be you know?

...
> -static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> -{
> -	unsigned long physpage = page_to_phys(page);
> -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> -
> -	if (pte_write(__pte) && PageDirty(page))
> -		__pte = pte_mkdirty(__pte);
> -	return __pte;
> -}
> -#define mk_pte mk_pte

Thanks!

