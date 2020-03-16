Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8031869F4
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgCPLWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 07:22:12 -0400
Received: from foss.arm.com ([217.140.110.172]:46470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbgCPLWM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 07:22:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8FC430E;
        Mon, 16 Mar 2020 04:22:11 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8238C3F52E;
        Mon, 16 Mar 2020 04:22:08 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:22:06 +0000
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
Message-ID: <20200316112205.GE3005@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp>
 <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp>
 <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 16, 2020 at 10:55:00AM +0000, Vincenzo Frascino wrote:
> On 3/16/20 10:34 AM, Catalin Marinas wrote:
> >> I tried to fine grain the headers as much as I could in order to avoid
> >> unneeded/unwanted inclusions:
> >>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
> >>    arch/arm64/kernel/vdso32/vgettimeofday.c).
> > 
> > I see. But the test is probably useless. With 4K pages, TASK_SIZE_32 is
> > 1UL << 32, so you can't have a u32 greater than this. So I'd argue that
> > the ABI compatibility here doesn't matter.
> > 
> > With 16K or 64K pages, TASK_SIZE_32 is slightly smaller but arm32 never
> > supported it.
> > 
> > What's the side-effect of dropping this check altogether?
> 
> The main side-effect is that arm32 and arm64 compat have a different behavior,
> that it is what we want to avoid.
> 
> The vdsotest [1] I am using, verifies all the side conditions with respect to
> the ABI, which we are now compatible with. Removing those checks would break
> this condition.

As I said above, I don't see how removing 'if ((u32)ts >= (1UL << 32))'
makes any difference. This check was likely removed by the compiler
already.

Also, userspace doesn't have a trivial way to figure out TASK_SIZE and I
can't see anything that tests this in the vdsotest (though I haven't
spent that much time looking). If it's hard-coded, note that arm32
TASK_SIZE is different from TASK_SIZE_32 on arm64.

Can you tell what actually is failing in vdsotest if you remove the
TASK_SIZE_32 checks in the arm64 compat vdso?

-- 
Catalin
