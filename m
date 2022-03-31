Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694C4EE153
	for <lists+linux-arch@lfdr.de>; Thu, 31 Mar 2022 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiCaTHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Mar 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiCaTHa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Mar 2022 15:07:30 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547421C727;
        Thu, 31 Mar 2022 12:05:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 33B1D3D67A7;
        Thu, 31 Mar 2022 15:05:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6ukdw3_Ch-TX; Thu, 31 Mar 2022 15:05:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 88EE63D670E;
        Thu, 31 Mar 2022 15:05:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 88EE63D670E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1648753540;
        bh=aCyzExiZNAlii4hNNUqKPOAEajExCBXUHglNihKOAvI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Xc1elefVGLKmqhhM58407/ZT1mhhPKmDZGHLDmZT9yfmDob05N5AEnpZEwv+KbHHL
         dC1TmOhl3DueN9/BoShgyRxEZ70pNKZzWR5EpEb/XNr9RlG71WE5Mr0i68+VSoXt9+
         njk/1WMSV1GwOC4+ckRMHfILAfc6TTUnfXauhv2s+wetabOQ8OFIVyX78Axmm6ktXU
         AtpeTxYgtRHY9klkGbOQKtZVAIiE36I3Pic4QYFtIRZO1zc0UUMfaU+hc9YKcj917w
         AtwKYrhPoDxti5O4GzPY8XPJDT0eK64zPH/+fNymsQH6BMNAobegH9M43L8is2svfi
         ObjDMayWLVPZQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6MFkmGC2BjV5; Thu, 31 Mar 2022 15:05:40 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 774A13D67A6;
        Thu, 31 Mar 2022 15:05:40 -0400 (EDT)
Date:   Thu, 31 Mar 2022 15:05:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Beau Belgrave <beaub@microsoft.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Message-ID: <1879409978.201000.1648753540376.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220329215421.GA2997@kbox>
References: <2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com> <20220329002935.2869-1-beaub@linux.microsoft.com> <1014535694.197402.1648570634323.JavaMail.zimbra@efficios.com> <20220329215421.GA2997@kbox>
Subject: Re: Comments on new user events ABI
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: Comments on new user events ABI
Thread-Index: 7vhB2TzqJsMr+Bak6Tdk339nleGFrg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 29, 2022, at 5:54 PM, Beau Belgrave beaub@linux.microsoft.com wrote:

> On Tue, Mar 29, 2022 at 12:17:14PM -0400, Mathieu Desnoyers wrote:
>> ----- On Mar 28, 2022, at 8:29 PM, Beau Belgrave beaub@linux.microsoft.com
>> wrote:
>> 
>> >> ----- On Mar 28, 2022, at 4:24 PM, Mathieu Desnoyers
>> >> mathieu.desnoyers@efficios.com wrote:
[...]
> 
>> > 
>> >> I would have rather thought that tracers implemented in user-space could
>> >> register
>> >> themselves, and then there could be one
>> >> /sys/kernel/debug/tracing/user_events_status
>> >> per tracer. Considering that all kernel tracers use the same ABI to write an
>> >> event,
>> >> and then dispatch this event internally within the kernel to each registered
>> >> tracer, I would expect to have a single memory mapping for all those (e.g. a
>> >> /sys/kernel/debug/tracing/user_events_status/kernel_tracers file).
>> >> 
>> >> Then eventually if we have other user-space tracers such as lttng-ust with its
>> >> their own user-space code performing tracing in a shared memory ring buffer, it
>> >> would make sense to allow it to register its own
>> >> /sys/kernel/debug/tracing/user_events_status/lttng_ust file, with its own
>> >> indexes.
>> >> 
>> > 
>> > I don't follow that. The intention is to get user processes to participate with
>> > trace_events and the built-in tooling. When would a user-space tracer be used
>> > instead of perf/ftrace?
>> > 
>> > It seems like a feature request?
>> 
>> It can very well be out of scope for the user events, and I'm fine with that.
>> I was merely considering how the user events could be leveraged by tracers
>> implemented purely in user-space. But if the stated goal of this feature is
>> really to call into kernel tracers through a writev(), then I suspect that
>> supporting purely user-space tracers is indeed out of scope.
>> 
> 
> That was the goal with this ABI, are there maybe ways we can change the
> ABI to accomodate this later without shutting that out?

I suspect that targeting this bit-enable memory mapping only as a gate for
kernel tracers is good enough for now. Let's consider other use-cases when
we have a clear picture of how it would be used. For the moment, I suspect
that I would prefer to manage my own bit-enable memory mapping within lttng-ust
rather than use a kernel-wide facility, which opens up questions about isolation
of containers, and ability to run multiple concurrent instances on a given kernel
without side-effects on each other.

I suspect that clarifying what this mmap'd based mechanism brings over the already
existing SDT semaphores will be important to justify this new ABI.

Ref. https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

[...]

> 
>> [...]
>> 
>> >> kernel/trace/trace_events_user.c:
>> >> 
>> >> static int user_events_release(struct inode *node, struct file *file)
>> >> {
>> >> [...]
>> >>         /*
>> >>          * Ensure refs cannot change under any situation by taking the
>> >>          * register mutex during the final freeing of the references.
>> >>          */
>> >>         mutex_lock(&reg_mutex);
>> >> [...]
>> >>         mutex_unlock(&reg_mutex);
>> >> 
>> >>         kfree(refs);
>> >> 
>> >>         ^ AFAIU, the user_events_write() does not rely on reg_mutex to ensure mutual
>> >>         exclusion.
>> >>           Doing so would be prohibitive performance-wise. But I suspect that freeing
>> >>           "refs" here
>> >>           without waiting for a RCU grace period can be an issue if user_events_write_core
>> >>           is using
>> >>           refs concurrently with file descriptor close.
>> >> 
>> > 
>> > The refs is per-file, so if user_events_write() is running release cannot be
>> > called for that file instance, since it's being used. Did I miss something?
>> 
>> I'm possibly the one missing something here, but what prevents 2 threads
>> from doing user_event_write() and close() concurrently on the same file
>> descriptor ?
>> 
> 
> While nothing prevents it, my understanding is that the actual release()
> on the file_operations won't be invoked until the file struct has been
> ref'd down to zero. (fs/file_table.c:fput, fs/read_write.c:do_pwritev).
> 
> While the write call is being run, the file should have a non-zero ref
> count. I believe looking at do_pwritev the fdget/fdput pair are largely
> responsible for this, do you agree?

Yes, you are correct. So the "refs" lifetime for writev vs close is guaranteed
by the reference counting of the struct file when the process file descriptor
table has multiple users (e.g. multithreaded process).

[...]

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
