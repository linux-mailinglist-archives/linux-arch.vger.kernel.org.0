Return-Path: <linux-arch+bounces-12741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3ACB0417E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E1E1888C2F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152C2561AF;
	Mon, 14 Jul 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP1zEGgU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DC255F5E;
	Mon, 14 Jul 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502922; cv=none; b=b8At/fVaI1eDP7otzTseGGv04BrMe9pPvBCJ14tAGLCHgHVMogi18D6eCDAdUUxlw6cItBTuYrV56L1upqGDcy3WNutshcnahmFZ4IHgDiy9aRqsb6kETXsA0lD/EJz4Zr8pdMmH4X0Azn0Av2sCLlzH1j34wQ4yYa17NxvWNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502922; c=relaxed/simple;
	bh=LXYASdYs274xH5+7ZkutHgLnsf8arGwEpqGBiT9kquk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djq5y3hcNdaqL3QlMdIuDibZ7oqdGIMm2c7JDl0rUDE4jOGFTxQsN9n2vlI9jDjPNYinOaIEBx8wbwvLzgmgq8ged3q1wGIaTHSr22/1N2Y9ipEPkppEtCkPS/t0nnvFEkdf3gbZWODPpGhlH646R6HbNUZ/RAFVpkdNEo0Wm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP1zEGgU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab60e97cf8so16608991cf.0;
        Mon, 14 Jul 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752502919; x=1753107719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ3UA4OiThrfJUfCAJnJai+VvM5KDOnLQOCMjU2eyNU=;
        b=IP1zEGgUzvGTRynisyIGuoK8q+xSDHeMq9Ss7YRrFxIzf+LjDZuOAbHLrcTjQMLX4s
         lt4472rtE1ckJ9w1T7T+1hfwFFMPH0qBw0FOzOkr0z1/Nzsp5B0D90J/hEQtcEaaxonO
         YwJk5nmB8i1mxI9cerayfnfqQxrRppIxiv7IH812/QAz66ZodYhFvRmy4OpVHnNroAnP
         kQmWi57TZo+heCTdvdFotvSqb5nbMUiOEkaKM/D4PSM7VHNmt1ELiU1klUYscPIblEZJ
         qdgc59obtojykh438Q09NGjmbAnIj8KZebVlgSia1JOaZ4JEWb6NpyDQTtCeHaaGBvDd
         9FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502919; x=1753107719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ3UA4OiThrfJUfCAJnJai+VvM5KDOnLQOCMjU2eyNU=;
        b=p1/fd08fKtDsl5LEWKDIgX7LMfxs2mCyL3Qxk2Ccmef5PdUwKkz7qIkoqkAqjGzIDO
         UdJf7MxtLEi0TeUSOinPHwiVMMfyaBuUw5C1xykgNotvLR+3vB+G9LLqyZBKmp+zwgbO
         ATAJ3e+wqk2187KmS8tyGw5MGkhoxBQV3ResaN2oCSTTUcJal8GDO7TBj0wXP72cXgoX
         MqfZJbxlBWD0F/dL3kvY9n1VtTDyN76txeDrfAdfzPXARvI5sfcHfo5EPmG4XEZFHJkQ
         ggmAWUEWfSlY8aizG8FazGNIvDS10CzzBo7u9wn6J8IvdNRzN39POQpAl/zUvpN3Axqb
         gIeA==
X-Forwarded-Encrypted: i=1; AJvYcCUupV/K9/5eEY4bX8Ro5FEnHeT/wZ3qv5qWV1EJkSpUHp/7xC0tA3dSV3c89TWGuH0G49V2dEavkRx/@vger.kernel.org, AJvYcCWRwIm/w9nvKtVgXVSioZJoyhFEh1BB8+rkyf1qFNG9XXQwx3HxkZCZrm/T6IBzJQqvbg6Y/tv6M2B9+nKnSbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJzw6GoCEW9I4JzNBxb+zfmbzvFWkPITntvVf8+cp0bPSba9U
	vBxQ9U+PlBFj0wmqrCX5w7smxx5X+YIACYZwVRhgWwVcGBQeywzAAUBa
