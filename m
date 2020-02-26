Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0202116F432
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 01:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBZAXY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 19:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgBZAXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 19:23:24 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3008421927;
        Wed, 26 Feb 2020 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582676603;
        bh=zbZcGwuBk0lpjSX3xx+Kk+TiKNLbzSLEzDkIp/A8uBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF2U/sSNT9K/Apq5Wxz/T8L9uh8Z/5Qi0PGNjDY/2i+LA4nf4rvFHmUKKPojDTzB2
         4djz/6XCrYTvUY/EiELLJTkp6CTeDFwA1u2yTjPvrroSafyINVWvpS2xuZ4oE10+q9
         3b1h8492D8CXOSGJEcT0FLxr3vXA94CXI6bdCYbQ=
Date:   Wed, 26 Feb 2020 01:23:21 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org
Subject: Re: [PATCH v4 07/27] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Message-ID: <20200226002320.GC9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.443368893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.443368893@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:23PM +0100, Peter Zijlstra wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> "irq" parameter that indicates whether these functions are invoked from
> an irq handler (irq==true) or an NMI handler (irq==false).  However,
> recent changes have applied notrace to a few critical functions such
> that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> on in_nmi().  Note that in_nmi() works no differently than before,
> but rather that tracing is now prohibited in code regions where in_nmi()
> would incorrectly report NMI state.
> 
> This commit therefore removes the "irq" parameter and inlines
> rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
> and rcu_nmi_exit(), respectively.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Although in the end, from a naming POV, it would make more sense to have
rcu_nmi_enter() calling rcu_irq_enter() rather than the opposite. But the
result would be another level of function in the way to keep the
NOKPROBE property, so I guess we'll stick with that layout.
