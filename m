Return-Path: <linux-arch+bounces-12322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF46AD40DC
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F5E168A09
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0723C501;
	Tue, 10 Jun 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi2A7RU/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF52441A0;
	Tue, 10 Jun 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576661; cv=none; b=WobC6vks8MD4n/gHHAlMSQrEC4JRU+pvAH6z6U45Q4t/HGPSAF8kwlCLsV30G0BYdN4dAwwO5aDzB/npsd4w58IwpBPsymDDIMg5Tp5Y0/9hPskSCmEtrUp1tvxCkT5vWUvDEEXeaO/vVWsw6Z4CgUelGXD4zGYjkCY0LYAmpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576661; c=relaxed/simple;
	bh=0NiHXbG4vYgb34rXAoH4moQ99hl+z8icp5lnTGEVaII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUaYWNjUzfEXyEJDK3VTTcCPOUf5nIvFtaNQ1Qx+ceSKollu0x6ZWNaB7/oO9Mu1hoeBby1i76mhN7vh/X2vcuTdJnLsGDWPkfkJbUEq+AOWNIEXjCoAsCptxc/nrGsadoWusbeotYiYIFhz8dpVDMqE1+YywVuWOGtBDCoe0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi2A7RU/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so21260386d6.2;
        Tue, 10 Jun 2025 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576658; x=1750181458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJdykh2EXzW6mCPNCtZcUijMyr6QYBWb9z7jw/427yo=;
        b=mi2A7RU//ltoZb0UTWAbabpaCRI9D6B7O5uI9iPX3Bpcah1tW/HQszR0Ir9eDbYeQd
         GLNU48tcjavQzZI1L3r5bqBVamu0SHmCfaGPgMpCNn3oMTZ1Y9HC+p5BwhzalJCs3uw1
         GkeKIkM90ml3s7Ce8nwkiPUBTAlV4fka9d8WFcKrET9V2OtdeQt9mkCfW17vguduNSzz
         BUCxVwlm8go+qGa4/qhahCjzNmrhkxNO79MxD6JaaeRmImanZcn/GRLCVxp11bXrHlxQ
         RJGl8mwcMGFWFQzVvAwK3UACL+OmvPw6Gebsh6bYLzmhExHLC6ba0g5pFpgHiCvpfQCm
         v3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576658; x=1750181458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJdykh2EXzW6mCPNCtZcUijMyr6QYBWb9z7jw/427yo=;
        b=h3nY0gY34oN+iW5lScvoR6uD9w0JO3q9oH8bQGNtyJtxn6ogHRnmemCqF7iIZj+4ce
         SlZwY2rzGbY4chhfWf+vvJQ3/h4qlXNOmpxlxN7iu0sF25Dzz6CVv3wbBho+YAfepgiW
         vFLfE6Sg/rRfbcWIpxumfEi6Ii0sx3RNDlfItuyBw+EWnwIAu2Jeu0ZTxL+EzSyNISwF
         ULKxmXIZK8wy6g6EW8yzynXdJSzaKfVde5nZrCcCD+eieTkDQW8T2UQAO+JIiS4zsU1s
         NZik+BtkxVAqQ0kIPRFEQLs5sCMyi/EZEUriQTVGlgy01q1mD2+ph8fcyoGAWRLjDrfe
         bkeA==
X-Forwarded-Encrypted: i=1; AJvYcCUC0LtKGwwxoYPx7ZbaGfExw8TY1dOVWiNzKzQYOgwgisgQ2F8KRjWXV1sC8ykm4NbcsBeIn3EjQy9B@vger.kernel.org, AJvYcCWgKPei/o/QjcSWYPTCYfwzXYA5Tj5GxIHUFgGa8ByKr3BccR0FJxq2XpfnXz7qE6aa88tJTZk/MyyAVfyFH1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWsl/Ie8loY9mNSp0LzjXOUhSNSan4PETW282/LQHne7oKXFz
	bGXpeQIkhnC9+oghw1KKg9HfdaZJPvUFSJH/rZV+fLpdVEd7jglREZlv
