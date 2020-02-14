Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230CE15D5E7
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgBNKkL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 05:40:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44588 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgBNKkL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 05:40:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so8675934qkb.11;
        Fri, 14 Feb 2020 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJhxXNnYsamX2r0UP9OC1Sb852WI9H8dlHsBa9UO8N4=;
        b=jfsUBx959uUXPV83mnToKcz9chCKRabV1wlTciuX+ORRi1fNIgOCb7XwDbRqxrNY22
         JyUA0nOjc6I+SetGTnbQgRRSK6zyvKYelah6i5rSbUV+CpImtkJlHUpzLh+3Bn+ZWqDr
         eot3IhkJs1cCj91etVb7jT7T1gBReqAhDTpq5c/Kw/C0uTsfPj/k3Tl2l6NlyjW+URLD
         GF5TBv6/o9+IOo8zySC/09akFj9GbaCfaV7Pk2GECFLCcZ4tXgJyJ+kqWRFAQpn8QO3J
         vYpVThw3Ddirag9/PboUW00jDOaLKyUcrmt9qm0r2LY2Wu/cctlRB9FqXSnC0huU2Wbk
         TbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJhxXNnYsamX2r0UP9OC1Sb852WI9H8dlHsBa9UO8N4=;
        b=D56UU+hYjJFw/nN9AHspWxaOyK3hkqB4/unhN0zkPqQheWqkx9X1nJssXFVnfaJ4P6
         BjPQmkDpl0vrE1L+t5NZMuiuqAMpiKsER7qsuwuLsHcw5krpT781RL3yP3u11asShAMQ
         Jb4c1flRTAk8CmzX0RI/2/+W9hoXsl2TEssPr8yJAC1Eb0xUDj6LFbZ2wGFY6JioZwqM
         5vHN9YKYCimffe03Mk+ZDuKq7NYX5c+WFMqmRzqRXfJSkBLsPM0xt4y7mBfypW1qkVXW
         yLdi5pbIi47r0AGtKl12rPVbDg8Xp1SzqkNCpzC0zVjDfxQ8//I5xxG0wqNIxpLdOwjt
         19fw==
X-Gm-Message-State: APjAAAUzm5Xxv0OT6tmLXsKg3FNhABBliYIt8k758QEXALCrH8DVxgMK
        sVHba36nGLZ0+s1oevcbSMX01CzNH0s=
X-Google-Smtp-Source: APXvYqzeyu9koQGK/hj7hznU2WzZpQhheTCRsLATTOntd5zPKGvkLIiQfoQzy/Y/+ikg7BnT3xLzBg==
X-Received: by 2002:a05:620a:579:: with SMTP id p25mr1717025qkp.291.1581676809790;
        Fri, 14 Feb 2020 02:40:09 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c192sm2923711qkg.125.2020.02.14.02.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 02:40:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1C90B2220E;
        Fri, 14 Feb 2020 05:40:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 05:40:08 -0500
X-ME-Sender: <xms:BXlGXqz5TYRTNfMnhjrZJPms419hr9Ic4Bx7RW4ieO4tmeVaNBUeSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:BXlGXoja4bT6jL_XNplMbaG209nOuilJcFNt4uiMfCdF-szdfWqKNA>
    <xmx:BXlGXukXJD8-4xZ5FVYVTZipMaB4_ZfQ47xT7k0RTxf2jMMWqDZgOw>
    <xmx:BXlGXmjyVPc5NSQCoFDxMUf2ytezFGTtPiQeG2Y9b5Zlo4pMWV7L7g>
    <xmx:CHlGXiYoyTvuLPMcMYYEzIYneMmz0v13_M3F3vtZpN-q7o5JgAtNG046JxU>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F083328005A;
        Fri, 14 Feb 2020 05:40:04 -0500 (EST)
Date:   Fri, 14 Feb 2020 18:40:03 +0800
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
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200214104003.GC20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
 <20200214081213.GA17708@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214081213.GA17708@andrea>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 09:12:13AM +0100, Andrea Parri wrote:
> > @@ -0,0 +1,24 @@
> > +C Atomic-set-observable-to-RMW
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * Test of the result of atomic_set() must be observable to atomic RMWs.
> > + *)
> > +
> > +{
> > +	atomic_t v = ATOMIC_INIT(1);
> > +}
> > +
> > +P0(atomic_t *v)
> > +{
> > +	(void)atomic_add_unless(v,1,0);
> 
> We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
> entry (6b) in tools/memory-model/README; the discussion was here:
> 
>   https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com
> 

And in an email replying to that email, you just tried and seemed
atomic_add_unless() works ;-)

> but unfortunately I can't remember other details at the moment: maybe
> it is just a matter of or the proper time to update that section.
> 

I spend a few time looking into the changes in herd, the dependency
problem seems to be as follow:

For atomic_add_unless(ptr, a, u), the return value (true or false)
depends on both *ptr and u, this is different than other atomic RMW,
whose return value only depends on *ptr. Considering the following
litmus test:

	C atomic_add_unless-dependency

	{
		int y = 1;
	}

	P0(int *x, int *y, int *z)
	{
		int r0;
		int r1;
		int r2;

		r0 = READ_ONCE(*x);
		if (atomic_add_unless(y, 2, r0))
			WRITE_ONCE(*z, 42);
		else
			WRITE_ONCE(*z, 1);
	}

	P1(int *x, int *y, int *z)
	{
		int r0;

		r0 = smp_load_acquire(z);

		WRITE_ONCE(*x, 1);
	}

	exists
	(1:r0 = 1 /\ 0:r0 = 1)

, the exist-clause will never trigger, however if we replace
"atomic_add_unless(y, 2, r0)" with "atomic_add_unless(y, 2, 1)", the
write on *z and the read from *x on CPU 0 are not ordered, so we could
observe the exist-clause triggered.

I just tried with the latest herd, and herd can work out this
dependency. So I think we are good now and can change the limitation
section in the document. But I will wait for Luc's input for this. Luc,
did I get this correct? Is there any other limitation on
atomic_add_unless() now?

Regards,
Boqun

> Thanks,
>   Andrea