X-Gm-Gg: ASbGncvrWENeR/UjZeiQ4LL/7UFPA65lvNA46oHCC62H1HpPELo+tSwZd4KAzjevlcb
	pGoPQ8PLBlH8Reb9swP9mzxL3ovxr/dhrmDKFNiOSBvYOBILh2UIYNw4uwBel9bsPHr8CN0D0e2
	s4kNAuL/AekTy29pMoXZrONVu3oPETpJ8mPRptyaPWtnlkR5XKWFNotPU3M1aLEtcK5ljD0Pdkz
	i84mk60K+lyjGoawlYFb4fr0QZE8lrKbd4ea2R/h855V923kbIfPfpnXH6/2mACiEzRu21toR1l
	842vOHyo6vjStCE3IUUNfm+Ckl/x/QAp7oqxQN3WseKrBlMSVX41n6ecqYdNoyytw6WtXu8cA4J
	JFOiFkMV23YDVJ7MoCRfHP11d+/fYDAcSvyItTEddmXHVzqANZRoZHKc/BhnbY5F6+B0oVJKBsi
	zhJmBWUbHUM7hn6S2ZFqduAW0=
X-Google-Smtp-Source: AGHT+IFPSGvNAkBdeHK89MtoMem4TLxdLXh4OZGGwdCkz7tqSOs4eBK5tCKfiDABlgF9UHT6wbjqjg==
X-Received: by 2002:a05:6214:4105:b0:702:c042:82a2 with SMTP id 6a1803df08f44-704a4083bb6mr199236616d6.4.1752502918367;
        Mon, 14 Jul 2025 07:21:58 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d8eee2sm47343296d6.97.2025.07.14.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:21:57 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D378CF40067;
	Mon, 14 Jul 2025 10:21:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 14 Jul 2025 10:21:56 -0400
X-ME-Sender: <xms:hBJ1aDGuMY4nwS1IWHR7fsftsJRHhMspcIAyaV49ruNh0A8EqV3-EA>
    <xme:hBJ1aB2apIqJlvd7uisnShqZRnfAgRRo9lEIe_UWpebKA7zbN8f9hSM7r38rqdN2e
    AWHtY9sDnR7xV3GvQ>
X-ME-Received: <xmr:hBJ1aJsLV2dd0SYLg3aM5c2jMCI89X5WjnkG49b8Hqtv_UmZv_oM6e1QRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgt
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hBJ1aAndUvXSTDtoRLanYeY1GLPCqR9APm1iHJI0MFcl_YNxQc7tlw>
    <xmx:hBJ1aHWKITGNp-uMHqPnwN9rk93WfIw-L4A70STwhCLMbRvktUJcAQ>
    <xmx:hBJ1aEsoLbEjTFVdP6DzVJIRMBlG9go7R2XjZiOaCa1WyZDeVoV1Ag>
    <xmx:hBJ1aKqTQoFr0MJuj9KJ8W9_41WszoJ3OB9Y5eFDXo2C_bnagj24tg>
    <xmx:hBJ1aJ58aWRW3w5DIuJshZtXpvwPTg1gN-OQnnB0OBJKPOm6DifSEz2w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 10:21:54 -0400 (EDT)