X-Gm-Gg: ASbGncsp14vs/EEjhbTd934Io/A0DuPch6Mu2fc3cw45Xp741bs5sqCT+ZPgsDeZV4l
	qZL448te64M1LMuk7SagadOXp8Qj56p0J5HfIfYgQ2diGJDpBvf0pq8qhnFrv18EOJGIePplWrx
	E3mFN0B50udtmHhiCS/mvM1Z1QCHRKx7X0BhgSfGO+WybK64KWZJ8Y9fT+aaZ+2fQ3lrrPl7LDu
	VWiYmaZ21Lg0/4YI2/hDSnbe2WRfF38yg18ww+Rz6LpigQLxZ2425hPHUV6xirlvzm3O2MLJaeW
	CY7dkf/1JIhQMqRjd6DpnSoI6Bngj4wPyM+iToTtKxJVIZ0sedpbGTz6qu7oPo5zH42pgDiZxRI
	yTZtnbDsfg6W0MuqjGrY3+fqUEYiVM8MqEoix3Q4ekfcsTVbzIHWGTy88Xn3w7AA=
X-Google-Smtp-Source: AGHT+IGeesgQ5STX3VBjTboY2m69/yDnUInxC81+kPGTrT4lMFU1EFCkk1W39S/XN0uHx1OdE8hWAw==
X-Received: by 2002:a05:6214:2249:b0:6fa:c81a:6230 with SMTP id 6a1803df08f44-6fb2c32dd04mr3967336d6.12.1749576658310;
        Tue, 10 Jun 2025 10:30:58 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab9595sm69151066d6.6.2025.06.10.10.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:30:57 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0D9BA1200068;
	Tue, 10 Jun 2025 13:30:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 13:30:57 -0400
X-ME-Sender: <xms:0GtIaHB6Vr7mjToj7PrcMCK9OiM_1Orfw8q-3HLYPCJppAWQvEhrhA>
    <xme:0GtIaNjdCARYN74EEBH3aUJGajYLai2_KWYCIcJVMduy-oYIM0nSzphtAShiHEA6e
    xdFlE142PBjE2FBiw>
X-ME-Received: <xmr:0GtIaCndlnnuX-PbRx-KjKBl1o8XzKOhe_2_EIVUAX5IS8yKgWAM3npYRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgt
    phhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgr
    hihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhord
    hnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0GtIaJxsngQY-Wo97-J4weFuu2li-Rk-PhtWI_5liMIwmczLZDkSJA>
    <xmx:0GtIaMQqHPFytiFA8z4PiryLpxM-KYy4OX6mIY2v9f0Vf2cdGJI6zA>
    <xmx:0GtIaMbpAN37rvx4sbuv16QVHY1ssjJHPXKiYc_y-cg3THQNk6IK7A>
    <xmx:0GtIaNT-kJQOzSft0Y9H44tfX1zDeiyWZDc4cFfuk7jS08PxlrJ4aw>
    <xmx:0WtIaCDFz1L5yRdSwEpquOmtDJ6e5-zuYpGGeQD5ciY0a3PRhy-KAYHH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 13:30:56 -0400 (EDT)
Date: Tue, 10 Jun 2025 10:30:55 -0700
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aEhrzxltkdnub_bR@tardis.local>
References: <20250609224615.27061-1-boqun.feng@gmail.com>
 <20250609224615.27061-4-boqun.feng@gmail.com>
 <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org>

On Tue, Jun 10, 2025 at 11:07:16AM +0200, Benno Lossin wrote:
> On Tue Jun 10, 2025 at 12:46 AM CEST, Boqun Feng wrote:
> > Preparation for atomic primitives. Instead of a suffix like _acquire, a
> > method parameter along with the corresponding generic parameter will be
> > used to specify the ordering of an atomic operations. For example,
> > atomic load() can be defined as:
> >
> > 	impl<T: ...> Atomic<T> {
> > 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> > 	}
> >
> > and acquire users would do:
> >
> > 	let r = x.load(Acquire);
> >
> > relaxed users:
> >
> > 	let r = x.load(Relaxed);
> >
> > doing the following:
> >
> > 	let r = x.load(Release);
> >
> > will cause a compiler error.
> >
> > Compared to suffixes, it's easier to tell what ordering variants an
> > operation has, and it also make it easier to unify the implementation of
> > all ordering variants in one method via generic. The `IS_RELAXED` and
> > `ORDER` associate consts are for generic function to pick up the
> > particular implementation specified by an ordering annotation.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Looks good, I got a few comments on the details below.
> 

Thanks for taking a look!

