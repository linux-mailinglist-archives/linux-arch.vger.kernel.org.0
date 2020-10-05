Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82A28395F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 17:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgJEPQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 11:16:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38495 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727025AbgJEPQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 11:16:40 -0400
Received: (qmail 379940 invoked by uid 1000); 5 Oct 2020 11:16:39 -0400
Date:   Mon, 5 Oct 2020 11:16:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201005151639.GE376584@rowland.harvard.edu>
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <20201004233146.GP29330@paulmck-ThinkPad-P72>
 <20201005023846.GA359428@rowland.harvard.edu>
 <20201005082002.GA23216@willie-the-truck>
 <20201005091247.GA23575@willie-the-truck>
 <20201005142351.GB376584@rowland.harvard.edu>
 <20201005151313.GA23892@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005151313.GA23892@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 04:13:13PM +0100, Will Deacon wrote:
> > The failure to recognize the dependency in P0 should be considered a 
> > combined limitation of the memory model and herd7.  It's not a simple 
> > mistake that can be fixed by a small rewrite of herd7; rather it's a 
> > deliberate choice we made based on herd7's inherent design.  We 
> > explicitly said that control dependencies extend only to the code in the 
> > branches of an "if" statement; anything beyond the end of the statement 
> > is not considered to be dependent.
> 
> Interesting. How does this interact with loops that are conditionally broken
> out of, e.g.  a relaxed cmpxchg() loop or an smp_cond_load_relaxed() call
> prior to a WRITE_ONCE()?

Heh --  We finesse this issue by not supporting loops at all!  :-)

Alan
