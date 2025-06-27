Return-Path: <linux-arch+bounces-12484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B21AEB94D
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7DC561ED3
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6E2DCC1A;
	Fri, 27 Jun 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJUytmS8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D772DD5F7;
	Fri, 27 Jun 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032420; cv=none; b=F2cI94wYxYszbKKT414IU1EpDZnjvkg6L+xp1u/7GCDVpW/yyNd3lIkx5O1KT+iNRwbTgO1S4N5WTHtPBuhuemRrX3aSLDHGo0Jpl3snrWLawcxOGGdvu2C/7tprojl8pdniH0fYufBXU7n25wj6Y6gZ67Ntidwv6ZLe9McXEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032420; c=relaxed/simple;
	bh=8tB5Tt+SddCBUKuuMhYJNECWuks405uefcI+g9Gv/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXrgwyg7BiWv1ipdCfu6uBWJ6fLbcpyrPSnG5b0W0Ir/+JxZOZJXNigsgV4kBgKXGOhDDPYIjpiQeZ4mcJfw8ehp5RkD57mooMMw5d7MNq4sMqSp5PLmF2+sP7tSllyZjgpBQr5KKNiJS47kgmBmNmw03WZ8F4iTZfIqTPof7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJUytmS8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a76ea97cefso24112831cf.2;
        Fri, 27 Jun 2025 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751032417; x=1751637217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uouMimeWn3ZYuKBw0rjlLhYpQtgnBhD5z9a/AZnhU0Q=;
        b=hJUytmS8RG5HU4jLr+V9Y/FBIpppIEGYfL90K0eKuFTlbqIYpCCoI6UqHPF7YuL0OF
         X/VzxBTgq6JHhOB4QYOXPm3aXD2fqvca9Ku14ulpPnf3z+PlJt4JghGUPA3F5ETzbrPU
         C4UUQvrF8rN2nKtX9LBC4TNu7bf2vANy1ImLjGDRiw1Owc5OsZeWle+KZkY7csUfu9Xy
         yWMLEplnT3JwpaVpPf5vjpVAt0hOY7xMWgUVv9/LF3qyPGI5vY7d5UbUtjuekw5M7RW0
         Q6hNqG4ew176eMZj47jVx32Egmvb8N70bj/Fla6/LMzS2UeA3VpfBC5gPfHaRglYMv09
         4m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751032417; x=1751637217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uouMimeWn3ZYuKBw0rjlLhYpQtgnBhD5z9a/AZnhU0Q=;
        b=NBT75TMsJo6eSiWD+MqXMS9H5dfUXG+UElM6upcuSGvYvf5y6U1mqINy0YjpMGU148
         Lrf8e+KhJ+hO7j33aN29xXs55SvCiQZzwFQI6Q/KC+cW7PPcqMyWXH9JMHqpm3Jfa069
         6ACO+dKDibx8GEIfp1y/0ls/EBt/ei/JHurSSgReobPSBRh9XIYzFJvtDde/00nmRdiI
         3oivkIfACqV930HoH9yu0USjULnPL4ghZcelmgHaEclDKzBGrUxKvMzMR3QOx5kY/lc8
         7lx6lw0Gz+29+1s4XvpbJ2Xc6ZCWmxu7QJuuXe6KGiXEsqbDmyUf17Khpr8KMwreaNa7
         MWhg==
X-Forwarded-Encrypted: i=1; AJvYcCU8UIMBL7ziryTqXcYH6IkPmq5iKWyeu7hFEevThJAmKpcEHgUVBM+nvy/Tg4qpkIvVhsv9T+1qiXPU@vger.kernel.org, AJvYcCXbzCvjRtpoMcPPSID3M0WaBVfqNwqcSNC/FiyY407z1RpZdQFCkNL1T889P6cT6Ft/UMoyAEgWEiudhBOuh4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxV6eJW7+GIMT9ScgIamr7eLWsadHXpVSWQw4gPOugmjv7mmj
	f7+z03DP3o1EqJj8Q9CVQPWjXKxNV723aW0hYf+vAMBmypsvdcn40PBR
