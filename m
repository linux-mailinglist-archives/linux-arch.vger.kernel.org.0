Return-Path: <linux-arch+bounces-12787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136AB0640B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5774A5793
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20940254878;
	Tue, 15 Jul 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Bi8rHx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CE22E3F0;
	Tue, 15 Jul 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596003; cv=none; b=pssP1HN8iJ0kcj6f2pnTif+GFLTkQswyBRovQhIPXVYqM71br5zcDGBABYGTEQOSdnCkObbD+8Y2tFNPah3+OcBtp1Mjnx4KDgmovmZV4s9SqTn1rS4EbxghEVsHJW/v4vpRoFPLgrxBviz6/4qzDQZnFjwxx40T/74P+Pmp7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596003; c=relaxed/simple;
	bh=tP/6JxZ6g3xh/Kit5uYKhDodCM96ZF4YsoVPvDuo4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfi7A9vxXvJnsAtm/yLe5dPoWHecKGrsEviqo0sYhHgfnSsLt1cfIHmiMzYiHVPucEI3nmnLsqo41DJGRiz9GvHfOAcQPh8hAXwTmd4o/f3eNswYhcMGlaGKTUkwjxQbyDG1Tz8d21CP5C4GPBTObvKYF2jBVN5PUbm2kSysv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Bi8rHx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fae04a3795so43673606d6.3;
        Tue, 15 Jul 2025 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752596000; x=1753200800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11kqvGJ2ewy7y65C+mNFgb67LnssHTLDixIwYJqLK7Y=;
        b=G7Bi8rHxfFcLXxfzvxW2NaA1juCqoPJ0pQR3fBu2RrnX2HBqhTQDxjRzYQ5WA2IcCY
         QvWMdByTAVTOpzatB22N0AhfB99D/kFD9GWac/g+7OqXrxtk5t1RTMywit8sXcX6i1di
         B+S+y+nbk86BgV3wCdG9Hd+GMxsiklKU6jzqf3UPEGe3+xOZHljw5WCWQVtCwI47c/Qo
         v9F93pVNk1domoel7QIZMuPZCevMpYA5d10T1FTNDz2grVas43dHCpzwQSrlo+VD5bPL
         Iyy7EUE+vMP5JL0UnNltH/Dno9fpRShVeJ0douVEWWNVszAU2ks3VIv0NY0yvEzjJofH
         Byog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752596000; x=1753200800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11kqvGJ2ewy7y65C+mNFgb67LnssHTLDixIwYJqLK7Y=;
        b=ioeWwgTjwVP+CHosMIBmTAnx9K2KxCOAdwkW0VI1tDJA+m9nRfK8tYuTFr5xlfEmUS
         BH5VAi/IOSfo0HSjFFBRi0vNaqm+L6xngrh3MygPo/cmdyiMMNwc+4pbTwoVWnyhPy/M
         bIqPr6Z4k70M3CeusF41ni0DtsPLxkSbk50po9xVlzXfQ9rC8SZCl1Vk3aZi8n0S5rNk
         GdXpaU/0x9zr3Uq2DLWP1bObQ4JrF85AI3SegxjZgOYR4AVDt4kKCmbGTNnjJdVe2PNq
         fYSYPguanPhzCsf8cKkK+Z3PK04re6ONV1YEbwnU3NOV9jjXZmRwTl4boRxN/KL25IQg
         fx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8BWGWARvmulcgXDwFXXlfh7rMeJHWJG+B5PGD5P2oZ9i/nzZZD8t6XrrbgI6ZgXpM68szWGJOmKC37RsaGuo=@vger.kernel.org, AJvYcCUHAjMGX6fJ/yzJVcwnKm5sahhlmlH8Xz8soRmnurYv6hE08x+kKkg8iQOr7Gr64xA1NpKdTNbcVe5A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr558bXsem8hyMaDRJAwOAiTHxUy5Vw9aN4uGEtOzk/oBfidN/
	JPhgdGm77XhMlHd+jEUeIfT+BkA7GGMsMXdu76X+9JS33H45J3WKVO8A
