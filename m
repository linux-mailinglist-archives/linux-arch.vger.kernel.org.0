Return-Path: <linux-arch+bounces-13077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4AB1C459
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7681835E0
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081923C8AE;
	Wed,  6 Aug 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bXCsUiIU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA591FDD;
	Wed,  6 Aug 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476399; cv=none; b=qQndD/3Z08iXRGfJwRi84C0p9IObQGvU9COeefF30/i91WFuPpYiFXA0rkOYhC1MZnYgd0/2WVXWPuMU6ePPSpa3wHT5ZnYDUQs375pHjQZro2Z8EFmJmnSM/X/AVubf8J1PPCwlw3h9Sc2rMRPGFye8Ru8ES0+pYu+4bi0ie/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476399; c=relaxed/simple;
	bh=4ONmXejy9qRChYD8YFLgNZvQakZuFN0pKogdmn9BB7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lECl74WgiAuBMxhS2Zvk7JkLFiWwgT0MYCLCaX7z3cYlsOr9bY+xIxtfIIHTgMVRTao6UMwhfGw8XIh05roYWoZzY8Yl83s0yvFbsYWlSYlMTmruUr1Wa68XFMGHzPgy+bMGFlM4n12ve7tuFH8Pbix6X+LIkGoEY9Pe9syjCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bXCsUiIU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57692NPP018065;
	Wed, 6 Aug 2025 10:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3wBoqQwRkSBaQEVLP0xWuNtEXTupVT
	vuJMqQFfbbBMk=; b=bXCsUiIUGuNdsnpstSK7KJ+EHWCL6u+flAEgHfLhazaMGZ
	A2cOEBmYWln1FbP2qTEczCBjdPo+RtNzcIMRJ19xPazntSu2S12gUFaaHfuo/nQU
	jHyAcBmYwm3yQi2lpywOWKhy9UgshrQmFDKiqSYdN0lvR6LteIeMno5fOYwy2N+1
	SS8FrDWGFapdZMQYu8BDyoEf+invbVP0dQ13P+dm0meAwlmfJ5hGZ1W3Ffuv22RH
	rVF7zho8Jk2fTvPROq5h3F2/8QA/aNNZQNOFLxnMzJDGjimVoQCGH45+KR3bmLfS
	0wlyA9YB8dI+vXNZ7cjWcVN308jpV5LOdVcXGSzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq633jar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 10:33:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57683Fvx020612;
	Wed, 6 Aug 2025 10:33:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmu5p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 10:33:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576AX2qq32703150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 10:33:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C7912005A;
	Wed,  6 Aug 2025 10:33:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7A652004B;
	Wed,  6 Aug 2025 10:33:01 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 10:33:01 +0000 (GMT)
Date: Wed, 6 Aug 2025 12:33:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 14/17] s390: Add __attribute_const__ to ffs()-family
 implementations
Message-ID: <20250806103300.11925Cbe-hca@linux.ibm.com>
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-14-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804164417.1612371-14-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX1ElbkHLwop5M
 nPtrgbB752LU1pfAwNBDgIAJaBFi6LdxUXlVN+CUECGityjOLd34EGE9Toa3cseKpijmOYkbMrT
 aNwZhYK7iA/bCymHo9U7IaM/O7Xot0VGlpwnnhV1aXHyUVrek/1n8npVMb07MiX+K+TDGIg0AO4
 ihzZswvna0t8psGTcbnxJracRM2oTHbAzHtGyMCKd3aNtNi66J9AADNlixjxITc6ZJ7TjnULCHk
 P4T4ObjAhkO8s+SveY8dJN1qu9r4TUmsgwFAOb96zQD69cH4RtCGyQz1GCIcyhMWlhz5kn2Ucc+
 LWbDbC/Jrwgoq+v6/0pZM6yn2Dx13ovRiSUZITmIvPptutFSJZ1mNsE00D5CNG/6vkJ4UDgYu3T
 wIBBzpQWWdbv/iQCNo1U4G1hbBeBXZZlCO1Mqsl7bXq7JJnmf6ZyHAANHSil8agH6h4bvtmd
X-Proofpoint-GUID: eM8kqSdm0FroOEI9WgdEMMtevU6pWRX4
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=68932f60 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=La76t7K_3jgqz9qSpcQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: eM8kqSdm0FroOEI9WgdEMMtevU6pWRX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=896 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060064

On Mon, Aug 04, 2025 at 09:44:10AM -0700, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> Add missing __attribute_const__ annotations to S390's implementations of
> ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
> functions that always return the same result for the same input with no
> side effects, making them eligible for compiler optimization.
> 
> Build tested ARCH=s390 defconfig with GCC s390x-linux-gnu 14.2.0.
> 
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  arch/s390/include/asm/bitops.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

