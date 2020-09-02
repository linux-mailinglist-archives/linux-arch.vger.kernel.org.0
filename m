Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03225A24E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIBAhs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 20:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBAhp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 20:37:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED97206F0;
        Wed,  2 Sep 2020 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599007065;
        bh=uXylxhEArUF1OTJL+DKdTu14JoB/sFaqO8H1MXHetpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjULBlljcNFVHbJD026My1NQ25hL7ZlJIP4Z5ShmkFh0RTUeJxqj669iql17iGHl3
         K009uQhrHbu0lpd+p22MdaNJmSoE+ZYH9zYo51neZbvs7q8LLv4yuG7Lx4ToTJ8/6t
         00X0kERIAZmu0c1GhOsnbeM4MHFyq4ZY3ewKrtDA=
Date:   Wed, 2 Sep 2020 09:37:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
In-Reply-To: <20200901190808.GK29142@worktop.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 1 Sep 2020 21:08:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Aug 29, 2020 at 09:59:49PM +0900, Masami Hiramatsu wrote:
> > Masami Hiramatsu (16):
> >       kprobes: Add generic kretprobe trampoline handler
> >       x86/kprobes: Use generic kretprobe trampoline handler
> >       arm: kprobes: Use generic kretprobe trampoline handler
> >       arm64: kprobes: Use generic kretprobe trampoline handler
> >       arc: kprobes: Use generic kretprobe trampoline handler
> >       csky: kprobes: Use generic kretprobe trampoline handler
> >       ia64: kprobes: Use generic kretprobe trampoline handler
> >       mips: kprobes: Use generic kretprobe trampoline handler
> >       parisc: kprobes: Use generic kretprobe trampoline handler
> >       powerpc: kprobes: Use generic kretprobe trampoline handler
> >       s390: kprobes: Use generic kretprobe trampoline handler
> >       sh: kprobes: Use generic kretprobe trampoline handler
> >       sparc: kprobes: Use generic kretprobe trampoline handler
> >       kprobes: Remove NMI context check
> >       kprobes: Free kretprobe_instance with rcu callback
> >       kprobes: Make local used functions static
> > 
> > Peter Zijlstra (5):
> >       llist: Add nonatomic __llist_add() and __llist_dell_all()
> >       kprobes: Remove kretprobe hash
> >       asm-generic/atomic: Add try_cmpxchg() fallbacks
> >       freelist: Lock less freelist
> >       kprobes: Replace rp->free_instance with freelist
> 
> This looks good to me, do you want me to merge them through -tip? If so,
> do we want to try and get them in this release still?

Yes, thanks. For the kretprobe missing issue, we will need the first half
(up to "kprobes: Remove NMI context check"), so we can split the series
if someone think the lockless is still immature.

> 
> Ingo, opinions? This basically fixes a regression cauesd by
> 
>   0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> 

Oops, I missed Ingo in CC. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