> > ---
> >  rust/kernel/sync/atomic.rs          |  3 +
> >  rust/kernel/sync/atomic/ordering.rs | 94 +++++++++++++++++++++++++++++
> >  2 files changed, 97 insertions(+)
> >  create mode 100644 rust/kernel/sync/atomic/ordering.rs
> >
> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > index 65e41dba97b7..9fe5d81fc2a9 100644
> > --- a/rust/kernel/sync/atomic.rs
> > +++ b/rust/kernel/sync/atomic.rs
> > @@ -17,3 +17,6 @@
> >  //! [`LKMM`]: srctree/tools/memory-mode/
> >  
> >  pub mod ops;
> > +pub mod ordering;
> > +
> > +pub use ordering::{Acquire, Full, Relaxed, Release};
> > diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
> > new file mode 100644
> > index 000000000000..14cda8c5d1b1
> > --- /dev/null
> > +++ b/rust/kernel/sync/atomic/ordering.rs
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Memory orderings.
> > +//!
> > +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> > +//!
> > +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> > +//! - [`Full`] means "fully-ordered", that is:
> > +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> > +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> > +//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
> > +//!     accesses.
> > +//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
> 
> s/strong/strength/ ?
> 

Good catch.

> > +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
> > +//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
> > +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> > +//!
> > +//! [`LKMM`]: srctree/tools/memory-model/
> > +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
> > +
> > +/// The annotation type for relaxed memory ordering.
> > +pub struct Relaxed;
> > +
> > +/// The annotation type for acquire memory ordering.
> > +pub struct Acquire;
> > +
> > +/// The annotation type for release memory ordering.
> > +pub struct Release;
> > +
> > +/// The annotation type for fully-order memory ordering.
> > +pub struct Full;
> 
> Is this ordering only ever used in combination with itself? (Since you
> don't have a `FullOrAcquire` trait)
> 

Yes, `Full` is an ordering that is stronger than `Acquire`.

> > +
> > +/// The trait bound for operations that only support relaxed ordering.
> > +pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
> > +
> > +impl RelaxedOnly for Relaxed {}
> > +
> > +/// The trait bound for operations that only support acquire or relaxed ordering.
> > +pub trait AcquireOrRelaxed: All {
> > +    /// Describes whether an ordering is relaxed or not.
> > +    const IS_RELAXED: bool = false;
> > +}
> > +
> > +impl AcquireOrRelaxed for Acquire {}
> > +
> > +impl AcquireOrRelaxed for Relaxed {
> > +    const IS_RELAXED: bool = true;
> > +}
> > +
> > +/// The trait bound for operations that only support release or relaxed ordering.
> > +pub trait ReleaseOrRelaxed: All {
> > +    /// Describes whether an ordering is relaxed or not.
> > +    const IS_RELAXED: bool = false;
> > +}
> > +
> > +impl ReleaseOrRelaxed for Release {}
> > +
> > +impl ReleaseOrRelaxed for Relaxed {
> > +    const IS_RELAXED: bool = true;
> > +}
> > +
> > +/// Describes the exact memory ordering of an `impl` [`All`].
> > +pub enum OrderingDesc {
> 
> Why not name this `Ordering`?
> 

I was trying to avoid having an `Ordering` enum in a `ordering` mod.
Also I want to save the name "Ordering" for the generic type parameter
of an atomic operation, e.g.

    pub fn xchg<Ordering: ALL>(..)

this enum is more of an internal implementation detail, and users should
not use this enum directly, so I would like to avoid potential
confusion.

I have played a few sealed trait tricks on my end, but seems I cannot
achieve:

1) `OrderingDesc` is only accessible in the atomic mod.
2) `All` is only impl-able in the atomic mod, while it can be used as a
trait bound outside kernel crate.

Maybe there is a trick I'm missing?

> > +    /// Relaxed ordering.
> > +    Relaxed,
> > +    /// Acquire ordering.
> > +    Acquire,
> > +    /// Release ordering.
> > +    Release,
> > +    /// Fully-ordered.
> > +    Full,
> > +}
> > +
> > +/// The trait bound for annotating operations that should support all orderings.
> > +pub trait All {
> > +    /// Describes the exact memory ordering.
> > +    const ORDER: OrderingDesc;
> 
> And then here: `ORDERING`.

Make sense, thanks!

Regards,
Boqun

> 
> ---
> Cheers,
> Benno
> 
> > +}
> > +
> > +impl All for Relaxed {
> > +    const ORDER: OrderingDesc = OrderingDesc::Relaxed;
> > +}
> > +
> > +impl All for Acquire {
> > +    const ORDER: OrderingDesc = OrderingDesc::Acquire;
> > +}
> > +
> > +impl All for Release {
> > +    const ORDER: OrderingDesc = OrderingDesc::Release;
> > +}
> > +
> > +impl All for Full {
> > +    const ORDER: OrderingDesc = OrderingDesc::Full;
> > +}
> 

