Return-Path: <linux-arch+bounces-13173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CDB28F56
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97E1A23395
	for <lists+linux-arch@lfdr.de>; Sat, 16 Aug 2025 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23490291C16;
	Sat, 16 Aug 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0f1g7yA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F128D85D;
	Sat, 16 Aug 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360627; cv=none; b=LOSI3ZbQUoo8m6B4z4M3gEy2j9xEdL6DBlCXtRIgvJQS1Iw3knC7fL2H3jA4+j36fOMiG0PlYCXQ6uFKZW6Fapye1yWbUJDF78m1SAmWvy73uwdMrAQzx3qil1FzVaithUkhN5YAZoq4iAtz61miNj3G/UjOk3b9PviTTw4PxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360627; c=relaxed/simple;
	bh=IUaTF+NFDqwsFAta5s9Kk+XUn0JlCEzmJ8Sm0Gdx7lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBwvdzHm6X/tI3xcFNfndo7rAltMP4nFSGAGi6cRBr1V9QRd0L+NWfB25a1PlHyeOEX6Hlh+vNOkwxJnreoOLmwzSawfJ9wysGPex8w/zCxCb6qaUKIKNdcEiVpxUFlZjMeF8DFdWzZpc5z7nsJlsIS0VIhrvdJ6ejAD5KGoap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0f1g7yA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e86faa158fso345710885a.1;
        Sat, 16 Aug 2025 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755360624; x=1755965424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg/mieQTPz9vtPLm51BfuUqCjgPFftVnx3T2UKgvrvA=;
        b=B0f1g7yAAFj9Fzdw82zlUbDrNOMBCXYyZYTyaQ1A+1abOKluDv+Ru3jA6Q8bqoXXEK
         SdwTHGm+K1RBLmOd7X8TkbwyTkAAT6QKN1b2aLQgbEXWvsQoRgbxSb2v6AjX/UWugBGS
         yKYsRniFfc1i6E4RrFCKBwwmQrZ/xGW2KEkIiqvY4BrYSlVyi6VTOWLUtBDk7Lm3zL53
         xp98wzX4nQP7xPFSfr+7C2hKo6g+pLFRDkuDjr6vHm0W5TiogxfyF1H/eQv3d993PJKZ
         NrfYKipFi61FMNWLxtTZTiURM8E6mfMe8T2cuKLi3/V012xYE6s0nyfkgZZhHqYig7QS
         9l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755360624; x=1755965424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg/mieQTPz9vtPLm51BfuUqCjgPFftVnx3T2UKgvrvA=;
        b=Bl0GmFhbM3ikowFWKOnka69Kf/f/PMiT8CI8lp5JFFOa7aGLEL4k74EvpVG4mA4aKA
         UdqY6R7Z4z67ctlYlCVlgwdlwGmW6gq8u3mpjuRRfq21GH+07BLkxSlY213TWzZgPQRT
         jElN7IaM3c5EKThGNGfPQJTIkA5v59nAo1X63PDDFDsoDZiclizuAhKFr2ErzLhVW/IJ
         IVIu//VJTwFiCSaxCpwCqSpjdmxog5h5moDIrajb0YDF5qvKCgK6shz3yQGhC03Sm+Hx
         BKbHeg64IQdzK2F2f9Im05dHiZjEgW+3r9G3LewalrSc2IJGPrzAFjuCzHiiz8umcxH8
         EwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKgAbp2CBeGw2TVNaNkNNUxr5yrr1rQ4WgVnO8S41gZ72dg0Y3G3rduYM6y4JpV9s2nys+iYeo6HGlB+titMw=@vger.kernel.org, AJvYcCX4HcXCsHLyac51qDS42QfqFs68Yw+j/Z7SwZfy5YAFzHIR1N0Kxgq5vuOTNBowfpyCWuGfKTtAvIlV@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhTgAdN3ME1hV+lMSbxAjSHwHNRfbbOvrsgNJOVo2wwkYtcKs
	OyVDA0fExJ4EE03CEPazsZREY+9rEaFn6108/6jnMAkS/5ywD+qg8lHM
X-Gm-Gg: ASbGnctvSnUcORdCACMFtKG1RcLlh93vh8pt0Bss4KIFKx1BNvXvonbfhql0pn82Kpb
	R6ICEgCMgjw3p3TAzXWBWbZPpRxIw5GbjofyLpI0pAKqihnP7VAdPVkMAtiofL19SlawY09rkgt
	tvs8Ymo9tzgDK5p2wH3cREEKTO8pi0h23fDSX9q3XXi6LrQaAfNIa4EUWfQmZ9pSl9KtfMm4dWO
	rUyFw6Qd9QTng4indZxDYM/mOaxFy88YfX/FVv782cZajsilUlgfwoskzDLL+mYHErJXXvyO+Wg
	NHn48fVYnFayCxRZ0l3m6ALpFzSMnngfrbixNDxphdP2H8zni2+Yy9zKQUfaQZBzU5XzdHmyzBF
	9Kz2MKLjeHqw7tE1ExiiF+rb1dQ2BbyCJ4s6X6pZ0sEAt0kKKHPgSQXhUBDeZhBb6NPXmwDpyoS
	kFwp6S0+g+fR477mdGeywnci/nOhY9VlRiqhEFhyUeFHaj
