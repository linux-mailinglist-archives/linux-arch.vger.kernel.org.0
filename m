Return-Path: <linux-arch+bounces-8262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5B9A35EC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 08:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2792FB23198
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0317C219;
	Fri, 18 Oct 2024 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPHeWZRc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B72BAEF;
	Fri, 18 Oct 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234046; cv=none; b=KG3697smJ2bDmd2hxgSFAz0ECY7Z/0uX9WT73rttXoMWlO/Cbw5gxTTdAJjQy1uzWIwdOwH+7rc1ne2mhEIYULqFWCK3Xezbo1Of3eWQGTgJRhuRaxSzbDjWEUY0dMJP8DZSkUQT5QOtqiTbWAh12N+rp3RfAcsz2E/DcsdTmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234046; c=relaxed/simple;
	bh=lMoys8CVcZ9w+7WoG4jXN4U1xi+wLOY7h39zghriRTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ld11gJ+/qo2RSP0Nk/fVfec5AAarSmG6JRHq16LLwM4ohs7uUl55jIW6SZFxqh1LI4eOsyRzuIlHWbsewD5RWsZR9veOvAb5YktqtZkFZEZNjrbY+G7TSy+jWi2I2azq4QQOugePL+8N2101kAhx7ZUHtD585E3XOhLdk5xRwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPHeWZRc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJS9cs013958;
	Fri, 18 Oct 2024 06:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZtZwrtsbjyP5G3OvZokw/afS3L0zNj
	beT125e38cN9M=; b=aPHeWZRcRdKDkBYcAG4N8tBJlnutL8kZsaHBixgTJBhsvX
	f18mar9lnvweNd7DFeAhKiwad0d00gOx5wj7E6VUK5ZunZaGn9RSmMbRgwzFmHmh
	FN+1ZzZrCXj+Il7uaIV0d8rEqfd6rIFyypEJXg3MgEZRtmbbv8vLiTGPlbFVEEsx
	5PHVa4fEN7Dv7f48HORFqRkk+GNUVNrFsGdhezW1CyVFmBk2pyfuN5r8PGgZLOmF
	f2SRhJgx12+chSjdFaT10CST/gfM2caWMK6ptxj7JfwgVhkKUD1XknPEir+igGVi
	yOq2SLkl2CO0hi8KcLYgneiMsV50hvu5sEnzIgNA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqk2qpew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 06:46:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I61TgH006338;
	Fri, 18 Oct 2024 06:46:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428651ak3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 06:46:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49I6kp8x57475340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 06:46:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05A1F20049;
	Fri, 18 Oct 2024 06:46:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D3A520040;
	Fri, 18 Oct 2024 06:46:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.16.203])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 06:46:50 +0000 (GMT)
Date: Fri, 18 Oct 2024 08:46:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 3/3] s390: Remove remaining _PAGE_* macros
Message-ID: <ZxIEWLKWF8SMnQSU@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241014151340.1639555-1-vincenzo.frascino@arm.com>
 <20241014151340.1639555-4-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014151340.1639555-4-vincenzo.frascino@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9nrIevi-JtxqmYYBmh6jnPv6L3gfJPns
X-Proofpoint-ORIG-GUID: 9nrIevi-JtxqmYYBmh6jnPv6L3gfJPns
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1011 mlxlogscore=374
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180039

On Mon, Oct 14, 2024 at 04:13:40PM +0100, Vincenzo Frascino wrote:

Hi Vincenzo,

> The introduction of vdso/page.h made redundant the definition of
> _PAGE_SHIFT, _PAGE_SIZE, _PAGE_MASK.
> 
> Refactor the code to remove the macros.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410112106.mvc2U2p0-lkp@intel.com/

Is my understanding correct that with patch 3/3 you fix an issue
introduced with patch 2/3?

> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/s390/include/asm/page.h    | 3 ---
>  arch/s390/include/asm/pgtable.h | 2 +-
>  arch/s390/mm/fault.c            | 2 +-
>  arch/s390/mm/gmap.c             | 6 +++---
>  arch/s390/mm/pgalloc.c          | 4 ++--
>  5 files changed, 7 insertions(+), 10 deletions(-)

Thanks!

