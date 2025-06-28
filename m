Return-Path: <linux-arch+bounces-12490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A90AEC45D
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B8B4A135D
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F9189513;
	Sat, 28 Jun 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYrWiDjD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E97E552;
	Sat, 28 Jun 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751079840; cv=none; b=EKp1vVU5UEKHqZCZR3Zas8yF2mFHu+xjgJm1BZOhKDrCgzrmC4/IVxdEOsa4PhjnvyKxroHYlRerUeDYzKT+Ed+kdirYeWbmR9DyYnPaH+zogoTgMO8SsxhmoZ+XuBeE2yLnL1yQqiBWtGrw9H4uQp0fWNOHklhGxDzvDj51Fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751079840; c=relaxed/simple;
	bh=z2g6FwoM1+yP/R1AO2qvEMxVHFZmKzDH0+Yb2w/7CAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIX7PkAOP4wtOu3K8VQGdGdlvtXJEsXjk8Bn2dTtmSLoMOqwgZWIxRdlgfD6yrWEtv4LZCt257/MwJVnMYVqdq5TBAyqaRPGRFvjVFzttYEs5qHBoC3GGRE7AMQ7oCZPa21x+jT6eS2op+fSwU3l9IH9PZ0c6AZDTW+MaAZaOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYrWiDjD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58f79d6e9so39332701cf.2;
        Fri, 27 Jun 2025 20:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751079837; x=1751684637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKfdkGsHs7NqMRbo/7Qs4sBJbj00KoBTElEavTmIUM0=;
        b=WYrWiDjD/583qdwndmIIRmRVmA7lrFAgsX9fyg6cwc1Ig0WM8G/kLMMhA0WbNakPO6
         FBl3rfZieU9O7Qt6cnzDxZx8/PRyhGsvJ1SCYE6jav2MAs9eUCSMZNJC9rzBb+DaDTsl
         9ZRYn1JRo6X7xAT0XpVfL+hGtPDhbjyh/fQml8bzEWxMpczDEE7rH1jsuPTQqIxDzi6Q
         p38vi6qWch+1YG8m/CsVUbxKRBDdveFf2RLLF4/6gIA1q4Fa1Pc9KAnXmMFHbXPZQ+Dk
         WUfGo6uSBoT+IlKKIIMOp6eKg1mVqQqklzNiUzOpjaitaDWQvJL2AAM9/jXqP8HHjR4t
         2fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751079837; x=1751684637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKfdkGsHs7NqMRbo/7Qs4sBJbj00KoBTElEavTmIUM0=;
        b=Vx5POMffR9DaU6Ey9zXo8ZeOSNN8Ezhgs6zR4Watk7a3YHh10PckhNOIXR/Kz54its
         pvXSbSjZPIVsYPMpY07AcG6kwkZPbRZAIkg3WXrrqg2a24v4Ykb0a+JOwggK2QY0gb1S
         6oBFKEjkOQ1J5u6af28n+szaP6Ur07P5vqz4SH9KcclarebqRvaSnDf7bTqsTlZrV5gw
         Qk4lyjq0fSokzotMH+nRRQiiRtX15/d/Uslq99ml/rUoY4MhaUPEiIYSkFNBC9RubSQO
         tczURrw3OQFp4CxQI8GQ1gIuyiMbObAGrd5ZiEM1brhwtEXjsYvKhMoVXvxxQry/Z7NM
         zugQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNY5HBQoizynWnaCoulcdD+YM8Zv5TfxJJtgBuHCVt3/5YGDALFetq1QTHevCi3dzjCxsWHrZIAcDPLeCDnV8=@vger.kernel.org, AJvYcCX1PriCYcmz3ed/KGScKZce1g8HLV5mr/HyFka3F1MXWDfBESfYUqEgnv8jI6lsabIGIxafk8VzeTAg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7urnx8F/VkW4gtYsILZoK+MaVrKrYY1wAONVH2ivqpeQoRJYr
	K1c9WcxqywjjjWRzPXfhWmUCFm4tSW3JkZdN6AtdwNt0DY7HfgheaD85
X-Gm-Gg: ASbGnct0Ch+AX5Vi8wv71s6jrrCep/dsOHMk7T9x1bo+8c7zzUiKvQGNxaMz58FI79+
	2cptRdKwohJM/JmyWbMN4xA+MvQvdulEH1l/0xDVNEJpAGl0/vH3sD24kgGYF2hYDjgNrq6RC7v
	7G171y+PPIHsFcv20+mdfh8TQkiON5n7eOdbXC0z4adITyvkE0N/S/jaesasAqLApim4WahGcaG
	PbekISffT26WcarsCX2+LS8eq9QsHg5vvLQ2FofRzwl1akf2eCUVPmYpY5Rc5EUirpGZ+bv0zZ3
	Zp4NZmiLzVWPP0sdHQJv7grYBBAT3CL+h/Bp6RwRAGf1kamWEcKo39p9vom1BFpGvZq7gn929Xk
	E80oPAGKtzOV3bnI3yr567E2d1dlQfpCC1/A3PNSKnngIn5xZ8TwCgUJTYmG5FzQ=
