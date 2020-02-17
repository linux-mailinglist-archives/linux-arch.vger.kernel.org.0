Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3115F161B50
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgBQTMq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 14:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgBQTMq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 14:12:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A929C20801;
        Mon, 17 Feb 2020 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581966765;
        bh=bBGh2zu9Ak33pj6iJVskOUz3q/3+KzGXfk104cCS3vU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iyZl7rw31feSNE1LTuRorqDiXP3Y9G62s0sBByNr9ZfckstTUZna1LpW9NalhgpeN
         Pnos4z7iBNdkFOzl1ZiWV3+PoQ0IRaWrXzHWiVejbX9c7RO+4747YJJzt5L+569DwX
         ygpx5EoDxiZS63BHPbPFBCzexMUAQ3dma9kFZjIM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7921D352273C; Mon, 17 Feb 2020 11:12:45 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:12:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model] Add recent references
Message-ID: <20200217191245.GV2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214233139.GA12521@paulmck-ThinkPad-P72>
 <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 16, 2020 at 12:01:14PM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Paul E. McKenney wrote:
> 
> > This commit updates the list of LKMM-related publications in
> > Documentation/references.txt.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> >  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> > -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> > -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> > +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> > +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.
> 
> Even though this is an update, the new version referenced here is
> already out-of-date (in particular, with regard to its discussions of 
> the ordering properties of unlock-lock sequences as viewed by threads 
> not holding the lock).  And it contains a few typos scattered 
> throughout.

Indeed, 18 months is a long time for LKMM, isn't it?  ;-)

Sounds like time to update it for the next meeting.  I of course would
welcome any notes you might have taken while going through it.

							Thanx, Paul
