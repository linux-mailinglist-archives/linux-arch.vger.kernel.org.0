Return-Path: <linux-arch+bounces-10209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C4A3B251
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 08:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C46516B00A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20861C1F05;
	Wed, 19 Feb 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7iIvY16"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D04EEAA;
	Wed, 19 Feb 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950059; cv=none; b=kd1oLl7uBTwjEGiC6KzbeRC1AQujFTGeY8A7v3vCkTsiZHuDdUvVhhJE380Zl/fLqsriUJXFXWw2GLFtcw4wKH7MLM7tQSaVES6r/CdVUp3phY75LHb9LxGw5oGa8QQGLcmPCc0wPjSffOQHLN+V/X8I5B/d7bglXQ43usw9sbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950059; c=relaxed/simple;
	bh=rBx3RHuGfRuXjbafCuoM7z7wAjafQQZUN7SQEu7BR8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTcVvfCVZ3unfgGyHhISirGi/66cBPef/aDK7kpmhT0F6KDitOMWa3Fd+rzGeG1Ue6S90y9czk5eu5URW1CBmcL8FUF5313kWVLWoj1ZQFs5dOYOaViffSirQiCSQ2TmmqShdXINZKoLrjsreJ3cSvFATB8K8e61oBJELC7VLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7iIvY16; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75IAE001899;
	Wed, 19 Feb 2025 07:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7cnvWzA7RfaVCOT66pTUOghWekuaZg
	xsFcMzX2h0QBE=; b=R7iIvY16LPJs0SC10eTbpwjNLhVbolsSaxD1XsJbVDUqmu
	j4aNluI6Y1sE0K+zEiv+hGEYnp0ZLBp6q53QAlxiBhjkdesvKL1K0ElytuHPKi0n
	WbRK5AYvW3AlKsWQE4yXqn6SstVjzpQ3wldstJeOkCSTZ7xTwjdyMDOdWlPmtWsT
	ReuIq8iltTpXJtI2o+ZHhbPNvUJ9YscNhq55EeiKZp2boaLjcz1R/049dXNPAbLA
	6TO9/wW9TSwevn9l4JL2JQ/Q885FhOWw511FosvgHbEM4zjCrvOthqydWnv0h+Kk
	gse7GpwQ29bhz9qD3tX8hc6MY/G5BAYdFLw8PdrQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyptgrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:27:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6bfxa030158;
	Wed, 19 Feb 2025 07:27:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x2spq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:27:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J7RNGk50594202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 07:27:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63ADA2004E;
	Wed, 19 Feb 2025 07:27:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E17AA20043;
	Wed, 19 Feb 2025 07:27:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 07:27:22 +0000 (GMT)
Date: Wed, 19 Feb 2025 08:27:21 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WH2VPdFvX6reij@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <Z7S-HgdXls65goJx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S-HgdXls65goJx@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qw4yE85lztD2877JVVqO7QrP47WEM6hu
X-Proofpoint-ORIG-GUID: Qw4yE85lztD2877JVVqO7QrP47WEM6hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=332 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190053

On Tue, Feb 18, 2025 at 05:06:38PM +0000, Matthew Wilcox wrote:
...
> > With the above the implicit dirtifying of hugetlb PTEs (as result of
> > mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:
> > 
> > static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> > 		bool try_mkwrite)
> > {
> > 	...
> > 	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
> > 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> > 					 vma->vm_page_prot)));
> > 	} else {
> > 		entry = huge_pte_wrprotect(mk_huge_pte(page,
> > 					   vma->vm_page_prot));
> > 	}
> 
> Took me a moment to spot how this was getting invoked; for anyone else
> playing along, it's mk_huge_pte() which calls mk_pte().
> 
> But I'm not sure how you lose out on the PTE being marked dirty.  In
> the first arm that you've quoted, the pte is made dirty anyway.  In the
> second arm, it's being writeprotected, so marking it dirty isn't a
> helpful thing to do because writing to it will cause a fault anyway?
> 
> I know s390 is a little different, so there's probably something I'm
> missing.

No, it is just me missing the obvious.