X-Gm-Gg: ASbGncv/12Kr6ev8qssMVTA4o477utbWqT2AaUokAd7yvLmGf291UALhwrvMD8dxWYW
	zoKGFADJmBoDO/4ccSpep7fksgWNRVDDTvkWomse1Hq/3RBMXv/I6+vKiIkunV6/Z4sG0JBQVc0
	+p14qZqD5VL97oHfhcJi2lb3iYK9dLiUIDHL63j4cpGp/c3b+9zl8Mjmmmgu6y5q1QlQQ9spPGS
	t7WknSU+GCEssViub4qW4CoG3PG5Ug91Qs6aoRxe3KKdN7J3nlQJXVCNabdLOjmjf/ZiRE4vKEv
	ZXDhoyF2TyGwlRBw+X6uzGMoQ0Nm8NIYQPiB/QCKYTwRfwPTBqL1YCvTWUeVVUPRAmVG5vK2cjM
	EHOEqwiKJohLpmd63ualwJdglHvN1e7uV0wizRocQUehlGSFWk0t1
X-Google-Smtp-Source: AGHT+IFB5RPz7AavPYxnvUdQV0GTPoXzInj8vBq+TaGKAoDyNUISq/13GFMrDrtRPxv8yQgsf/UAoA==
X-Received: by 2002:a05:622a:1b8f:b0:4a7:f683:9749 with SMTP id d75a77b69052e-4a7fcacff9emr61351051cf.30.1751032416813;
        Fri, 27 Jun 2025 06:53:36 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc1061d3sm12664251cf.15.2025.06.27.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 06:53:36 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 52B84F40066;
	Fri, 27 Jun 2025 09:53:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 27 Jun 2025 09:53:35 -0400
X-ME-Sender: <xms:X6JeaHTxoa3I_5haNUJuCuDhdqS0gqX5rNd4xGZpITPIHCtjcBRtKA>
    <xme:X6JeaIwiyONgnklVtgQedSe3iBmF3fqDjqOueL8G0BFIab4uYk3T4maCJfEIouMNO
    C4oZEolDkepnmhjcg>
X-ME-Received: <xmr:X6JeaM3VsANY7ZPYU55fdYt_hWX_c9bQf_ONd9Vvh3yi_1RzOxZXPhC9Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpedugeetueejudegieffvdevffektefgvdfhgfekvdduffeuieduueekkeetleevleen
    ucffohhmrghinheprhgvrgguhidrshhtohhrvgdprhgvrgguhidrtghomhhprghrvgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfoh
    hrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhm
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:X6JeaHCiQJZ8SxvfLpk-O1IjpqLksqfNI4FqnICIg2jQe0D_yPtFfg>
    <xmx:X6JeaAiO-SZ71Rf7y5-ZPjT8akWg9wCztqk7_qxN6iFSFQ3Xr6BIBA>
    <xmx:X6JeaLpFIy4Lsu2G4UjMEKuCBp1oauPq7GdJzkD-czkOtbtQ2hJNMw>
    <xmx:X6JeaLhdv1stuY4KcDbGvhX3Hqy50z03qVyk_fGc5PK94i7qTXjtcA>
    <xmx:X6JeaDQE__zOJyV2HLRV7dRbmDuQyG6DOvQLyoicHMV1M2zUdFvrCMIu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 09:53:33 -0400 (EDT)
Date: Fri, 27 Jun 2025 06:53:32 -0700
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
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aF6iXB6wiHcpAKIU@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>

