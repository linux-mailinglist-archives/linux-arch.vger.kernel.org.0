Return-Path: <linux-arch+bounces-1976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9A845D5E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F681C23DCD
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EC3FFE;
	Thu,  1 Feb 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="JYoDOZUn"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732701FDB;
	Thu,  1 Feb 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805324; cv=none; b=EkNH8bjaatOQUiA+3/jiilXGi7ZmmbFyUaAUld4rR4CKzNH5M2iVZu1GRbBuYrqIdTY6G02+pu0UPFNklFuDDm91MtdvD1dU64r1T26B7jVtIvcknu5491bivtRKU/u6uY/M7qZbNUimJ27kPtZrbgALFVnxW+eGRUaGIvctdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805324; c=relaxed/simple;
	bh=v7yRlc8JbVP7rQJskWuydHy/lSbUiMt1FoOZpCEGI8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIul/qem1xE9gWKnBiBTZPCVtkomdXXrxh7lrawSEnJEIhuezmqKsYJSQwsCoPX1Q99yAMGugP/OHN3yZBrcgJvHSyOCZUFb6SoBZK3uizdPVszfvMdwRQszGYzJYl0F93+bbQdCO8tSdKK3dKA/Sgrzi+XM1hSp9ZGK8uxw4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=JYoDOZUn; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1706805314;
	bh=v7yRlc8JbVP7rQJskWuydHy/lSbUiMt1FoOZpCEGI8U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JYoDOZUn8MgttQo2WLaIYWcNLO+qZHiVJvxm3Rm4lci1/VFs7m/TrprXoqL7q7DBv
	 9+nWGS9OcbqYLiZ1L2l1ZbwFkIYhg/ALGXbmXOuyMPcP9lroSSx3Xgffb6g4bKhvWs
	 jq2oNQLazmxM1vjcP3757V8G8KHEKEF9pIvoILCs=
