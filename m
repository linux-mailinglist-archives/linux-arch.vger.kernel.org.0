Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617A287BBD
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgJHScl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgJHScl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 14:32:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773602145D;
        Thu,  8 Oct 2020 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602181960;
        bh=/8fOwt/Qn5xe/dYjyUSsAHEDn2T/gSBbNJtdJH0G9q0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rekAvmMoqxdT8aLb8t4dTGfslNnoBg1qFhMCXA01qhfaDg8SGWsipwsjh447JaX7j
         wKltTDgCHKyhF1P+kUuW/sRiNOsWA4C7KSpQlgffnL0FXnC0JQISmDYI4xFWEaV8yL
         XnABhduU0dwhBjnixh+VVmUnHom1Yw0jSc/nuy88=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1231235228D5; Thu,  8 Oct 2020 11:32:39 -0700 (PDT)
Date:   Thu, 8 Oct 2020 11:32:39 -0700
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
Message-ID: <20201008183239.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201005191801.GF29330@paulmck-ThinkPad-P72>
 <20201005194834.GB389867@rowland.harvard.edu>
 <20201006163954.GM29330@paulmck-ThinkPad-P72>
 <20201006170525.GA423499@rowland.harvard.edu>
 <20201007175040.GQ29330@paulmck-ThinkPad-P72>
 <20201007194050.GC468921@rowland.harvard.edu>
 <20201007223851.GV29330@paulmck-ThinkPad-P72>
 <20201008022537.GA480405@rowland.harvard.edu>
 <20201008025025.GX29330@paulmck-ThinkPad-P72>
 <20201008140148.GA495091@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008140148.GA495091@rowland.harvard.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 08, 2020 at 10:01:48AM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 07:50:25PM -0700, Paul E. McKenney wrote:
> > There are some distractions at the moment.
> > 
> > Please see below.  If this is not exactly correct, I will use "git rm"
> > and let you submit the patch as you wish.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit dc0119c24b64f9d541b94ba5d17eec0cbc265bfa
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Tue Oct 6 09:38:37 2020 -0700
> > 
> >     manual/kernel: Add LB data dependency test with no intermediate variable
> >     
> >     Test whether herd7 can detect a data dependency when there is no
> >     intermediate local variable, as in WRITE_ONCE(*x, READ_ONCE(*y)).
> >     Commit 0f3f8188a326 in herdtools fixed an oversight which caused such
> >     dependencies to be missed.
> >     
> >     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/manual/kernel/C-LB+mb+data.litmus b/manual/kernel/C-LB+mb+data.litmus
> > new file mode 100644
> > index 0000000..e9e24e0
> > --- /dev/null
> > +++ b/manual/kernel/C-LB+mb+data.litmus
> > @@ -0,0 +1,27 @@
> > +C LB+mb+data
> > +(*
> > + * Result: Never
> > + *
> > + * Versions of herd7 prior to commit 0f3f8188a326 ("[herd] Fix dependency
> > + * definition") recognize data dependencies only when they flow through
> > + * an intermediate local variable.  Since the dependency in P1 doesn't,
> > + * those versions get the wrong answer for this test.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *x, int *y)
> > +{
> > +	int r1;
> > +
> > +	r1 = READ_ONCE(*x);
> > +	smp_mb();
> > +	WRITE_ONCE(*y, r1);
> > +}
> > +
> > +P1(int *x, int *y)
> > +{
> > +	WRITE_ONCE(*x, READ_ONCE(*y));
> > +}
> > +
> > +exists (0:r1=1)
> 
> Okay, that's exactly what it should be.  :-)

Whew!!!  ;-)

							Thanx, Paul
