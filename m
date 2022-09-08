Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E055B2322
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIHQIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiIHQI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 12:08:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F6FB8C9;
        Thu,  8 Sep 2022 09:08:26 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:08:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662653305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3melgoxOyPm2WW+MNhQzQQlSABq+pMymGaM5BLeai9A=;
        b=Gp7zAcq+7nzep4nzUQTlLdgRIUFuc+CYrEawsF2uMxsBS2OCy2xJ6e9vaGHj5Akw1AhABk
        1WOEwlsYw+6q/zbB6J46ir2O6l884q5B3EW5aXqiaNGvhko4xkD6wb83FtXsPQqho5nJxS
        IH9PHxxbCmX4xOycUcdzrelBnit9tcaUOlO3PRfU9JLFgkqgKngO6h9udx5HvJzuwRz+5n
        S9Dgwelw9WHpk1a2yfx1AOHnMRNEMQA65RwjsuXGRLRcSocegsJlbExOtjw9m9rZT/rhWJ
        5A7XVgKn4T3q2+oAKJN/kK2yoU2MViFP0VmKgj/DXxpx/GeydYWqwPIneYOJ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662653305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3melgoxOyPm2WW+MNhQzQQlSABq+pMymGaM5BLeai9A=;
        b=h8h0ZIYnWSbUEFvLZoVbXhjwdVf0TrAXuHPJieWzTDYNEf6tCIWWlU8leHT7kCHnJxQ6NW
        T1VaQjp3ssK/XyCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 6/8] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <YxoTdxk772vneG53@linutronix.de>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-7-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908022506.1275799-7-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-09-07 22:25:04 [-0400], guoren@kernel.org wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a07bb3b73b5b..a8a12b4ba1a9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -433,6 +433,14 @@ config FPU
>  
>  	  If you don't know what to do here, say Y.
>  
> +config IRQ_STACKS
> +	bool "Independent irq stacks"
> +	default y
> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +	help
> +	  Add independent irq stacks for percpu to prevent kernel stack overflows.
> +	  We may save some memory footprint by disabling IRQ_STACKS.

Do you really think that it is needed to save memory here? Avoiding
stack overflows in deep call chains is probably more important than
saving ~8KiB per CPU.

Sebastian