Received: from [IPv6:240e:358:11d4:5700:dc73:854d:832e:4] (unknown [IPv6:240e:358:11d4:5700:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0BB2866EF0;
	Thu,  1 Feb 2024 11:35:08 -0500 (EST)
Message-ID: <9d1d51e69c3f96bf5992e9a988969515ba97f883.camel@xry111.site>
Subject: Re: [PATCH 1/3] ptrace: Introduce exception_ip arch hook
From: Xi Ruoyao <xry111@xry111.site>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Oleg Nesterov <oleg@redhat.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton
 <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 02 Feb 2024 00:35:01 +0800
In-Reply-To: <20240201-exception_ip-v1-1-aa26ab3ee0b5@flygoat.com>
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
	 <20240201-exception_ip-v1-1-aa26ab3ee0b5@flygoat.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 15:46 +0000, Jiaxun Yang wrote:
> On architectures with delay slot, architecture level instruction
> pointer (or program counter) in pt_regs may differ from where
> exception was triggered.
>=20
> Introduce exception_ip hook to invoke architecture code and determine
> actual instruction pointer to the exception.
>=20
> Link:
> https://lore.kernel.org/lkml/00d1b813-c55f-4365-8d81-d70258e10b16@app.fas=
tmail.com/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

How about adding something like

#ifndef arch_exception_ip
#define exception_ip(regs) instruction_pointer(regs)
#else
#define exception_ip(regs) arch_exception_ip(regs)
#endif

into a generic header, instead of having to add exception_ip definition
everywhere?

> ---
> =C2=A0arch/alpha/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 1 +
> =C2=A0arch/arc/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0arch/arm/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0arch/csky/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0arch/hexagon/include/uapi/asm/ptrace.h | 1 +
> =C2=A0arch/loongarch/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0arch/m68k/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0arch/microblaze/include/asm/ptrace.h=C2=A0=C2=A0 | 3 ++-
> =C2=A0arch/mips/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0arch/mips/kernel/ptrace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
> =C2=A0arch/nios2/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 ++-
> =C2=A0arch/openrisc/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0arch/parisc/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 +
> =C2=A0arch/s390/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0arch/sparc/include/asm/ptrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 ++
> =C2=A0arch/um/include/asm/ptrace-generic.h=C2=A0=C2=A0 | 1 +
> =C2=A016 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/alpha/include/asm/ptrace.h
> b/arch/alpha/include/asm/ptrace.h
> index 3557ce64ed21..1ded3f2d09e9 100644
> --- a/arch/alpha/include/asm/ptrace.h
> +++ b/arch/alpha/include/asm/ptrace.h
> @@ -8,6 +8,7 @@
> =C2=A0#define arch_has_single_step()		(1)
> =C2=A0#define user_mode(regs) (((regs)->ps & 8) !=3D 0)
> =C2=A0#define instruction_pointer(regs) ((regs)->pc)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0#define current_user_stack_pointer() rdusp()
> =C2=A0
> diff --git a/arch/arc/include/asm/ptrace.h
> b/arch/arc/include/asm/ptrace.h
> index 00b9318e551e..94084f1048df 100644
> --- a/arch/arc/include/asm/ptrace.h
> +++ b/arch/arc/include/asm/ptrace.h
> @@ -105,6 +105,7 @@ struct callee_regs {
> =C2=A0#endif
> =C2=A0
> =C2=A0#define instruction_pointer(regs)	((regs)->ret)
> +#define exception_ip(regs)		instruction_pointer(regs)
> =C2=A0#define profile_pc(regs)		instruction_pointer(regs)
> =C2=A0
> =C2=A0/* return 1 if user mode or 0 if kernel mode */
> diff --git a/arch/arm/include/asm/ptrace.h
> b/arch/arm/include/asm/ptrace.h
> index 7f44e88d1f25..fb4dc23eba78 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -89,6 +89,7 @@ static inline long regs_return_value(struct pt_regs
> *regs)
> =C2=A0}
> =C2=A0
> =C2=A0#define instruction_pointer(regs)	(regs)->ARM_pc
> +#define
> exception_ip(regs)			instruction_pointer(regs)
> =C2=A0
> =C2=A0#ifdef CONFIG_THUMB2_KERNEL
> =C2=A0#define frame_pointer(regs) (regs)->ARM_r7
> diff --git a/arch/csky/include/asm/ptrace.h
> b/arch/csky/include/asm/ptrace.h
> index 0634b7895d81..a738630e64b0 100644
> --- a/arch/csky/include/asm/ptrace.h
> +++ b/arch/csky/include/asm/ptrace.h
> @@ -22,6 +22,7 @@
> =C2=A0
> =C2=A0#define user_mode(regs) (!((regs)->sr & PS_S))
> =C2=A0#define instruction_pointer(regs) ((regs)->pc)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0#define trap_no(regs) ((regs->sr >> 16) & 0xff)
> =C2=A0
> diff --git a/arch/hexagon/include/uapi/asm/ptrace.h
> b/arch/hexagon/include/uapi/asm/ptrace.h
> index 2a3ea14ad9b9..846471936237 100644
> --- a/arch/hexagon/include/uapi/asm/ptrace.h
> +++ b/arch/hexagon/include/uapi/asm/ptrace.h
> @@ -25,6 +25,7 @@
> =C2=A0#include <asm/registers.h>
> =C2=A0
> =C2=A0#define instruction_pointer(regs) pt_elr(regs)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs) ((regs)->r29)
> =C2=A0
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> diff --git a/arch/loongarch/include/asm/ptrace.h
> b/arch/loongarch/include/asm/ptrace.h
> index f3ddaed9ef7f..a34327f0e69d 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -160,6 +160,7 @@ static inline void regs_set_return_value(struct
> pt_regs *regs, unsigned long val
> =C2=A0}
> =C2=A0
> =C2=A0#define instruction_pointer(regs) ((regs)->csr_era)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0
> =C2=A0extern void die(const char *str, struct pt_regs *regs);
> diff --git a/arch/m68k/include/asm/ptrace.h
> b/arch/m68k/include/asm/ptrace.h
> index ea5a80ca1ab3..cb553e2ec73a 100644
> --- a/arch/m68k/include/asm/ptrace.h
> +++ b/arch/m68k/include/asm/ptrace.h
> @@ -13,6 +13,7 @@
> =C2=A0
> =C2=A0#define user_mode(regs) (!((regs)->sr & PS_S))
> =C2=A0#define instruction_pointer(regs) ((regs)->pc)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0#define current_pt_regs() \
> =C2=A0	(struct pt_regs *)((char *)current_thread_info() +
> THREAD_SIZE) - 1
> diff --git a/arch/microblaze/include/asm/ptrace.h
> b/arch/microblaze/include/asm/ptrace.h
> index bfcb89df5e26..974c00fa7212 100644
> --- a/arch/microblaze/include/asm/ptrace.h
> +++ b/arch/microblaze/include/asm/ptrace.h
> @@ -12,7 +12,8 @@
> =C2=A0#define user_mode(regs)			(!kernel_mode(regs))
> =C2=A0
> =C2=A0#define instruction_pointer(regs)	((regs)->pc)
> -#define profile_pc(regs)		instruction_pointer(regs)
> +#define
> exception_ip(regs)			instruction_pointer(regs)
> +#define
> profile_pc(regs)			instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs)	((regs)->r1)
> =C2=A0
> =C2=A0static inline long regs_return_value(struct pt_regs *regs)
> diff --git a/arch/mips/include/asm/ptrace.h
> b/arch/mips/include/asm/ptrace.h
> index daf3cf244ea9..97589731fd40 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -154,6 +154,7 @@ static inline long regs_return_value(struct
> pt_regs *regs)
> =C2=A0}
> =C2=A0
> =C2=A0#define instruction_pointer(regs) ((regs)->cp0_epc)
> +extern unsigned long exception_ip(struct pt_regs *regs);
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0
> =C2=A0extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, lo=
ng
> syscall);
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index d9df543f7e2c..59288c13b581 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -31,6 +31,7 @@
> =C2=A0#include <linux/seccomp.h>
> =C2=A0#include <linux/ftrace.h>
> =C2=A0
> +#include <asm/branch.h>
> =C2=A0#include <asm/byteorder.h>
> =C2=A0#include <asm/cpu.h>
> =C2=A0#include <asm/cpu-info.h>
> @@ -48,6 +49,12 @@
> =C2=A0#define CREATE_TRACE_POINTS
> =C2=A0#include <trace/events/syscalls.h>
> =C2=A0
> +unsigned long exception_ip(struct pt_regs *regs)
> +{
> +	return exception_epc(regs);
> +}
> +EXPORT_SYMBOL(exception_ip);
> +
> =C2=A0/*
> =C2=A0 * Called by kernel/ptrace.c when detaching..
> =C2=A0 *
> diff --git a/arch/nios2/include/asm/ptrace.h
> b/arch/nios2/include/asm/ptrace.h
> index 9da34c3022a2..136f5679ae79 100644
> --- a/arch/nios2/include/asm/ptrace.h
> +++ b/arch/nios2/include/asm/ptrace.h
> @@ -66,7 +66,8 @@ struct switch_stack {
> =C2=A0#define user_mode(regs)	(((regs)->estatus & ESTATUS_EU))
> =C2=A0
> =C2=A0#define instruction_pointer(regs)	((regs)->ra)
> -#define profile_pc(regs)		instruction_pointer(regs)
> +#define
> exception_ip(regs)			instruction_pointer(regs)
> +#define
> profile_pc(regs)			instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs)	((regs)->sp)
> =C2=A0extern void show_regs(struct pt_regs *);
> =C2=A0
> diff --git a/arch/openrisc/include/asm/ptrace.h
> b/arch/openrisc/include/asm/ptrace.h
> index 375147ff71fc..67c28484d17e 100644
> --- a/arch/openrisc/include/asm/ptrace.h
> +++ b/arch/openrisc/include/asm/ptrace.h
> @@ -67,6 +67,7 @@ struct pt_regs {
> =C2=A0#define STACK_FRAME_OVERHEAD=C2=A0 128=C2=A0 /* size of minimum sta=
ck frame */
> =C2=A0
> =C2=A0#define instruction_pointer(regs)	((regs)->pc)
> +#define
> exception_ip(regs)			instruction_pointer(regs)
> =C2=A0#define user_mode(regs)			(((regs)->sr &
> SPR_SR_SM) =3D=3D 0)
> =C2=A0#define user_stack_pointer(regs)	((unsigned long)(regs)->sp)
> =C2=A0#define profile_pc(regs)		instruction_pointer(regs)
> diff --git a/arch/parisc/include/asm/ptrace.h
> b/arch/parisc/include/asm/ptrace.h
> index eea3f3df0823..d7e8dcf26582 100644
> --- a/arch/parisc/include/asm/ptrace.h
> +++ b/arch/parisc/include/asm/ptrace.h
> @@ -17,6 +17,7 @@
> =C2=A0#define user_mode(regs)			(((regs)->iaoq[0] &
> 3) !=3D PRIV_KERNEL)
> =C2=A0#define user_space(regs)		((regs)->iasq[1] !=3D
> PRIV_KERNEL)
> =C2=A0#define instruction_pointer(regs)	((regs)->iaoq[0] & ~3)
> +#define
> exception_ip(regs)			instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs)	((regs)->gr[30])
> =C2=A0unsigned long profile_pc(struct pt_regs *);
> =C2=A0
> diff --git a/arch/s390/include/asm/ptrace.h
> b/arch/s390/include/asm/ptrace.h
> index d28bf8fb2799..a5255b2337af 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -211,6 +211,7 @@ static inline int
> test_and_clear_pt_regs_flag(struct pt_regs *regs, int flag)
> =C2=A0
> =C2=A0#define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) !=3D =
0)
> =C2=A0#define instruction_pointer(regs) ((regs)->psw.addr)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs)((regs)->gprs[15])
> =C2=A0#define profile_pc(regs) instruction_pointer(regs)
> =C2=A0
> diff --git a/arch/sparc/include/asm/ptrace.h
> b/arch/sparc/include/asm/ptrace.h
> index d1419e669027..41ae186f2245 100644
> --- a/arch/sparc/include/asm/ptrace.h
> +++ b/arch/sparc/include/asm/ptrace.h
> @@ -63,6 +63,7 @@ extern union global_cpu_snapshot
> global_cpu_snapshot[NR_CPUS];
> =C2=A0#define force_successful_syscall_return() set_thread_noerror(1)
> =C2=A0#define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
> =C2=A0#define instruction_pointer(regs) ((regs)->tpc)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define instruction_pointer_set(regs, val) do { \
> =C2=A0		(regs)->tpc =3D (val); \
> =C2=A0		(regs)->tnpc =3D (val)+4; \
> @@ -142,6 +143,7 @@ static inline bool pt_regs_clear_syscall(struct
> pt_regs *regs)
> =C2=A0
> =C2=A0#define user_mode(regs) (!((regs)->psr & PSR_PS))
> =C2=A0#define instruction_pointer(regs) ((regs)->pc)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0#define user_stack_pointer(regs) ((regs)->u_regs[UREG_FP])
> =C2=A0unsigned long profile_pc(struct pt_regs *);
> =C2=A0#else /* (!__ASSEMBLY__) */
> diff --git a/arch/um/include/asm/ptrace-generic.h
> b/arch/um/include/asm/ptrace-generic.h
> index adf91ef553ae..f9ada287ca12 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -26,6 +26,7 @@ struct pt_regs {
> =C2=A0#define PT_REGS_SYSCALL_NR(r) UPT_SYSCALL_NR(&(r)->regs)
> =C2=A0
> =C2=A0#define instruction_pointer(regs) PT_REGS_IP(regs)
> +#define exception_ip(regs) instruction_pointer(regs)
> =C2=A0
> =C2=A0#define PTRACE_OLDSETOPTIONS 21
> =C2=A0
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

