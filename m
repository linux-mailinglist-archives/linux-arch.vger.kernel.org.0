Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F560AFBB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiJXP4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiJXP4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 11:56:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 561F7B1DD2;
        Mon, 24 Oct 2022 07:51:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A827D6E;
        Mon, 24 Oct 2022 05:14:56 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70D1E3F7B4;
        Mon, 24 Oct 2022 05:14:45 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:14:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
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
Message-ID: <Y1aBshGIWMEm+yTv@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
 <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
 <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
 <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N>
 <Y1Z/rLaaUp7e9xoy@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Z/rLaaUp7e9xoy@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 02:06:04PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 24, 2022 at 12:56:03PM +0100, Mark Rutland wrote:
> 
> > How about we split this like:
> > 
> > | /*
> > |  * Prevent the compiler from instrumenting this code in any way
> > |  * This does not prevent instrumentation via KPROBES, which must be
> > |  * prevented through other means if necessary.
> 
> Perhaps point to NOINSTR_TEXT in vmlinux.lds.h

Makes sense, will do.

> 
> > |  */
> > | #define __no_compiler_instrument				\
> > | 	noinline notrace noinline notrace __no_kcsan		\
> > | 	__no_sanitize_address __no_sanitize_coverage
> > | 
> > | /* 
> > |  * Section for code which can't be instrumented at all.
> > |  * Any code in this section cannot be instrumented with KPROBES.
> > |  */
> > | #define noinstr __no_compiler_instrument section(".noinstr.text")
> > 
> > ... then we don't need __noinstr_section(), and IMO the split is
> > clearer.
> 
> Yeah, perhaps, no strong feelings. Note I have this in the sched-idle
> series as well (which I still need to rebase and repost :/).

Ah; I'll sit on this for now then, and once that's all in I can send a
cleanup/rework patch. Sorry for the noise!

Thanks,
Mark.
