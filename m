Return-Path: <linux-arch+bounces-10223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305FBA3C5D6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A39E1883572
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C3C21423F;
	Wed, 19 Feb 2025 17:15:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E181F61C;
	Wed, 19 Feb 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985353; cv=none; b=aKGWe1XA4P+QRhOsRBNI6IcudALJSxxONNqPqE7obIuJd5/dzlolxyeKXLlRkrjdS4wKfQr4aC0LIHbebdqgL1qwqyOr1RhrqFVg3j5hyhglDbDUydCwxJnrdZ32mfRf2E539H4fGbA3Z12bZGrxcb+hA39bhBa3onRtu5/xeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985353; c=relaxed/simple;
	bh=QvmJAcxumbdGw5pVgtb8a1HCfpeuwZB04qMbZpB9Smg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GGR/3iYAxCmO+J78hbWDYTwmAovxgKYZ8+6vYxk5pHXvqAT4fjqJq+fsEmalQ7zScmX/ySV1ARKHPO6u9sU8dyILvUrDW8epq+vKTPiavd+xuYgHKvIjEipgkHVw7CAxX+GS5i8gSoH4Dw8MeO5VGAkL9fGeVFofvGUbPgVPyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7D21992009C; Wed, 19 Feb 2025 18:15:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7875792009B;
	Wed, 19 Feb 2025 17:15:48 +0000 (GMT)
Date: Wed, 19 Feb 2025 17:15:48 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Dmitry V. Levin" <ldv@strace.io>
cc: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
    Alexey Gladkov <legion@kernel.org>, 
    Eugene Syromyatnikov <evgsyr@gmail.com>, 
    Charlie Jenkins <charlie@rivosinc.com>, Helge Deller <deller@gmx.de>, 
    Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>, 
    Davide Berardi <berardi.dav@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
    Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
    Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
    Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
    Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
    Stafford Horne <shorne@gmail.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    "David S. Miller" <davem@davemloft.net>, 
    Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
    Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, strace-devel@lists.strace.io, 
    linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
    linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
    linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
    linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
    linux-um@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 2/6] syscall.h: add syscall_set_arguments()
In-Reply-To: <20250217091020.GC18175@strace.io>
Message-ID: <alpine.DEB.2.21.2502191642590.65342@angie.orcam.me.uk>
References: <20250217091020.GC18175@strace.io>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Feb 2025, Dmitry V. Levin wrote:

