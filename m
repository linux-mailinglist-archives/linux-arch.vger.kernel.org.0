Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1875B16B280
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXVc2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 16:32:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVc1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 16:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91LwxLWvdfJmKpIkvnbgVBtKYjb/D3h4IRfL3vb9smw=; b=n2R+f4R/VQE8sdI8xxw08ZSM4s
        2VktBF/WEtXYZWmIIdQvP5UhysH3fmG732lFdKX3UuW3KvVZxDlQrLYAgwAFu2KOyit6nHfP+FGnT
        7Md1GgBE3FOnkz1ZuCi5cRgYkO3oRst5y4CJhT5TfCZfmXrg0xmNTm+jRKnAvlSTKMj3cMGERS3bX
        Pv1uvCRdzjcnXlD2ECh65C6U91CA/ZbfyBabEGIqt0gpMQNKqKy9S0AudEZtcF3tW7erIgWu267bs
        C4QD66T+Ig/yXxg891EnEeRR73Z8SX6hdCHRoWC3qLyTKtlssSdZsU09s274E7dP4NCl7uGM0v/NI
        FbiOoWoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6LKP-0000dO-30; Mon, 24 Feb 2020 21:31:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81F1C980E37; Mon, 24 Feb 2020 22:31:39 +0100 (CET)
Date:   Mon, 24 Feb 2020 22:31:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200224213139.GO11457@worktop.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
 <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
 <20200224114754.0fb798c1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224114754.0fb798c1@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 11:47:54AM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2020 17:34:09 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Looking at nmi_enter(), that leaves trace_hardirq_enter(), since we know
> > we marked rcu_nmi_enter() as NOKPROBES, per the patches elsewhere in
> > this series.
> 
> Maybe this was addressed already in the series, but I'm just looking at
> Linus's master branch we have:
> 
> #define nmi_enter()                                             \
>         do {                                                    \
>                 arch_nmi_enter();                               \
>                 printk_nmi_enter();                             \
>                 lockdep_off();                                  \
>                 ftrace_nmi_enter();                             \
>                 BUG_ON(in_nmi());                               \
>                 preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET); \
>                 rcu_nmi_enter();                                \
>                 trace_hardirq_enter();                          \
>         } while (0)
> 
> 
> Just want to confirm that printk_nmi_enter(), lockdep_off(),
> and ftrace_nmi_enter() are all marked fully with NOKPROBE.

*sigh*, right you are, I only looked at notrace, not nokprobe.

In particular the ftrace one is a bit off a mess, let me sort through
that.
