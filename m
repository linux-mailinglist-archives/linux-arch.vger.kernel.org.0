Return-Path: <linux-arch+bounces-8335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ABF9A65D2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B705B2CE3D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DD1EABA2;
	Mon, 21 Oct 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WL4D7lJN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2994195FEC;
	Mon, 21 Oct 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507234; cv=none; b=UbKxnbvgVsnVLVoEJfP83q+y4AePUB00Ha2bEWi3CgNYanD8g0ZVz5xZsQrf95llqmsCHb5a5yDBsGwUXZGKsq+ue7WcEQz3XacsNXRagcT/GA5h/J9llT6e4vQb6uPlKQ9FPZ2b54X2DbCZ56b5VN1CcyNHUomPhKn9Wy3LKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507234; c=relaxed/simple;
	bh=41f6oEtljvqz5Te0x1SNWi4SHNJw6n7wHUBSgCBwR3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB6/4heloakgrVdG+7Sf1Hm4L928IJ+O90B2SFgKvEIPle/tPnAMB6s7cAUO2hv+zL21ZHsEnXWUXa8y95jqJqzjlxpK6WVFALRWl49WOIQ6clz0/p5EsyJdTYmbXo0nrLV7oczntzE+wYLUSqdFZRF822T2Y5Jawj0yMXCNFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WL4D7lJN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KH3K032533;
	Mon, 21 Oct 2024 10:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=92knE4jiltiV907EhRGLVYeamkXayI
	7j0BwYX0ZH1JA=; b=WL4D7lJNas37Nzdhxi9rX+lx/0u/7ytK48q3TqjJR++gKt
	r7ueMht7alDtgQ7pasPryEpqoYRd0OWJqyszZwZ+SpNOF2LJ1isSitDYhyMC/LAS
	FwERDIOSqxtV94TGFg/XwPocGXOJNG9slT3/uBhOpxWpILgE6aPOyXK2xUh7rTpF
	iZSfIsmznUv35ep6vlQ2EA5avKOIqsYrhOQyes8ee48qcQRT99bJpKxarFGhHfc/
	Sf1AmAC4Lua0AKvgB9CPRIHyiQxUS0kOC4/Q4iiF3ywr7qQlDkQN+CyvM61jpuW4
	hTkpnbK13JKGJKjwKEuAWROXZpMXdSctg6J3mWmA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hm8my5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:40:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L9CWB9018605;
	Mon, 21 Oct 2024 10:40:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj5kvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 10:40:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49LAe94P24249044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 10:40:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389B320043;
	Mon, 21 Oct 2024 10:40:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0602004B;
	Mon, 21 Oct 2024 10:40:08 +0000 (GMT)
Received: from osiris (unknown [9.171.37.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Oct 2024 10:40:08 +0000 (GMT)
Date: Mon, 21 Oct 2024 12:40:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 07/15] s390/crc32: expose CRC32 functions through lib
Message-ID: <20241021104007.6950-E-hca@linux.ibm.com>
References: <20241021002935.325878-1-ebiggers@kernel.org>
 <20241021002935.325878-8-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021002935.325878-8-ebiggers@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f0A5vIL1iLbWasgVAUuToCuIbQMCR4iX
X-Proofpoint-GUID: f0A5vIL1iLbWasgVAUuToCuIbQMCR4iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=730 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210076

On Sun, Oct 20, 2024 at 05:29:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Move the s390 CRC32 assembly code into the lib directory and wire it up
> to the library interface.  This allows it to be used without going
> through the crypto API.  It remains usable via the crypto API too via
> the shash algorithms that use the library interface.  Thus all the
> arch-specific "shash" code becomes unnecessary and is removed.
> 
> Note: to see the diff from arch/s390/crypto/crc32-vx.c to
> arch/s390/lib/crc32-glue.c, view this commit with 'git show -M10'.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/s390/Kconfig                      |   1 +
>  arch/s390/configs/debug_defconfig      |   1 -
>  arch/s390/configs/defconfig            |   1 -
>  arch/s390/crypto/Kconfig               |  12 -
>  arch/s390/crypto/Makefile              |   2 -
>  arch/s390/crypto/crc32-vx.c            | 306 -------------------------
>  arch/s390/lib/Makefile                 |   3 +
>  arch/s390/lib/crc32-glue.c             |  82 +++++++
>  arch/s390/{crypto => lib}/crc32-vx.h   |   0
>  arch/s390/{crypto => lib}/crc32be-vx.c |   0
>  arch/s390/{crypto => lib}/crc32le-vx.c |   0
>  11 files changed, 86 insertions(+), 322 deletions(-)
>  delete mode 100644 arch/s390/crypto/crc32-vx.c
>  create mode 100644 arch/s390/lib/crc32-glue.c
>  rename arch/s390/{crypto => lib}/crc32-vx.h (100%)
>  rename arch/s390/{crypto => lib}/crc32be-vx.c (100%)
>  rename arch/s390/{crypto => lib}/crc32le-vx.c (100%)

...

> -static int __init crc_vx_mod_init(void)
> -{
> -	return crypto_register_shashes(crc32_vx_algs,
> -				       ARRAY_SIZE(crc32_vx_algs));
> -}
> -
> -static void __exit crc_vx_mod_exit(void)
> -{
> -	crypto_unregister_shashes(crc32_vx_algs, ARRAY_SIZE(crc32_vx_algs));
> -}
> -
> -module_cpu_feature_match(S390_CPU_FEATURE_VXRS, crc_vx_mod_init);

What makes sure that all of the code is available automatically if the
CPU supports the instructions like before? I can see that all CRC32
related config options support also module build options.

Before this patch, this module and hence the fast crc32 variants were
loaded automatically when required CPU features were present.
Right now I don't how this is happening with this series.

> -MODULE_ALIAS_CRYPTO("crc32");
> -MODULE_ALIAS_CRYPTO("crc32-vx");
> -MODULE_ALIAS_CRYPTO("crc32c");
> -MODULE_ALIAS_CRYPTO("crc32c-vx");

...

> +static int __init crc32_s390_init(void)
> +{
> +	if (cpu_have_feature(S390_CPU_FEATURE_VXRS))
> +		static_branch_enable(&have_vxrs);
> +	return 0;
> +}
> +arch_initcall(crc32_s390_init);

I guess this should be changed to:

module_cpu_feature_match(S390_CPU_FEATURE_VXRS, ...);

Which would make at least the library functions available if cpu
features are present. But this looks only like a partial solution of
the above described problem.

But maybe I'm missing something.

