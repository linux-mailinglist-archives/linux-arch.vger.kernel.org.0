Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC460C8A1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJYJrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJYJri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 05:47:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E40DFE087;
        Tue, 25 Oct 2022 02:47:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F000D6E;
        Tue, 25 Oct 2022 02:47:41 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D3C3F792;
        Tue, 25 Oct 2022 02:47:31 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:47:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>, arnd@arndb.de,
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
Message-ID: <Y1ewrRpHBwg2wJnb@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
 <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
 <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
 <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N>
 <Y1Z/rLaaUp7e9xoy@hirez.programming.kicks-ass.net>
 <Y1aBshGIWMEm+yTv@FVFF77S0Q05N>
 <CAJF2gTQvmSuOP_QQ8RGfq2soLrv9XD3g=8v9pE+U0y+pzqMY4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQvmSuOP_QQ8RGfq2soLrv9XD3g=8v9pE+U0y+pzqMY4A@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 25, 2022 at 10:51:02AM +0800, Guo Ren wrote:
> On Mon, Oct 24, 2022 at 8:14 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Oct 24, 2022 at 02:06:04PM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 24, 2022 at 12:56:03PM +0100, Mark Rutland wrote:
> > >
> > > > How about we split this like:
> > > >
> > > > | /*
> > > > |  * Prevent the compiler from instrumenting this code in any way
> > > > |  * This does not prevent instrumentation via KPROBES, which must be
> > > > |  * prevented through other means if necessary.
> > >
> > > Perhaps point to NOINSTR_TEXT in vmlinux.lds.h
> >
> > Makes sense, will do.
> Do I need to update the comment with NOINSTR_TEXT? eg:
> 
>  * Prevent the compiler from instrumenting this code in any way
>  * This does not prevent instrumentation via KPROBES, which must be
>  * prevented through other means if necessary. See NOINSTR_TEXT
>  * in vmlinux.lds.h.

I think given Peter's reply we can leave the patch as-is for now, and we can
leave commentary or other changes to a later follow up. I'm happy to propose
patches for that once the existing bits are merged.

Sorry for confusing matters!

> > > > |  */
> > > > | #define __no_compiler_instrument                          \
> > > > |   noinline notrace noinline notrace __no_kcsan            \
> > > > |   __no_sanitize_address __no_sanitize_coverage
> > > > |
> > > > | /*
> > > > |  * Section for code which can't be instrumented at all.
> > > > |  * Any code in this section cannot be instrumented with KPROBES.
> > > > |  */
> > > > | #define noinstr __no_compiler_instrument section(".noinstr.text")
> > > >
> > > > ... then we don't need __noinstr_section(), and IMO the split is
> > > > clearer.
> > >
> > > Yeah, perhaps, no strong feelings. Note I have this in the sched-idle
> > > series as well (which I still need to rebase and repost :/).
> >
> > Ah; I'll sit on this for now then, and once that's all in I can send a
> > cleanup/rework patch. Sorry for the noise!
> We still keep __noinstr_section(), right?

Yes -- for now this patch can stay as-is, and __noinstr_section() will remain.

Thanks,
Mark.
