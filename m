Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F860A4FA
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiJXMUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiJXMTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 08:19:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 009D97B5AD;
        Mon, 24 Oct 2022 04:58:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA95D6E;
        Mon, 24 Oct 2022 04:56:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A90F3F7B4;
        Mon, 24 Oct 2022 04:56:06 -0700 (PDT)
Date:   Mon, 24 Oct 2022 12:56:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>, peterz@infradead.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, arnd@arndb.de,
        palmer@rivosinc.com, tglx@linutronix.de, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for
 noinstr
Message-ID: <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
 <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
 <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 08:29:28PM +0800, Guo Ren wrote:
> Hi Mark and Lai,
> 
> On Thu, Oct 20, 2022 at 5:15 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sat, Oct 08, 2022 at 09:54:39AM +0800, Guo Ren wrote:
> > > On Mon, Oct 3, 2022 at 7:39 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Sat, Oct 01, 2022 at 09:24:44PM -0400, guoren@kernel.org wrote:
> > > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > >
> > > > > And it will be extended for C entry code.
> > > > >
> > > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > > ---
> > > > >  include/linux/compiler_types.h | 8 +++++---
> > > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > > > index 4f2a819fd60a..e9ce11ea4d8b 100644
> > > > > --- a/include/linux/compiler_types.h
> > > > > +++ b/include/linux/compiler_types.h
> > > > > @@ -227,9 +227,11 @@ struct ftrace_likely_data {
> > > > >  #endif
> > > > >
> > > > >  /* Section for code which can't be instrumented at all */
> > > > > -#define noinstr                                                              \
> > > > > -     noinline notrace __attribute((__section__(".noinstr.text")))    \
> > > > > -     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> > > > > +#define __noinstr_section(section)                           \
> > > > > +     noinline notrace __section(section) __no_profile        \
> > > > > +     __no_kcsan __no_sanitize_address __no_sanitize_coverage
> > > > > +
> > > > > +#define noinstr __noinstr_section(".noinstr.text")
> > > >
> > > > One thing proably worth noting here is that while KPROBES will avoid
> > > > instrumenting `.noinstr.text`, that won't happen automatically for other
> > > > __noinstr_section() sections, and that will need to be inhibited through other
> > > > means (e.g. the kprobes blacklist, explicit NOKPROBE_SYMBOL() annotation, or
> > > > otherwise).
> > >
> > > In riscv, "we select HAVE_KPROBES if !XIP_KERNEL", so don't worry
> > > about that. I don't think we could enable kprobe for XIP_KERNEL in the
> > > future.
> >
> > Sure; but someone else might use __noinstr_section() elsewhere where this could
> > matter, and I was suggesting that we could add a comment as above.
> Okay, how about:
> 
> /* Be care KPROBES will avoid instrumenting .noinstr.text, not
> __noinstr_section(). */
> #define __noinstr_section(section)                             \
>        noinline notrace __section(section) __no_profile        \
>        __no_kcsan __no_sanitize_address __no_sanitize_coverage

How about we split this like:

| /*
|  * Prevent the compiler from instrumenting this code in any way
|  * This does not prevent instrumentation via KPROBES, which must be
|  * prevented through other means if necessary.
|  */
| #define __no_compiler_instrument				\
| 	noinline notrace noinline notrace __no_kcsan		\
| 	__no_sanitize_address __no_sanitize_coverage
| 
| /* 
|  * Section for code which can't be instrumented at all.
|  * Any code in this section cannot be instrumented with KPROBES.
|  */
| #define noinstr __no_compiler_instrument section(".noinstr.text")

... then we don't need __noinstr_section(), and IMO the split is
clearer.

Peter?

Thanks,
Mark.
