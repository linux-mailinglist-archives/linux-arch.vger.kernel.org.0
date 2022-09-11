Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7205B4F92
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIKPKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Sep 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiIKPKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2022 11:10:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5CD13DCC;
        Sun, 11 Sep 2022 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T8kXbrdbT0Mke2qcZ/J70Cx3QoQ+vc4dEdyuf7NS6dY=; b=hwd59oKeR7QyS4faWmLioIutcD
        jnFDLj8Kq4wxulz4rBu+1D+I0NXF+nYg7V72IBpovjcu2BV7iXrg5hgUrS0OEykNZdPMnd/zLMOvJ
        9hfKCVTTZxhat6GIfnIcF37jW3WIL/YSWUV1u7EKbA6t3IDHq4Z589CrwvR1jjgi60tJOhRtfhE3X
        sT8475j0pTfITCc8mIWM7+b8yg4XDOtJ0zO/oaSfhJDrgmbhtlj2JZ+4pjDLnp1QHH+yPzL7Y7lOO
        Sr0mRn8L2pWSAHgwzFT8OZSUWEVfGemVzETGuBAT5mOH/ZScFJDTVcew4x8nRm0YWPM9vMGy99T6o
        Ljv3QMOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXOaQ-00F8y6-Tf; Sun, 11 Sep 2022 15:09:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7016C30008D;
        Sun, 11 Sep 2022 17:09:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A1AB2B16572A; Sun, 11 Sep 2022 17:09:25 +0200 (CEST)
Date:   Sun, 11 Sep 2022 17:09:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
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
Message-ID: <Yx36JRG64DtuDrRz@hirez.programming.kicks-ass.net>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-5-guoren@kernel.org>
 <Yxmaz7wJPEBQ7Vki@hirez.programming.kicks-ass.net>
 <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSs4Ycu52DH6NUzdMXQGMT51XU6x-fgQ-_OpRne+vkTqQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 10, 2022 at 05:17:44PM +0800, Guo Ren wrote:

> > > -asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > > +asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)  \
> >
> > But now you have __trap_section and noinstr both adding a section
> > attribute.
> 
> Oops, thx for correcting. Here is my solution.
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 635e6ec26938..eba744caa711 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -92,9 +92,11 @@ static void do_trap_error(struct pt_regs *regs, int
> signo, int code,
>  }
> 
>  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> -#define __trap_section         __section(".xip.traps")
> +#define __trap_section                                                 \
> +       noinline notrace __attribute((__section__(".xip.traps")))       \
> +       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
>  #else
> -#define __trap_section
> +#define __trap_section noinstr
>  #endif

This is almost guaranteed to get out of sync when the compiler guys add
yet another sanitizier. Please consider picking up this patch:

  https://lore.kernel.org/all/20211110115736.3776-7-jiangshanlai@gmail.com/

and using __noinstr_section(".xip.traps")
