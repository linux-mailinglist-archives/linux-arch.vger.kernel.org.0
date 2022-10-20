Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27885605ADA
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTJQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJTJP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 05:15:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81541CB26;
        Thu, 20 Oct 2022 02:15:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A56ED1;
        Thu, 20 Oct 2022 02:15:41 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.4.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C92AA3F792;
        Thu, 20 Oct 2022 02:15:30 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:15:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH V6 04/11] compiler_types.h: Add __noinstr_section() for
 noinstr
Message-ID: <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
 <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 08, 2022 at 09:54:39AM +0800, Guo Ren wrote:
> On Mon, Oct 3, 2022 at 7:39 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sat, Oct 01, 2022 at 09:24:44PM -0400, guoren@kernel.org wrote:
> > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > >
> > > And it will be extended for C entry code.
> > >
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > ---
> > >  include/linux/compiler_types.h | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > index 4f2a819fd60a..e9ce11ea4d8b 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -227,9 +227,11 @@ struct ftrace_likely_data {
> > >  #endif
> > >
> > >  /* Section for code which can't be instrumented at all */
> > > -#define noinstr                                                              \
> > > -     noinline notrace __attribute((__section__(".noinstr.text")))    \
> > > -     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> > > +#define __noinstr_section(section)                           \
> > > +     noinline notrace __section(section) __no_profile        \
> > > +     __no_kcsan __no_sanitize_address __no_sanitize_coverage
> > > +
> > > +#define noinstr __noinstr_section(".noinstr.text")
> >
> > One thing proably worth noting here is that while KPROBES will avoid
> > instrumenting `.noinstr.text`, that won't happen automatically for other
> > __noinstr_section() sections, and that will need to be inhibited through other
> > means (e.g. the kprobes blacklist, explicit NOKPROBE_SYMBOL() annotation, or
> > otherwise).
> 
> In riscv, "we select HAVE_KPROBES if !XIP_KERNEL", so don't worry
> about that. I don't think we could enable kprobe for XIP_KERNEL in the
> future.

Sure; but someone else might use __noinstr_section() elsewhere where this could
matter, and I was suggesting that we could add a comment as above.

Thanks,
Mark.
