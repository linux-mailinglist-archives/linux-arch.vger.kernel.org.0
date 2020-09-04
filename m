Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9C25CEE4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgIDA7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 20:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgIDA73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 20:59:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FAC061244;
        Thu,  3 Sep 2020 17:59:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so4951748qkd.9;
        Thu, 03 Sep 2020 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2HYxr1hKgKaGFsZr9AvO6upFQnVYZ17jVCpmYOeLgcY=;
        b=CnJdCdzVKYrGs+uNRNYqIfumGJgiShCsEexURQ0/7tgj/vXTfURyK6KLvbvcrvo7KW
         1MeKyPZ5P1lcFHTF2NBQzhnAqa7oHnUOxHylRihPv41n8C9zuHi8E7BBRDUJRnpIjeYy
         RLIZihOuzJc/BgBWB0oa9ay7bpuqtUvqokNfyIlgt+uvFlgeBXfyd7eH1W3unWtw+3AZ
         DqYk6lQNbtbnopLxXZi+IKOb8DNvixcUQQgsw4B8XXiiF6Q+7wzfhUXWw+n+gguJLpVK
         ZqK3JTtLOl8yAkZqWSYSUgkdsCYwA1I8HxQH8movk1b2JoN2KqsV07s5EHnPQYcM3aU2
         SO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HYxr1hKgKaGFsZr9AvO6upFQnVYZ17jVCpmYOeLgcY=;
        b=SOSorGCL4hRHQsNxTWn8FgTcLkpYZXTvmuMrYIBPQX+6jOF/BamaB3wlFjsaQWhxUi
         sfy54c7YUQf4x1Vf1ooXCnifW/SDfUk9cNaZFZXnvrnUrKlWGnkjsjfZCm8uYj2zFs0i
         Jje32wKz2/YTAKDzxa4FvaqcqR1W1QbnzFXHdM4MzOA+4wwBgYeNVdZ4jmGXCEcA3QIR
         KLknacloHtk8jSBlp+hDiCtHAdpyhOC/VB1L/wjd6etYyj6i76f9zl6aXNKHzz5j552+
         Gg3FPxhDVI01iXntISemh53anrZNbHz4ycLGBS3cfSK1OQ1l74wlOShTatkjobXvVFlp
         Ulcg==
X-Gm-Message-State: AOAM531I89kQPkJgj7Vt6XHD3JrMF5lTlWV2VoD94hyJpp/TNsJSOd+X
        ZGF3dVL+WXKfTYxKHxpaLDw=
X-Google-Smtp-Source: ABdhPJxnS6w5KmkUHJThgHcp2vNNPm45OiNcr2X3uCW5OEvCFhizpBKsLk0+EiMZ1NPmal6Hz0s+BQ==
X-Received: by 2002:a05:620a:1348:: with SMTP id c8mr5588667qkl.443.1599181168513;
        Thu, 03 Sep 2020 17:59:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n144sm3223889qkn.69.2020.09.03.17.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 17:59:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9197A27C0054;
        Thu,  3 Sep 2020 20:59:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 20:59:26 -0400
X-ME-Sender: <xms:a5FRX4ocBu1meP34F9ABEvh0xKsT87gIzvUYsJ6WauEqO6-11P8mIA>
    <xme:a5FRX-o-bKwQJZFHiL8NVmA7W5Ugg3Y5DC_UQImWRKaz-fCNRVe8Pt-EziVc3GFZ6
    4bPEhi4JPllPFUpVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:a5FRX9NdtY1xQGITa7LlFafa19vNYU41E64uMZAK6cA8967oW6oPXA>
    <xmx:a5FRX_7w6wXBzKbhOl8c8jc8VpBXIEz9kF1dehkpX9cTp50o-ctsZw>
    <xmx:a5FRX36UZSoJVlGDEEdLiKXg9DUC0RaRrmL6MOifm-ipIvJfyUpqRg>
    <xmx:bpFRX_zjutQk7jV82DFpfIEytjUZpyN_bO5OnQC9XQX3ThzoSFQ9W64pqfQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id C8D20306005B;
        Thu,  3 Sep 2020 20:59:22 -0400 (EDT)
Date:   Fri, 4 Sep 2020 08:59:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200904005921.GA7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
 <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200903233037.GW29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903233037.GW29330@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 04:30:37PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 02, 2020 at 08:37:15PM +0800, Boqun Feng wrote:
