Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335FB5BCD79
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiISNpu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISNpt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 09:45:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8517066;
        Mon, 19 Sep 2022 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bjogngX1F/JZwA+k9RfkZhp88x9yf+GaiFwl+CZH6hg=; b=d4nxG+MzP54k7yWbKFQHdqhuGv
        ozyorpIIgc4NNC9rIw994EZtM6mjs1hztVHSPVx0bIG5bf2wtTh988madhgQtJGM3ytUd3pLN6Nsf
        7MzV3Npvn+edwN/xTN4XEAVPVUU/tfjGeKs4EHIMgdaiynn5Lt8FqTIye5owf8vMn4xpy0CeeUAK8
        TSbFhnqlzFxMKabPlf5uh6Mt5IdwNJxhvHB8gah14SkZun2E10bmeyq3usOtPdHhKLFgRNPd9qiwd
        Fm/2Z/pCv+mydapcnpDMHXuSw5tGuGQyjepzNCFwihAkcNWhF7zJWpe3a69ymybUjV/sPZAPOYsUa
        PQSlWAOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaH5L-004k8i-9t; Mon, 19 Sep 2022 13:45:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CA95300202;
        Mon, 19 Sep 2022 15:45:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED5F02BAC75BE; Mon, 19 Sep 2022 15:45:14 +0200 (CEST)
Date:   Mon, 19 Sep 2022 15:45:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, keescook@chromium.org
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <Yyhyap+Xi3UtV+T0@hirez.programming.kicks-ass.net>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-9-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918155246.1203293-9-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 18, 2022 at 11:52:43AM -0400, guoren@kernel.org wrote:

> +ENTRY(call_on_stack)
> +	/* Create a frame record to save our ra and fp */
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	ra, (sp)
> +	addi	sp, sp, -RISCV_SZPTR
> +	REG_S	fp, (sp)
> +
> +	/* Save sp in fp */
> +	move	fp, sp
> +
> +	/* Move to the new stack and call the function there */
> +	li	a3, IRQ_STACK_SIZE
> +	add	sp, a1, a3
> +	jalr	a2
> +
> +	/*
> +	 * Restore sp from prev fp, and fp, ra from the frame
> +	 */
> +	move	sp, fp
> +	REG_L	fp, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +	REG_L	ra, (sp)
> +	addi	sp, sp, RISCV_SZPTR
> +	ret
> +ENDPROC(call_on_stack)

IIRC x86_64 moved away from a stack-switch function like this because it
presents a convenient exploit gadget.

I'm not much of an exploit writer and I've no idea how effective our
inline stategy is, perhaps other can comment.
