Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6060BA27
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJXU0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiJXUYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 16:24:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACC2E6BE;
        Mon, 24 Oct 2022 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PQNqs6IdtT9gCZUPfrGepUfUTCnXjYqE6ZtxOOCZbuY=; b=bZUxoZ3o+SOLm2CQBy+VttoP2B
        OUQg3xIogy0yBtLBjNHhw1AD98RCzB0kPet/YEkeMNmVR/Jmhxl2GbO9TFg6nk3qeBdntj9dcE/v/
        nQts5mvftu6i0IDZtQ3YnguK28E+WnrwyIOrUDc2x63UPAzQ2pixygVcHRlZTrLavNxyFHLVHL2uS
        k14/UwfFI3DWikDyw/rSul/fVBClCA0zMSCYm8I+/lV1m1y334PA5s+FYIfGEhpNvPf/n04//nkZ8
        1QoLyLZHGM65OVUTIkaIUyY+clnTYDxYiZgdNLCVFW2kkrWV6IfNI1VNDdOMV6HcwySTaqQIE5mqt
        xqXw/k8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omwDX-0063bj-GO; Mon, 24 Oct 2022 12:06:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AEE33000DD;
        Mon, 24 Oct 2022 14:06:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BAEE2018F17F; Mon, 24 Oct 2022 14:06:04 +0200 (CEST)
Date:   Mon, 24 Oct 2022 14:06:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <Y1Z/rLaaUp7e9xoy@hirez.programming.kicks-ass.net>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-5-guoren@kernel.org>
 <YzrJ0wQxWfjWCxhQ@FVFF77S0Q05N>
 <CAJF2gTRBEGx3qncpk_C8rCsFN+kqxjgeAcPvZU5m7kDnpwytoA@mail.gmail.com>
 <Y1ERsP0YYVNulWnw@FVFF77S0Q05N>
 <CAJF2gTTurEaFjbKvj1tUptq_TLpXeBAE1UstNYxriC-7r5MHpQ@mail.gmail.com>
 <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Z9U7XN4nlGg8yb@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 12:56:03PM +0100, Mark Rutland wrote:

> How about we split this like:
> 
> | /*
> |  * Prevent the compiler from instrumenting this code in any way
> |  * This does not prevent instrumentation via KPROBES, which must be
> |  * prevented through other means if necessary.

Perhaps point to NOINSTR_TEXT in vmlinux.lds.h

> |  */
> | #define __no_compiler_instrument				\
> | 	noinline notrace noinline notrace __no_kcsan		\
> | 	__no_sanitize_address __no_sanitize_coverage
> | 
> | /* 
> |  * Section for code which can't be instrumented at all.
> |  * Any code in this section cannot be instrumented with KPROBES.
> |  */
> | #define noinstr __no_compiler_instrument section(".noinstr.text")
> 
> ... then we don't need __noinstr_section(), and IMO the split is
> clearer.

Yeah, perhaps, no strong feelings. Note I have this in the sched-idle
series as well (which I still need to rebase and repost :/).
