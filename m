Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56C325AB3C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIBMh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 08:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIBMhW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 08:37:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB526C061244;
        Wed,  2 Sep 2020 05:37:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so3363532qtg.4;
        Wed, 02 Sep 2020 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cY9qC0kbsxc+YZFWunizZECaQ+DzGdlchQ+Sbkt7gTY=;
        b=umOwl/rXNcD8W+cmSKfr3e7Pwkv1mQ/lP8rSwUMr5oRv2QPTzBLy2YQZaTmkYxquBI
         hCwjO1FCmkZhkXOeukWoH/7nKaFsZJhpTRdio2unFn8tE2E7hvgbAgA61CHv6pWUwlFv
         KOAhxMBn6+w8kFIH3CKfLCWhU+IVCBWWsW8hYvFXwx0f1gNcG1C/4Ryh9O4X06oNAkLJ
         tzANGyx2It1y13jCexWl961rp6UsFZmxhyPnJXrI/nOlvKE7XOaXuVQw5cPfzTB+6l8b
         0BkqVGHaGg+Eu/WLo2rCAoEA3/tMSN7/7tZFy1YhQtpcLfSNfP9vxzGAGwfBEdx49/yC
         1/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cY9qC0kbsxc+YZFWunizZECaQ+DzGdlchQ+Sbkt7gTY=;
        b=i3mwHadB5RG/k0GUYYaLb2ahFHhKoc36FyDgjyT4abqOwRIcVgvQ68+7g0H57n6KBS
         IrrpfDP4rgcH+6jzcyfFe8kvemk+2I/cBPXQLn9okIerI2hV3YHrpGCYd/EEbHftEVEX
         t52lh5kPEVLC4kvVWCDxSbsjRqVm8jxM1dz2lm+vOsuKDXV1DGHm4hxTAqCeoYtYnWa8
         27AF9L50WW/yU9SE920k2At+bEIG3j2wgRs0ntwEBn4JrsW/4XzlrPai8824lg4sOQCw
         /r13idr25/9SivMVf1/NMEykOJpmVd+Sp2vs1ZE0ZSEWuEoedtUX1iTlyh3vIR0nNnFx
         Ovvw==
X-Gm-Message-State: AOAM533azVObAoyiwadPY54GNbRqwAQ2zAT9F6FEhrx8edG4BxeDTaXG
        IFdYkqKBWLmMY6rB3ge8kBs=
X-Google-Smtp-Source: ABdhPJy6q8ebD/s1bwAx+hY+FqURLA6gZO9hfO+XdKVaQNIcZGoIP1SFzCSrsEr4spp/cY2bgfEbfg==
X-Received: by 2002:ac8:140b:: with SMTP id k11mr6510963qtj.287.1599050241000;
        Wed, 02 Sep 2020 05:37:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a3sm4494276qtj.21.2020.09.02.05.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 05:37:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B9B1727C0058;
        Wed,  2 Sep 2020 08:37:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 02 Sep 2020 08:37:18 -0400
X-ME-Sender: <xms:_JFPX_SXLyvra_lE5g1fqeRtCE2_ph0cryf354P5_9Y3IPpjAbQxOg>
    <xme:_JFPXwwHrxqC1dxzvTFl7Dt4TVZ10jDGYsTDdY5CV0N3DnDzNyq32DyHaiHxZ143K
    i8JkHleAKeCeLdySQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphephedvrdduheehrdduuddurdej
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:_ZFPX00gS3uHiXsuSiT1afgwQ4rWzZwuioojmaYPwYJfzHkwAzVfqg>
    <xmx:_ZFPX_Ba4c-tXnldXxNEk13HorB4jDNsZV2Y099C_WYN0s78__RDeQ>
    <xmx:_ZFPX4gcKyw8PPWIiKpht8AMhqY7qfvGJ0FUh0NPrGqf1LI_mOBYvQ>
    <xmx:_pFPX5ZORE01vtK3u9sls5iv1t-9YXDEjAg6kAtxEGWYkoMZVj1DWWr9nY0>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 90609328005E;
        Wed,  2 Sep 2020 08:37:16 -0400 (EDT)
Date:   Wed, 2 Sep 2020 20:37:15 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     peterz@infradead.org
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 12:14:12PM +0200, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 11:54:48AM +0800, Boqun Feng wrote:
> > On Mon, Aug 31, 2020 at 11:20:34AM -0700, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > This commit adds a key entry enumerating the various types of relaxed
> > > operations.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
> > >  1 file changed, 15 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> > > index 33ba98d..31b814d 100644
> > > --- a/tools/memory-model/Documentation/cheatsheet.txt
> > > +++ b/tools/memory-model/Documentation/cheatsheet.txt
> > > @@ -5,7 +5,7 @@
> > >  
> > >  Store, e.g., WRITE_ONCE()            Y                                       Y
> > >  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> > > -Unsuccessful RMW operation           Y                          Y   Y        Y
> > > +Relaxed operation                    Y                          Y   Y        Y
> > >  rcu_dereference()                    Y                          Y   Y        Y
> > >  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> > >  Successful *_release()         C        Y  Y    Y     W                      Y
> > > @@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> > >  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> > >  
> > >  
> > > -Key:	C:	Ordering is cumulative
> > > -	P:	Ordering propagates
> > > -	R:	Read, for example, READ_ONCE(), or read portion of RMW
> > > -	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> > > -	Y:	Provides ordering
> > > -	a:	Provides ordering given intervening RMW atomic operation
> > > -	DR:	Dependent read (address dependency)
> > > -	DW:	Dependent write (address, data, or control dependency)
> > > -	RMW:	Atomic read-modify-write operation
> > > -	SELF:	Orders self, as opposed to accesses before and/or after
> > > -	SV:	Orders later accesses to the same variable
> > > +Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > > +		  operation, an unsuccessful RMW operation, or one of
> > > +		  the atomic_read() and atomic_set() family of operations.
> > 
> > To be accurate, atomic_set() doesn't return any value, so it cannot be
> > ordered against DR and DW ;-)
> 
> Surely DW is valid for any store.
> 

IIUC, the DW colomn stands for whether the corresponding operation (in
this case, it's atomic_set()) is ordered any write that depends on this
operation. I don't think there is a write->write dependency, so DW for
atomic_set() should not be Y, just as the DW for WRITE_ONCE().

> > I think we can split the Relaxed family into two groups:
> > 
> > void Relaxed: atomic_set() or atomic RMW operations that don't return
> >               any value (e.g atomic_inc())
> > 
> > non-void Relaxed: a *_relaxed() RMW operation, an unsuccessful RMW
> >                   operation, or atomic_read().
> > 
> > And "void Relaxed" is similar to WRITE_ONCE(), only has "Self" and "SV"
> > equal "Y", while "non-void Relaxed" plays the same rule as "Relaxed"
> > in this patch.
> > 
> > Thoughts?
> 
> I get confused by the mention of all this atomic_read() atomic_set()
> crud in the first place, why are they called out specifically from any
> other regular load/store ?

Agreed. Probably we should fold those two operations into "Load" and
"Store" cases.

Regards,
Boqun
