Return-Path: <linux-arch+bounces-15705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96342D025EF
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EE243086039
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D748BD34;
	Thu,  8 Jan 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aYOWi/WD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9048B389;
	Thu,  8 Jan 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868882; cv=none; b=UQGY5O0Fi+ER8d8F5SdmV3OaIi9x8zIljdGVeBOia4ZjUPwl4NLa/QIwUZe5CUlHCGR4q5QXpqT7Yi6qvtSQCynhT74D2sWTYHqym+giFzWud47uKkszuHE6zr5+Jd9mIqQq+GCZv4FIKAkyyZs13SmIpXrRYrCp6KVHsweVPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868882; c=relaxed/simple;
	bh=aXgaMegsrBk1+i2p8L6sBSd00SfqVF7uIcMgYtcUFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH14yeUXYrH9yTfUvA9cIvlES++3vvRNgxfyX2PMh5DaBMDvlzdAsBXzcoNX3tEjADNEnMOwddoZYuJECzKc0Nv2zLXBcbZjoYzbqA3LOo7kGDoOSsXXezjHrR1TOXrA06AZwnEZwQG8za0eF1DR2GoEG0gz2hquctKqJsAN46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aYOWi/WD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607K106Q003588;
	Thu, 8 Jan 2026 10:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4TTBroKnN0eLVOHeCy8YsD1wmF7eal
	rZ7/OBBXM8gtM=; b=aYOWi/WDbsEI6QFGhzuBiObqdHsOaTK2Kc3HcoQ+zoovzX
	2r75nvofMVCPDwbPyv5wPkaeODzKnO0wyvu+4tP59Gq+5oHSnCgONreEStsY1F09
	RHWMjyc8yvGTApGtmyD3h3ro6ZeQOnd9Ad2DcmKJ15HIY4aQ/F2tBQ++SYvryniS
	2oyA4uMNbrAYQCU41sot8qjPBl8ZbtkNlQW6pLXLE4KwKj1ro2Pj4f5Ezufwe1QL
	EAgGcv3bIthcBgnBEMak5xqMRF2eLMycOp/2vLycVyceIsQY1Vu5N522lNqwSOpk
	d/QbiOURcW0uEjCrtbktJCiAroKlkd3CjM1q17Cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqdssu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 10:40:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 608AdSul025029;
	Thu, 8 Jan 2026 10:40:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqdsss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 10:40:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60871mDp019411;
	Thu, 8 Jan 2026 10:40:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51e0yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 10:40:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 608AenKO39321866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Jan 2026 10:40:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E700C20040;
	Thu,  8 Jan 2026 10:40:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E21520043;
	Thu,  8 Jan 2026 10:40:48 +0000 (GMT)
Received: from osiris (unknown [9.111.54.4])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Jan 2026 10:40:48 +0000 (GMT)
Date: Thu, 8 Jan 2026 11:40:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: will@kernel.org, aneesh.kumar@kernel.org, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org,
        "David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH] mm/mmu_gather: remove @delay_remap of
 __tlb_remove_page_size()
Message-ID: <20260108104046.9857B79-hca@linux.ibm.com>
References: <20251231030026.15938-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231030026.15938-1-richard.weiyang@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sCafAl5JZ-iCW3CEVShbxhFeg-5utwS-
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695f89b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BpKC6iUb4ImYL19sRPUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: zuf_APRcevyr7dXxP5ZWDs6PkNI1Voh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2OSBTYWx0ZWRfXzpscs6TxyynH
 GM7L6OI3Ws+IgqfpA+zIxpv3g0cDNmEZ/IsLExpoUxgnppjOzx6AhaVUtaAgtU8mFbPuVL+rn+4
 lrUL7rSb6nn6tSeCPET9w9tNZ8R2CTMAEA71UWmpMvWZL/2Mj1UMNshrUJH8rvDKQOcyC/DhtrU
 2uEGv2fR/6zrWtwG0ze7n83IBhVnSTYyTZNpzzScmGa36PKYWnytnvN7Qi1ZFMNySvxgGAGpUpc
 gCFJarXBC02LdthiirYxfczNrqQV9dA3ica6qPpc7Hi3hLoKDVe756pxH9KvmrMfJVSWXtSzxqK
 kpJ6N/TyFPzncHda6iQTQm+yGYWp8g7zk7GfyhNIlF+StvIRDgq5uNblcllPNRUFhBQmUWRZ7lp
 l0EN6nLKcEHmxhg9xqnRNCZKfJKz0Kii0JRPB1+ord0BAPOHGtMyIF+5Gt8VeDQMex+gmOXkayF
 TtB/BteVCNu8pUZqD2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601080069

On Wed, Dec 31, 2025 at 03:00:26AM +0000, Wei Yang wrote:
> Functioin __tlb_remove_page_size() is only used in
> tlb_remove_page_size() with @delay_remap set to false and it is passed
> directly to __tlb_remove_folio_pages_size().
> 
> Remove @delay_remap of __tlb_remove_page_size() and call
> __tlb_remove_folio_pages_size() with false @delay_remap.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> ---
>  arch/s390/include/asm/tlb.h | 6 ++----
>  include/asm-generic/tlb.h   | 5 ++---
>  mm/mmu_gather.c             | 5 ++---
>  3 files changed, 6 insertions(+), 10 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