Date: Mon, 14 Jul 2025 07:21:53 -0700
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
Subject: Re: [PATCH v7 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHUSgXW9A6LzjBIS@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-5-boqun.feng@gmail.com>
 <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBPI9ZJVO64.3A83G118BMVLI@kernel.org>

On Mon, Jul 14, 2025 at 12:30:12PM +0200, Benno Lossin wrote:
> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> > To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> > added, currently `T` needs to be Send + Copy because these are the
> > straightforward usages and all basic types support this.
> >
> > Implement `AllowAtomic` for `i32` and `i64`, and so far only basic
> > operations load() and store() are introduced.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/sync/atomic.rs         |  14 ++
> >  rust/kernel/sync/atomic/generic.rs | 285 +++++++++++++++++++++++++++++
> >  2 files changed, 299 insertions(+)
> >  create mode 100644 rust/kernel/sync/atomic/generic.rs
> >
> > diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> > index e80ac049f36b..c5193c1c90fe 100644
> > --- a/rust/kernel/sync/atomic.rs
> > +++ b/rust/kernel/sync/atomic.rs
> > @@ -16,7 +16,21 @@
> >  //!
> >  //! [`LKMM`]: srctree/tools/memory-model/
> >  
> > +pub mod generic;
> 
> Hmm, maybe just re-export the stuff? I don't think there's an advantage
> to having the generic module be public.
> 

If `generic` is not public, then in the kernel::sync::atomic page, it
won't should up, and there is no mentioning of struct `Atomic` either.

If I made it public and also re-export the `Atomic`, there would be a
"Re-export" section mentioning all the re-exports, so I will keep
`generic` unless you have some tricks that I don't know.

Also I feel it's a bit naturally that `AllowAtomic` and `AllowAtomicAdd`
stay under `generic` (instead of re-export them at `atomic` mod level)
because they are about the generic part of `Atomic`, right?

> >  pub mod ops;
> >  pub mod ordering;
> >  
> > +pub use generic::Atomic;
> >  pub use ordering::{Acquire, Full, Relaxed, Release};
> > +
[...]
> > +/// A memory location which can be safely modified from multiple execution contexts.
> > +///
> > +/// This has the same size, alignment and bit validity as the underlying type `T`.
> 
> Let's also mention that this disables any niche optimizations (due to
> the unsafe cell).
> 

Done

> > +///
> > +/// The atomic operations are implemented in a way that is fully compatible with the [Linux Kernel
> > +/// Memory (Consistency) Model][LKMM], hence they should be modeled as the corresponding
> > +/// [`LKMM`][LKMM] atomic primitives. With the help of [`Atomic::from_ptr()`] and
> > +/// [`Atomic::as_ptr()`], this provides a way to interact with [C-side atomic operations]
> > +/// (including those without the `atomic` prefix, e.g. `READ_ONCE()`, `WRITE_ONCE()`,
> > +/// `smp_load_acquire()` and `smp_store_release()`).
> > +///
> > +/// [LKMM]: srctree/tools/memory-model/
> > +/// [C-side atomic operations]: srctree/Documentation/atomic_t.txt
> 
> Did you check that these links looks good in rustdoc?
> 

Yep.

