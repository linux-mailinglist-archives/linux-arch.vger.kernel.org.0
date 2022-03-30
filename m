Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E474EBF97
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiC3LLH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243071AbiC3LLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 07:11:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFAA3EAAE;
        Wed, 30 Mar 2022 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yvZCXQhb37MOgxLXU/XqW9QmTlcuArhm2RsVvTAH3qo=; b=fjbHNdMzCsKzmXBcjUyke+JK+d
        LjJoer1GnS3wELRRqzIDeA4xu1xsaNcB+otbKA4M7vy7TZ5wN7mAWLpfVHWoNCq7KY5j9NdnhTJiZ
        ONv7YK0DqZzZVYUnB6dK89OBy2gPfK3C740Nu3xTlE18OrfM3kiCjnaJbNMNja1MPkNW0/QQG2rVM
        w/5VHCgWvnyjO9hS6iC+ddI+/jgDeI+4yR8a95SDGxI5rpjTd5ajcmyqgqXTCMYXPNtlpi4lROLcN
        +YIZ9oo0ooPKbvhYnuvGR4qnd2NIW9LuTc+i9g1cmC7CQ5gTlQ4QVeJ0YEMuGIASA75d/cGy82Wim
        hs0KkJJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZWC7-001AYf-Pz; Wed, 30 Mar 2022 11:08:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B233986215; Wed, 30 Mar 2022 13:08:54 +0200 (CEST)
Date:   Wed, 30 Mar 2022 13:08:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220330110853.GK8939@worktop.programming.kicks-ass.net>
References: <20220322185709.141236-1-namhyung@kernel.org>
 <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net>
 <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 28, 2022 at 10:48:59AM -0700, Namhyung Kim wrote:
> > Also, if you were to add LCB_F_MUTEX then you could have something like:
> 
> Yep, I'm ok with having the mutex flag.  Do you want me to send
> v5 with this change or would you like to do it by yourself?

I'll frob my thing on top. No need to repost.
