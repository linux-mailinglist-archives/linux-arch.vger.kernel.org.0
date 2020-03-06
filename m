Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31117C765
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFUz0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 15:55:26 -0500
Received: from mail.efficios.com ([167.114.26.124]:42020 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFUzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 15:55:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AA34A2690C5;
        Fri,  6 Mar 2020 15:55:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gEnsaX2owVTb; Fri,  6 Mar 2020 15:55:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 36502269214;
        Fri,  6 Mar 2020 15:55:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 36502269214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583528124;
        bh=nX7EnnV+jSctgcR9sDVdbgvtem6AIOc0p1CI0k+DUNE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kj36zf9htuTEQt1L3szwMd8vVQ+Ypy+N15CL9GeUykc6RcWINym08BLMu1V0l8oIm
         aAY7f7v3wAjBsnp4zF+wcLTRhITNCkw/bkyo87Fu3w81M/k66wwe9R7i7etUNLn0p7
         N83VzTGM3ZJnG/nB9nMW4WmK603KOoB1lodruNOPr2O3jm7zQngkz6pfGBxvz0V50O
         rPy4jjzP7rqQyaCsFdaLQMXZ+oBCpCEI4swmA5WzI7edaK12OW5tcubuPnvK0nAOGS
         PJGT4ZD7Zatd1LFFYWHD1DbRUGdlExRgFSddVsfGh0c82KS2Hg+Ji4Pq9y9hp/83DW
         y7QfYrOA5HvpA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tBQnlFexS270; Fri,  6 Mar 2020 15:55:24 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 25D18268DEE;
        Fri,  6 Mar 2020 15:55:24 -0500 (EST)
Date:   Fri, 6 Mar 2020 15:55:24 -0500 (EST)
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
Message-ID: <65796626.20397.1583528124078.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200306154556.6a829484@gandalf.local.home>
References: <20200221133416.777099322@infradead.org> <20200306104335.GF3348@worktop.programming.kicks-ass.net> <20200306113135.GA8787@worktop.programming.kicks-ass.net> <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com> <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com> <20200306125500.6aa75c0d@gandalf.local.home> <609624365.20355.1583526166349.JavaMail.zimbra@efficios.com> <20200306154556.6a829484@gandalf.local.home>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing: Remove regular RCU context for _rcuidle tracepoints (again)
Thread-Index: O+2BxyZ+gYfOWDMsabZK0oJx9bG+6Q==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 6, 2020, at 3:45 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 6 Mar 2020 15:22:46 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I agree with the overall approach. Just a bit of nitpicking on the API:
>> 
>> I understand that the "prio" argument is a separate argument because it can take
>> many values. However, "rcu" is just a boolean, so I wonder if we should not
>> rather
>> introduce a "int flags" with a bitmask enum, e.g.
> 
> I thought about this approach, but thought it was a bit overkill. As the
> kernel doesn't have an internal API, I figured we can switch this over to
> flags when we get another flag to add. Unless you can think of one in the
> near future.

The additional feature I have in mind for near future would be to register
a probe which can take a page fault to a "sleepable" tracepoint. This would
require preemption to be enabled and use of SRCU.

We can always change things when we get there.

Thanks,

Mathieu

> 
>> 
>> int tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe,
>>                                          void *data, int prio, int flags)
>> 
>> where flags would be populated through OR between labels of this enum:
>> 
>> enum tracepoint_flags {
>>   TRACEPOINT_FLAG_RCU = (1U << 0),
>> };
>> 
>> We can then be future-proof for additional flags without ending up calling e.g.
>> 
>> tracepoint_probe_register_featurea_featureb_featurec(tp, probe, data, 0, 1, 0,
>> 1)
> 
> No, as soon as there is another boolean to add, the rcu version would be
> switched to flags. I even thought about making the rcu and prio into one,
> and change prio to be a SHRT_MAX max, and have the other 16 bits be for
> flags.
> 
> -- Steve
> 
> 
>> 
> > which seems rather error-prone and less readable than a set of flags.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
