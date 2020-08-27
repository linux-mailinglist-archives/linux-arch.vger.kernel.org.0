Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CC254496
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgH0Lxp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 07:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgH0Lu6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483462177B;
        Thu, 27 Aug 2020 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598529032;
        bh=FJ6VppXfhXdONz0GZcmIu4gnd/OYSpzCj9s6sDvRBk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t9vHXty5w3CKX05loqhbwow0e6e7zcsqhVW3Z5ib1F3qjHrP3er+YBf9Ahw0hln3i
         xBNS1q6YfTMpN3ox8Nk1QPPIYG5+uzEIXx9AvzFhHXkbExJrWm5fowdaPnZBFy893t
         ex/4B4P90OzkDQ0SDC3xbjIaHIeYJOLuvU5jcmzU=
Date:   Thu, 27 Aug 2020 20:50:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Eddy Wu <Eddy_Wu@trendmicro.com>,
        x86@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 15/15] kprobes: Free kretprobe_instance with rcu
 callback
Message-Id: <20200827205028.964ca2ac4cd79d4e6cee7f9f@kernel.org>
In-Reply-To: <20200827114807.GA2674@hirez.programming.kicks-ass.net>
References: <159852811819.707944.12798182250041968537.stgit@devnote2>
        <159852826969.707944.15092569392287597887.stgit@devnote2>
        <20200827114807.GA2674@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Aug 2020 13:48:07 +0200
peterz@infradead.org wrote:

> On Thu, Aug 27, 2020 at 08:37:49PM +0900, Masami Hiramatsu wrote:
> > Free kretprobe_instance with rcu callback instead of directly
> > freeing the object in the kretprobe handler context.
> > 
> > This will make kretprobe run safer in NMI context.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  include/linux/kprobes.h |    3 ++-
> >  kernel/kprobes.c        |   25 ++++++-------------------
> >  2 files changed, 8 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 46a7afcf5ec0..97557f820d9b 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -160,6 +160,7 @@ struct kretprobe_instance {
> >  	struct kretprobe *rp;
> >  	kprobe_opcode_t *ret_addr;
> >  	struct task_struct *task;
> > +	struct rcu_head rcu;
> >  	void *fp;
> >  	char data[];
> >  };
> 
> You can stick the rcu_head in a union with hlist.

Indeed. OK, I'll update it.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
