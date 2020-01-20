Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1D14304C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATQxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 11:53:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 11:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VDW7FtXo4BtzloxC2r6H0DCb1zORddn+6B6Y6JeqHl4=; b=Md6XQet82ug27plX8I1roPwWY
        fcY7rANcFZ9K4vSec64bgyfnkrG270L+ECykSrd4zaJaL/JGxzPm8hhZ+g9R7ohusKYCptQWLu1q5
        MCuJwU5znf6xj/m1CjCy4lCpisLRyxXz2Q+XpCYgfMtGnQ79OQ+zOfzrkUUAP4cLJMbR0XEptG7ta
        OvYlEe4CX9jlFAstqZDK0ypBwjrK4zaiG2eE1ut6p5A+vlaILXUNfGZ4AkgP4E6kE3sZlOXeyKeWL
        Cz/u+oKqLMNr64TuH+QHM7Iax8CoTu+UHuowBs0qFfIPkG/nOO1aqmymo3woryIzF7Nch8UmnFlnt
        DTAJHm8pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itaHq-00022B-Mr; Mon, 20 Jan 2020 16:52:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89C353008A9;
        Mon, 20 Jan 2020 17:50:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2574820146B63; Mon, 20 Jan 2020 17:52:23 +0100 (CET)
Date:   Mon, 20 Jan 2020 17:52:23 +0100
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
Message-ID: <20200120165223.GC14914@hirez.programming.kicks-ass.net>
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120162725.GE2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 08:27:25AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 20, 2020 at 03:40:48PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> > > Add explicit KCSAN checks for bitops.
> > > 
> > > Note that test_bit() is an atomic bitop, and we instrument it as such,
> > 
> > Well, it is 'atomic' in the same way that atomic_read() is. Both are
> > very much not atomic ops, but are part of an interface that facilitates
> > atomic operations.
> 
> True, but they all are either inline assembly or have either an
> implicit or explicit cast to volatile, so they could be treated
> the same as atomic_read(), correct?  If not, what am I missing?

Sure, but that is due to instrumentation requirements, not anything
else.

Also note the distinct lack of __test_bit(), to mirror the non-atomic
__set_bit() and __clear_bit().
