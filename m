Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3258E866
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 10:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiHJIGk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiHJIGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 04:06:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7984E870;
        Wed, 10 Aug 2022 01:06:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660118772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2fH4lJLf/jGm0kpr5WZqRjUlovmjzDjuvuvj8cmPCo=;
        b=nmM2MlcqdYiVpNn4GJUaSDEuVVublkrFCvcUTcHXwlIURDH3xshfcUalN5MYmf3RcCJEgE
        MT4Ofd86FIxd6UoEx9xi2sIcsWZrcJu+ZYUBI52v1M8IAVQZhJ2FUP5Hho8OOTntbH97gK
        8bKR52enGD3lOdOAKgmndS2cOp/a7ORv9sWu5PNuv2yLpDLjtUB4Bm7UkKpNOrsNveK5ut
        16b6oFUcO+bWFsh5QIeNoOvXGuvGJ3/3nEAFCLJA3xrgPU+o859nlCuZWkspjJESNcPZXd
        kKL+do205xajzKujBW5Dm7q5+YbFCibRIA/82diqfBNqGHy4IkbifprdGfJiNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660118772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2fH4lJLf/jGm0kpr5WZqRjUlovmjzDjuvuvj8cmPCo=;
        b=tItuBdzeNkK0S5xlXxIP5cOBL95T9Kw77s1+NHyt7qWcpffgEOBoh5bYu30t5IXbk7cyUJ
        k2OCXtu/7n4aYYDw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] asm-generic: Conditionally enable
 do_softirq_own_stack() via Kconfig.
In-Reply-To: <YvKD4hkZ3erf54DG@linutronix.de>
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
 <CAHk-=wgZSD3W2y6yczad2Am=EfHYyiPzTn3CfXxrriJf9i5W5w@mail.gmail.com>
 <YvKD4hkZ3erf54DG@linutronix.de>
Date:   Wed, 10 Aug 2022 10:06:11 +0200
Message-ID: <8735e4v7yk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 09 2022 at 17:57, Sebastian Andrzej Siewior wrote:
>  
> +config SOFTIRQ_ON_OWN_STACK
> +	def_bool !PREEMPT_RT
> +	depends on HAVE_SOFTIRQ_ON_OWN_STACK

        def_bool !PREEMPT_RT && HAVE_SOFTIRQ_ON_OWN_STACK

No?
