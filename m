Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13A516F43C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 01:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgBZA17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 19:27:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgBZA16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 19:27:58 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C8420732;
        Wed, 26 Feb 2020 00:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582676878;
        bh=5nMgN58XKA7T07lw5HTmd0MdFsxDRYFpp3ZCFiAQb40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K91fWeJ2NST6G+AsIq4lKKSlTLT9GlAFs8YuYUCcULbQSOzxnQ57B+7ceUiHjM7wm
         ql0ygqkXqxXkkbE3ZMSg5wi34lJhCmXXKoVKgL2QS3bkF5BVa6IIqeKycYMuSnokUj
         BiiDErM/RB/VXSCsy+iz9J6hJre5oGamm5yTE9/w=
Date:   Wed, 26 Feb 2020 01:27:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org
Subject: Re: [PATCH v4 08/27] rcu/kprobes: Comment why rcu_nmi_enter() is
 marked NOKPROBE
Message-ID: <20200226002755.GD9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.501225981@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.501225981@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:24PM +0100, Peter Zijlstra wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> It's confusing that rcu_nmi_enter() is marked NOKPROBE and
> rcu_nmi_exit() is not. One may think that the exit needs to be marked
> for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
> state back to what it was before rcu_nmi_enter(). But the reason has
> nothing to do with the state of RCU.
> 
> The breakpoint handler (int3 on x86) must not have any kprobe on it
> until the kprobe handler is called. Otherwise, it can cause an infinite
> recursion and crash the machine. It just so happens that
> rcu_nmi_enter() is called by the int3 handler before the kprobe handler
> can run, and therefore needs to be marked as NOKPROBE.
> 
> Comment this to remove the confusion to why rcu_nmi_enter() is marked
> NOKPROBE but rcu_nmi_exit() is not.
> 
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
