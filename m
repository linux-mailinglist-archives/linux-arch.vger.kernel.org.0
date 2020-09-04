Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC125CF72
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 04:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgIDCrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 22:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbgIDCrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 22:47:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C79C061244;
        Thu,  3 Sep 2020 19:47:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so5179445qkd.1;
        Thu, 03 Sep 2020 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kz3m+8wx1zjPfndL+ovPIpx43LfU3nilyG5FcsGL0YI=;
        b=O8SbpTj61fCuMazPWfeQP3TbgvXv1SWlWeYoybOW/wtRdpU36mDowrty3+teqx/vfi
         jbS0Ob/2wUR1H0QeLHCBYPVhPZcyMQzomiFndO7PSuMd73/ctnEMIcJYBWz5fouXNgFx
         A+QFQgfP4hOEbNj+EA/Tk5K3EYNAz3A3keUF739DRe+oz/HUt81DHh7UNauW3T/BmZjE
         qloEzrcVYYpEcXO8e52Q7QRpt/gEpXoAeaFpfu1/VdTJrbG4kVN+Wz45KHQ9RMKgxGVX
         avU/n7D+tmT2z2aisPqJBlBV3pNXxZEi6+lxcVomd5lPpICuU/T3OeA8pmoRBSV+ib3M
         9tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kz3m+8wx1zjPfndL+ovPIpx43LfU3nilyG5FcsGL0YI=;
        b=U1ollmKs2kVq0HXwWfL5JQDZIKuqwogR8TSUdTtjb2J0NizyZGZDdP3iC9tiFmPW6v
         JguiQ2eTCRdjLLY2hbrpzVuWh+ph3Obj3Paa4qVmSY002SJvpbSe9F8CYiFtwn5BMDAi
         5plI9i0iNUmAD8q1vgN7kqlAkas+/qCQyb2DzRBdUp/88fvjgv9dQ2vafLJiMWq/DlIl
         +1ajUUg38HBUucm75ZOdNBesWmNN5Ofkxv0WutBRQBkrCcPe11j/NOoCxSmqxE0CPl4i
         Vo2xSdBCB/RRcfhV9NPpqrbOnWP4YG+WpzXqudRYCUYIkXxLXYyCCtCmkjBCI+nJp/HB
         OC+A==
X-Gm-Message-State: AOAM532oVde8u+mj8ANcWo2hOgDLfyxDreLM1xb5j9V2QK1lE/cMP5p9
        aUKXYvMHbC01X5JTIxdDHkM=
X-Google-Smtp-Source: ABdhPJwrOIuPjHqe/6RExl21TyiZPu8Tj0Fcyx9KIUVEUnUYf4sdPUe9NI0p9kv2s6lcDjU8GC8/AA==
X-Received: by 2002:a37:74c1:: with SMTP id p184mr5836777qkc.336.1599187641957;
        Thu, 03 Sep 2020 19:47:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g14sm3595958qkk.38.2020.09.03.19.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 19:47:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7E44427C0054;
        Thu,  3 Sep 2020 22:47:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 22:47:20 -0400
X-ME-Sender: <xms:t6pRXxx3uLBSuiHM2DCSygFN4SyaR3YLFZz2hWJD8S4xgfb7gG67Tg>
    <xme:t6pRXxT7U1egR0Q31CdkKwoUeIFsNHBZzVSZs5b70EilkK4DGZgBlfc1pRYZHAD8t
    6SpqVf7MBBnzWaJbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:t6pRX7U3JmhhZBt8XNmR4FgvabNZ4sj-DRrEEteFFyxbHAy7XDQ1Gw>
    <xmx:t6pRXzjCEUSGHhf7eMG-KUphjtp3x2EubWs-wClv0pwUvcnD7W9IlQ>
    <xmx:t6pRXzDG8ccGIpHZ2ZLgFzJwTAm0Zx3fkWy2rv_GLHlEFYIt_h_qag>
    <xmx:uKpRX36-1Z9kNLnBXI3xYBetHefoms-ahZ0rND4rMsrwMY25IeWOQJambeA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4530A306005F;
        Thu,  3 Sep 2020 22:47:19 -0400 (EDT)
Date:   Fri, 4 Sep 2020 10:47:17 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH kcsan 6/9] tools/memory-model: Expand the cheatsheet.txt
 notion of relaxed
Message-ID: <20200904024717.GC7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200831182012.GA1965@paulmck-ThinkPad-P72>
 <20200831182037.2034-6-paulmck@kernel.org>
 <20200902035448.GC49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200902101412.GC1362448@hirez.programming.kicks-ass.net>
 <20200902123715.GD49492@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200903233037.GW29330@paulmck-ThinkPad-P72>
 <20200904005921.GA7503@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200904023955.GX29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904023955.GX29330@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 07:39:55PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 04, 2020 at 08:59:21AM +0800, Boqun Feng wrote:
> > On Thu, Sep 03, 2020 at 04:30:37PM -0700, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > How about like this, adding "Relaxed" to the WRITE_ONCE() and READ_ONCE()
> > > rows and "RMW" to the "Relaxed operation" row?
> > > 
> > 
> > Much better now, thanks! However ...
> > 
> > > The file contents are followed by a diff against the previous version.
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> 
> [ . . . ]
> 
> > > Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> > > 		  operation, an unsuccessful RMW operation, READ_ONCE(),
> > > 		  WRITE_ONCE(), or one of the atomic_read() and
> > > 		  atomic_set() family of operations.
> > 
> > And:
> > 		  a RMW operation that doesn't return any value (e.g
> > 		  atomic_inc()), IOW it's a void Relaxed operation.
> 
> Good point!  Please see below.
> 

Looks good to me ;-)


Acked-by: Boqun Feng <boqun.feng@gmail.com>


Regards,
Boqun

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
> Key:	Relaxed:  A relaxed operation is either READ_ONCE(), WRITE_ONCE(),
> 		  a *_relaxed() RMW operation, an unsuccessful RMW
> 		  operation, a non-value-returning RMW operation such
> 		  as atomic_inc(), or one of the atomic*_read() and
> 		  atomic*_set() family of operations.
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
> index 4146b8d..99d0087 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -17,10 +17,11 @@ smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
>  smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y    Y
>  
>  
> -Key:	Relaxed:  A relaxed operation is either a *_relaxed() RMW
> -		  operation, an unsuccessful RMW operation, READ_ONCE(),
> -		  WRITE_ONCE(), or one of the atomic_read() and
> -		  atomic_set() family of operations.
> +Key:	Relaxed:  A relaxed operation is either READ_ONCE(), WRITE_ONCE(),
> +		  a *_relaxed() RMW operation, an unsuccessful RMW
> +		  operation, a non-value-returning RMW operation such
> +		  as atomic_inc(), or one of the atomic*_read() and
> +		  atomic*_set() family of operations.
>  	C:	  Ordering is cumulative
>  	P:	  Ordering propagates
>  	R:	  Read, for example, READ_ONCE(), or read portion of RMW
