Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013C7279F3
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjFHIaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjFHIaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 04:30:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DC2700;
        Thu,  8 Jun 2023 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dtEYRmo7Mb4HUPwmNIi7aG7beCq9+eQ8V/5sHbI/Q38=; b=hBBKScrUI1BSKFTaY5cRW0O5DK
        6A8/XsHkCD6vbgeQUP8jxDFsg1DqqsIsyjeTU7dvMGCeHlAkHJmca43pwPV0RMQMSv9QIji7wOGV4
        iSYfxwy36sAG16PNED0NJ+yagL2152BVszOq5AHtjtlxY3OE2k3kTqc5lzsH3zW64jqe6DQBt5tsp
        f77I0iL7TCIQir8d9+/YkvIM6BGOcb70scybid46M5a2MBAUbbxj8U9pIycSDMkn56DKXWic/nGH8
        srrTdzOOkiSfjyKEl9fkKut8jAPFv4gdzuuVJ2guD0ptKWXIXzrgHD2Hz3Ti89DXajthrOewvBa22
        blwutyZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7B1a-0069YO-18;
        Thu, 08 Jun 2023 08:29:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28BE9300222;
        Thu,  8 Jun 2023 10:29:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02C7120D72191; Thu,  8 Jun 2023 10:29:40 +0200 (CEST)
Date:   Thu, 8 Jun 2023 10:29:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     mark.rutland@arm.com, arnd@arndb.de, ndesaulniers@google.com,
        trix@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] percpu: Fix self-assignment of __old in
 raw_cpu_generic_try_cmpxchg()
Message-ID: <20230608082940.GF998233@hirez.programming.kicks-ass.net>
References: <20230607-fix-shadowing-in-raw_cpu_generic_try_cmpxchg-v1-1-8f0a3d930d43@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607-fix-shadowing-in-raw_cpu_generic_try_cmpxchg-v1-1-8f0a3d930d43@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 07, 2023 at 02:20:59PM -0700, Nathan Chancellor wrote:
> After commit c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()"),
> clang built ARCH=arm and ARCH=arm64 kernels with CONFIG_INIT_STACK_NONE
> started panicking on boot in alloc_vmap_area():
> 
>   [    0.000000] kernel BUG at mm/vmalloc.c:1638!
>   [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>   [    0.000000] Modules linked in:
>   [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc2-ARCH+ #1
>   [    0.000000] Hardware name: linux,dummy-virt (DT)
>   [    0.000000] pstate: 200000c9 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   [    0.000000] pc : alloc_vmap_area+0x7ec/0x7f8
>   [    0.000000] lr : alloc_vmap_area+0x7e8/0x7f8
> 
> Compiling mm/vmalloc.c with W=2 reveals an instance of -Wshadow, which
> helps uncover that through macro expansion, '__old = *(ovalp)' in
> raw_cpu_generic_try_cmpxchg() can become '__old = *(&__old)' through
> raw_cpu_generic_cmpxchg(), which results in garbage being assigned to
> the inner __old and the cmpxchg not working properly.
> 
> Add an extra underscore to __old in raw_cpu_generic_try_cmpxchg() so
> that there is no more self-assignment, which resolves the panics.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1868

First time I see Closes; is this an 'official' tag?

> Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: c5c0ba953b8c ("percpu: Add {raw,this}_cpu_try_cmpxchg()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Durr, C is such a lovely language :-)

I'll go stick it in locking/core to go with the bunch that wrecked it.
Thanks!
