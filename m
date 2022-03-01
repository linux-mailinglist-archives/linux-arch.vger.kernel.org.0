Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627374C8E58
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiCAOym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 09:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiCAOyk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 09:54:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C8AA146F;
        Tue,  1 Mar 2022 06:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F386159A;
        Tue,  1 Mar 2022 14:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF33CC340EE;
        Tue,  1 Mar 2022 14:53:55 +0000 (UTC)
Date:   Tue, 1 Mar 2022 09:53:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20220301095354.0c2b7008@gandalf.local.home>
In-Reply-To: <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
        <20220301010412.431299-4-namhyung@kernel.org>
        <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
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

On Tue, 1 Mar 2022 10:05:12 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 28, 2022 at 05:04:11PM -0800, Namhyung Kim wrote:
> > The __mutex_lock_slowpath() and friends are declared as noinline and
> > _RET_IP_ returns its caller as mutex_lock which is not meaningful.
> > Pass the ip from mutex_lock() to have actual caller info in the trace.  
> 
> Blergh, can't you do a very limited unwind when you do the tracing
> instead? 3 or 4 levels should be plenty fast and sufficient.

Is there a fast and sufficient way that works across architectures?

Could objtool help here?

-- Steve