X-Gm-Gg: ASbGncsjrEdiYB1QdBDlds1cUam5yf4r7t5rkjZAY9AZ/ay9J4YtxPTq/wsvw9rJcTC
	CwdOJmLyCfTInBq9z0QdsdQ0THeHYVJLuAsiVMdnwLCuLvCvpmeOccsVulolNP0fy0OWFlDzdU4
	q2m1EcEYxKGqJC/ZYQC+pxA3QHaFm9IKlIwL6OoCKLQe30VGzH1U2KhjfIHtyS4zzF+qD53u/vw
	eAj1e/hKZ+NSGBt3Av+NMO7L0d6SL5/jUQHAnLkEjjq1+G5SLqps7zgqVI35UqgU0ATsegSho09
	Q+jWWmG5R7nVgZ0szdg1VeQ1gT21smXahGSJyQKKThFBc5mEDYnLmCZW993VETuGk4NJin4pF6f
	2Z3qSCn2w1LZNsoMidLtih9FTUW4rUBimRwM/nKHwbbEn4/aLkZEtdsy+FMa58FAAVn8GjYmxqJ
	1uMbunFaYi4v9B
X-Google-Smtp-Source: AGHT+IH0lYDUA7YI8hQnze+ytDhagaRzMtzMWLcoPzYi387bUy5bZ6JrDIFe/sZA7JBTcLNYGpgUmw==
X-Received: by 2002:a05:6214:5788:b0:6fb:25f:ac8c with SMTP id 6a1803df08f44-704f4ab51famr589926d6.31.1752595999863;
        Tue, 15 Jul 2025 09:13:19 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b80e1sm59508516d6.36.2025.07.15.09.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:13:19 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 95195F40069;
	Tue, 15 Jul 2025 12:13:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 12:13:18 -0400
X-ME-Sender: <xms:Hn52aI1WuzCMTmkBrxjsovdbxUeqDtoRcLp7aD9Ct2tenBBfL5ssBQ>
    <xme:Hn52aEnxU2nyPsX_bazfFrqhd-ZyvPhzReZn8vOkA2OAqdH7gmDck7Rbw2XWJejb4
    l02nkHX2rJuN50fFg>
X-ME-Received: <xmr:Hn52aFex4EQ7TF28hGOb628f-O_JkRl_5MTBeM1xZXhhb_xPeTiKGo6tJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedvkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Hn52aBVWJcWZt9IYrPFRaO8Nrn2VkuLWmneVgJDCmLQW1SDp7cdBoA>
    <xmx:Hn52aJHcj8W0R0hfA-YqPVXGgUE956CRy-mjh9Up2VRYHa1W0gY7IQ>
    <xmx:Hn52aDdGu_vqAsUHjE66Hf5CKt0U_H3rOEr-OCXulwgRUF7D5io35A>
    <xmx:Hn52aCZZNyyXfQg-THepwOun6FGAqDtAL2nhnCjDKPusaqCzrrYqhQ>
    <xmx:Hn52aGr6Xq4d0SwLom9nT7tZhNsPWsUleVy5rlwJIbAMgcS2QCZMRhmG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:13:17 -0400 (EDT)
Date: Tue, 15 Jul 2025 09:13:16 -0700
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
Message-ID: <aHZ-HP1ErzlERfpI@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
 <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>

On Tue, Jul 15, 2025 at 05:45:34PM +0200, Benno Lossin wrote:
> On Tue Jul 15, 2025 at 3:33 PM CEST, Boqun Feng wrote:
> > On Tue, Jul 15, 2025 at 01:21:20PM +0200, Benno Lossin wrote:
> >> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> >> > +/// Types that support atomic add operations.
> >> > +///
> >> > +/// # Safety
> >> > +///
> >> > +/// Wrapping adding any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> >> 
> >> I don't like "wrapping adding", either we use "`wrapping_add`" or we use
> >> some other phrasing.
> >> 
> >
> > Let's use `wrapping_add` then.
> >
> >     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`Self::rhs_into_delta()`] to
> >     /// any value of type `Self::Repr` obtained through transmuting a value of type `Self` to must
> >     /// yield a value with a bit pattern also valid for `Self`.
> >
> >> > +pub unsafe trait AllowAtomicAdd<Rhs = Self>: AllowAtomic {
> >> 
> >> Why `Allow*`? I think `AtomicAdd` is better?
> >> 
> >
> > To be consistent with `AllowAtomic` (the super trait), if we use
> > `AtomicAdd` here, should we change `AllowAtomic` to `AtomicBase`?
> 
> Ideally, we would name that trait just `Atomic` :) But it then
> conflicts with the `Atomic<T>` struct (this would be motivation to put
> them in different modules :). I like `AtomicBase` better than

