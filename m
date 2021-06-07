Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234439D9EB
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 12:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFGKpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFGKpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 06:45:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C7C061766;
        Mon,  7 Jun 2021 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/oHhUDq9TK5yJJT28UIf32y1UqSwz/anyOKZzEFl8BU=; b=rQiEy33uAJGB4ZMlh9wdLPZb18
        Qgomdy/fkm5LY7UGP9yb7+LRvEdILw7/rlEKcKU/zq87DjEb7ORGM59Q/Jnuz38bXqKw3qJ8D0x5b
        IgrKadhrFnR0RyzBmDZcJNOD14MSrGMOMYiEgRFJwhRmu8UNKtGsMQzrtDr/1+X+H73UjXZsHe9CX
        Yu9iJRpcijnINtfsgY6yLIY7YdUEslgbiGvwRWZw0SVEypt4Z8nCkxUvaS8xNxwye7JOyTG97TEcz
        XdpMgjlk2w6J1u35wqvvA0XHG2IbVldI51Sa1lMhT/2cS+4f4rf7ytDlpjHWn7IIpxtFuwIwVCAwF
        zUk7hckw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqCie-004MPC-Kl; Mon, 07 Jun 2021 10:43:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAD4F30018A;
        Mon,  7 Jun 2021 12:43:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A49FF2D4D6621; Mon,  7 Jun 2021 12:43:01 +0200 (CEST)
Date:   Mon, 7 Jun 2021 12:43:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
References: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 11:43:42AM -0700, Linus Torvalds wrote:
> So while the example code is insane and pointless (and you shouldn't
> read *too* much into it), conceptually the notion of that pattern of
> 
>     if (READ_ONCE(a)) {
>         WRITE_ONCE(b,1);
>         .. do something ..
>     } else {
>         WRITE_ONCE(b,1);
>         .. do something else ..
>     }

This is actually more tricky than it would appear (isn't it always).

The thing is, that normally we must avoid speculative stores, because
they'll result in out-of-thin-air values.

*Except* in this case, where both branches emit the same store, then
it's a given that the store will happen and it will not be OOTA.
Someone's actually done the proof for that apparently (Will, you have a
reference to Jade's paper?)

There's apparently also a competition going on who can build the
weakestest ARM64 implementation ever.

Combine the two, and you'll get a CPU that *will* emit the store early
:/

So it might be prudent to make this pattern as difficult as possible (a
compiler implementation of volatile_if might be able to observe and WARN
about this).

How's something like (leaving the improved barrier() aside for now):

#define volatile_if(x) \
	if (!(({ _Bool __x = (x); BUILD_BUG_ON(__builtin_constant_p(__x)); __x; }) && \
	     ({ barrier(); 1; }))) { } else

That makes writing:

	volatile_if(READ_ONCE(a)) {
		WRITE_ONCE(b, 1);
		// something
	} else {
		WRITE_ONCE(b, 1);
		// something else
	}

A syntax error, due to volatile_if() already being an else. And yes,
there's plenty other ways to write the same :/
