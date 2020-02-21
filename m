Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3824C168844
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 21:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBUUV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 15:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUUV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 15:21:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A762B2072C;
        Fri, 21 Feb 2020 20:21:55 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:21:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Message-ID: <20200221152153.15b3cf36@gandalf.local.home>
In-Reply-To: <20200221134215.559644596@infradead.org>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.559644596@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 Feb 2020 14:34:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -699,10 +699,10 @@ void rcu_irq_exit(void)
>  /*
>   * Wrapper for rcu_irq_exit() where interrupts are enabled.

			where interrupts may be enabled.

>   *
> - * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_exit_irqson(void)
> +void rcu_irq_exit_irqsave(void)
>  {
>  	unsigned long flags;
>  
> @@ -875,10 +875,10 @@ void rcu_irq_enter(void)
>  /*
>   * Wrapper for rcu_irq_enter() where interrupts are enabled.

			where interrupts may be enabled.

-- Steve

>   *
> - * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_enter_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_enter_irqson(void)
> +void rcu_irq_enter_irqsave(void)
>  {
>  	unsigned long flags;
>  
