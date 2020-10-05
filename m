Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51AB283776
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJEOQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 10:16:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60251 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726329AbgJEOQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 10:16:29 -0400
Received: (qmail 377541 invoked by uid 1000); 5 Oct 2020 10:16:28 -0400
Date:   Mon, 5 Oct 2020 10:16:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005141628.GA376584@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005082002.GA23216@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005082002.GA23216@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 09:20:03AM +0100, Will Deacon wrote:
> On Sun, Oct 04, 2020 at 10:38:46PM -0400, Alan Stern wrote:
> > Considering the bug in herd7 pointed out by Akira, we should rewrite P1 as:
> > 
> > P1(int *x, int *y)
> > {
> > 	int r2;
> > 
> > 	r = READ_ONCE(*y);
> 
> (r2?)

Oops, yes, thank you.

> > 	WRITE_ONCE(*x, r2);
> > }
> > 
> > Other than that, this is fine.
> 
> But yes, module the typo, I agree that this rewrite is much better than the
> proposal above. The definition of control dependencies on arm64 (per the Arm
> ARM [1]) isn't entirely clear that it provides order if the WRITE is
> executed on both paths of the branch, and I believe there are ongoing
> efforts to try to tighten that up.

Do you mean that people aren't yet in agreement about what the answer 
should be?

How can the CPU tell whether a write is executed on both branches?  
Speculatively execute both and see if they both reach the same write 
instruction?  What if the same instruction is reached on both branches 
but the values written or the addresses written to are different?

>  I'd rather keep _that_ topic separate
> from the "bug in herd" topic to avoid extra confusion.

Indeed.

Alan
