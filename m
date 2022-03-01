Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2802F4C94F8
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 20:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiCATt4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 14:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbiCATtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 14:49:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E25A084;
        Tue,  1 Mar 2022 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JTjpHIBNzbqDknQ+Nbv4Mia7f/qQBAKZ0P9X14dcOCY=; b=TS3MjJTjjyWVrc0Vzjy/hLdTS0
        jyfpowb4SXry/qUrvbLRPPOPxa3DvgdnjL/DG5wgQZpGLBNgRxarZ+/gnJzYC3B09gBFqJbG6W4iK
        2AjGYnTviAgEE8FBbfAL1UrzgpP9j6ZZPHcYnRtou9brufHwSOgjQ+4y0Vd0NsCk0y7/kPXkRlFyl
        EsApvHdgTaZLxKlmCKUZXHk//Rsh5HCbVfrX+Y3VBkxE/9X6aY2IH0tGVvNUkt/+i2jk5JScWYLP1
        hRxB8w/PxNXJnYdIYis/UafmXUBALsnFwuaxj7BW9X0yYZ2SPmrltfu4/uv//vvITzfexi9OBqZIo
        QR9Q+ErQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP8Sv-00EMCU-Sv; Tue, 01 Mar 2022 19:47:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FBDE986271; Tue,  1 Mar 2022 20:47:20 +0100 (CET)
Date:   Tue, 1 Mar 2022 20:47:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 3/4] locking/mutex: Pass proper call-site ip
Message-ID: <20220301194720.GJ11184@worktop.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
 <20220301010412.431299-4-namhyung@kernel.org>
 <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
 <20220301095354.0c2b7008@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301095354.0c2b7008@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 01, 2022 at 09:53:54AM -0500, Steven Rostedt wrote:
> On Tue, 1 Mar 2022 10:05:12 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Feb 28, 2022 at 05:04:11PM -0800, Namhyung Kim wrote:
> > > The __mutex_lock_slowpath() and friends are declared as noinline and
> > > _RET_IP_ returns its caller as mutex_lock which is not meaningful.
> > > Pass the ip from mutex_lock() to have actual caller info in the trace.  
> > 
> > Blergh, can't you do a very limited unwind when you do the tracing
> > instead? 3 or 4 levels should be plenty fast and sufficient.
> 
> Is there a fast and sufficient way that works across architectures?

The normal stacktrace API? Or the fancy new arch_stack_walk() which is
already available on most architectures you actually care about and
risc-v :-)

Remember, this is the contention path, we're going to stall anyway,
doing a few levels of unwind shouldn't really hurt at that point.

Anyway; when I wrote that this morning, I was thinking:

	unsigned long ips[4];
	stack_trace_save(ips, 4, 0);


> Could objtool help here?

There's a contradition there... objtool is still x86_64 only :-/

IIRC there's been work on s390, arm64 and power objtool, but so far none
of them actually made it in.
