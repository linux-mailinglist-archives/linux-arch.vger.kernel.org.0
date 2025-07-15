Return-Path: <linux-arch+bounces-12781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DBB05DAC
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FAD3B61F8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA162EA729;
	Tue, 15 Jul 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1HwMsDM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9A2EA723;
	Tue, 15 Jul 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586429; cv=none; b=sWNdVYBcxWLsnb5YK3ozyo/bF/u2Kl+c/v25fbQLPdL8VHapZ0qyX30u4R9pA5vMqoWKGCXrWJwR0Mzy2kiQAb9QnOd2QzU7Gzh8JNQ4jC9x/eSa1tAHuoND1WxEyhSlFETKCEUREBz9sJ8y+zBdxpJWUgWfTA9WCtKNc9+xrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586429; c=relaxed/simple;
	bh=pVE5YnjCSPErRIluAjIvy/UtsReHKlr74mAmZRFiN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfwFrd6e5DOsQjb65vK1TqDKV9bCsxsxsb1Xy15JnZIEg6QzwZ8gBd9OrDyK1bOyOQyaR6hLaarm2LcaFEXsY6aLGu4s+nyoJLM09L9EuN44bM9v4M+i+RAhMzawnxCPMxq0AKVCOa6efcwMUkUTLueTP/ePtvFFbgfZX4FATqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1HwMsDM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e3142e58cfso130158585a.0;
        Tue, 15 Jul 2025 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752586426; x=1753191226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2oaG9QbGpOsofvR1kED/97aI+p4RU3s8x/wrVWRQvs=;
        b=U1HwMsDMPr8kBzgbqNdnlutEpwpiySXnU73icv0wnkGS8xVAwL6xdCUkHQwECpb0OF
         rr3zDGax+F6cDsXZMOq0/DrT3BzJjGF7pmh/cnnGxiwkkMsBy9jXsOFNQhe1Gs6uo/qQ
         ncvwSb4k98aV+M5iEKH6nyuKpeuaKw5FQRVwOyFJ9NkNba0LfoC30dWnSLFn6F43xmOK
         6GPY6rZMF7CxfwQt4SxHMH1pnpQVMD9IP/mvEoycijf7mtI4rrCzK/Vg6b85y4JAvOIZ
         9oMiTInhbXTnZWhEinXyIv0hxK6Avh9x9awMuMCCXZpsPWMBw3NHl36IM4A94t9lCSfG
         2Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586426; x=1753191226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2oaG9QbGpOsofvR1kED/97aI+p4RU3s8x/wrVWRQvs=;
        b=QCPdVtolxF3gWgW0dRklOPpkxuz5YP+8lUKuw8QRaLAEPHVgHbuB/6j/orNr8Ead4G
         jbrd+XXC2wKFLSyKoS+eAdFFP1ulEmJ2neEsuEJyND/vC+8+cyv0iFCBnXwN6Jq/X8Y2
         we9KCIubui9wAX17uuFiA7batyONS8T9Zj2AfHPHIUNP098MMPF6xCPvNcPcfoSis+oH
         VvWSO0l2IulYgpqyJg3sdGTm3mFoxkAH/vDB0zWawXcRgd7eeA21OpbQ+6R1ABfT+j53
         /rA4nithO85c050oebeQQNq+sWXxoxZDkJK7mUkw9EDchCh5fP0llu9xomEsR8noZnt3
         QySA==
X-Forwarded-Encrypted: i=1; AJvYcCVTOp9T8na/1nZVSgvAMuQwjKYUp5un8EcfajUEdQo89eXpmszogbM4A+t7ckSZveTdc63iWYJzNTfv@vger.kernel.org, AJvYcCVnkIwIQiC8nAGshoR+MMzkP3xU40n61JkQ+LNaMZhKJuax2cYU32Dzx75oJSAHaqysvHNCipG1cKUcF1t1PA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzTj3h6z6OSiM4C1srbQbaU7j0Xi7N+j41kMV+qFtJv6bar5f
	aJgCLT8PDZdPe7bhqBlmvnY4gy7/1Ejokgf7/R3hpSx1PU02Vo3eOdGU
X-Gm-Gg: ASbGncs3mEtG5jEgKQZ78QNAkHaLZ64lKC6uuutkVeHGLXLz3UX6Ted1z60/5Dq/ABt
	uwXjyrN9NtrwDW6fT9+5vD8mm5CXd+ldGKqJfpg4ZOqoQ4bhSStjH/ecK6xQvVpZ1pYZw2Lr+QR
	G311zoYpsywrxyHt3NJ5aLHyKl2nZPN3b8G1KbCK/MDY8eVv90DGgUMAM41wzvbf8dwqSe/dXUs
	ub1ThqKoRc/6sz9jQJXALxTdz6tth/QfpvePMhCV5jVv2iob3BOljC0xj4kuV4BYRvHzAUBMpPY
	37qFfJrSpVDURZmPVtFbrLXL1gmbcejik5TibsPVZh4p6vBVtmFla1RUmvTdgNc1ouisK/8zeG1
	J4jsMP+THmgdTEMxGkkY82YBqqp7fjG8npL/L8y3kcvZPlwJf4L7/mmaqdmbrNDVIH0EgplbFD5
	nsWjN+ceMpHVaB