> This function is going to be needed on all HAVE_ARCH_TRACEHOOK
> architectures to implement PTRACE_SET_SYSCALL_INFO API.
> 
> This partially reverts commit 7962c2eddbfe ("arch: remove unused
> function syscall_set_arguments()") by reusing some of old
> syscall_set_arguments() implementations.
> 
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> ---
>  arch/arc/include/asm/syscall.h        | 14 +++++++++++
>  arch/arm/include/asm/syscall.h        | 13 ++++++++++
>  arch/arm64/include/asm/syscall.h      | 13 ++++++++++
>  arch/csky/include/asm/syscall.h       | 13 ++++++++++
>  arch/hexagon/include/asm/syscall.h    |  7 ++++++
>  arch/loongarch/include/asm/syscall.h  |  8 ++++++
>  arch/mips/include/asm/syscall.h       | 32 ++++++++++++++++++++++++
>  arch/nios2/include/asm/syscall.h      | 11 ++++++++
>  arch/openrisc/include/asm/syscall.h   |  7 ++++++
>  arch/parisc/include/asm/syscall.h     | 12 +++++++++
>  arch/powerpc/include/asm/syscall.h    | 10 ++++++++
>  arch/riscv/include/asm/syscall.h      |  9 +++++++
>  arch/s390/include/asm/syscall.h       |  9 +++++++
>  arch/sh/include/asm/syscall_32.h      | 12 +++++++++
>  arch/sparc/include/asm/syscall.h      | 10 ++++++++
>  arch/um/include/asm/syscall-generic.h | 14 +++++++++++
>  arch/x86/include/asm/syscall.h        | 36 +++++++++++++++++++++++++++
>  arch/xtensa/include/asm/syscall.h     | 11 ++++++++
>  include/asm-generic/syscall.h         | 16 ++++++++++++
>  19 files changed, 257 insertions(+)
> 
> diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
> index 9709256e31c8..89c1e1736356 100644
> --- a/arch/arc/include/asm/syscall.h
> +++ b/arch/arc/include/asm/syscall.h
> @@ -67,6 +67,20 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>  	}
>  }
>  
> +static inline void
> +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> +		      unsigned long *args)
> +{
> +	unsigned long *inside_ptregs = &regs->r0;
> +	unsigned int n = 6;
> +	unsigned int i = 0;
> +
> +	while (n--) {
> +		*inside_ptregs = args[i++];
> +		inside_ptregs--;
> +	}
> +}
> +
>  static inline int
>  syscall_get_arch(struct task_struct *task)
>  {
> diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
> index fe4326d938c1..21927fa0ae2b 100644
> --- a/arch/arm/include/asm/syscall.h
> +++ b/arch/arm/include/asm/syscall.h
> @@ -80,6 +80,19 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
>  }
>  
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 const unsigned long *args)
> +{
> +	memcpy(&regs->ARM_r0, args, 6 * sizeof(args[0]));
> +	/*
> +	 * Also copy the first argument into ARM_ORIG_r0
> +	 * so that syscall_get_arguments() would return it
> +	 * instead of the previous value.
> +	 */
> +	regs->ARM_ORIG_r0 = regs->ARM_r0;
> +}
> +
>  static inline int syscall_get_arch(struct task_struct *task)
>  {
>  	/* ARM tasks don't change audit architectures on the fly. */
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index ab8e14b96f68..76020b66286b 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -73,6 +73,19 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
>  }
>  
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 const unsigned long *args)
> +{
> +	memcpy(&regs->regs[0], args, 6 * sizeof(args[0]));
> +	/*
> +	 * Also copy the first argument into orig_x0
> +	 * so that syscall_get_arguments() would return it
> +	 * instead of the previous value.
> +	 */
> +	regs->orig_x0 = regs->regs[0];
> +}
> +
>  /*
>   * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
>   * AArch64 has the same system calls both on little- and big- endian.
> diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
> index 0de5734950bf..30403f7a0487 100644
> --- a/arch/csky/include/asm/syscall.h
> +++ b/arch/csky/include/asm/syscall.h
> @@ -59,6 +59,19 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
>  	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
>  }
>  
> +static inline void
> +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> +		      const unsigned long *args)
> +{
> +	memcpy(&regs->a0, args, 6 * sizeof(regs->a0));
> +	/*
> +	 * Also copy the first argument into orig_x0
                                                  ^
 Typo here, s/orig_x0/orig_a0/; see below.

> +	 * so that syscall_get_arguments() would return it
> +	 * instead of the previous value.
> +	 */
> +	regs->orig_a0 = regs->a0;

 Also:

> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 056aa1b713e2..ea050b23d428 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -120,6 +137,21 @@ static inline void syscall_get_arguments(struct task_struct *task,
>  		mips_get_syscall_arg(args++, task, regs, i++);
>  }
>  
> +static inline void syscall_set_arguments(struct task_struct *task,
> +					 struct pt_regs *regs,
> +					 unsigned long *args)
> +{
> +	unsigned int i = 0;
> +	unsigned int n = 6;
> +
> +	/* O32 ABI syscall() */
> +	if (mips_syscall_is_indirect(task, regs))
> +		i++;

-- given MIPS syscall_set_nr() implementation in 3/6 this conditional is 
supposed to never be true.  Should it be BUG_ON() or discarded entirely?

> +
> +	while (n--)
> +		mips_set_syscall_arg(args++, task, regs, i++);
> +}
> +
>  extern const unsigned long sys_call_table[];
>  extern const unsigned long sys32_call_table[];
>  extern const unsigned long sysn32_call_table[];

  Maciej