Oh, if we move `Atomic<T>` to atomic.rs and keep atomic::generic, then
we can name it atomic::generic::Atomic ;-)

> `AllowAtomic`, but maybe there is a better name, how about `AtomicType`?
> 

AtomicType may be better than AtomicBase to me.

> >> > +    /// Converts `Rhs` into the `Delta` type of the atomic implementation.
> >> > +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> >> > +}
> >> > +
> >> >  impl<T: AllowAtomic> Atomic<T> {
> >> >      /// Creates a new atomic `T`.
> >> >      pub const fn new(v: T) -> Self {
> >> > @@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self, old: &mut T, new: T, _: Ordering)
> >> >          ret
> >> >      }
> >> >  }
> >> > +
> >> > +impl<T: AllowAtomic> Atomic<T>
> >> > +where
> >> > +    T::Repr: AtomicHasArithmeticOps,
> >> > +{
> >> > +    /// Atomic add.
> >> > +    ///
> >> > +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
> >> > +    ///
> >> > +    /// # Examples
> >> > +    ///
> >> > +    /// ```
> >> > +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> >> > +    ///
> >> > +    /// let x = Atomic::new(42);
> >> > +    ///
> >> > +    /// assert_eq!(42, x.load(Relaxed));
> >> > +    ///
> >> > +    /// x.add(12, Relaxed);
> >> > +    ///
> >> > +    /// assert_eq!(54, x.load(Relaxed));
> >> > +    /// ```
> >> > +    #[inline(always)]
> >> > +    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs, _: Ordering)
> >> > +    where
> >> > +        T: AllowAtomicAdd<Rhs>,
> >> > +    {
> >> > +        let v = T::rhs_into_delta(v);
> >> > +        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
> >> > +        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
> >> > +        let a = self.as_ptr().cast::<T::Repr>();
> >> > +
> >> > +        // `*self` remains valid after `atomic_add()` because of the safety requirement of
> >> > +        // `AllowAtomicAdd`.
> >> 
> >> This part should be moved to the CAST comment above, since we're not
> >> only writing a value transmuted from `T` into `*self`.
> >> 
> >
> > Hmm.. the CAST comment should explain why a pointer of `T` can be a
> > valid pointer of `T::Repr` because the atomic_add() below is going to
> > read through the pointer and write value back. The comment starting with
> > "`*self`" explains the value written is a valid `T`, therefore
> > conceptually atomic_add() below writes a valid `T` in form of `T::Repr`
> > into `a`.
> 
> I see, my interpretation was that if we put it on the cast, then the
> operation that `atomic_add` does also is valid.
> 
> But I think this comment should either be part of the `CAST` or the
> `SAFETY` comment. Going by your interpretation, it would make more sense
> in the SAFETY one, since there you justify that you're actually writing
> a value of type `T`.
> 

Hmm.. you're probably right. There are two safety things about
atomic_add():

- Whether calling it is safe
- Whether the operation on `a` (a pointer to `T` essentially) is safe.

How about the following:

        let v = T::rhs_into_delta(v);
        // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
        // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
        let a = self.as_ptr().cast::<T::Repr>();

        // `*self` remains valid after `atomic_add()` because of the safety requirement of
        // `AllowAtomicAdd`.
        //
        // SAFETY:
        // - For calling `atomic_add()`:
        //   - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
        //   - `a` is a valid pointer per the CAST justification above.
        // - For accessing `*a`: the value written is transmutable to `T`
        //   due to the safety requirement of `AllowAtomicAdd`.
        unsafe { T::Repr::atomic_add(a, v) };

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > Basically
> >
> > // CAST
> > let a = ..
> >
> > ^ explains what `a` is a valid for and why it's valid.
> >
> > // `*self` remains
> >
> > ^ explains that we write a valid value to `a`.
> >
> >
> > So I don't think we need to move?

