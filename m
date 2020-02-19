Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D65164AFE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSQv6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:51:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgBSQv6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aOY3HVNQlxhNJtO2V3TApKHEpYE+w+Db2fWfBxPBg70=; b=aPCcJ9zrRXoUBYVDUKXy3j/k5j
        yZk9tmPqWFKmqWJQ98hEtRqBOsPIYOIenFwwhHx8m8CYgSGxcMjQzJ3YApVKYLxDgUX8aXH4oQzJf
        KfZg5wyIDaz2RVRvBCtSBe6T39nda9WAj3V65qNSoEBI5/eA+3hPRpB2ADTKUO/zfZ4q+nOTE78/5
        H6ljMA5Pp3zU3gbJ2Duv8QwodNYEKtto+/JcMYkkLWTtPjcY4t4V+YTCkY9VRCLXJAGPxTQpK/ooh
        c2qx87kmUEOKNEsWjyp/LQ/LKXol9Q8hyI60NtIMd2SzUwABydg/rZARjRJvflIPrQBT/U2mRpItU
        1vqZOtTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SZN-0001JM-FA; Wed, 19 Feb 2020 16:51:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75EB4300606;
        Wed, 19 Feb 2020 17:49:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB88D201E478A; Wed, 19 Feb 2020 17:51:27 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:51:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 22/22] x86/int3: Ensure that poke_int3_handler() is
 not sanitized
Message-ID: <20200219165127.GF14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150745.651901321@infradead.org>
 <CACT4Y+Y+nPcnbb8nXGQA1=9p8BQYrnzab_4SvuPwbAJkTGgKOQ@mail.gmail.com>
 <20200219163025.GH18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163025.GH18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:30:25PM +0100, Peter Zijlstra wrote:
> > It's quite fragile. Tomorrow poke_int3_handler handler calls more of
> > fewer functions, and both ways it's not detected by anything.
> 
> Yes; not having tools for this is pretty annoying. In 0/n I asked Dan if
> smatch could do at least the normal tracing stuff, the compiler
> instrumentation bits are going to be far more difficult because smatch
> doesn't work at that level :/
> 
> (I actually have

... and I stopped typing ...

I think I mean to say something like: ... more changes to
poke_int3_handler() pending, but they're all quite simple).
