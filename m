Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D714393C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAUJQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 04:16:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 04:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LyuFNpAXFwCRQciuWpZEuClZCiBhfl/IXNpqcj5ve08=; b=BkLy0jiLon7chhIXqqOzzzgP0
        OGa1wl43bmLxo30SES4dQs5uEFUD5np7nDMlTBVqRIoKnPnfq9mfW8i7dZ8nGIy8Pq2YRnFSEllG+
        L5yL+dH1/WigcYzbYRhDRyTH2EpKwxojfsdYlesiMsPMnavRyxUNPvBC9se8kvXYMrSZXl+Ze3iuO
        7pu902VrDsuN5S1o1gZqBos9F5rsYBVgFG+NkkDChX2YRR+KN37vkzRwJVv6sgDLWggikpPV2PD+g
        8Lx/321hVttbQGi6X8DIz+aG5VWIPjjr+gVXalOQ8yB8rZuoY3en1eMdsUv3BC59+5x2/wPAvHetC
        isYQLbwTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itpcm-0003XR-Jc; Tue, 21 Jan 2020 09:15:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BB0E30067C;
        Tue, 21 Jan 2020 10:13:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3645F20983E34; Tue, 21 Jan 2020 10:15:01 +0100 (CET)
Date:   Tue, 21 Jan 2020 10:15:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200121091501.GF14914@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
 <20200120202359.GF2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120202359.GF2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> and atomic_set() are considered to be non-racy, right?

What is racy? :-) You can make data races with atomic_{read,set}() just
fine.

Anyway, traditionally we call the read-modify-write stuff atomic, not
the trivial load-store stuff. The only reason we care about the
load-store stuff in the first place is because C compilers are shit.

atomic_read() / test_bit() are just a load, all we need is the C
compiler not to be an ass and split it. Yes, we've invented the term
single-copy atomicity for that, but that doesn't make it more or less of
a load.

And exactly because it is just a load, there is no __test_bit(), which
would be the exact same load.
