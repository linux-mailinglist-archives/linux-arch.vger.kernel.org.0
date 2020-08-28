Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129BC255E75
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgH1QBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 12:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgH1QBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 12:01:39 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA5D2075B;
        Fri, 28 Aug 2020 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598630499;
        bh=C9e4JWgOXMyAeZGFAs1HgB2Jk5Sbc+z66fHTKpOP0Cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dBdPRoj3USsELHAeAEg/pq9jx0Z3hh0xUKTeq2hX56d+ZMGsMWPS4ScVwTlpLuuNA
         WGAxIq2dPTIVaV4jb88sMajN5bMoFeobnviXcuKaPU8Hza03Qdwy11tEHzAiKmu92b
         TWlTno0Bevb0SuOZrjIUaoNFq/2eRkptT1PaX7hc=
Date:   Sat, 29 Aug 2020 01:01:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 20/23] [RFC] kprobes: Remove task scan for updating
 kretprobe_instance
Message-Id: <20200829010135.faf4657147aed64beb896a08@kernel.org>
In-Reply-To: <20200828151806.GF1362448@hirez.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861781740.992023.4956784710984854658.stgit@devnote2>
        <20200828125236.GA1362448@hirez.programming.kicks-ass.net>
        <20200829001010.7ec1a183c2294f7bd843b153@kernel.org>
        <20200828151806.GF1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 17:18:06 +0200
peterz@infradead.org wrote:

> On Sat, Aug 29, 2020 at 12:10:10AM +0900, Masami Hiramatsu wrote:
> > On Fri, 28 Aug 2020 14:52:36 +0200
> > peterz@infradead.org wrote:
> 
> > > >  	synchronize_rcu();
> > > 
> > > This one might help, this means we can do rcu_read_lock() around
> > > get_kretprobe() and it's usage. Can we call rp->handler() under RCU?
> > 
> > Yes, as I said above, the get_kretprobe() (and kretprobe handler) must be
> > called under preempt-disabled.
> 
> Then we don't need the ordering; we'll need READ_ONCE() (or
> rcu_derefernce()) to make sure the address dependency works on Alpha.
> And a comment/assertion that explains this might not go amiss in
> get_kretprobe().


OK, I'll rewrite it with READ_ONCE() and rcu_read_lock_any_held().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