X-Google-Smtp-Source: AGHT+IFYZv5YRaAFBtbmtnhCh7ln4coorVbby1YEzxczCjIN9KAFBwrnQ0BFqfrw0CPvusbFLicOpA==
X-Received: by 2002:a05:620a:471e:b0:7e0:e2d7:e03 with SMTP id af79cd13be357-7e87db77a36mr791075485a.7.1755360624081;
        Sat, 16 Aug 2025 09:10:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1e15besm285785885a.72.2025.08.16.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:10:23 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id AED63F40066;
	Sat, 16 Aug 2025 12:10:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 16 Aug 2025 12:10:22 -0400
X-ME-Sender: <xms:bq2gaNHxhAgGhftN_kkXh6fkv-wcrpIEMLkBwD0RsnK249D7qN4lGw>
    <xme:bq2gaD0lWoZM1mgofjfuny5OIzW1CVDTuJC1C0ipALvkHHHZG8aYpWEDlFeSlbuiJ
    _0C457XnqjQXjlDEw>
X-ME-Received: <xmr:bq2gaDsIIrArzNPtDRIK8Fvka_GneNsyXW0RB408jXnPO5h4ZXvCGngaB4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekjefhvddvheeftdevjeffudevhffgteeigeffgeegveefgfejhedvvdekueei
    gfenucffohhmrghinhepohhpvghrrghtihhonhhsrdhsrghfvghthienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgs
    pghrtghpthhtohepvdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhssh
    hinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhs
    rdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:bq2gaCktOPYQOVH-9-aacjtfeVjpYoVpCH7CxcLqVh-daB-WdOqEZQ>
    <xmx:bq2gaBVoQTZXZLgY7od7Bu1-cfF8MbFlg2afyFBvs-7-gxynTEMEtw>
    <xmx:bq2gaGtFXJDY63JlhanCXkANLGTfFZejV_i6JaQRzy4qkXxPHmtWnQ>
    <xmx:bq2gaEq6_HWq5SxvoWdSbzvtCuIfbhvWJOR130adu-LiLBW1glexnA>
    <xmx:bq2gaL6u3zFp2kb9yWPCPqqExMGSsMkWLCw1A-l0_vaoGT0vR_LVvW6y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 12:10:22 -0400 (EDT)
Date: Sat, 16 Aug 2025 09:10:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v8 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aKCtbSDuJNrtdLNp@tardis-2.local>
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-7-boqun.feng@gmail.com>
 <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org>

On Tue, Aug 12, 2025 at 10:04:12AM +0200, Benno Lossin wrote:
> On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
> > One important set of atomic operations is the arithmetic operations,
> > i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> > make senses for all the types that `AtomicType` to have arithmetic
> > operations, for example a `Foo(u32)` may not have a reasonable add() or
> > sub(), plus subword types (`u8` and `u16`) currently don't have
> > atomic arithmetic operations even on C side and might not have them in
> > the future in Rust (because they are usually suboptimal on a few
> > architecures). Therefore the plan is to add a few subtraits of
> > `AtomicType` describing which types have and can do atomic arithemtic
> > operations.
> >
> > One trait `AtomicAdd` is added, and only add() and fetch_add() are
> > added. The rest will be added in the future.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> 

Thank you!

> > ---
> >  rust/kernel/sync/atomic.rs           | 93 +++++++++++++++++++++++++++-
> >  rust/kernel/sync/atomic/predefine.rs | 14 +++++
> >  2 files changed, 105 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > index 793134aeaac1..e3a30b6aaee4 100644
> > --- a/rust/kernel/sync/atomic.rs
> > +++ b/rust/kernel/sync/atomic.rs
> > @@ -16,7 +16,6 @@
> >  //!
> >  //! [`LKMM`]: srctree/tools/memory-model/
> >  
> > -#[allow(dead_code, unreachable_pub)]
> >  mod internal;
> >  pub mod ordering;
> >  mod predefine;
> > @@ -25,7 +24,7 @@
> >  pub use ordering::{Acquire, Full, Relaxed, Release};
> >  
> >  use crate::build_error;
> > -use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
> > +use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
> >  use ordering::OrderingType;
> >  
> >  /// A memory location which can be safely modified from multiple execution contexts.
> > @@ -115,6 +114,18 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
> >      type Repr: AtomicImpl;
> >  }
> >  
> > +/// Types that support atomic add operations.
> > +///
> > +/// # Safety
> > +///
> > +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> 
> Can you add a normal comment TODO here:
> 
>     // TODO: properly define `wrapping_add` in this context.

Yeah, this sounds good to me. How do you propose we arrange the normal
comment with the doc comment, somthing like:

    // TODO: properly define `wrapping_add` in this context.
    
    /// Types that support atomic add operations.
    ///
    /// # Safety
    ///
    /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
    ...
    pub unsafe trait AtomicAdd<...> {
        ...
    }

Regards,
Boqun

> 
> ---
> Cheers,
> Benno
> 
> > +/// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
> > +/// yield a value with a bit pattern also valid for `Self`.
> > +pub unsafe trait AtomicAdd<Rhs = Self>: AtomicType {
> > +    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
> > +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> > +}
> > +
> 

