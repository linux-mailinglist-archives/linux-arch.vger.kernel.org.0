Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0215C880
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMQk5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:40:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgBMQk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 11:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=luwMxyZU6lFzVJt3SO6czFv4ciHzh854fmX24FDkPhk=; b=EYB6bMxMkcq8ZMZOFxKpztIYpm
        8JWzqukpe0Mwhyc9DrWPgOzOCUWcrkOCR57n3FXNizFJHMrXrV5cZYfoQ3/B2mDq5D7TpwAWeOcL1
        BscLNMPC3RFO4Z3/WojgVh9vB4h3ihYsKmyxqhBjqQ6mjRulcMC2qo+Am4nG3blmyHSKAhrhjUuLV
        szuKDgRj+go9B0Ka173GGhy8DJ4cn//+4EkKDYHve6MswcBITTKOin4tfLXaLhQqrnzaVNc2cC8fR
        WtpM4snTUyzhSzyDVf5fhpq6YGxjnBJwcpRMOq6gHzXTkxOEfayMsz2nYyKfVBwW//BtDF9lX/9Ng
        a1sKGrCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2HXW-0000mE-M2; Thu, 13 Feb 2020 16:40:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E667D307963;
        Thu, 13 Feb 2020 17:38:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EFA620206D69; Thu, 13 Feb 2020 17:40:31 +0100 (CET)
Date:   Thu, 13 Feb 2020 17:40:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213164031.GH14914@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213135138.GB2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 05:51:38AM -0800, Paul E. McKenney wrote:

> The reason for the irq argument is to avoid invoking
> rcu_prepare_for_idle() and rcu_dynticks_task_enter() from NMI context
> from rcu_nmi_exit_common().  Similarly, we need to avoid invoking
> rcu_dynticks_task_exit() and rcu_cleanup_after_idle() from NMI context
> from rcu_nmi_enter_common().

Aaah, I see. I didn't grep hard enough earlier today (I only found
stubs). Yes, those take locks, we mustn't call them from NMI context.

> It might well be that I could make these functions be NMI-safe, but
> rcu_prepare_for_idle() in particular would be a bit ugly at best.
> So, before looking into that, I have a question.  Given these proposed
> changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> to just use in_nmi()?

That _should_ already be the case today. That is, if we end up in a
tracer and in_nmi() is unreliable we're already screwed anyway.
