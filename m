Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E22608C9
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgIHCzf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 22:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgIHCze (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 22:55:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B3720678;
        Tue,  8 Sep 2020 02:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599533733;
        bh=JWnIjcnJzQwoUBMp2JNF74qQ2x9XJSOCWBezRJosGWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhluC8MTcrpRscv8gged+7zO2Rg9TnVnAx+EKYOvnIwvst97Z3S3dJ5yQ9AYOVgHA
         g03qgZB4pYRQMHQjCuWox3tm/xc+6dqf4/7NxiHCYPzseFP9wn1PqiTEBYusxt3ljx
         jYhwvHLdNQXbPo4eCXjHbOPMVW2sDqed4oYno6hc=
Date:   Tue, 8 Sep 2020 11:55:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     fche@redhat.com (Frank Ch. Eigler)
Cc:     peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org,
        systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200908115527.cf8d2b106bf1a9c4416bbc89@kernel.org>
In-Reply-To: <87eendo51o.fsf@redhat.com>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
        <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
        <20200903110226.8963179e6a7c978e2d56c595@kernel.org>
        <87eendo51o.fsf@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 07 Sep 2020 13:44:19 -0400
fche@redhat.com (Frank Ch. Eigler) wrote:

> Masami Hiramatsu <mhiramat@kernel.org> writes:
> 
> > Sorry, for noticing this point, I Cc'd to systemtap. Is systemtap taking
> > care of spinlock too?
> 
> On PRREMPT_RT configurations, systemtap uses the raw_spinlock_t
> types/functions, to keep its probe handlers as atomic as we can make them.

OK, if the lock is only used in the probe handlers, there should be
no problem. Even if a probe hits in the NMI which happens in another
kprobe handler, the probe does not call its handler (because we don't
support nested kprobes* yet).
But maybe you'll get warnings if you enable the lockdep.

* https://lkml.kernel.org/r/158894789510.14896.13461271606820304664.stgit@devnote2
It seems that we need more work for the nested kprobes.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
