Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F27186930
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 11:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgCPKfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 06:35:04 -0400
Received: from foss.arm.com ([217.140.110.172]:45780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbgCPKfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 06:35:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AE21FB;
        Mon, 16 Mar 2020 03:35:03 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF7E33F534;
        Mon, 16 Mar 2020 03:35:00 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:34:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Message-ID: <20200316103437.GD3005@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp>
 <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 16, 2020 at 09:42:32AM +0000, Vincenzo Frascino wrote:
> you should not really work on Sunday ;-)

I was getting bored ;).

> On 3/15/20 6:30 PM, Catalin Marinas wrote:
> > On Fri, Mar 13, 2020 at 03:43:37PM +0000, Vincenzo Frascino wrote:
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/vdso/processor.h
> >> @@ -0,0 +1,31 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (C) 2020 ARM Ltd.
> >> + */
> >> +#ifndef __ASM_VDSO_PROCESSOR_H
> >> +#define __ASM_VDSO_PROCESSOR_H
> >> +
> >> +#ifndef __ASSEMBLY__
> >> +
> >> +#include <asm/page-def.h>
> >> +
> >> +#ifdef CONFIG_COMPAT
> >> +#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
> >> +/*
> >> + * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
> >> + * by the compat vectors page.
> >> + */
> >> +#define TASK_SIZE_32		UL(0x100000000)
> >> +#else
> >> +#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
> >> +#endif /* CONFIG_ARM64_64K_PAGES */
> >> +#endif /* CONFIG_COMPAT */
> > 
> > Just curious, what's TASK_SIZE_32 used for in the vDSO code? You don't
> > seem to move TASK_SIZE.
> > 
> 
> I tried to fine grain the headers as much as I could in order to avoid
> unneeded/unwanted inclusions:
>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
>    arch/arm64/kernel/vdso32/vgettimeofday.c).

I see. But the test is probably useless. With 4K pages, TASK_SIZE_32 is
1UL << 32, so you can't have a u32 greater than this. So I'd argue that
the ABI compatibility here doesn't matter.

With 16K or 64K pages, TASK_SIZE_32 is slightly smaller but arm32 never
supported it.

What's the side-effect of dropping this check altogether?

-- 
Catalin