On Fri, Jun 27, 2025 at 10:58:43AM +0200, Benno Lossin wrote:
> On Wed Jun 18, 2025 at 6:49 PM CEST, Boqun Feng wrote:
> > +impl<T: AllowAtomic> Atomic<T>
> > +where
> > +    T::Repr: AtomicHasXchgOps,
> > +{
> > +    /// Atomic exchange.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```rust
> > +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> > +    ///
> > +    /// let x = Atomic::new(42);
> > +    ///
> > +    /// assert_eq!(42, x.xchg(52, Acquire));
> > +    /// assert_eq!(52, x.load(Relaxed));
> > +    /// ```
> > +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> > +    #[inline(always)]
> > +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
> 
> Can we name this `exchange`?
> 

FYI, in Rust std, this operation is called `swap()`, what's the reason
of using a name that is neither the Rust convention nor Linux kernel
convention?

As for naming, the reason I choose xchg() and cmpxchg() is because they
are the name LKMM uses for a long time, to use another name, we have to
have a very good reason to do so and I don't see a good reason
that the other names are better, especially, in our memory model, we use
xchg() and cmpxchg() a lot, and they are different than Rust version
where you can specify orderings separately. Naming LKMM xchg()/cmpxchg()
would cause more confusion I believe.

Same answer for compare_exchange() vs cmpxchg().

> > +        let v = T::into_repr(v);
> > +        let a = self.as_ptr().cast::<T::Repr>();
> > +
> > +        // SAFETY:
> > +        // - For calling the atomic_xchg*() function:
> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> > +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> > +        //   - per the type invariants, the following atomic operation won't cause data races.
> > +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> > +        //   - atomic operations are used here.
> > +        let ret = unsafe {
> > +            match Ordering::TYPE {
> > +                OrderingType::Full => T::Repr::atomic_xchg(a, v),
> > +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
> > +                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
> > +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
> > +            }
> > +        };
> > +
> > +        T::from_repr(ret)
> > +    }
> > +
> > +    /// Atomic compare and exchange.
> > +    ///
> > +    /// Compare: The comparison is done via the byte level comparison between the atomic variables
> > +    /// with the `old` value.
> > +    ///
> > +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
> > +    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
> > +    /// failed cmpxchg should be treated as a relaxed read.
> 
> This is a bit confusing to me. The operation has a store and a load
> operation and both can have different orderings (at least in Rust
> userland) depending on the success/failure of the operation. In
> userland, I can supply `AcqRel` and `Acquire` to ensure that I always
> have Acquire semantics on any read and `Release` semantics on any write
> (which I would think is a common case). How do I do this using your API?
> 

Usually in kernel that means in a failure case you need to use a barrier
afterwards, for example:

	if (old != cmpxchg(v, old, new)) {
		smp_mb();
		// ^ following memory operations are ordered against.
	}

> Don't I need `Acquire` semantics on the read in order for
> `compare_exchange` to give me the correct behavior in this example:
> 
>     pub struct Foo {
>         data: Atomic<u64>,
>         new: Atomic<bool>,
>         ready: Atomic<bool>,
>     }
> 
>     impl Foo {
>         pub fn new() -> Self {
>             Self {
>                 data: Atomic::new(0),
>                 new: Atomic::new(false),
>                 ready: Atomic::new(false),
>             }
>         }
> 
>         pub fn get(&self) -> Option<u64> {
>             if self.new.compare_exchange(true, false, Release).is_ok() {

You should use `Full` if you want AcqRel-like behavior when succeed.

>                 let val = self.data.load(Acquire);
>                 self.ready.store(false, Release);
>                 Some(val)
>             } else {
>                 None
>             }
>         }
> 
>         pub fn set(&self, val: u64) -> Result<(), u64> {
>             if self.ready.compare_exchange(false, true, Release).is_ok() {

Same.

Regards,
Boqun

>                 self.data.store(val, Release);
>                 self.new.store(true, Release);
>             } else {
>                 Err(val)
>             }
>         }
>     }
> 
> IIUC, you need `Acquire` ordering on both `compare_exchange` operations'
> reads for this to work, right? Because if they are relaxed, this could
> happen:
> 
>                     Thread 0                    |                    Thread 1
> ------------------------------------------------|------------------------------------------------
>  get() {                                        | set(42) {
>                                                 |   if ready.cmpxchg(false, true, Rel).is_ok() {
>                                                 |     data.store(42, Rel)
>                                                 |     new.store(true, Rel)
>    if new.cmpxchg(true, false, Rel).is_ok() {   |
>      let val = self.data.load(Acq); // reads 0  |
>      ready.store(false, Rel);                   |
>      Some(val)                                  |
>    }                                            |   }
>  }                                              | }
>  
> So essentially, the `data.store` operation is not synchronized, because
> the read on `new` is not `Acquire`.
> 
[...]

