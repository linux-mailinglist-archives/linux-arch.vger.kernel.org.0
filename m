Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F351D52F
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 12:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiEFKKm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390800AbiEFKKl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 06:10:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 379DE5DA7F;
        Fri,  6 May 2022 03:06:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F384C14BF;
        Fri,  6 May 2022 03:06:57 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.65.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583A13FA31;
        Fri,  6 May 2022 03:06:55 -0700 (PDT)
Date:   Fri, 6 May 2022 11:06:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, jthierry@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, masahiroy@kernel.org,
        jpoimboe@redhat.com, ycote@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, maz@kernel.org,
        tglx@linutronix.de, luc.vanoostenryck@gmail.com
Subject: Re: [RFC PATCH v4 22/37] arm64: kernel: Skip validation of kuser32.o
Message-ID: <YnTzO3imkSUAuIKx@FVFF77S0Q05N>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
 <20220429094355.122389-23-chenzhongjin@huawei.com>
 <YmvGja62yWdPHPOW@hirez.programming.kicks-ass.net>
 <a57f7d73-6e01-8f41-9be3-8e90807ec08f@huawei.com>
 <20220505092448.GE2501@worktop.programming.kicks-ass.net>
 <YnOtbYOIT5OP7F0g@FVFF77S0Q05N.cambridge.arm.com>
 <51ce37b5-f527-9743-36d3-50247cb0939f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ce37b5-f527-9743-36d3-50247cb0939f@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 06, 2022 at 10:18:10AM +0800, Chen Zhongjin wrote:
> On 2022/5/5 18:56, Mark Rutland wrote:
> > On Thu, May 05, 2022 at 11:24:48AM +0200, Peter Zijlstra wrote:
> >> On Thu, May 05, 2022 at 11:36:12AM +0800, Chen Zhongjin wrote:
> >>> Hi Peter,
> >>>
> >>> IIRC now the blacklist mechanisms all run on check stage, which after
> >>> decoding, but the problem of kuser32.S happens in decoding stage. Other
> >>> than that the assembly symbols in kuser32 is STT_NOTYPE and
> >>> STACK_FRAME_NON_STANDARD will throw an error for this.
> >>>
> >>> OBJECT_FILES_NON_STANDARD works for the single file but as you said
> >>> after LTO it's invalid. However STACK_FRAME_NON_STANDARD doesn't work
> >>> for kuser32 case at all.
> >>>
> >>> Now my strategy for undecodable instructions is: show an error message
> >>> and mark insn->ignore = true, but do not stop anything so decoding work
> >>> can going on.
> >>>
> >>> To totally solve this my idea is that applying blacklist before decode.
> >>> However for this part objtool doesn't have any insn or func info, so we
> >>> should add a new blacklist just for this case...
> >>
> >> OK, so Mark explained that this is 32bit userspace (VDSO) code.
> >>
> >> And as such there's really no point in running objtool on it. Does all
> >> that live in it's own section? Should it?
> > 
> > It's placed in .rodata by a linker script:
> > 
> > * The 32-bit vdso + kuser code is placed in .rodata, between the `vdso32_start`
> >   and `vdso32_end` symbols, as raw bytes (via .incbin).
> >   See arch/arm64/kernel/vdso32-wrap.S.
> > 
> > * The 64-bit vdso code is placed in .rodata, between the `vdso_start`
> >   and `vdso32` symbols, as raw bytes (via .incbin).
> >   See arch/arm64/kernel/vdso-wrap.S.
> > 
> > The objects under arch/arm64/kernel/{vdso,vdso32}/ are all userspace objects,
> > and from userspace's PoV the existing secrtions within those objects are
> > correct, so I don't think those should change.
> > 
> > How does x86 deal with its vdso objects?
> > 
> > Thanks,
> > Mark.
> > .
> 
> However for my build kuser32.o content is in .text 

We should be able to move that into .rodata; it's never executed in kernel context.

> and there is only `vdso` symbol in .rodata without `vdso32`.

That means you're not building with CROSS_COMPILE_COMPAT, and so we can't build
the 32-bit VDSO.

> And for defconfig the CONFIG_KUSER_HELPERS=y is on.

Yes.

> According to your description, it seems something wrong here?

Sorry, I was wrong about how we linked the kuser32 code.

I believe we can move that into .rodata by adding:

	.section .rodata

... to the start of that.

I think that'd be a nice cleanup to do regardless of objtool.

Thanks,
Mark.
