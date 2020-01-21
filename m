Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E91143FED
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2020 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAUOsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jan 2020 09:48:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44236 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAUOsP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 09:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uyryvzrOJVnY2Rp4qJ6rxjhfB8x1mJVRx6ecxsTZGfA=; b=bwKVHF7soQKI2IrooaVefjguG
        fiAGC74P3bvssr0+css1C8EDCghS7r8UidTgSfsCcsr7l9MJtQOBGEztGXa+draot+IJe1QsvNUWm
        ooyuPGZu7ltO1acjhyi9PTgOZgKMhjfDCTAsoatpnl18p88qhPu6Jw06F9KBUyv45wlBW4yWwNqwf
        qQUW6g192epkfBVw2EcZj1iaUt2shzGMxi7C4M24doGP/9t+u8zmdVnImpXEgvqjV/4AzBqRIpC5v
        /cN7vv8avgOlqsmMtRk9CNvAThOodw2QTHJ0HW3GkIngZk5JmjpHEyfUwikqFK1R7crtZdrOPJlKM
        5nYFbT79Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ituoJ-0007N0-GP; Tue, 21 Jan 2020 14:47:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CE8E30067C;
        Tue, 21 Jan 2020 15:45:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35E7C20983E32; Tue, 21 Jan 2020 15:47:16 +0100 (CET)
Date:   Tue, 21 Jan 2020 15:47:16 +0100
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
Message-ID: <20200121144716.GQ14879@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
 <20200120202359.GF2935@paulmck-ThinkPad-P72>
 <20200121091501.GF14914@hirez.programming.kicks-ass.net>
 <20200121142109.GQ2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121142109.GQ2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 06:21:09AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 21, 2020 at 10:15:01AM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 20, 2020 at 12:23:59PM -0800, Paul E. McKenney wrote:
> > > We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
> > > and atomic_set() are considered to be non-racy, right?
> > 
> > What is racy? :-) You can make data races with atomic_{read,set}() just
> > fine.
> 
> Like "fairness", lots of definitions of "racy".  ;-)
> 
> > Anyway, traditionally we call the read-modify-write stuff atomic, not
> > the trivial load-store stuff. The only reason we care about the
> > load-store stuff in the first place is because C compilers are shit.
> > 
> > atomic_read() / test_bit() are just a load, all we need is the C
> > compiler not to be an ass and split it. Yes, we've invented the term
> > single-copy atomicity for that, but that doesn't make it more or less of
> > a load.
> > 
> > And exactly because it is just a load, there is no __test_bit(), which
> > would be the exact same load.
> 
> Very good!  Shouldn't KCSAN then define test_bit() as non-racy just as
> for atomic_read()?

Sure it does; but my comment was aimed at the gripe that test_bit()
lives in the non-atomic bitops header. That is arguably entirely
correct.
