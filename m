Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55414DCB8B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiCQQjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiCQQjA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 12:39:00 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD901FE55B;
        Thu, 17 Mar 2022 09:37:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 784873F1806;
        Thu, 17 Mar 2022 12:37:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5IU4r6yf7cn0; Thu, 17 Mar 2022 12:37:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E79CB3F11F0;
        Thu, 17 Mar 2022 12:37:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E79CB3F11F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1647535061;
        bh=PAPHnbmF2wR3OMxiL7OnGQkD2yhd8ljr7LSo+m6MLCo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=T/3OA0T0S3X2mfR5fnvDp2mIRLLxB9dPjr7c3ZY3NJQnwwCzYqM66+/x06cBREYdd
         A2RqZsXjZwEARFzpYhg4OlsXAXiIWX6OuR3ZEjgiBZbQQ2T3gI2stE250D6nW2HxaY
         54NJN5kSPdpRXXrP8X/271uzqlEXJvErwi4TXjdZGIgdqvYawN9PLO4BfWt4imFb57
         8i/HKxf3SfHzlO2Uu2hnoOMRAGTHcr32Qb6PZ12HtZdhHR54r+2wlgecwlNTk/x8a+
         mFm8gW2FfMAALqsVcbR0FmOtehwweqmpUl+uPrIufJymdMbKzVomdLbiooyL5V34e6
         W7gpyliS6FRfA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j8KehMFo--jP; Thu, 17 Mar 2022 12:37:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D49F63F16A6;
        Thu, 17 Mar 2022 12:37:41 -0400 (EDT)
Date:   Thu, 17 Mar 2022 12:37:41 -0400 (EDT)
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
Message-ID: <1649265824.157580.1647535061743.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220317120753.4cd73f9e@gandalf.local.home>
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-2-namhyung@kernel.org> <636955156.156341.1647523975127.JavaMail.zimbra@efficios.com> <20220317120753.4cd73f9e@gandalf.local.home>
Subject: Re: [PATCH 1/2] locking: Add lock contention tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Topic: locking: Add lock contention tracepoints
Thread-Index: +VNQJvpuNZvv5prjCmd52ze/0Xeh4g==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 17, 2022, at 12:07 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Unless there is a particular reason for using preprocessor defines here, the
>> following form is typically better because it does not pollute the preprocessor
>> defines, e.g.:
>> 
>> enum lock_contention_flags {
>>         LCB_F_SPIN =   1U << 0;
>>         LCB_F_READ =   1U << 1;
>>         LCB_F_WRITE =  1U << 2;
>>         LCB_F_RT =     1U << 3;
>>         LCB_F_PERCPU = 1U << 4;
>> };
> 
> If you do this, then to use the __print_flags(), You'll also need to add:
> 
> TRACE_DEFINE_ENUM(LCB_F_SPIN);
> TRACE_DEFINE_ENUM(LCB_F_READ);
> TRACE_DEFINE_ENUM(LCB_F_WRITE);
> TRACE_DEFINE_ENUM(LCB_F_RT);
> TRACE_DEFINE_ENUM(LCB_F_PERCPU);
> 
> Which does slow down boot up slightly.

So it looks like there is (currently) a good reason for going with the #define.

As a side-discussion, I keep finding it odd that this adds overhead on boot. I suspect
this is also implemented as a linked list which needs to be iterated over at boot-time.

With a few changes to these macros, these linked lists could be turned into arrays,
and thus remove the boot-time overhead.

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
