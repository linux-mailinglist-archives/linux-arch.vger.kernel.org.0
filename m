Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8830C1ABD9D
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504763AbgDPKH6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Apr 2020 06:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504761AbgDPKH4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 06:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B2A21D92;
        Thu, 16 Apr 2020 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587031675;
        bh=K0WP10TiIcLv27eDTOY6OMpM34tUS8V0xWTdgNc2fLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cW536kFNR+lJ390TAjqmnns3zSb2Sh5McnMQQEIyxViOUSyHa8wZMP4EaYMDSHepJ
         JJflAD42r0ahyWpHQJjmamC3yOF6SlZN5zxT7fwLPejwi3VwLufZwNyCCjB4SA5Vnl
         GgkbeFFqwlke+dMMAE8IIANO9UktKIjxlZl7sMCE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7F12735227CC; Thu, 16 Apr 2020 03:07:55 -0700 (PDT)
Date:   Thu, 16 Apr 2020 03:07:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
Message-ID: <20200416100755.GP17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
 <20200415184945.16487-6-paulmck@kernel.org>
 <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
 <20200416001741.GJ17661@paulmck-ThinkPad-P72>
 <9cd5b3c0a9a0f55d799a3d3ebd68ba8ff5f907d8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd5b3c0a9a0f55d799a3d3ebd68ba8ff5f907d8.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 15, 2020 at 06:46:21PM -0700, Joe Perches wrote:
> On Wed, 2020-04-15 at 17:17 -0700, Paul E. McKenney wrote:
> > On Wed, Apr 15, 2020 at 02:39:59PM -0700, Joe Perches wrote:
> > > On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> > > > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > > > Acked but somewhere along the line got lost. Add myself in this patch.
> > > []
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > > @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> > > >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > > >  R:	Akira Yokosawa <akiyks@gmail.com>
> > > >  R:	Daniel Lustig <dlustig@nvidia.com>
> > > > +R:	Joel Fernandes <joel@joelfernandes.org>
> > > >  L:	linux-kernel@vger.kernel.org
> > > >  L:	linux-arch@vger.kernel.org
> > > >  S:	Supported
> > > > @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
> > > >  F:	Documentation/core-api/refcount-vs-atomic.rst
> > > >  F:	Documentation/memory-barriers.txt
> > > >  F:	tools/memory-model/
> > > > +F:	Documentation/litmus-tests/
> > > 
> > > trivia:
> > > 
> > > Alphabetic ordering of F: entries please.
> > > This should be between core-api and memory-barriers.
> > > 
> > > >  LIS3LV02D ACCELEROMETER DRIVER
> > > >  M:	Eric Piel <eric.piel@tremplin-utc.net>
> > 
> > New one on me, but it does make a lot of sense, especially for cases
> > with lots of scattered paths.  How about the following?
> 
> Thanks Paul.
> 
> If the recent commits that Linus did just before v5.7-rc1:
> 
> 3b50142d8528 ("MAINTAINERS: sort field names for all entries")
> 4400b7d68f6e ("MAINTAINERS: sort entries by entry name")
> 
> don't create too many problems I suppose
> 
> $ scripts/parse-maintainers.pl --order --input=MAINTAINERS --output=MAINTAINERS
> 
> could be run just before every -rc1 to keep all this stuff organized.
> 
> We'll see.

Easier than me remembering, I suppose.  ;-)

							Thanx, Paul