X-Google-Smtp-Source: AGHT+IENHGG6gjc1y6TnpBpTdkf27mATfXOIOHmBDYkft5eYdEI+PM3hm40FM9FR4iCyeuRlYqKnJA==
X-Received: by 2002:a05:622a:4e9a:b0:4a7:b73:5356 with SMTP id d75a77b69052e-4a7fcae8dc1mr89595271cf.40.1751079837258;
        Fri, 27 Jun 2025 20:03:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc55c67esm23103201cf.48.2025.06.27.20.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:03:56 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id F0B08F40066;
	Fri, 27 Jun 2025 23:03:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Jun 2025 23:03:56 -0400
X-ME-Sender: <xms:m1tfaNN3CCBDYWLgTmC0HrwD5BOHWjNquEzLHu4PDn5QIoYq6xMvNQ>
    <xme:m1tfaP-yvPebA6oK2kDQgHqJNNi7aF6qDJCXHJmW9MkFa39sUq8lDt-oxTyVGaz4_
    P97WMtWxx5knvzvZA>
X-ME-Received: <xmr:m1tfaMSonSBlVUIF9z5IZl3yqLoUHWYd-ClnofsmSVucMM_PX1CC-FnwUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhu
    shhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidq
    rghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:m1tfaJtfVFqgsAVdx0fRjarA2xgGOpdHtrpo2iBFtKWS6xxKUIylgw>
    <xmx:m1tfaFe7-QxzKOy8f9pgXpFhG-Xr-nJ1zzbY4_Eu2NGSK1S3XKvu1A>
    <xmx:m1tfaF2Kv4sNjvwOCuBiY-nAFnoF-eo9XHoAh3TeApOPkcpCycMATA>
    <xmx:m1tfaB8JNz01A4lKxbk7szR3jw05_mYcnVRbhm76PgdGXd2wsihjNg>
    <xmx:m1tfaA-J5dUpJYNnarlWOsRs9W-lyuz-hHMToJZUoWNR7PcwWfldlGFF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 23:03:55 -0400 (EDT)
Date: Fri, 27 Jun 2025 20:03:54 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <aF9bmpX-i6HVMlaj@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <jBAtISwM9LKkR7KuCHEnym75NfGOM4z408pMuDfk4U8VzN8PQuk9JJfBc33Usre3YSjbgtFRj8c0ZNeeQMpZsA==@protonmail.internalid>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <87a55uzlxv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a55uzlxv.fsf@kernel.org>

On Thu, Jun 26, 2025 at 03:12:12PM +0200, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > xchg() and cmpxchg() are basic operations on atomic. Provide these based
> > on C APIs.
> >
> > Note that cmpxchg() use the similar function signature as
> > compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> > the operation succeeds and `Err(old)` means the operation fails.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/sync/atomic/generic.rs | 154 +++++++++++++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >
> > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> > index 73c26f9cf6b8..bcdbeea45dd8 100644
> > --- a/rust/kernel/sync/atomic/generic.rs
> > +++ b/rust/kernel/sync/atomic/generic.rs
> > @@ -256,3 +256,157 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> >          };
> >      }
> >  }
> > +
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
> > +        let v = T::into_repr(v);
> > +        let a = self.as_ptr().cast::<T::Repr>();
> > +
> > +        // SAFETY:
> > +        // - For calling the atomic_xchg*() function:
> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> 
> Typo: `AllowAtomic`.
> 

Fixed.

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
> Rust `core::ptr` functions have this sentence on success ordering for
> compare_exchange:
> 
>   Using Acquire as success ordering makes the store part of this
>   operation Relaxed, and using Release makes the successful load
>   Relaxed.
> 
> Does this translate to LKMM cmpxchg operations? If so, I think we should
> include this sentence. This also applies to `Atomic::xchg`.
> 

I see this as a different style of documenting, so in my next version,
I have the following:

//! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
//!   following memory accesses.
//! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
//!   the annotated operation.

in atomic/ordering.rs, I think I can extend it to:

//! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
//!   following memory accesses, and if there is a store part, it has Relaxed ordering.
//! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
//!   the annotated operation, and if there is load part, it has Relaxed ordering

This aligns with what we usually describe things in tool/memory-model/.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

