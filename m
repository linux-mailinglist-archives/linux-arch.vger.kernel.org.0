Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C2D160801
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 03:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBQCSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 21:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgBQCSg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BFE208C4;
        Mon, 17 Feb 2020 02:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581905915;
        bh=9wMvhzIojzb0NLzzASUWqtH8HA2/a9hA696DFOy+lBA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kUDquShC/5Shul1w7vjQYLPrufu5NT9UVsFbIfGvRYX9DZEBLdlKJheSnsJRt2Zu+
         wSkShkZ2TYrfnm/GCrcxiNubpLQt8x5VJwBCeua3LFIaczl2JuQAk96cPLbWMOmjOW
         7BqylrJ6yAw96sPsyFZGRBLhh1zV7KUtLd0rG8oM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0144E3520D7D; Sun, 16 Feb 2020 05:51:34 -0800 (PST)
Date:   Sun, 16 Feb 2020 05:51:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model] Add recent references
Message-ID: <20200216135134.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214233139.GA12521@paulmck-ThinkPad-P72>
 <20200216005801.GA3581@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216005801.GA3581@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 16, 2020 at 01:58:01AM +0100, Andrea Parri wrote:
> On Fri, Feb 14, 2020 at 03:31:39PM -0800, Paul E. McKenney wrote:
> > This commit updates the list of LKMM-related publications in
> > Documentation/references.txt.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Applied and queued for v5.7, thank you!

							Thanx, Paul

> Thanks,
>   Andrea
> 
> 
> > 
> > diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
> > index b177f3e..ecbbaa5 100644
> > --- a/tools/memory-model/Documentation/references.txt
> > +++ b/tools/memory-model/Documentation/references.txt
> > @@ -73,6 +73,18 @@ o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
> >  Linux-kernel memory model
> >  =========================
> >  
> > +o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
> > +	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
> > +	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
> > +	2019. "Calibrating your fear of big bad optimizing compilers"
> > +	Linux Weekly News.  https://lwn.net/Articles/799218/
> > +
> > +o	Jade Alglave, Will Deacon, Boqun Feng, David Howells, Daniel
> > +	Lustig, Luc Maranget, Paul E. McKenney, Andrea Parri, Nicholas
> > +	Piggin, Alan Stern, Akira Yokosawa, and Peter Zijlstra.
> > +	2019. "Who's afraid of a big bad optimizing compiler?"
> > +	Linux Weekly News.  https://lwn.net/Articles/793253/
> > +
> >  o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> >  	Alan Stern.  2018. "Frightening small children and disconcerting
> >  	grown-ups: Concurrency in the Linux kernel". In Proceedings of
> > @@ -88,6 +100,11 @@ o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> >  	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
> >  	Linux Weekly News.  https://lwn.net/Articles/720550/
> >  
> > +o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> > +	Alan Stern.  2017-2019.  "A Formal Model of Linux-Kernel Memory
> > +	Ordering" (backup material for the LWN articles)
> > +	https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/
> > +
> >  
> >  Memory-model tooling
> >  ====================
> > @@ -110,5 +127,5 @@ Memory-model comparisons
> >  ========================
> >  
> >  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> > -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> > -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> > +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> > +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.
