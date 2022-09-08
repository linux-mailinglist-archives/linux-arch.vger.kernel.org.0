Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61CD5B15BD
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiIHHeQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiIHHeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 03:34:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632A9C510;
        Thu,  8 Sep 2022 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qOOipAMFA6jU/iAD0NNT6fAlhjOnSrPaO5m9WLa7Ha0=; b=XWBTcDwPn7I4lM/UNGkV9JDC7V
        LCGE6JzoqcxPZHavPhQOjtc8pc1L45zx/Z2uFkIMZMs3VYT4POhxsWq5PHApBJxUSSbMmk/Hr/aiv
        CEifLxaRKaSOiaR4y0jtY8R3Hr/YaFoxr48v8KhsNv6unvME1pwvn3iZrUgFDitZ9Xl+74K4NKKm2
        NYV3WlSA02f8JTjdBIlt8QFSF2HGaTRkd6y2wSAl9os41Vtu4WbyQSZyDe6WjCofFt/kp+bWuL/9a
        bCdlkmqc6G0o2XCGIf4rM1CpC6pvFHO9CnZpGUmTN5oFCDVqj9AKAj24niruMjW18qgGtG/mKfiXU
        S1p/LumQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWC2d-00Ae5F-8k; Thu, 08 Sep 2022 07:33:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B03D30004F;
        Thu,  8 Sep 2022 09:33:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0DA92B99E10D; Thu,  8 Sep 2022 09:33:35 +0200 (CEST)
Date:   Thu, 8 Sep 2022 09:33:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 4/8] riscv: traps: Add noinstr to prevent
 instrumentation inserted
Message-ID: <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908022506.1275799-5-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 07, 2022 at 10:25:02PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Without noinstr the compiler is free to insert instrumentation (think
> all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> yet ready to run this early in the entry path, for instance it could
> rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> 
> Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/traps.c | 8 ++++----
>  arch/riscv/mm/fault.c     | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 635e6ec26938..3ed3dbec250d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -97,7 +97,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  #define __trap_section
>  #endif
>  #define DO_ERROR_INFO(name, signo, code, str)				\
> -asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
> +asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)	\

But now you have __trap_section and noinstr both adding a section
attribute.