> > On Wed, Sep 02, 2020 at 12:14:12PM +0200, peterz@infradead.org wrote:
> > > On Wed, Sep 02, 2020 at 11:54:48AM +0800, Boqun Feng wrote:
> > > > On Mon, Aug 31, 2020 at 11:20:34AM -0700, paulmck@kernel.org wrote:
> > > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > 
> > > > > This commit adds a key entry enumerating the various types of relaxed
> > > > > operations.
> > > > > 
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  tools/memory-model/Documentation/cheatsheet.txt | 27 ++++++++++++++-----------
> > > > >  1 file changed, 15 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> > > > > index 33ba98d..31b814d 100644
> > > > > --- a/tools/memory-model/Documentation/cheatsheet.txt
> > > > > +++ b/tools/memory-model/Documentation/cheatsheet.txt
> > > > > @@ -5,7 +5,7 @@
> > > > >  
> > > > >  Store, e.g., WRITE_ONCE()            Y                                       Y
> > > > >  Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> > > > > -Unsuccessful RMW operation           Y                          Y   Y        Y
> > > > > +Relaxed operation                    Y                          Y   Y        Y
> > > > >  rcu_dereference()                    Y                          Y   Y        Y
> > > > >  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> > > > >  Successful *_release()         C        Y  Y    Y     W                      Y
> > > > > @@ -17,14 +17,17 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> > > > >  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> > > > >  
> > > > >  
> > > > > -Key:	C:	Ordering is cumulative
> > > > > -	P:	Ordering propagates
> > > > > -	R:	Read, for example, READ_ONCE(), or read portion of RMW
> > > > > -	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> > > > > -	Y:	Provides ordering
> > > > > -	a:	Provides ordering given intervening RMW atomic operation
> > > > > -	DR:	Dependent read (address dependency)
> > > > > -	DW:	Dependent write (address, data, or control dependency)
> > > > > -	RMW:	Atomic read-modify-write operation
> > > > > -	SELF:	Orders self, as opposed to accesses before and/or after
> > > > > -	SV:	Orders later accesses to the same variable
> > > > > +Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > > > > +		  operation, an unsuccessful RMW operation, or one of
> > > > > +		  the atomic_read() and atomic_set() family of operations.
> > > > 
> > > > To be accurate, atomic_set() doesn't return any value, so it cannot be
> > > > ordered against DR and DW ;-)
> > > 
> > > Surely DW is valid for any store.
> > > 
> > 
> > IIUC, the DW colomn stands for whether the corresponding operation (in
> > this case, it's atomic_set()) is ordered any write that depends on this
> > operation. I don't think there is a write->write dependency, so DW for
> > atomic_set() should not be Y, just as the DW for WRITE_ONCE().
> > 
> > > > I think we can split the Relaxed family into two groups:
> > > > 
> > > > void Relaxed: atomic_set() or atomic RMW operations that don't return
> > > >               any value (e.g atomic_inc())
> > > > 
> > > > non-void Relaxed: a *_relaxed() RMW operation, an unsuccessful RMW
> > > >                   operation, or atomic_read().
> > > > 
> > > > And "void Relaxed" is similar to WRITE_ONCE(), only has "Self" and "SV"
> > > > equal "Y", while "non-void Relaxed" plays the same rule as "Relaxed"
> > > > in this patch.
> > > > 
> > > > Thoughts?
> > > 
> > > I get confused by the mention of all this atomic_read() atomic_set()
> > > crud in the first place, why are they called out specifically from any
> > > other regular load/store ?
> > 
> > Agreed. Probably we should fold those two operations into "Load" and
> > "Store" cases.
> 
> All good points.
> 
> How about like this, adding "Relaxed" to the WRITE_ONCE() and READ_ONCE()
> rows and "RMW" to the "Relaxed operation" row?
> 

Much better now, thanks! However ...

> The file contents are followed by a diff against the previous version.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>                                   Prior Operation     Subsequent Operation
>                                   ---------------  ---------------------------
>                                C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
>                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
> 
> Relaxed store                        Y                                       Y
> Relaxed load                         Y                          Y   Y        Y
> Relaxed RMW operation                Y                          Y   Y        Y

void Relaxed RMW operation is still missing ;-) Maybe:

  void Relaxed RMW operation           Y                                       Y

> rcu_dereference()                    Y                          Y   Y        Y
> Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> Successful *_release()         C        Y  Y    Y     W                      Y
> smp_rmb()                               Y       R        Y      Y        R
> smp_wmb()                                  Y    W           Y       Y    W
> smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
> Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
> smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
> 
> 
> Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> 		  operation, an unsuccessful RMW operation, READ_ONCE(),
> 		  WRITE_ONCE(), or one of the atomic_read() and
> 		  atomic_set() family of operations.

And:
		  a RMW operation that doesn't return any value (e.g
		  atomic_inc()), IOW it's a void Relaxed operation.

Thoughts?

Regards,
Boqun

> 	C:	  Ordering is cumulative
> 	P:	  Ordering propagates
> 	R:	  Read, for example, READ_ONCE(), or read portion of RMW
> 	W:	  Write, for example, WRITE_ONCE(), or write portion of RMW
> 	Y:	  Provides ordering
> 	a:	  Provides ordering given intervening RMW atomic operation
> 	DR:	  Dependent read (address dependency)
> 	DW:	  Dependent write (address, data, or control dependency)
> 	RMW:	  Atomic read-modify-write operation
> 	SELF:	  Orders self, as opposed to accesses before and/or after
> 	SV:	  Orders later accesses to the same variable
> 
> ------------------------------------------------------------------------
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> index 31b814d..4146b8d 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -3,9 +3,9 @@
>                                 C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
>                                --  ----  -  -  ---  ----  -  -  --  --  ---  --
>  
> -Store, e.g., WRITE_ONCE()            Y                                       Y
> -Load, e.g., READ_ONCE()              Y                          Y   Y        Y
> -Relaxed operation                    Y                          Y   Y        Y
> +Relaxed store                        Y                                       Y
> +Relaxed load                         Y                          Y   Y        Y
> +Relaxed RMW operation                Y                          Y   Y        Y
>  rcu_dereference()                    Y                          Y   Y        Y
>  Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
>  Successful *_release()         C        Y  Y    Y     W                      Y
> @@ -18,8 +18,9 @@ smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
>  
>  
>  Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> -		  operation, an unsuccessful RMW operation, or one of
> -		  the atomic_read() and atomic_set() family of operations.
> +		  operation, an unsuccessful RMW operation, READ_ONCE(),
> +		  WRITE_ONCE(), or one of the atomic_read() and
> +		  atomic_set() family of operations.
>  	C:	  Ordering is cumulative
>  	P:	  Ordering propagates
>  	R:	  Read, for example, READ_ONCE(), or read portion of RMW
