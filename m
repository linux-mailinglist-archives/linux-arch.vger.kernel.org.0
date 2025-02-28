Return-Path: <linux-arch+bounces-10463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A7A49491
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 10:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BFE17091F
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315E2561B4;
	Fri, 28 Feb 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CR5nCp5R"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842F24A046;
	Fri, 28 Feb 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734148; cv=none; b=D7tPKHv7xRbSz7h9evuEFSFQqYkUAo37YE6kl0mYYjTCKOyM4B7e6nqP2EwpH1ampV1xfWmqZGlIgPMdHbaju0mQm2ika6BQbaXJRjcsDQ9ofQNc/dHTFxy2E4A0NR79DuFZO79BUQ5/l5vatI1tD2e4E06/QtVzOHND7If2/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734148; c=relaxed/simple;
	bh=XUXziA+nTZDBj2Li7foJzUDDRkHQt+bXPdaAGNeKlqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfoZmfDuuKyErNSgkxk/qBhzsAxp5LEyKK4lQgOR2wlcka2cldWoYO/e6X0iaOy7hvod7sh3x2XXWtL3ZfwKDy/scKSdJS2lRABEGe11iPCFdzutA3xbK6L2VIKgM1gNmAitRmAgU8UBPdl4704Nj6abNVmkeFwTQ4ZszcIkfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CR5nCp5R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S18l30011287;
	Fri, 28 Feb 2025 09:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zbXmaRcT2XwkeDCQc4Fd1apB2+M2uJ
	/a3I4PM1YAgw0=; b=CR5nCp5RBt4kqQy37SzzjYHulkurnB3J6loL1dYZQg3Jw1
	TRY9FbD2yoZUIsQVu6vsPdB5oazypxeGOE/y89LUz6G1yoNa9PUfNPYP2KzLVc0v
	ZiyzOnQtoPGKdXFSlsTpr8tRUOGIDGYQqLWU6hidsyNQkR1fKOog+hefQ8uMHdrw
	hFm12FlgrIhjMZ6tdM0hVcKdXERHMr/0MlGFhklKGj2N30F4q1DxvpYkJF4ja58y
	nX29zfVCJR4mlOQIPg1jSadnA2UY2/yrU5LwwrNca73oF3TbmlhImTtVeLhRyTV4
	gPAZVh0J2t72Vp2yFxz65407FMZoUhJRHinNpd+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337ahym7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 09:15:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51S8xMff016279;
	Fri, 28 Feb 2025 09:15:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337ahym5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 09:15:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51S7xvWL002595;
	Fri, 28 Feb 2025 09:15:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k5avf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 09:15:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51S9FBd120578658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 09:15:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A512004B;
	Fri, 28 Feb 2025 09:15:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B32D720040;
	Fri, 28 Feb 2025 09:15:10 +0000 (GMT)
Received: from osiris (unknown [9.171.87.109])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 09:15:10 +0000 (GMT)
Date: Fri, 28 Feb 2025 10:15:09 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <20250228091509.8985B18-hca@linux.ibm.com>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221924.265259-3-lyude@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PXilDMwrSa6mnq-6V0CgFdcdACh3D8aI
X-Proofpoint-GUID: uvIo6Uq09NLmGDRrJ19UmGamCa1Xy5fB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=670
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280064

On Thu, Feb 27, 2025 at 05:10:13PM -0500, Lyude Paul wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
>  arch/s390/include/asm/preempt.h  | 19 +++++++++++++++++++
>  arch/x86/include/asm/preempt.h   | 10 ++++++++++
>  include/asm-generic/preempt.h    | 14 ++++++++++++++
>  4 files changed, 61 insertions(+)
...
> diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
> index 6ccd033acfe52..67a6e265e9fff 100644
> --- a/arch/s390/include/asm/preempt.h
> +++ b/arch/s390/include/asm/preempt.h
> @@ -98,6 +98,25 @@ static __always_inline bool should_resched(int preempt_offset)
>  	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
>  }
>  
> +static __always_inline int __preempt_count_add_return(int val)
> +{
> +	/*
> +	 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
> +	 * enabled, gcc 12 fails to handle __builtin_constant_p().
> +	 */
> +	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES)) {
> +		if (__builtin_constant_p(val) && (val >= -128) && (val <= 127)) {
> +			return val + __atomic_add_const(val, &get_lowcore()->preempt_count);
> +		}
> +	}
> +	return val + __atomic_add(val, &get_lowcore()->preempt_count);
> +}

This should just be

static __always_inline int __preempt_count_add_return(int val)
{
	return val + __atomic_add(val, &get_lowcore()->preempt_count);
}

since __atomic_add_const() won't return the original value.

Well.. at least it should not, but the way it is currently implemented it
indeed does sometimes depending on config options - there is room for
improvement. That's my fault - going to address that.

I couldn't find any cover letter for the whole patch series which describes
what this is about, and why it is needed.
It looks like some Rust enablement?