X-Google-Smtp-Source: AGHT+IGtEc1parY4FUeNpX2+Bcp/b0sdIePYdFNZiOG5zXg79PFDIVIOA5PlCc8JtvGRJOYeJUl9qg==
X-Received: by 2002:a05:620a:454b:b0:7e3:3aa0:f458 with SMTP id af79cd13be357-7e33aa0fcb8mr285334785a.28.1752586426150;
        Tue, 15 Jul 2025 06:33:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f7d06sm623142785a.40.2025.07.15.06.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:33:45 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id AC8FBF4006D;
	Tue, 15 Jul 2025 09:33:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 09:33:44 -0400
X-ME-Sender: <xms:uFh2aC30q6AKxLqUKbhQa0YHAlIL9HJ6MlAvsViswuuGvF21EqDi6w>
    <xme:uFh2aGnO5E8J2lVLK3O36iYH6dXYJVkPq-mOMADZxCmPXiueDi3vxaI2zfGQUVP93
    36YF_ePJjt5_Uv0zg>
X-ME-Received: <xmr:uFh2aPeXuTDJDUIj8Pq7tuR1qQubWcHHhwkLAIAjJj8ln0wBewkNR9nkNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeliecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:uFh2aDVIM2vpqHVADDaHSRic9-6M0HWQ6ZFuNQh-XD3HwPvEiQi6zg>
    <xmx:uFh2aDG0iPYRmRa7efCozL1CydFxXcrrN7JUeSWP6TNbRRs2gTqsog>
    <xmx:uFh2aFfV6O4Cw88rIW1163ExYo-M6RQZCYeR9J6mKD88SnEsxkvgPw>
    <xmx:uFh2aMYJtFY180locnCXo7UTK6UCeuqQjUeXn8rcFQtOEoB5UbYAQA>
    <xmx:uFh2aIrupV_NKBTr9cgufyeZ3hOKr_qFzUNsvJhJk7reSgbe9-qU-zhE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 09:33:44 -0400 (EDT)
Date: Tue, 15 Jul 2025 06:33:43 -0700
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
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aHZYt3Csy29GF2HM@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>

On Tue, Jul 15, 2025 at 01:21:20PM +0200, Benno Lossin wrote:
> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> > +/// Types that support atomic add operations.
> > +///
> > +/// # Safety
> > +///
> > +/// Wrapping adding any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> 
> I don't like "wrapping adding", either we use "`wrapping_add`" or we use
> some other phrasing.
> 

Let's use `wrapping_add` then.

    /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
    /// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
    /// yield a value with a bit pattern also valid for `Self`.

> > +pub unsafe trait AllowAtomicAdd<Rhs = Self>: AllowAtomic {
> 
> Why `Allow*`? I think `AtomicAdd` is better?
> 

To be consistent with `AllowAtomic` (the super trait), if we use
`AtomicAdd` here, should we change `AllowAtomic` to `AtomicBase`?

> > +    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
> > +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> > +}
> > +
> >  impl<T: AllowAtomic> Atomic<T> {
> >      /// Creates a new atomic `T`.
> >      pub const fn new(v: T) -> Self {
> > @@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self, old: &mut T, new: T, _: Ordering)
> >          ret
> >      }
> >  }
> > +
> > +impl<T: AllowAtomic> Atomic<T>
> > +where
> > +    T::Repr: AtomicHasArithmeticOps,
> > +{
> > +    /// Atomic add.
> > +    ///
> > +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> > +    ///
> > +    /// let x = Atomic::new(42);
> > +    ///
> > +    /// assert_eq!(42, x.load(Relaxed));
> > +    ///
> > +    /// x.add(12, Relaxed);
> > +    ///
> > +    /// assert_eq!(54, x.load(Relaxed));
> > +    /// ```
> > +    #[inline(always)]
> > +    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs, _: Ordering)
> > +    where
> > +        T: AllowAtomicAdd<Rhs>,
> > +    {
> > +        let v = T::rhs_into_delta(v);
> > +        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
> > +        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
> > +        let a = self.as_ptr().cast::<T::Repr>();
> > +
> > +        // `*self` remains valid after `atomic_add()` because of the safety requirement of
> > +        // `AllowAtomicAdd`.
> 
> This part should be moved to the CAST comment above, since we're not
> only writing a value transmuted from `T` into `*self`.
> 

Hmm.. the CAST comment should explain why a pointer of `T` can be a
valid pointer of `T::Repr` because the atomic_add() below is going to
read through the pointer and write value back. The comment starting with
"`*self`" explains the value written is a valid `T`, therefore
conceptually atomic_add() below writes a valid `T` in form of `T::Repr`
into `a`.

Basically

// CAST
let a = ..

^ explains what `a` is a valid for and why it's valid.

// `*self` remains

^ explains that we write a valid value to `a`.


So I don't think we need to move?

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > +        //
> > +        // SAFETY:
> > +        // - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
> > +        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
> > +        // - `a` is a valid pointer per the CAST justification above.
> > +        unsafe {
> > +            T::Repr::atomic_add(a, v);
> > +        }
> > +    }

