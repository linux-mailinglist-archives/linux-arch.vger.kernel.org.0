Return-Path: <linux-arch+bounces-9937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86351A20CDA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150F51677B3
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2421D5AD3;
	Tue, 28 Jan 2025 15:20:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA221CAA8A;
	Tue, 28 Jan 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077606; cv=none; b=bKX2WDqiVSv0JPhXg5fcXkqL+LukGlkoC2e7UZe857FITq/cMmchsoIEBSxI9O2Yf3RSkqSb9+NtD0eyy8buJdf5R1lqnmNrLAAKY/R6MjTKu4XtA/HWeA6eLImzf9jLQJ6d7rcivrgUuUSv+mINyxYwJ5lIVsph6BP4Zhd/+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077606; c=relaxed/simple;
	bh=gEEe3ytPfkoQKjM3T2pAQfISERlcVe7TiJOsIheAWfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bc0n7h18QtTavdpJcQN+9NPcRheY3XAFSTILyNJrHKuTZ/IaTs6c3fDcG/Nd8ikR+EhW0jU3mk1fdM1T2AVujQqvCiIavBpYLbN5BA/rI+OwT0RrG20lHzarALIM6/Q8oTdtJvARfkg6S67sLByclCMSu2bn8lcrCs5EVXYGtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Yj82D1NL5z9sSh;
	Tue, 28 Jan 2025 16:13:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cq2jNfGuglH; Tue, 28 Jan 2025 16:13:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Yj82D06Ztz9sSX;
	Tue, 28 Jan 2025 16:13:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DE8B98B76C;
	Tue, 28 Jan 2025 16:13:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id iuMElj2ydnSp; Tue, 28 Jan 2025 16:13:55 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E34BB8B763;
	Tue, 28 Jan 2025 16:13:52 +0100 (CET)
Message-ID: <e76df471-1346-459a-9f24-fa053d7dcbe8@csgroup.eu>
Date: Tue, 28 Jan 2025 16:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] syscall.h: introduce syscall_set_nr()
To: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>
Cc: Alexey Gladkov <legion@kernel.org>, Charlie Jenkins
 <charlie@rivosinc.com>, Eugene Syromyatnikov <evgsyr@gmail.com>,
 Mike Frysinger <vapier@gentoo.org>, Renzo Davoli <renzo@cs.unibo.it>,
 Davide Berardi <berardi.dav@gmail.com>, strace-devel@lists.strace.io,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
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
 Arnd Bergmann <arnd@arndb.de>, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20250128091636.GC8601@strace.io>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250128091636.GC8601@strace.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/01/2025 à 10:16, Dmitry V. Levin a écrit :
> Similar to syscall_set_arguments() that complements
> syscall_get_arguments(), introduce syscall_set_nr()
> that complements syscall_get_nr().
> 
> syscall_set_nr() is going to be needed along with
> syscall_set_arguments() on all HAVE_ARCH_TRACEHOOK
> architectures to implement PTRACE_SET_SYSCALL_INFO API.
> 
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/arc/include/asm/syscall.h        | 11 +++++++++++
>   arch/arm/include/asm/syscall.h        | 24 ++++++++++++++++++++++++
>   arch/arm64/include/asm/syscall.h      | 16 ++++++++++++++++
>   arch/hexagon/include/asm/syscall.h    |  7 +++++++
>   arch/loongarch/include/asm/syscall.h  |  7 +++++++
>   arch/m68k/include/asm/syscall.h       |  7 +++++++
>   arch/microblaze/include/asm/syscall.h |  7 +++++++
>   arch/mips/include/asm/syscall.h       | 14 ++++++++++++++
>   arch/nios2/include/asm/syscall.h      |  5 +++++
>   arch/openrisc/include/asm/syscall.h   |  6 ++++++
>   arch/parisc/include/asm/syscall.h     |  7 +++++++
>   arch/powerpc/include/asm/syscall.h    | 10 ++++++++++
>   arch/riscv/include/asm/syscall.h      |  7 +++++++
>   arch/s390/include/asm/syscall.h       | 12 ++++++++++++
>   arch/sh/include/asm/syscall_32.h      | 12 ++++++++++++
>   arch/sparc/include/asm/syscall.h      | 12 ++++++++++++
>   arch/um/include/asm/syscall-generic.h |  5 +++++
>   arch/x86/include/asm/syscall.h        |  7 +++++++
>   arch/xtensa/include/asm/syscall.h     |  7 +++++++
>   include/asm-generic/syscall.h         | 14 ++++++++++++++
>   20 files changed, 197 insertions(+)
> 

> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index 76020b66286b..712daa90e643 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -61,6 +61,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
>   	regs->regs[0] = val;
>   }
>   
> +static inline void syscall_set_nr(struct task_struct *task,
> +				  struct pt_regs *regs,
> +				  int nr)
> +{
> +	regs->syscallno = nr;
> +	if (nr == -1) {
> +		/*
> +		 * When the syscall number is set to -1, the syscall will be
> +		 * skipped.  In this case the syscall return value has to be
> +		 * set explicitly, otherwise the first syscall argument is
> +		 * returned as the syscall return value.
> +		 */
> +		syscall_set_return_value(task, regs, -ENOSYS, 0);
> +	}
> +}
> +
>   #define SYSCALL_MAX_ARGS 6
>   
>   static inline void syscall_get_arguments(struct task_struct *task,

> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 521f279e6b33..7505dcfed247 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -39,6 +39,16 @@ static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>   		return -1;
>   }
>   
> +static inline void syscall_set_nr(struct task_struct *task, struct pt_regs *regs, int nr)
> +{
> +	/*
> +	 * Unlike syscall_get_nr(), syscall_set_nr() can be called only when
> +	 * the target task is stopped for tracing on entering syscall, so
> +	 * there is no need to have the same check syscall_get_nr() has.
> +	 */
> +	regs->gpr[0] = nr;

Doesn't the same as for ARM64 apply here as well ?

> +}
> +
>   static inline void syscall_rollback(struct task_struct *task,
>   				    struct pt_regs *regs)
>   {

