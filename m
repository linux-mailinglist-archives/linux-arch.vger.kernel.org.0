Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA415D3B2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 09:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgBNIUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 03:20:48 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33040 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgBNIUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 03:20:48 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so3931676qvn.0;
        Fri, 14 Feb 2020 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/x/CDVKcjVhDvaDNlzActs6ZY2vMfwoiLIHukrUfng=;
        b=UmI3ZjQniXlRn29AjFC78EzXV2zYnESaeGap8kwrctiD9G1bEzhrFDZyvwqGwIOmdD
         uo+qmFqu0WhfsJDkiiSXUYMSpDDzpkBKkOjtnrfRGMdRKDppbm6sDEZpFp4XQ7vbZef9
         ePt2Rixd0oQSDevxEoiNEvDLV4azIg+1tcCpHmsHaVlE7nKmI7xW8r148Wip9ByQHdRe
         FVq1zPjrLEfCmZNcJLrY7YV++ydhOpA2b/lz72r0h6iKxc5i9+sHxceSPFe4hHDO+7gm
         mJfFl/SNaAlapDvm93yqF+k1gaDowh9nSYJ8B10KxxFylQBEOyeBw6gvzXJRtAr45Tdv
         HO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/x/CDVKcjVhDvaDNlzActs6ZY2vMfwoiLIHukrUfng=;
        b=N8p81LwEk+obqklsdjT/4D6R8aUvuclbKhLqCTHEyJuUpwXw7fTM/Lcn+YflJjddTr
         7B+mrMTp/+yucrBMevVafcQQ4X361gqvo1zkmvqMdJlMOZ60SAMC2bFKehfyIC24Ck6k
         nAELcMsqhx2d0/MNvn3gOBuFGWzkeOkq+IEA+yPk8cM+mXC0Hf/jGcjSZSFpaKrENVgw
         Aegq2QdOVT3OTtuVlaB/fB1Qq3bUl18yWKEUznL4bcHT74EXgi5o7nnKpUiaqYkTFA/Z
         qJ1MzgnlHuoLJtvpRY7p7mhcemHeSe1GtK4ST+lqP9WStxsWYjSxGM+1dyVk6GsOqnOm
         +hBg==
X-Gm-Message-State: APjAAAWN3Zu7748Bos/utIyYUHgeGCK/kUDdu6WBG+a14A6HHRRxZ64S
        rsvXO9x/eQW18riYboYnUV0=
X-Google-Smtp-Source: APXvYqyyRHiEiIeOzA955X24yb9WTJaEERPjsyBhyZBwHJW3JAgAlFmj5Tl8MWVnl1sIf+tGE16hPg==
X-Received: by 2002:ad4:4e04:: with SMTP id dl4mr1114972qvb.150.1581668446967;
        Fri, 14 Feb 2020 00:20:46 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o187sm2734969qkf.26.2020.02.14.00.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 00:20:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 91ECE22189;
        Fri, 14 Feb 2020 03:20:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 03:20:45 -0500
X-ME-Sender: <xms:XFhGXopM7xzY9_WjSj6KEtEKJJRbhbTZR4rR_-Dkpy8QINNIQ5wOJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:XFhGXl6cvqOuDDGfAy5SCcLW7UtvADc4Ohgt92kzXYAFn05heS4AVA>
    <xmx:XFhGXh6HVHnuKbLv_kSh1GU8c-9TABa-OcBFNRQHNZ-spfArXBwCzA>
    <xmx:XFhGXslbZtfHDAxkAxu7qMWAePy9P5QY4bI7vztniPNcL89zps0keQ>
    <xmx:XVhGXvfkn56nxnl7RCxDiePc2BVuvO1SW_kF9SCMKeteQ9ryovBOtOy3o1Q>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 758213280067;
        Fri, 14 Feb 2020 03:20:44 -0500 (EST)
Date:   Fri, 14 Feb 2020 16:20:42 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Message-ID: <20200214082042.GB20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-4-boqun.feng@gmail.com>
 <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200214081826.GB17708@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214081826.GB17708@andrea>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 09:18:26AM +0100, Andrea Parri wrote:
> > > @@ -0,0 +1,29 @@
> > > +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> > > + * "strong-acquire": both the read and write part of the RMW is ordered before
> > > + * the subsequential memory accesses.
> > > + *)
> > > +
> > > +{
> > > +}
> > > +
> > > +P0(int *x, atomic_t *y)
> > > +{
> > > +	r0 = READ_ONCE(*x);
> > > +	smp_rmb();
> > > +	r1 = atomic_read(y);
> 
> IIRC, klitmus7 needs a declaration for these local variables, say
> (trying to keep herd7 happy):
> 

Got it. I will add the declaration in the next version. It's just that
herd doesn't need those so I haven't put them in this version ;-)

Thanks!

Regards,
Boqun

> P0(int *x, atomic_t *y)
> {
> 	int r0;
> 	int r1;
> 
> 	r0 = READ_ONCE(*x);
> 	smp_rmb();
> 	r1 = atomic_read(y);
> }
> 
> Thanks,
>   Andrea
