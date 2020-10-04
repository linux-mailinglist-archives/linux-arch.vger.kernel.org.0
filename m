Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243D7282E3C
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 01:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJDXNO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 19:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgJDXNO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Oct 2020 19:13:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1219206B6;
        Sun,  4 Oct 2020 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601853193;
        bh=m31SqXUL6DCOc1VrsmPEwIQUTxhYaXnIw5bhkN06IsA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BkruzT6rF2BYCftQpBquEm0Ob3fQxw3Sbn1Kkp/xHvXH7wfrr+i/toA7D9yFJ5e/R
         ZK/OT8svWzkAEw2sjeuNwkP9dujnEiDezHeHyhDM38ddx/WWBlomvg+UsRzu5wKzZW
         AHLWVhndF9rHQMV336Zlsw1tnHoMPI8pF4vagQyk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 811FB35225F2; Sun,  4 Oct 2020 16:13:13 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:13:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Litmus test for question from Al Viro
Message-ID: <20201004231313.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001045116.GA5014@paulmck-ThinkPad-P72>
 <20201001161529.GA251468@rowland.harvard.edu>
 <20201001213048.GF29330@paulmck-ThinkPad-P72>
 <20201003160846.GA3598977@google.com>
 <20201003161159.GA3601096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003161159.GA3601096@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 03, 2020 at 12:11:59PM -0400, joel@joelfernandes.org wrote:
> On Sat, Oct 03, 2020 at 12:08:46PM -0400, joel@joelfernandes.org wrote:
> [...] 
> > static void code0(struct v_struct* v,spinlock_t* l,int* out_0_r1) {
> > 
> >         struct v_struct *r1; /* to_free */
> > 
> >         r1 = NULL;
> >         spin_lock(l);
> >         if (!smp_load_acquire(&v->b))
> >                 r1 = v;
> >         v->a = 0;
> >         spin_unlock(l);
> > 
> >   *out_0_r1 = !!r1;
> > }
> > 
> > static void code1(struct v_struct* v,spinlock_t* l,int* out_1_r1) {
> > 
> >         struct v_struct *r1; /* to_free */
> > 
> >         r1 = v;
> >         if (READ_ONCE(v->a)) {
> >                 spin_lock(l);
> >                 if (v->a)
> >                         r1 = NULL;
> >                 smp_store_release(&v->b, 0);
> >                 spin_unlock(l);
> >         }
> > 
> >   *out_1_r1 = !!r1;
> > }
> > 
> > Results on both arm64 and x86:
> > 
> >     Histogram (2 states)
> >     19080852:>0:r1=1; 1:r1=0;
> >     20919148:>0:r1=0; 1:r1=1;
> >     No
> >     
> >     Witnesses
> >     Positive: 0, Negative: 40000000
> >     Condition exists (0:r1=1 /\ 1:r1=1) is NOT validated
> >     Hash=4a8c15603ffb5ab464195ea39ccd6382
> >     Observation AL+test Never 0 40000000
> >     Time AL+test 6.24
> > 
> > I guess I could do an alloc and free of v_struct. However, I just checked for
> > whether the to_free in Al's example could ever be NULL for both threads.
> 
> Sorry, here I meant "ever be non-NULL".
> 
> So basically I was trying to experimentally confirm that to_free could never
> be non-NULL in both code0 and code1 threads.

Thank you for running these!  In conjunction with Alan's analysis,
this seems quite convincing.  ;-)

							Thanx, Paul
