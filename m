Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FF1723E9
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 17:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgB0QtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 11:49:04 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29038 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730194AbgB0QtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 11:49:04 -0500
From:   Luc Maranget <luc.maranget@inria.fr>
X-IronPort-AV: E=Sophos;i="5.70,492,1574118000"; 
   d="scan'208";a="437938070"
Received: from yquem.paris.inria.fr (HELO yquem.inria.fr) ([128.93.101.33])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Feb 2020 17:49:02 +0100
Received: by yquem.inria.fr (Postfix, from userid 18041)
        id 065F9E1AAB; Thu, 27 Feb 2020 17:49:02 +0100 (CET)
Date:   Thu, 27 Feb 2020 17:49:02 +0100
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] tools/memory-model: Add an exception for
 limitations on _unless() family
Message-ID: <20200227164901.jxwk26ey3i2n2yhu@yquem.inria.fr>
References: <20200227004049.6853-2-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002271129370.1730-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002271129370.1730-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On Thu, 27 Feb 2020, Boqun Feng wrote:
> 
> > According to Luc, atomic_add_unless() is directly provided by herd7,
> > therefore it can be used in litmus tests. So change the limitation
> > section in README to unlimit the use of atomic_add_unless().
> 
> Is this really true?  Why does herd treat atomic_add_unless() different
> from all the other atomic RMS ops?  All the other ones we support do
> have entries in linux-kernel.def.

I think this to be true :)

As far as I remember atomic_add_unless is quite different fron other atomic
RMW ops and called for a specific all-OCaml implementation, without an
entry in linux-kernel.def. As to  atomic_long_add_unless, I was not aware
of its existence.

--Luc

> 
> Alan
> 
> PS: It seems strange to support atomic_add_unless but not 
> atomic_long_add_unless.  The difference between the two is trivial.
> 
> > 
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  tools/memory-model/README | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index fc07b52f2028..409211b1c544 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -207,11 +207,15 @@ The Linux-kernel memory model (LKMM) has the following limitations:
> >  		case as a store release.
> >  
> >  	b.	The "unless" RMW operations are not currently modeled:
> > -		atomic_long_add_unless(), atomic_add_unless(),
> > -		atomic_inc_unless_negative(), and
> > -		atomic_dec_unless_positive().  These can be emulated
> > +		atomic_long_add_unless(), atomic_inc_unless_negative(),
> > +		and atomic_dec_unless_positive().  These can be emulated
> >  		in litmus tests, for example, by using atomic_cmpxchg().
> >  
> > +		One exception of this limitation is atomic_add_unless(),
> > +		which is provided directly by herd7 (so no corresponding
> > +		definition in linux-kernel.def). atomic_add_unless() is
> > +		modeled by herd7 therefore it can be used in litmus tests.
> > +
> >  	c.	The call_rcu() function is not modeled.  It can be
> >  		emulated in litmus tests by adding another process that
> >  		invokes synchronize_rcu() and the body of the callback
> > 
