Return-Path: <linux-arch+bounces-12574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F9AF9CB1
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF61C20C93
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5921B9D6;
	Fri,  4 Jul 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDd75BUe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEE1DF247;
	Fri,  4 Jul 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751671295; cv=none; b=S/voCeWPX/p6j8ld5Docxqj+3X1k8VR2nW6XJOeei5CWlxlmDNE0rFSMiwOaz9LS0ZwiZSBII/S74cQtEtbR2WhRs0gq2KYPe4wEshYaNvQSrPXXLTseJEQu1btwgqt00T7DiooYqcbA0HiKtTe+afyBDDC3UlmlMfh+i7M+T/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751671295; c=relaxed/simple;
	bh=jE1b/T8vu4ANmTDJ4ST4tad0xZbO91vThM2oPCRjy+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGHlFKkuxXuGx+11R9qSAnKhHeGD68epP+uqRmifcDjLYWL9rya8I3DiC+otBmtTQxqSoxfz86v9elSZuwUMk/jW5HX3yJsJJOWrTSbvqVQis0Bur5Nizg6ziy5yJnxNa4mMRE4a3RkN8K01EwozPO2b4dcmlM+quNNfyNJVFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDd75BUe; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ff16e97d1eso34560066d6.1;
        Fri, 04 Jul 2025 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751671292; x=1752276092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZOJHZdr8mH7+1fX6/tNc+dr4/GCSPI71PoHd4DmHIg=;
        b=hDd75BUeP+LRCluXbd6YtB2eUHgGXI8QrbLq3m6vUQMQRu47UfNs5OClx52Koi28CK
         epIt6Y5r8FC51z19f/gSci5tkdcI4BB0Xm4bnMthBi696YMCN/y5D+Z2NdcZI/2Kk+52
         wH+rCukt+lfuEB5IwBC+lA7VPXE3fqqfy7SR0xPbGyfo8nw7eER0OVwW/pSViHuENOH4
         LisBoD2n8UENINnEccPDWKkaDzovUmBL6t1FLs9+BBc2ckDsezUE8W2EDOCW8UWNQfZ5
         v4+X0XvL+nDOX0dszUT3olxeTZCXuAkpB3gLFtjsx5eBdLNHxtG3gg4S+37VcBz8uZBO
         UkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751671292; x=1752276092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZOJHZdr8mH7+1fX6/tNc+dr4/GCSPI71PoHd4DmHIg=;
        b=nOdw5y5JB4A8iQStpg7B99FfVqmFUTAiPVW7cZ/rpDiFU/UQjpKZyPtB4JderLGv8o
         qX5OyPKUdQjvo5OelcDo5AJM0STnRW422ZnV36qHDf/Jy6p6i6QXDGJ2bGNoTki4yqCT
         rNSaj3jmfBFz87TY0PDtNJWeR2bi5bbO/cUvteOwW3mtIDBbR3td8aDyiyRkfBsNujQi
         fohvSqrckIgMuVyHawPpxtiGBnOK3BELmBaFxfELnmUxkSebEcvWSyyFtLnXCZey4I4T
         RNKxvXMhm3rwPhIKcj4A2+Yf+NIERkHalmGjoKuifiJ6emeLB8dGSV4uTLxZZY77ruyh
         XxVw==
X-Forwarded-Encrypted: i=1; AJvYcCUkG55Z2+IEghH7s4LfeJAt4LMciLlrqqmCBcLyEDGDS043pUD9z4rTQiEXYLWnD1ylmmFxDWmPvly4qN2ga+o=@vger.kernel.org, AJvYcCXkXc9zbbB7CSrA8KsZH/kH6QRQXMxO6MLRjbJsik3+GwBBHV3IcVa8ULZbucTgqG25SD0SQ5GCa8IX@vger.kernel.org, AJvYcCXoQLH0JqJNkh2zL6ZFMoJAjGjskkZPuf5a4Q1ZnjRuImcshIRkGENtlZKapES+okuftpdOuMz3dh1rbfBR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eheTdqahZWn78+DmMoPdXnLq5Q4IwPX6Eo05edJapDjMtHE3
	BCMv4qhD5LWqjfZSx47dCGPTJYALaXXmcWwT8cq3eYEG0dRUFEf9SoS2
