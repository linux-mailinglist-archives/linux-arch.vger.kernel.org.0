Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2151AB5A5
	for <lists+linux-arch@lfdr.de>; Thu, 16 Apr 2020 03:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgDPBsl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 21:48:41 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:47966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387838AbgDPBsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 21:48:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A4AD86130;
        Thu, 16 Apr 2020 01:48:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3872:3874:4321:4362:5007:6119:6742:7514:7901:7903:8957:9586:10004:10400:10471:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13138:13231:13255:13311:13357:13439:13548:14096:14097:14181:14659:14721:21080:21451:21611:21627:21809:30029:30030:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: vein82_67ab8ba175634
X-Filterd-Recvd-Size: 3060
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Apr 2020 01:48:32 +0000 (UTC)
Message-ID: <9cd5b3c0a9a0f55d799a3d3ebd68ba8ff5f907d8.camel@perches.com>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date:   Wed, 15 Apr 2020 18:46:21 -0700
In-Reply-To: <20200416001741.GJ17661@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
         <20200415184945.16487-6-paulmck@kernel.org>
         <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
         <20200416001741.GJ17661@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-04-15 at 17:17 -0700, Paul E. McKenney wrote:
> On Wed, Apr 15, 2020 at 02:39:59PM -0700, Joe Perches wrote:
> > On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> > > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > > Acked but somewhere along the line got lost. Add myself in this patch.
> > []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> > >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > >  R:	Akira Yokosawa <akiyks@gmail.com>
> > >  R:	Daniel Lustig <dlustig@nvidia.com>
> > > +R:	Joel Fernandes <joel@joelfernandes.org>
> > >  L:	linux-kernel@vger.kernel.org
> > >  L:	linux-arch@vger.kernel.org
> > >  S:	Supported
> > > @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
> > >  F:	Documentation/core-api/refcount-vs-atomic.rst
> > >  F:	Documentation/memory-barriers.txt
> > >  F:	tools/memory-model/
> > > +F:	Documentation/litmus-tests/
> > 
> > trivia:
> > 
> > Alphabetic ordering of F: entries please.
> > This should be between core-api and memory-barriers.
> > 
> > >  LIS3LV02D ACCELEROMETER DRIVER
> > >  M:	Eric Piel <eric.piel@tremplin-utc.net>
> 
> New one on me, but it does make a lot of sense, especially for cases
> with lots of scattered paths.  How about the following?

Thanks Paul.

If the recent commits that Linus did just before v5.7-rc1:

3b50142d8528 ("MAINTAINERS: sort field names for all entries")
4400b7d68f6e ("MAINTAINERS: sort entries by entry name")

don't create too many problems I suppose

$ scripts/parse-maintainers.pl --order --input=MAINTAINERS --output=MAINTAINERS

could be run just before every -rc1 to keep all this stuff organized.

We'll see.


