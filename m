Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA7283BAF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgJEPxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:53:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49865 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727137AbgJEPxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 11:53:11 -0400
Received: (qmail 381520 invoked by uid 1000); 5 Oct 2020 11:53:10 -0400
Date:   Mon, 5 Oct 2020 11:53:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Luc Maranget <luc.maranget@inria.fr>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005155310.GH376584@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 05:15:57PM +0200, Luc Maranget wrote:
> > On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
> > > > P1(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, READ_ONCE(*y));
> > > 
> > > Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.
> > 
> > You're right.  This is definitely a bug in herd7.
> > 
> > Luc, were you aware of this?
> 
> Hi Alan,
> 
> No I was not aware of it. Now I am, the bug is normally fixed in the master branch of herd git deposit.
> <https://github.com/herd/herdtools7/commit/0f3f8188a326d5816a82fb9970fcd209a2678859>
> 
> Thanks for the report.

I tested the new commit -- it does indeed fix the problem.

Thanks.

Alan