X-Gm-Gg: ASbGncshOMpLAKgemQp8Eu+SP4nUA0m2/PxW8lyoDtJpRZRCByBfl1JAgvWCq5r0vSu
	o1rooSQkzyJrsoCZ8GFKPdg4uLPbrL+G/HK0fDYF2T7sxbp8LacT4lUvtwfZE9leCeMwLdc+dxG
	Pvet//YPlrtRMUTTrf/nru9XG0lVHYTvLQkoiZOyGKUen5IopUiHWnHyCPIIiExlo6aA6UDbXUB
	k6l+6ltja/Oo1gtn3ksPr/7zB6PAM4JtlcbqshTNSoxFHPsrPXdo8WvZrtyymhEVjapyrw7RhKE
	fC/8GmHBAYAgxUfqFdLvX29fGmwb35vHRzuULdievhuQmhlUZJuwUEJXOOa6f/dY021od477Z05
	2481KmvzkGNeNAKnmj4H8vqWTghawPYv4EGBII5tzlwM0Xv3JQD1n
X-Google-Smtp-Source: AGHT+IHQUE1vxUwY6a29kM6aQ4jL6Q5bbMamdAxATn/vcvaCIRvkmQPDq+TxxT8m0tk8xiw0vQII+Q==
X-Received: by 2002:a05:6214:5d05:b0:702:bb67:d4f0 with SMTP id 6a1803df08f44-702c574a5a8mr70500076d6.10.1751671292362;
        Fri, 04 Jul 2025 16:21:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ab9csm20191366d6.87.2025.07.04.16.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:21:31 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41BAEF40066;
	Fri,  4 Jul 2025 19:21:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Jul 2025 19:21:31 -0400
X-ME-Sender: <xms:-2FoaJfvnsuLNQNPdIUS4gDurppQlcxGStISqEP3jlZZjO8mC8nupg>
    <xme:-2FoaHPJF5fGZwJjL-Ul9GeNOC3Bd_UORg6PvXqBLoiokVAeRPKwZxz31cOn5asKm
    4wyVRGwtCMKsepFWw>
X-ME-Received: <xmr:-2FoaChwghtG2HJnsvao4w6Xt79DhyFerzB-qDdZtl5WBmMBUXWRcjqRBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:-2FoaC8dEUFcnef0udQarx6jb6o0JoNw0s3J0MuGlx2lmlTzc1LeCg>
    <xmx:-2FoaFtrGfpQ-sSZasDfGpuKCk7-L2EDBh-NgwSl2jux2FBDTJEx4Q>
    <xmx:-2FoaBEUEbaxtmkQYFSi5WKGmI-7VXD8_wmSnoVDKpN6NrEGtQn4ZQ>
    <xmx:-2FoaMNilo0pBkrB8G2urReG_qULQDEcS10pH181mmR9450O1mlxtg>
    <xmx:-2FoaOMLOJR894elT3vAzScE3B1gYc60MRdtdRFLxRu4oRXiNEUEdKd9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 19:21:30 -0400 (EDT)
Date: Fri, 4 Jul 2025 16:21:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <aGhh-TvNOWhkt0JG@Mac.home>
References: <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
 <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org>
 <aFrTyXcFVOjWa2o-@Mac.home>
 <DAWIKTODZ3FT.2LGX1H8ZFDONN@kernel.org>
 <aGhGDJvUf7zFCmQt@Mac.home>
 <DB3M1FEMKVLN.1BDAD6WHDR7HG@kernel.org>
 <aGhWBp3IhfJDhPOs@Mac.home>
 <DB3MYM27XOVT.2TNXQP9K1KK9I@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3MYM27XOVT.2TNXQP9K1KK9I@kernel.org>

