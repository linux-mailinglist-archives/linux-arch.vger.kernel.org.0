Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB88746400
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 22:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGCU1m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCU1l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 16:27:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F40D8E4E
        for <linux-arch@vger.kernel.org>; Mon,  3 Jul 2023 13:27:38 -0700 (PDT)
Received: (qmail 1082657 invoked by uid 1000); 3 Jul 2023 16:27:37 -0400
Date:   Mon, 3 Jul 2023 16:27:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Olivier Dion <odion@efficios.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rnk@google.com,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Message-ID: <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
References: <87ttukdcow.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttukdcow.fsf@laura>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
> Hi all,
> 
> This is a request for comments on extending the atomic builtins API to
> help avoiding redundant memory barriers.  Indeed, there are

What atomic builtins API are you talking about?  The kernel's?  That's 
what it sounded like when I first read this sentence -- why else post 
your message on a kernel mailing list?

> discrepancies between the Linux kernel consistency memory model (LKMM)
> and the C11/C++11 memory consistency model [0].  For example,

Indeed.  The kernel's usage of C differs from the standard in several 
respects, and there's no particular reason for its memory model to match 
the standard's.

> fully-ordered atomic operations like xchg and cmpxchg success in LKMM
> have implicit memory barriers before/after the operations [1-2], while
> atomic operations using the __ATOMIC_SEQ_CST memory order in C11/C++11
> do not have any ordering guarantees of an atomic thread fence
> __ATOMIC_SEQ_CST with respect to other non-SEQ_CST operations [3].

After reading what you wrote below, I realized that the API you're 
thinking of modifying is the one used by liburcu for user programs.  
It's a shame you didn't mention this in either the subject line or the 
first few paragraphs of the email; that would have made understanding 
the message a little easier.

In any case, your proposal seems reasonable to me at first glance, with 
two possible exceptions:

1.	I can see why you have special fences for before/after load, 
	store, and rmw operations.  But why clear?  In what way is 
	clearing an atomic variable different from storing a 0 in it?

2.	You don't have a special fence for use after initializing an 
	atomic.  This operation can be treated specially, because at the 
	point where an atomic is initialized, it generally has not yet 
	been made visible to any other threads.  Therefore the fence 
	which would normally appear after a store (or clear) generally 
	need not appear after an initialization, and you might want to 
	add a special API to force the generation of such a fence.

Alan Stern
