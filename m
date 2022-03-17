Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20654DCB9E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiCQQoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiCQQoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 12:44:23 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5ED0829;
        Thu, 17 Mar 2022 09:43:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3220E3F12FB;
        Thu, 17 Mar 2022 12:43:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WfkQh1S7sllS; Thu, 17 Mar 2022 12:43:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 97C833F12FA;
        Thu, 17 Mar 2022 12:43:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 97C833F12FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1647535385;
        bh=5AJ+jdGzB5VC3ygMKOoPElKPln3rM1dEMPBCPv/N7+c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sWuyKjvgg62rsf6OstOn1yLtnyrjIRalB4iJ/Atqg8uhCFi4jAKFVCZJGkk+AxnpJ
         gaR6uuaDn3NAGUyTAy8760ImP8bwRYhpATrNa8cxdUvJ1GKI7zXRjfzgoS9oyMRo2t
         6ipXT3irQmEVAhxmFH5wte97QN1xNn+iUDvJKdpCmXp7Wyg/YeR65Gb7EJ9PJu97gw
         niQzS1dKvo2fOXoq7QQjJWZPUCsSKK7przRnSryQqKtlUHn4seU2/+yJM5I2klj+LF
         DoJPuyzlwq+tZwDHofEo5NXmGnNeVewqBxoKM06nkLzDgSXg57YpZnm7ugdiJ4uaqZ
         pM7COTV4OGWSg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vOUprICtB_LA; Thu, 17 Mar 2022 12:43:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 81E613F15C0;
        Thu, 17 Mar 2022 12:43:05 -0400 (EDT)
Date:   Thu, 17 Mar 2022 12:43:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        paulmck <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Message-ID: <1325267700.157591.1647535385417.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220317121055.33812ac1@gandalf.local.home>
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org> <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com> <20220317121055.33812ac1@gandalf.local.home>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: locking: Apply contention tracepoints in the slow path
Thread-Index: XtYNwpD1Kl95+SVBT3UlFooWB7QYrg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 17, 2022, at 12:10 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 17 Mar 2022 09:45:28 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> > *sem, bool reader)
>> > 		schedule();
>> > 	}
>> > 	__set_current_state(TASK_RUNNING);
>> > +	trace_contention_end(sem, 0);
>> 
>> So for the reader-write locks, and percpu rwlocks, the "trace contention end"
>> will always
>> have ret=0. Likewise for qspinlock, qrwlock, and rtlock. It seems to be a waste
>> of trace
>> buffer space to always have space for a return value that is always 0.
>> 
>> Sorry if I missed prior dicussions of that topic, but why introduce this single
>> "trace contention begin/end" muxer tracepoint with flags rather than
>> per-locking-type
>> tracepoint ? The per-locking-type tracepoint could be tuned to only have the
>> fields
>> that are needed for each locking type.
> 
> per-locking-type tracepoint will also add a bigger footprint.

If you are talking about code and data size footprint in the kernel, yes, we agree
there.

> 
> One extra byte is not an issue.

The implementation uses a 32-bit integer.

But given that this only traces contention, it's probably not as important to
shrink the event size as if it would be for tracing every uncontended lock/unlock.

> This is just the tracepoints. You can still
> attach your own specific LTTng trace events that ignores the zero
> parameter, and can multiplex into specific types of trace events on your
> end.

Indeed, I could, as I do for system call entry/exit tracing. But I suspect it would
not be worth it for contended locks, because I don't expect those events to be frequent
enough in the trace to justify the added code/data footprint, as you pointed out.

> 
> I prefer the current approach as it keeps the tracing footprint down.

Likewise. I just wanted to make sure this was done knowing the trace buffer vs kernel
code/data overhead trade-off.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
