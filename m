Return-Path: <linux-arch+bounces-12126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A086AC6212
	for <lists+linux-arch@lfdr.de>; Wed, 28 May 2025 08:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EAA1BC278E
	for <lists+linux-arch@lfdr.de>; Wed, 28 May 2025 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06911243376;
	Wed, 28 May 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKYtFkTR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2224467F;
	Wed, 28 May 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414284; cv=none; b=IyYU5bB2+GmHjL31BDF8srRWjL7hw6Ov1c8Nwe26SKtgWxAx7BwISHNfeSuk6qAB0vlq3WaIY94kpup9EXRKVYbSQTlGkKgB6p8XA97I0P1Cog2sDWFyXa5ei4NkUldmG3K5kittChqcO1OiKdUnMnCcORFJ/3IZw1rJfFxQnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414284; c=relaxed/simple;
	bh=bB82vmL6a+M31IOUJuuSn5weOdN/FrkXJIDlz5KgiwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga1tK3Dr54eNVjEaG7x4J5TPITtUtpCC1lppvGeQWtowykg/8gGWXgBqKT4hTwkHpkHYZRr4C/Sz+EUKuiawQQrx/RYY7tQTmL43KRDz+65fCSGfUmSNWuKOh4cLOBIgLsMn3VWrXFilVkCFRI7ZmICtFMKpK3Oqueb1QaySBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKYtFkTR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5Zx0t008547;
	Wed, 28 May 2025 06:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BbSHV62Wuvy5Df5zaV9/pLva8CNc8x
	+VcthWIwNtRjw=; b=BKYtFkTRw7R76/ZD9BeOohPHmddfU6KSDpBbXh8/Hmj2d3
	cl65xW+vMHjBdsQrc1ZoE3csck2GaDr9J/ePSSQcnI5WcTNWhAKvBuSrfAJxQUY3
	b/u3ai9mjhsw/S0Wq+zpVEBmvujlq31VzQ3Ouetxv7zRpscFyxppRklrEW27VC2a
	n+IKEJboTMUULmkwoRi5FZIbbMf8YTpx1la43SzNOEuq1l5T8+gczgc+NTtNBamr
	C0ZKfbP88H7xA6qglKR8YQvMcDSkh9Fs0vGL/j2YJCYB8wLNql9ApEh/3CWQUAam
	KXFlVc3BJGd77JK8PTQ+Ja0qedYtM+d3DTifWB2A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb07kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:37:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54S6WLkA019749;
	Wed, 28 May 2025 06:37:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb07kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:37:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54S6FFpc016139;
	Wed, 28 May 2025 06:37:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureuegus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 06:37:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54S6bY8O34144544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 06:37:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781EC2004B;
	Wed, 28 May 2025 06:37:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C463220040;
	Wed, 28 May 2025 06:37:33 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 06:37:33 +0000 (GMT)
Date: Wed, 28 May 2025 08:37:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
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
        Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [RFC RESEND v10 02/14] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <20250528063731.8022B19-hca@linux.ibm.com>
References: <20250527222254.565881-1-lyude@redhat.com>
 <20250527222254.565881-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527222254.565881-3-lyude@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1NiBTYWx0ZWRfX0T/cYI9jB324 vSOkEmOl/7vl/+6HuElcS05NMxCHyCHZKZUa7rWQoTV2IKtC+vCc9aIlSWRARa9fqEQABto5bvT zS5vjcJDKYXmd/2xx2JaERYo/JYPMwDyQKNJ/iCvvGY5MfNfA79Ppf84B/iY5viEHG8YAZI5KDD
 VHwUVyIWDTEPeOowg8agh2dZiByTvUE1CO0alL/yQUebOWcVxr5wJlf5h1s84FuVsh9trNEPsc3 z7R7vBbotBMpN3UTg/WY5qJBin5NB7Vod4IeuPVPysagNK/nLwz583gyxObIoFlbOTrm3LKKvjK BmfxjmphNEAElmmgKkDKPaFjOlCcdIKrFCIaIRXApSeq2ZqHdvjPAh5e2WcdkuXSNLYjqYamdMD
 yhNZP5Ebc0znmiYKJ2BUvJNzkwqo61fpjv/QXBZHXg6Aq24Uydz1r79z0AEKCIumHaakx+pj
X-Proofpoint-ORIG-GUID: Po87WT_2gKohl3MVVII4-9DCSMQdYQMn
X-Authority-Analysis: v=2.4 cv=bt5MBFai c=1 sm=1 tr=0 ts=6836af34 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=sCjic1ysK2PjgQY2DYoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dwv2dCkek_F3F7nKzn0VlVIce0MIHx1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=796
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280056

On Tue, May 27, 2025 at 06:21:43PM -0400, Lyude Paul wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> In order to use preempt_count() to tracking the interrupt disable
> nesting level, __preempt_count_{add,sub}_return() are introduced, as
> their name suggest, these primitives return the new value of the
> preempt_count() after changing it. The following example shows the usage
> of it in local_interrupt_disable():
> 
> 	// increase the HARDIRQ_DISABLE bit
> 	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);
> 
> 	// if it's the first-time increment, then disable the interrupt
> 	// at hardware level.
> 	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
> 		local_irq_save(flags);
> 		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> 	}
> 
> Having these primitives will avoid a read of preempt_count() after
> changing preempt_count() on certain architectures.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> ---
> V10:
> * Add commit message I forgot
> * Rebase against latest pcpu_hot changes
> 
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

This is still wrong and needs to be changed to:

static __always_inline int __preempt_count_add_return(int val)
{
	return val + __atomic_add(val, &get_lowcore()->preempt_count);
}

