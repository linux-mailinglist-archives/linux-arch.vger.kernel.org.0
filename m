Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A324DCAD4
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiCQQMQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 12:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiCQQMQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 12:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF421415D;
        Thu, 17 Mar 2022 09:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD51260EED;
        Thu, 17 Mar 2022 16:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C81BC340E9;
        Thu, 17 Mar 2022 16:10:57 +0000 (UTC)
Date:   Thu, 17 Mar 2022 12:10:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220317121055.33812ac1@gandalf.local.home>
In-Reply-To: <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com>
References: <20220316224548.500123-1-namhyung@kernel.org>
        <20220316224548.500123-3-namhyung@kernel.org>
        <365529974.156362.1647524728813.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 17 Mar 2022 09:45:28 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > *sem, bool reader)
> > 		schedule();
> > 	}
> > 	__set_current_state(TASK_RUNNING);
> > +	trace_contention_end(sem, 0);  
> 
> So for the reader-write locks, and percpu rwlocks, the "trace contention end" will always
> have ret=0. Likewise for qspinlock, qrwlock, and rtlock. It seems to be a waste of trace
> buffer space to always have space for a return value that is always 0.
> 
> Sorry if I missed prior dicussions of that topic, but why introduce this single
> "trace contention begin/end" muxer tracepoint with flags rather than per-locking-type
> tracepoint ? The per-locking-type tracepoint could be tuned to only have the fields
> that are needed for each locking type.

per-locking-type tracepoint will also add a bigger footprint.

One extra byte is not an issue. This is just the tracepoints. You can still
attach your own specific LTTng trace events that ignores the zero
parameter, and can multiplex into specific types of trace events on your
end.

I prefer the current approach as it keeps the tracing footprint down.

-- Steve
