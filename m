Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830CC143F4F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUOVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 09:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbgAUOVK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jan 2020 09:21:10 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C6B217F4;
        Tue, 21 Jan 2020 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579616469;
        bh=d8N8bHZ6gdDEoq72Z0eXZ2581jVoflv+KRkpsia+jf0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wQU1jn0f+AejKAp8s5GeUNVqP/8LaBtPd48e/iolHpmgJpHp/ooZAfw2WQjb86wDS
         mdFBntGtw0ism+j4JSYEpc+jGoSB6Zg91mSfmgsusq6AwSuWZQWpezQO1f0FFT4+7V
         H/nyp0F5+UCTbpc32OKHAcP90xtw2UILUTQJec2k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 54B7F35227E4; Tue, 21 Jan 2020 06:21:09 -0800 (PST)
Date:   Tue, 21 Jan 2020 06:21:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, andreyknvl@google.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de,
        viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net,
        mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@kernel.org, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Message-ID: <20200121142109.GQ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
 <20200120202359.GF2935@paulmck-ThinkPad-P72>
 <20200121091501.GF14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121091501.GF14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 10:15:01AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> > We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> > and atomic_set() are considered to be non-racy, right?
> 
> What is racy? :-) You can make data races with atomic_{read,set}() just
> fine.

Like "fairness", lots of definitions of "racy".  ;-)

> Anyway, traditionally we call the read-modify-write stuff atomic, not
> the trivial load-store stuff. The only reason we care about the
> load-store stuff in the first place is because C compilers are shit.
> 
> atomic_read() / test_bit() are just a load, all we need is the C
> compiler not to be an ass and split it. Yes, we've invented the term
> single-copy atomicity for that, but that doesn't make it more or less of
> a load.
> 
> And exactly because it is just a load, there is no __test_bit(), which
> would be the exact same load.

Very good!  Shouldn't KCSAN then define test_bit() as non-racy just as
for atomic_read()?

							Thanx, Paul
