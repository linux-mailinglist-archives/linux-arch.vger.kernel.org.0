Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2447162A2E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 17:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 11:15:33 -0500
Received: from mail.efficios.com ([167.114.26.124]:42580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRQPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 11:15:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 58D4B256DF3;
        Tue, 18 Feb 2020 11:15:31 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tmNNx4F-udVa; Tue, 18 Feb 2020 11:15:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E0BEF2578A4;
        Tue, 18 Feb 2020 11:15:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E0BEF2578A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582042530;
        bh=5UEGMAe09c0uhoyr1w31js41MQsx532sjq0P/JWOjIo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DqRQgGg3QaKuaJ/KHVfwr0hX0w8rcR/sm/1Q5yrVteFd7E1ClYUdUzAsa9MfANy4b
         BzcHqVH3e5L0RKghM+TFjdBrjxwYepZYej/+FJMw85oFlSrcbgMvTvCsD9JsHKYUUr
         9bzmwQpLzOTVoZ/G08+wmGY/r9oBSqib7jES4/hsKiwcpQ1SX/s7ZkcynBayNUWxhs
         Ko6WU+ylzrHJW2O6hRk+oZYu36SNssSt9N/OkVfx1fJZtyKAW0O5iW1PBabqsueVLy
         ta1I+dMO3R/Uk1hoRgeh0u/6bpQfmFZ5ftz8ykJCYQvMKB1Bdft9KW6GS+IdJuVeFB
         1U4vxRMXsyN3Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mycul7_S9TMN; Tue, 18 Feb 2020 11:15:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CACF2256DB5;
        Tue, 18 Feb 2020 11:15:30 -0500 (EST)
Date:   Tue, 18 Feb 2020 11:15:30 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1841874582.7975.1582042530726.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200218161231.GD2935@paulmck-ThinkPad-P72>
References: <20200213211930.GG170680@google.com> <20200213223918.GN2935@paulmck-ThinkPad-P72> <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org> <20200215145934.GD2935@paulmck-ThinkPad-P72> <20200217175519.12a694a969c1a8fb2e49905e@kernel.org> <20200217163112.GM2935@paulmck-ThinkPad-P72> <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org> <20200218161231.GD2935@paulmck-ThinkPad-P72>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: rcu,tracing: Create trace_rcu_{enter,exit}()
Thread-Index: E7a9UHyAd+58DcDwrMqxghyBB+Sv3g==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Feb 18, 2020, at 11:12 AM, paulmck paulmck@kernel.org wrote:

> On Tue, Feb 18, 2020 at 01:33:35PM +0900, Masami Hiramatsu wrote:
>> On Mon, 17 Feb 2020 08:31:12 -0800
>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> > 
>> > > BTW, if you consider the x86 specific code is in the generic file,
>> > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
>> > > (Sorry, I've hit this idea right now)
>> > 
>> > Might this affect other architectures with NMIs and probe-like things?
>> > If so, it might make sense to leave it where it is.
>> 
>> Yes, git grep shows that arm64 is using rcu_nmi_enter() in
>> debug_exception_enter().
>> OK, let's keep it, but maybe it is good to update the comment for
>> arm64 too. What about following?
>> 
>> +/*
>> + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
>> + * marked NOKPROBE before kprobes handler is called.
>> + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
>> + * before kprobes handle happens to call rcu_nmi_enter() which means
>> + * that rcu_nmi_enter() must be marked NOKRPOBE.
>> + */
> 
> Would it work to describe the general problem, then give x86 details
> as a specific example, as follows?
> 
> /*
> * On some architectures, certain exceptions prohibit use of kprobes until
> * the exception code path reaches a certain point.  For example, on x86 all
> * functions called by do_int3() must be marked NOKPROBE.  However, once
> * kprobe_int3_handler() is called, kprobing is permitted.  Specifically,
> * ist_enter() is called in do_int3() before kprobe_int3_handle().
> * Furthermore, ist_enter() calls rcu_nmi_enter(), which means that
> * rcu_nmi_enter() must be marked NOKRPOBE.
> */
> 
> That way, I don't feel like I need to update the commment each time
> a new architecture adds this capability.  ;-)

I suspect this kind of comment would belong in a new
Documentation/features/kprobes/annotations.txt or something
similar. You might want to look at other "features" files to see
the expected layout.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
