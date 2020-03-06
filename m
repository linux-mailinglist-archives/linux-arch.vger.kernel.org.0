Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC217C6F8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 21:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFUWt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 15:22:49 -0500
Received: from mail.efficios.com ([167.114.26.124]:54530 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFUWs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 15:22:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EEBC2268B52;
        Fri,  6 Mar 2020 15:22:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zO7JmsQsDJM9; Fri,  6 Mar 2020 15:22:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8631E26896D;
        Fri,  6 Mar 2020 15:22:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8631E26896D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583526166;
        bh=r+lBEt5STJwJzj6tJ/OfbFfU87Bc66ZCYDieRzIweKg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DCVLzUiHd8NlIOA4CUd57TuDsLhDDgLtXTFJXHdSdCygDqcQ+WuE8nK1gYY+2vncX
         N/BbNEOxPr5ZgdbBJba0dycsEF9GP1SNPsZ+Fh5vTzZX6mMJ8Y3iF9gar2uoXIoudo
         6eu4HcZktQW6zdZkZ3f7OrbDB4fKtX+frK6ywAgw15+6jNORgq4qzyE9vIm5HFpCqr
         2An98eKkku/w/QfF75feCpxFVJYm2F6etUjmt8wrq6dwvH9N3l/4L35kgb8I60Zo9V
         +o0KhQQ1RLwpQm3Kn3LQOo/lmXfmUvhjMZKsqN+6LoRy37HNI4M7y3ycJylpECQgrG
         Q7m5ZiqWuS+YA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QxsuSvlpbagB; Fri,  6 Mar 2020 15:22:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 719D5268AD8;
        Fri,  6 Mar 2020 15:22:46 -0500 (EST)
Date:   Fri, 6 Mar 2020 15:22:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Message-ID: <609624365.20355.1583526166349.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200306125500.6aa75c0d@gandalf.local.home>
References: <20200221133416.777099322@infradead.org> <20200221134216.051596115@infradead.org> <20200306104335.GF3348@worktop.programming.kicks-ass.net> <20200306113135.GA8787@worktop.programming.kicks-ass.net> <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com> <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com> <20200306125500.6aa75c0d@gandalf.local.home>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing: Remove regular RCU context for _rcuidle tracepoints (again)
Thread-Index: bZNNWmRnIZd0OYh0THVv3pcm6i1KDw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 6, 2020, at 12:55 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 6 Mar 2020 11:04:28 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> If we care about not adding those extra branches on the fast-path, there is
>> an alternative way to do things: BPF could provide two distinct probe callbacks,
>> one meant for rcuidle tracepoints (which would have the trace_rcu_enter/exit),
>> and
>> the other for the for 99% of the other callsites which have RCU watching.
>> 
>> I would recommend performing benchmarks justifying the choice of one approach
>> over
>> the other though.
> 
> I just whipped this up (haven't even tried to compile it), but this should
> satisfy everyone. Those that register a callback that needs RCU protection
> simply registers with one of the _rcu versions, and all will be done. And
> since DO_TRACE is a macro, and rcuidle is a constant, the rcu protection
> code will be compiled out for locations that it is not needed.
> 
> With this, perf doesn't even need to do anything extra but register with
> the "_rcu" version.
> 
> -- Steve
> 

[...]

> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 73956eaff8a9..1797e20fd471 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -295,6 +295,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  * @probe: probe handler
>  * @data: tracepoint data
>  * @prio: priority of this function over other registered functions
> + * @rcu: set to non zero if the callback requires RCU protection
>  *
>  * Returns 0 if ok, error value on error.
>  * Note: if @tp is within a module, the caller is responsible for
> @@ -302,8 +303,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  * performed either with a tracepoint module going notifier, or from
>  * within module exit functions.
>  */
> -int tracepoint_probe_register_prio(struct tracepoint *tp, void *probe,
> -				   void *data, int prio)
> +int tracepoint_probe_register_prio_rcu(struct tracepoint *tp, void *probe,
> +				       void *data, int prio, int rcu)

I agree with the overall approach. Just a bit of nitpicking on the API:

I understand that the "prio" argument is a separate argument because it can take
many values. However, "rcu" is just a boolean, so I wonder if we should not rather
introduce a "int flags" with a bitmask enum, e.g.

int tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe,
                                         void *data, int prio, int flags)

where flags would be populated through OR between labels of this enum:

enum tracepoint_flags {
  TRACEPOINT_FLAG_RCU = (1U << 0),
};

We can then be future-proof for additional flags without ending up calling e.g.

tracepoint_probe_register_featurea_featureb_featurec(tp, probe, data, 0, 1, 0, 1)

which seems rather error-prone and less readable than a set of flags.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