> > +#[repr(transparent)]
> > +pub struct Atomic<T: AllowAtomic>(UnsafeCell<T>);
> > +
> > +// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
> > +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> > +
> > +/// Types that support basic atomic operations.
> > +///
> > +/// # Round-trip transmutability
> > +///
> > +/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
> > +///
> > +/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
> > +/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` and then to `T` again
> > +///   yields a value that is in all aspects equivalent to the original value.
> > +///
> > +/// # Safety
> > +///
> > +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> > +/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
> > +///
> > +/// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
> > +/// [`transmute()`] is always sound between `U` to `T`) because of the support for atomic variables
> 
> s/ to / and /
> 

Fixed.

> > +/// over unit-only enums, see [Examples].
> > +///
> > +/// # Limitations
> > +///
> > +/// Because C primitives are used to implement the atomic operations, and a C function requires a
> > +/// valid object of a type to operate on (i.e. no `MaybeUninit<_>`), hence at the Rust <-> C
> > +/// surface, only types with no uninitialized bits can be passed. As a result, types like `(u8,
> 
> s/no uninitialized/initialized/
> 

hmm.. "with initialized bits" seems to me saying "it's OK as long as
some bits are initialized", how about "with all the bits initialized"?

> > +/// u16)` (a tuple with a `MaybeUninit` hole in it) are currently not supported. Note that
> 
> s/a tuple with a `MaybeUninit` hole in it/padding bytes are uninitialized/
> 

Done.

[...]
> > +
> > +#[inline(always)]
> > +const fn into_repr<T: AllowAtomic>(v: T) -> T::Repr {
> > +    // SAFETY: Per the safety requirement of `AllowAtomic`, the transmute operation is sound.
> 
> Please explain the concrete parts of the safety requirements that you
> are using here (ie round-trip-transmutability).
> 

Done.

> > +    unsafe { core::mem::transmute_copy(&v) }
> > +}
> > +
> > +/// # Safety
> > +///
> > +/// `r` must be a valid bit pattern of `T`.
> > +#[inline(always)]
> > +const unsafe fn from_repr<T: AllowAtomic>(r: T::Repr) -> T {
> > +    // SAFETY: Per the safety requirement of the function, the transmute operation is sound.
> > +    unsafe { core::mem::transmute_copy(&r) }
> > +}
> > +
> > +impl<T: AllowAtomic> Atomic<T> {
> > +    /// Creates a new atomic `T`.
> > +    pub const fn new(v: T) -> Self {
> > +        Self(UnsafeCell::new(v))
> > +    }
> > +
> > +    /// Creates a reference to an atomic `T` from a pointer of `T`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - `ptr` is aligned to `align_of::<T>()`.
> > +    /// - `ptr` is valid for reads and writes for `'a`.
> > +    /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
> > +    ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
> > +    ///   accesses are atomic, then this safety requirement is trivially fulfilled.
> > +    ///
> > +    /// [`LKMM`]: srctree/tools/memory-model
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
> > +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
> > +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> > +    ///
> > +    /// ```
> > +    /// # use kernel::types::Opaque;
> > +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> > +    ///
> > +    /// // Assume there is a C struct `foo`.
> > +    /// mod cbindings {
> > +    ///     #[repr(C)]
> > +    ///     pub(crate) struct foo {
> > +    ///         pub(crate) a: i32,
> > +    ///         pub(crate) b: i32
> > +    ///     }
> > +    /// }
> > +    ///
> > +    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2 });
> > +    ///
> > +    /// // struct foo *foo_ptr = ..;
> > +    /// let foo_ptr = tmp.get();
> > +    ///
> > +    /// // SAFETY: `foo_ptr` is valid, and `.a` is in bounds.
> > +    /// let foo_a_ptr = unsafe { &raw mut (*foo_ptr).a };
> > +    ///
> > +    /// // a = READ_ONCE(foo_ptr->a);
> > +    /// //
> > +    /// // SAFETY: `foo_a_ptr` is valid for read, and all other accesses on it is atomic, so no
> > +    /// // data race.
> > +    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> > +    /// # assert_eq!(a, 1);
> > +    ///
> > +    /// // smp_store_release(&foo_ptr->a, 2);
> > +    /// //
> > +    /// // SAFETY: `foo_a_ptr` is valid for writes, and all other accesses on it is atomic, so
> > +    /// // no data race.
> > +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> > +    /// ```
> > +    ///
> > +    /// However, this should be only used when communicating with C side or manipulating a C
> > +    /// struct.
> 
> This sentence should be above the `Safety` section.
> 

Hmm.. why? This is the further information about what the above
"Examples" section just mentioned?

> > +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> > +    where
> > +        T: Sync,
> > +    {
> > +        // CAST: `T` is transparent to `Atomic<T>`.
> > +        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
> > +        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
> > +        // guarantees other accesses won't cause data races.
> > +        unsafe { &*ptr.cast::<Self>() }
> > +    }
> > +
> > +    /// Returns a pointer to the underlying atomic `T`.
> > +    ///
> > +    /// Note that use of the return pointer must not cause data races defined by [`LKMM`].
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// The returned pointer is properly aligned (i.e. aligned to [`align_of::<T>()`])
> 
> You really only need this guarantee? Not validity etc?
> 

Nice find, I changed it to also guarantee the pointer is valid.

> > +    ///
> > +    /// [`LKMM`]: srctree/tools/memory-model
> > +    /// [`align_of::<T>()`]: core::mem::align_of
> > +    pub const fn as_ptr(&self) -> *mut T {
> > +        // GUARANTEE: `self.0` has the same alignment of `T`.
> > +        self.0.get()
> > +    }
> > +
> > +    /// Returns a mutable reference to the underlying atomic `T`.
> > +    ///
> > +    /// This is safe because the mutable reference of the atomic `T` guarantees the exclusive
> 
> s/the exclusive/exclusive/
> 

Done.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > +    /// access.
> > +    pub fn get_mut(&mut self) -> &mut T {
> > +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`. `&mut self` guarantees the exclusive
> > +        // access, so it's safe to reborrow mutably.
> > +        unsafe { &mut *self.as_ptr() }
> > +    }
> > +}

