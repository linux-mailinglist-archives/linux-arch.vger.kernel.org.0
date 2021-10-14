Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14F42D55A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhJNIst (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 04:48:49 -0400
Received: from [115.28.160.31] ([115.28.160.31]:47816 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhJNIsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 04:48:46 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2021 04:48:45 EDT
Received: from [100.100.57.93] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1E9ED60184;
        Thu, 14 Oct 2021 16:37:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1634200620; bh=dGzC6c3/YezH/m3Bv9p7hGmN6lTCScWaeRYmlxTIHw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ce4KLPqdlJsRkL+guN9T6iJ6eIm4VgRwWbn9w3LmlnBEnG0RurI4eln8ot9+DMpDi
         y96zrhqLLVrCHj9eSqljScFkuHP0xeYdfruIFLXkDlovX7buO1V9Jyp1zmyaSubpUP
         KcvuwBuZRIX33BFQaq79UjC68BaK7sgGNity7Z9Y=
Message-ID: <ddfbb616-9df1-9a92-3171-d534bddbd3d1@xen0n.name>
Date:   Thu, 14 Oct 2021 16:36:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0a1
Subject: Re: [PATCH v3 1/2] MIPS: convert syscall to generic entry
Content-Language: en-US
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>,
        tsbogend@alpha.franken.de, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, zhouyu@wanyeetech.com, hns@goldelico.com,
        Yanteng Si <siyanteng@loongson.cn>
References: <cover.1634177547.git.chenfeiyang@loongson.cn>
 <31a97087b56c703606b8d871ac35d2192928fe6b.1634177547.git.chenfeiyang@loongson.cn>
From:   WANG Xuerui <i.kernel@xen0n.name>
In-Reply-To: <31a97087b56c703606b8d871ac35d2192928fe6b.1634177547.git.chenfeiyang@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Feiyang,

On 2021/10/14 16:32, Feiyang Chen wrote:
> Convert MIPS syscall to use the generic entry infrastructure from
> kernel/entry/*.
>
> There are a few special things on MIPS:
>
> - There is one type of syscall on MIPS32 (scall32-o32) and three types
> of syscalls on MIPS64 (scall64-o32, scall64-n32 and scall64-n64). Now
> convert to C code to handle different types of syscalls.
>
> - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
> save_static_function() wrapper is used to save static registers. Now
> SAVE_STATIC is used in handle_sys before calling do_syscall(), so the
> save_static_function() wrapper can be removed.
>
> - For sigreturn/rt_sigreturn and sysmips, inline assembly is used to
> jump to syscall_exit directly for skipping setting the error flag and
> restoring all registers. Now use regs->regs[27] to mark whether to
> handle the error flag and restore all registers in handle_sys, so these
> functions can return normally as other architecture.
>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
> ---
>  arch/mips/Kconfig                         |   1 +
>  arch/mips/include/asm/entry-common.h      |  13 ++
>  arch/mips/include/asm/ptrace.h            |   8 +-
>  arch/mips/include/asm/sim.h               |  70 -------
>  arch/mips/include/asm/syscall.h           |   5 +
>  arch/mips/include/asm/thread_info.h       |  17 +-
>  arch/mips/include/uapi/asm/ptrace.h       |   7 +-
>  arch/mips/kernel/Makefile                 |  14 +-
>  arch/mips/kernel/entry.S                  |  75 ++------
>  arch/mips/kernel/linux32.c                |   1 -
>  arch/mips/kernel/ptrace.c                 |  78 --------
>  arch/mips/kernel/scall.S                  | 137 +++++++++++++
>  arch/mips/kernel/scall32-o32.S            | 223 ----------------------
>  arch/mips/kernel/scall64-n32.S            | 107 -----------
>  arch/mips/kernel/scall64-n64.S            | 116 -----------
>  arch/mips/kernel/scall64-o32.S            | 221 ---------------------
>  arch/mips/kernel/signal.c                 |  37 ++--
>  arch/mips/kernel/signal_n32.c             |  16 +-
>  arch/mips/kernel/signal_o32.c             |  31 +--
>  arch/mips/kernel/syscall.c                | 148 +++++++++++---
>  arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
>  arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
>  23 files changed, 354 insertions(+), 995 deletions(-)
>  create mode 100644 arch/mips/include/asm/entry-common.h
>  delete mode 100644 arch/mips/include/asm/sim.h
>  create mode 100644 arch/mips/kernel/scall.S
>  delete mode 100644 arch/mips/kernel/scall32-o32.S
>  delete mode 100644 arch/mips/kernel/scall64-n32.S
>  delete mode 100644 arch/mips/kernel/scall64-n64.S
>  delete mode 100644 arch/mips/kernel/scall64-o32.S
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 1291774a2fa5..debd125100ad 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -32,6 +32,7 @@ config MIPS
>  	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
> +	select GENERIC_ENTRY
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_IOMAP
>  	select GENERIC_IRQ_PROBE
> diff --git a/arch/mips/include/asm/entry-common.h b/arch/mips/include/asm/entry-common.h
> new file mode 100644
> index 000000000000..0fe2a098ded9
> --- /dev/null
> +++ b/arch/mips/include/asm/entry-common.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
> +#define ARCH_LOONGARCH_ENTRY_COMMON_H
Do you intend to say "MIPS"? ;-)
> +
> +#include <linux/sched.h>
> +#include <linux/processor.h>
> +
> +static inline bool on_thread_stack(void)
> +{
> +	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
> +}
> +
> +#endif
