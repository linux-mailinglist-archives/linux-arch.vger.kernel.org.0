Return-Path: <linux-arch+bounces-6216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97808952E1F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1431C23670
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95ED17BEBE;
	Thu, 15 Aug 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEtNSewI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E631217BEAC;
	Thu, 15 Aug 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723982; cv=none; b=UTOFfzHNs6N/B9jKHlarB+7mixQF3MqUG/m5URV1CEnwZBVGcBVyDG1dMAdF3Tm73ShDmq1zU/eDLPNLm9rU7x/y/niNaEDbYQasHUxvAYOdDtTd58w7xuS62uLztDmvR8Y4k3rNo7xEqYygsB3U51UVKPHbCE4WzI1EnX7w4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723982; c=relaxed/simple;
	bh=zQsjIyYQOlQ3I1bqwiuky5sjALysFrzzi+2fbwM0C/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag+kMLC6qQY/RNlw2CEB+v7ahTDb3UTmQIFaHzqUeiCbw+k3Db+DOdQ3zglpOoTKO94LI8iAiIGQdB1aWukMMbtQaA6xhLy8Gi2qrS9ttyWMvxRlf8Ayb/yQdjTrPS/25St1ZX9yV0oHmCA9DVPJLvd77fJNgpjAaDPBuBRSVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEtNSewI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FBKP9r026593;
	Thu, 15 Aug 2024 12:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Xd64frNEOeLFKhWfmvTBNHEnJQb
	uJhSqIR8O1N+8JAw=; b=aEtNSewIsOxiFfdSDm5P7ULut5AJ6szYIqS4Xh1ulKA
	Jhj/jexK11owQT1/zINKb6NBI5WwhuhjEIEHXjYwv7cr/xys7VPKHfMLL8Ue7IHy
	yqG1XOFjiei1f49LYzVJQZsrtjLRI0v5ZPxrsNaaTLh36Zsd7welFEZlVNrElhhL
	6JsH2ooZH5VFVwsL/zHd/FOxtwgkAdNC0nHBjE0uDIw0dFC4frv3vlLdc95YTK3G
	QlygyzeTjErADWAJFIzSqCu5K/vUueCZeuGjNKBre5MyvfCcLcp0I3qRlN1GJvFH
	/x3WFQ8aY7gy4DDZSBdV08KlsK/Br6MYz5t7RpSVmfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6keaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 12:12:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47F8dU2n010055;
	Thu, 15 Aug 2024 12:12:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0xtgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 12:12:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FCCaGf34341270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 12:12:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F38B2004B;
	Thu, 15 Aug 2024 12:12:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5770220040;
	Thu, 15 Aug 2024 12:12:35 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.11.33])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Aug 2024 12:12:35 +0000 (GMT)
Date: Thu, 15 Aug 2024 14:12:33 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Message-ID: <Zr3wsRHO+hcwv5Y0@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-GUID: 35RWKvcTfZLS9yX681VV333VTIEl95d-
X-Proofpoint-ORIG-GUID: 35RWKvcTfZLS9yX681VV333VTIEl95d-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_03,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=306
 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150087

On Wed, Aug 14, 2024 at 04:44:24PM +0100, Matthew Wilcox (Oracle) wrote:

Hi Matthew,

> I believe the test for PageDirty() is no longer needed.  The
> commit adding it was abf09bed3cce with the rationale that this
> avoided faults for tmpfs and shmem pages.  shmem does not mark
> newly allocated folios as dirty since 2016 (commit 75edd345e8ed)
> so this test has been ineffective since then.

We will investigate if that is really safe thing to do.
Some people on vacation, so we might be not too quick
with the response.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/s390/include/asm/pgtable.h | 11 -----------
>  1 file changed, 11 deletions(-)
...

Thanks!

