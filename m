Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76578283CCF
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgJEQwY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 12:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgJEQwY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 12:52:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89ABF207BC;
        Mon,  5 Oct 2020 16:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601916743;
        bh=vDaSw7or0+IopPu+t3KiIUtfzVibfMKUvXPz8Qzewgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cFt0jE2h24BB/WingHvOzg40dIUJExT4SajS+jIpZ3qIpmADC96pOT7ud7MDEQvRG
         BMjNUS5RrPVoYfcFutNVt/OQDAI1jWU8W0Dnm/FJtZgujmymWuwZ9QJp/aiTx1Qlm2
         eBeJ9jCGksQ78ID782P3qqc40zIjTUrVQQAOLbCk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 512C8352301E; Mon,  5 Oct 2020 09:52:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:52:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, joel@joelfernandes.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Bug in herd7 [Was: Re: Litmus test for question from Al Viro]
Message-ID: <20201005165223.GB29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003132212.GB318272@rowland.harvard.edu>
 <045c643f-6a70-dfdf-2b1e-f369a667f709@gmail.com>
 <20201003171338.GA323226@rowland.harvard.edu>
 <20201005151557.4bcxumreoekgwmsa@yquem.inria.fr>
 <20201005155310.GH376584@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005155310.GH376584@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 05, 2020 at 11:53:10AM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 05:15:57PM +0200, Luc Maranget wrote:
> > > On Sun, Oct 04, 2020 at 12:16:31AM +0900, Akira Yokosawa wrote:
> > > > > P1(int *x, int *y)
> > > > > {
> > > > > 	WRITE_ONCE(*x, READ_ONCE(*y));
> > > > 
> > > > Looks like this one-liner doesn't provide data-dependency of y -> x on herd7.
> > > 
> > > You're right.  This is definitely a bug in herd7.
> > > 
> > > Luc, were you aware of this?
> > 
> > Hi Alan,
> > 
> > No I was not aware of it. Now I am, the bug is normally fixed in the master branch of herd git deposit.
> > <https://github.com/herd/herdtools7/commit/0f3f8188a326d5816a82fb9970fcd209a2678859>
> > 
> > Thanks for the report.
> 
> I tested the new commit -- it does indeed fix the problem.

Beat me to it, very good!  ;-)

But were you using the crypto-control-data litmus test?  That one still
gets me Sometimes:

$ herd7 -version
7.56+02~dev, Rev: 0f3f8188a326d5816a82fb9970fcd209a2678859
$ herd7 -conf linux-kernel.cfg ~/paper/scalability/LWNLinuxMM/litmus/manual/kernel/crypto-control-data.litmus
Test crypto-control-data Allowed
States 2
0:r1=0;
0:r1=1;
Ok
Witnesses
Positive: 1 Negative: 4
Condition exists (0:r1=1)
Observation crypto-control-data Sometimes 1 4
Time crypto-control-data 0.00
Hash=10898119bac87e11f31dc22bbb7efe17

Or did I mess something up?

							Thanx, Paul
