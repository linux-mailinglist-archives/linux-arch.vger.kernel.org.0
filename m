Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2762839BD5D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDQjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDQjf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:39:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC6C061766;
        Fri,  4 Jun 2021 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iiD4y9A/Zk5p/Ee8pWkSEoLIOJioLBBsCNXgz7QVNos=; b=v+YqUolP6jZUIeIhklDnnhleW1
        us2KvJZUm0pCJWXZ/cKydzD807UuqG9gxR1vKbHxW0H+OYqaL6V0jY7z9r5k7Rl7+NMffI6p5RhwD
        1YdrRAHojjXmo8K1ss9hEIOxoJSKmgW/n8FYPU2tj+iKT0c/DcSx8NULRLV3aBU3Xtx+vySjZfCsf
        xSKORERYey3GkwmaqzLxeyllxNqmoZo8vc3hbaH2xU/L71fLJVmOSsXVtlMdCtJreO4B0Rm5u4Q1v
        1cCNEDvoYJqfS9utFAstSH4PKnsVJPeZERdEi2phmOGAFOVw8vfBmcG81+8XzWoaeh66Nmsf0mjCM
        Q9VQB6Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpCp1-00DLRn-8e; Fri, 04 Jun 2021 16:37:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC3883001DB;
        Fri,  4 Jun 2021 18:37:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2CB3207AA26B; Fri,  4 Jun 2021 18:37:22 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:37:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 09:30:01AM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 3:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I've converted most architectures we care about, and the rest will get
> > an extra smp_mb() by means of the 'generic' fallback implementation (for
> > now).
> 
> Why is "volatile_if()" not just
> 
>        #define barier_true() ({ barrier(); 1; })
> 
>        #define volatile_if(x) if ((x) && barrier_true())
> 
> because that should essentially cause the same thing - the compiler
> should be *forced* to create one conditional branch (because "barrier"
> is an asm that can't be done on the false side, so it can't do it with
> arithmetic or other games), and after that we're done.
> 
> No need for per-architecture "asm goto" games. No new memory barriers.
> No actual new code generation (except for the empty asm volatile that
> is a barrier).

Because we weren't sure compilers weren't still allowed to optimize the
branch away. If compiler folks can guarantee us your thing (along with
maybe the BUILD_BUG_ON(__builtin_constant_p(cond)) thing) always shall
generate a conditional branch instruction, then Yay!
