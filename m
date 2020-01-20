Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB620142F92
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgATQ10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 11:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATQ10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jan 2020 11:27:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FA22087E;
        Mon, 20 Jan 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579537645;
        bh=DfsQKj6JVD4yxySwTBjUqI0G1NNDS6wQtVYJpuK5oYY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=02XheXlNlUAXFFARtrvh6NVeg9iWItQyCrHq/oLCUJltrCFTWiDl7PK7sO76IYnyF
         tJ3zKkTCIzfQYN5l5nwIsH6W3b5LHKdbhmdgLFuceqqWsDSQo+QbvB9xVVgjbBvIat
         lZP2tp4yT5N88yggo/b9s6d3qIPOwQdq6h3Tzh8s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A3543522745; Mon, 20 Jan 2020 08:27:25 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:27:25 -0800
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
Message-ID: <20200120162725.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120144048.GB14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 03:40:48PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> > Add explicit KCSAN checks for bitops.
> > 
> > Note that test_bit() is an atomic bitop, and we instrument it as such,
> 
> Well, it is 'atomic' in the same way that atomic_read() is. Both are
> very much not atomic ops, but are part of an interface that facilitates
> atomic operations.

True, but they all are either inline assembly or have either an
implicit or explicit cast to volatile, so they could be treated
the same as atomic_read(), correct?  If not, what am I missing?

(There is one exception, but it is in arch/x86/boot/bitops.h,
which I UP-only, correct?)

						Thanx, Paul
