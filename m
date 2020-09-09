Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE272626BF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 07:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIF2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 01:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIF2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Sep 2020 01:28:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869E121D40;
        Wed,  9 Sep 2020 05:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599629326;
        bh=ml6WI+Chx2VJC/Q73iCBAJoy55Yh6p7fbppRzEQTBhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B4giaAfOriZRBNC2lbcDSpoIwM/1GVMsqQBTbOjvVW9ErO+HeEoYALGkVU0qYQw0I
         m1hLqkFj/kqDO6K8NT3Stto6lzJcLuJfbKgjpYpR2WhISL23lCL2VNetFpqdueMtZy
         6tpBZ1kKewFKC8hmcsoy5WvW72NXnf6Uan2MMOnI=
Date:   Wed, 9 Sep 2020 14:28:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org,
        systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200909142840.b2245ae2f8325f042a3bc546@kernel.org>
In-Reply-To: <20200909000923.54cca4fb530904c57e8ff529@kernel.org>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
        <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
        <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
        <20200909000923.54cca4fb530904c57e8ff529@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 9 Sep 2020 00:09:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Of course make it lockless then warning is gone.
> > > But even without the lockless patch, this warning can be false-positive
> > > because we prohibit nested kprobe call, right?
> > 
> > Yes, because the actual nesting is avoided by kprobe_busy, but lockdep
> > can't tell. Lockdep sees a regular lock user and an in-nmi lock user and
> > figures that's a bad combination.

Hmm, what about introducing new LOCK_USED_KPROBE bit, which will be set
if the lock is accessed when the current_kprobe is set (including kprobe_busy)?
This means it is in the kprobe user-handler context. If we access the lock always
in the kprobes context, it is never nested.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
