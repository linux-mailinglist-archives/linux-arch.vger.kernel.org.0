Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D594255C2B
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH1OTZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgH1OTY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:19:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8C7208C9;
        Fri, 28 Aug 2020 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598624364;
        bh=TdetsC/IwhbsAgTlgvX2TtgjuiEy6W6tBp2ZWqLO+JM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtDWadleCxTR0PpV04LVMcmFE6CLPUIAXMPQ01N15drNu1lbMIvXC65zqFQ4kp6WG
         Gih9hip23BkPOqD3sY/i9NgFZUnQ4gf7g6v8tnpXSS6aADVP/GRRdhKXlEEGBEWqzg
         NL6VQLuwsWmPZ96IL+h1DpTYX02OGeYN7drBGqkk=
Date:   Fri, 28 Aug 2020 23:19:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-Id: <20200828231920.4cb817dd9c624703ecfedc5d@kernel.org>
In-Reply-To: <20200828135824.GD1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
        <7df0a1af432040d9908517661c32dc34@trendmicro.com>
        <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
        <20200828135824.GD1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 15:58:24 +0200
peterz@infradead.org wrote:

> On Fri, Aug 28, 2020 at 10:51:13PM +0900, Masami Hiramatsu wrote:
>  
> > OK, schedule function will be the key. I guess the senario is..
> > 
> > 1) kretporbe replace the return address with kretprobe_trampoline on task1's kernel stack
> > 2) the task1 forks task2 before returning to the kretprobe_trampoline
> > 3) while copying the process with the kernel stack, task2->kretprobe_instances.first = NULL
> > 4) task2 returns to the kretprobe_trampoline
> > 5) Bomb!
> > 
> > Hmm, we need to fixup the kernel stack when copying process. 
> 
> How would that scenario have been avoided in the old code? Because there
> task2 would have a different has and not have found a kretprobe_instance
> either.

Good question, I think this bug has not been solved in old code too.
Let me check.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