On Sat, Jul 05, 2025 at 12:49:09AM +0200, Benno Lossin wrote:
> On Sat Jul 5, 2025 at 12:30 AM CEST, Boqun Feng wrote:
> > On Sat, Jul 05, 2025 at 12:05:48AM +0200, Benno Lossin wrote:
> > [..]
> >> >> 
> >> >> I don't think there is a big difference between `Opaque<T>` and
> >> >> `Opaque<T::Repr>` if we have the transmute equivalence between the two.
> >> >> From a safety perspective, you don't gain or lose anything by using the
> >> >> first over the second one. They both require the invariant that they are
> >> >> valid (as `Opaque` removes that... we should really be using
> >> >> `UnsafeCell` here instead... why aren't we doing that?).
> >> >> 
> >> >
> >> > I need the `UnsafePinned`-like behavior of `Atomic<*mut T>` to support
> >> > Rcu<T>, and I will replace it with `UnsafePinned`, once that's is
> >> > available.
> >> 
> >> Can you expand on this? What do you mean by "`UnsafePinned`-like
> >> behavior"? And what does `Rcu<T>` have to do with atomics?
> >> 
> >
> > `Rcu<T>` is an RCU protected (atomic) pointer, the its definition is
> >
> >     pub struct Rcu<T>(Atomic<*mut T>);
> >
> > I need Pin<&mut Rcu<T>> and &Rcu<T> able to co-exist: an updater will
> > have the access to Pin<&mut Rcu<T>>, and all the readers will have the
> > access to &Rcu<T>, for that I need `Atomic<*mut T>` to be
> > `UnsafePinned`, because `Pin<&mut Rcu<T>>` cannot imply noalias.
> 
> Then `Rcu` should be
>     
>     pub struct Rcu<T>(UnsafePinned<Atomic<*mut T>>);
> 
> And `Atomic` shouldn't wrap `UnsafePinned<T>`. Because that prevents
> `&mut Atomic<i32>` to be tagged with `noalias` and that should be fine.
> You should only pay for what you need :)
> 

Fair enough. Changing it to UnsafeCell then.

> >> > Maybe that also means `UnsafePinned<T>` make more sense? Because if `T`
> >> > is a pointer, it's easy to prove the provenance is there. (Note a
> >> > `&Atomic<*mut T>` may come from a `*mut *mut T`, may be a field in C
> >> > struct)
> >> 
> >> Also don't understand this.
> >> 
> >
> > One of the usage of the atomic is being able to communicate with C side,
> > for example, if we have a struct foo:
> >
> >     struct foo {
> >         struct bar *b;
> >     }
> >
> > and writer can do this at C side:
> >
> >    struct foo *f = ...;
> >    struct bar *b = kcalloc(*b, ...);
> >
> >    // init b;
> >
> >    smp_store_release(&f->b, b);
> >
> > and a reader at Rust side can do:
> >
> >     #[repr(transparent)]
> >     struct Bar(binding::bar);
> >     struct Foo(Opaque<bindings::foo>);
> >
> >     fn get_bar(foo: &Foo) {
> >         let foo_ptr = foo.0.get();
> >
> >         let b: *mut *mut Bar = unsafe { &raw mut (*foo_ptr).b }.cast();
> >         // SAFETY: C side accessing this pointer with atomics.
> >         let b = unsafe { Atomic::<*mut Bar>::from_ptr(b) };
> >
> >         // Acquire pairs with the Release from C side;
> >         let bar_ptr = b.load(Acquire);
> >
> >         // accessing bar.
> >     }
> 
> This is a nice example, might be a good idea to put this on
> `Atomic::from_ptr`.
> 

I have something similar in the doc comment of `Atomic::from_ptr()`,
just not an `Atomic<*mut T>`.

> > This is the case we must support if we want to write any non-trivial
> > synchronization code communicate with C side.
> >
> > And in this case, it's generally easier to reason why we can convert a
> > *mut *mut Bar to &UnsafePinned<*mut Bar>.
> 
> What does that have to do with `UnsafePinned`? `UnsafeCell` should
> suffice.
> 

I was talking about things like UnsafeCell<*mut T> vs UnsafeCell<isize>
not comparing between UnsafePinned and UnsafeCell.

Regards,
Boqun

> Also where does the provenance interact with `UnsafePinned`?
> 
> ---
> Cheers,
> Benno

