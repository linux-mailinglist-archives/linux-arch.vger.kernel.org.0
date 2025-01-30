Return-Path: <linux-arch+bounces-9954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96600A22A45
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2025 10:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297DB3A3A8F
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2025 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D91B4253;
	Thu, 30 Jan 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GwOLwzTm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184518F2DD;
	Thu, 30 Jan 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229263; cv=none; b=TijTey/3tCMVkuAePfQs1bDkIU15vnydKOsVJohXkC3MbaICmiDZJnPfixiECU+poYX2fAI8Xo2CuwHjnE7FYSO4xwytt+/NztsdnFx0aKTbYpVtHElAFq/uz1w+u8CgKraq9Q6HcwvM7jH82luNva6ZVHooJ2JPwz7lzA7Ok4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229263; c=relaxed/simple;
	bh=gKOaLLBI8U3R5sv9YWNTY+T70jxJcyjJHQyFlHGWRlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Um4Xt4MikYcykLrzJdzPsqTVUCTeY5MPWfNlXeSKMEGk33PC4UZKXPYPBSwC40iqdvKeCzQbt4ZNQNuqHf/JVo42r80Ztt+Yp+KIGm8S4fYjzV8ZPEpariISUSQgaVwLqKxkyZx0fWP2v0b3wTEEvfXfhEgnJ1P6PgoN27zHW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GwOLwzTm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U5OAmX012556;
	Thu, 30 Jan 2025 09:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ENEt8TNFIIQna4oUkl6ZCfI1AZ3n0X
	WJoliPvJndSUA=; b=GwOLwzTmFKIJ+S/G/NDcueBX18kFIQDozO4Emp5FNyAE83
	LlV8nb0N5Bm6GmF5rJqj+NqKVtw41Fu0SdvorBdgMNdaaBYADm/bLytgCkSMwXuA
	iwBm6dlH41JVpb/ySdvAi7UUJVaC/ZdRGzHWxxHx7TTRfvejugAD9ULeVB2y7y6P
	SAsUNb0P96I/u5Laf36dVl5YhZS2/9Dx+cCv0EEOC1hCePh9PimW1Fq0lCgz8Npv
	BG1V0Ms7SqQOkVthuXoWasQs9yCyIkH3v4NRg30eAfifJVDwlW+u1J8spbIuh7M/
	fmg4P7PW5a4zD9z6VHTFRUR0ynPP4BvYS/C0wQmQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g38810r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:25:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50U9P48j030487;
	Thu, 30 Jan 2025 09:25:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44g38810r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:25:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U5FMJt018905;
	Thu, 30 Jan 2025 09:25:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dd01n2ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:25:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50U9PSJL47907140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 09:25:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F98F200D7;
	Thu, 30 Jan 2025 08:33:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9EC7200D6;
	Thu, 30 Jan 2025 08:33:03 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jan 2025 08:33:03 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Eugene Syromyatnikov
 <evgsyr@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, Renzo Davoli
 <renzo@cs.unibo.it>,
        Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
        Vineet Gupta <vgupta@kernel.org>,
        Russell
 King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
        Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen
 <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne
 <shorne@gmail.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe
 Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Richard Weinberger
 <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel
 <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/6] syscall.h: add syscall_set_arguments() and
 syscall_set_return_value()
In-Reply-To: <20250128091626.GB8601@strace.io> (Dmitry V. Levin's message of
	"Tue, 28 Jan 2025 11:16:26 +0200")
References: <20250128091626.GB8601@strace.io>
Date: Thu, 30 Jan 2025 09:33:03 +0100
Message-ID: <yt9dwmecya4g.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _PT8AYkS--OiAY9k3Cx2fgjUXkzP0l7n
X-Proofpoint-GUID: HYavPV8yQaPduF9AV11zSUaS5ZQTGJu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=851 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300069

"Dmitry V. Levin" <ldv@strace.io> writes:

> These functions are going to be needed on all HAVE_ARCH_TRACEHOOK
> architectures to implement PTRACE_SET_SYSCALL_INFO API.
>
> This partially reverts commit 7962c2eddbfe ("arch: remove unused
> function syscall_set_arguments()") by reusing some of old
> syscall_set_arguments() implementations.
>
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/arc/include/asm/syscall.h        | 14 +++++++++++
>  arch/arm/include/asm/syscall.h        | 13 ++++++++++
>  arch/arm64/include/asm/syscall.h      | 13 ++++++++++
>  arch/csky/include/asm/syscall.h       | 13 ++++++++++
>  arch/hexagon/include/asm/syscall.h    | 14 +++++++++++
>  arch/loongarch/include/asm/syscall.h  |  8 ++++++
>  arch/mips/include/asm/syscall.h       | 32 ++++++++++++++++++++++++
>  arch/nios2/include/asm/syscall.h      | 11 ++++++++
>  arch/openrisc/include/asm/syscall.h   |  7 ++++++
>  arch/parisc/include/asm/syscall.h     | 12 +++++++++
>  arch/powerpc/include/asm/syscall.h    | 10 ++++++++
>  arch/riscv/include/asm/syscall.h      |  9 +++++++
>  arch/s390/include/asm/syscall.h       | 12 +++++++++
>  arch/sh/include/asm/syscall_32.h      | 12 +++++++++
>  arch/sparc/include/asm/syscall.h      | 10 ++++++++
>  arch/um/include/asm/syscall-generic.h | 14 +++++++++++
>  arch/x86/include/asm/syscall.h        | 36 +++++++++++++++++++++++++++
>  arch/xtensa/include/asm/syscall.h     | 11 ++++++++
>  include/asm-generic/syscall.h         | 16 ++++++++++++
>  19 files changed, 267 insertions(+)
>
> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> index 27e3d804b311..b3dd883699e7 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -78,6 +78,18 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  	args[0] = regs->orig_gpr2 & mask;
>  }
>  
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 const unsigned long *args)
> +{
> +	unsigned int n = 6;
> +
> +	while (n-- > 0)
> +		if (n > 0)
> +			regs->gprs[2 + n] = args[n];
> +	regs->orig_gpr2 = args[0];
> +}

Could that be changed to something like:

for (int n = 1; n < 6; n++)
        regs->gprs[2 + n] = args[n];
regs->orig_gpr2 = args[0];

I think this is way easier to parse.

