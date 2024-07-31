Return-Path: <linux-arch+bounces-5742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8C94264C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 08:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E5B25308
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3749B49644;
	Wed, 31 Jul 2024 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xqu4xGC8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4F1BC3F;
	Wed, 31 Jul 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406526; cv=none; b=O34jkG5JgJGHQLeTUq4qmAKSuwmmxKthEacToXwe2lHUYRCFsuAtH+MoukSeUyoHAB3bAdHuYTu9crTEZgfwi2DdU80IP5/8uztJ5n3BCsPiFBJCMXuhUKPqhotNTBpqSDMPmXmi9WI2hB1rQdfFPQxwZqN4HpwZh2qF9uLoUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406526; c=relaxed/simple;
	bh=GgzIOQ3UJOo77UznjM+jaMkSMf677W+Ok3lORS8sc/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVCIh1YsP+ydU06daFUkMwKjiZrViK+olN3644Pdh9ZmBYUhGM/kuVuKACIuITLfcQ6FCEv8AcH0mOt6WqqudMluYOV7JJAjSw7PGmhE8BaLdprv43bymj9SIRSV0pr0K2P5CUOSMoByFzFOjjco/fSVnS7pp5VbFxu3XSoEITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xqu4xGC8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V5RMLi030350;
	Wed, 31 Jul 2024 06:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=SCo8GObb+++IhRCicfjv5InwiEB
	g3LBR5cl3ncZ29WY=; b=Xqu4xGC8CBr0SllgB4EnsdYHNwLG+wbblKHRJTz6PbF
	hL+W/yT58VkHTvjEB6shV0OABqSp0+XVTFd3q7TaHDmMxV+UMbGPOEZ+kGyRQ/50
	HhLVrdsSYyInWDue9P/EfuDSvys9vje1R7vzr4i+86pKOHx+7ASiVHN47JVGlDA6
	/n6eOPEHVVzyqItkGW1hhROsPwDf50w715cKJciupXijZR49rfLAdxM73WsLHoyf
	5rTEyTq5bx6hZBxGJ8pSg3Iyme0ZZ+NKeVi4lxHrojrt3Mey3IvD7dpdZ+lH0WIc
	4BEci8dD70VpTkp0ja8IeyZwVvdPDi9Z9Bc90lIP/0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qdu3086k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:14:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V6ExJq012909;
	Wed, 31 Jul 2024 06:14:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qdu3086g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:14:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V4t4Tj007479;
	Wed, 31 Jul 2024 06:14:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u9xcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:14:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46V6EqYf51642718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 06:14:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352302042D;
	Wed, 31 Jul 2024 06:14:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC392042E;
	Wed, 31 Jul 2024 06:14:47 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.42.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 31 Jul 2024 06:14:47 +0000 (GMT)
Date: Wed, 31 Jul 2024 08:14:46 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] runtime constants: move list of constants to
 vmlinux.lds.h
Message-ID: <ZqnWVi4M/UwJQwdz@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -s9BdagkxvpCCyiNSHvrqBHlPFTxMFw6
X-Proofpoint-GUID: NeuBvEi_lgS1f7VZYOwmQ8nrJWO4tP5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_02,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310043

On Tue, Jul 30, 2024 at 10:15:16PM +0200, Jann Horn wrote:
> Refactor the list of constant variables into a macro.
> This should make it easier to add more constants in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I'm not sure whose tree this has to go through - I guess Arnd's?
> ---
>  arch/arm64/kernel/vmlinux.lds.S   | 3 +--
>  arch/s390/kernel/vmlinux.lds.S    | 3 +--
>  arch/x86/kernel/vmlinux.lds.S     | 3 +--
>  include/asm-generic/vmlinux.lds.h | 4 ++++
>  4 files changed, 7 insertions(+), 6 deletions(-)
...
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 975c654cf5a5..3e8ebf1d64c5 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -187,14 +187,13 @@ SECTIONS
>  	_eamode31 = .;
>  
>  	/* early.c uses stsi, which requires page aligned data. */
>  	. = ALIGN(PAGE_SIZE);
>  	INIT_DATA_SECTION(0x100)
>  
> -	RUNTIME_CONST(shift, d_hash_shift)
> -	RUNTIME_CONST(ptr, dentry_hashtable)
> +	RUNTIME_CONST_VARIABLES
>  
>  	PERCPU_SECTION(0x100)
>  
>  	. = ALIGN(PAGE_SIZE);
>  	__init_end = .;		/* freed after init ends here */
>  
...

For s390:

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

