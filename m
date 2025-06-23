Return-Path: <linux-arch+bounces-12434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD364AE4D4A
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 21:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45277A4A96
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C42D5415;
	Mon, 23 Jun 2025 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw2ahumo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DE2D4B5A;
	Mon, 23 Jun 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705767; cv=none; b=IMAgK8zsnbj3k55T4x2WXlBSK1/nfdgcN/n45K0eD4MNZ+aRCuhdoyiKTOfwA7EhsecwLnPaVlfK1+TJ31MQxHwMkaRMC2YenUedtj0iH99dabTBYPWvTtsMr5Z2jX0ZK85fH++fsIkKXDHveH1L6AET4c8vfmGlSYKPBAa35rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705767; c=relaxed/simple;
	bh=3aUrTipdBM0DvG+bnkRlIqVvv9Fl0CJzrYFcGMsX7+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcq32xGTd8N5MThI8ZqwJhb/dTJkKFt3WUtjpMrViaP4klCb2uZU+MdlRLEe3uZvflzUaO/RSlZ54OlZrkd34X18/BrxbyGw5jEqCaYTlCrsl4ki2f9BrtLGigFMnS3TcfBElAYmHvFxGMaZdbNUYkOP2vmEwTJLoZptX5Gd/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw2ahumo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so512398485a.1;
        Mon, 23 Jun 2025 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750705764; x=1751310564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sms7B4y2rI1NnoG8cKJvlxEFKP61lyDQPa3zPMR/0k=;
        b=mw2ahumoqwXGFj88rCaLZ8MlrJwp0k3y/47i/4c9bc0Jh+fjJbHpQ4w/W2JutkjTVI
         OO7Rcaj5kgO6GQss5mAqWYFB50mI9uMSrdK47ejW0D2mJXEZnrsLRzc/n2MXBB+24C1o
         r+I1MYn/K0d6BPD1kiHTGveFwIhvm1KyPx+9LFJqz0DNMQdW2SwJEC8vnIY9Eouz8mNx
         IhDDOI8tCUYUhNZbyaXB8m9tuLfEI8pZS4aPOFpOKhLVv8nDP4wtDThyfzfpgDlMs4Zl
         Pbu33uK9hN7CiEGFt2ZeXQlKFb+rg7g3CiZcW61/vlVVhPWAdJmTWmDgqtTjh12SkvnF
         eyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705764; x=1751310564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sms7B4y2rI1NnoG8cKJvlxEFKP61lyDQPa3zPMR/0k=;
        b=bTanNossIFRMIMukqjX6NU/0I9Wptzxgv/JuYz7mrvCgEgL0xz2KTKfzl5KpvkaKYV
         GbckFIuv33JOdb81pE6SSLcWrNC0o3ojrod8UFuNcti0rusyQR5D3MS9xKnfrHbFioJy
         cM9O8cVMgH5E/vvp5s/VDCFdHiWboqqG7RXb6w2j1uO0/RKzJpsGsWckJ3X+t5dKbCtA
         MDHRnwIgINUfzRidd24qY5ksUwnTcijfeUfN1gBohv9+05JlebtNO6oN/IW8OdbIzCBS
         Obe7ZpZVH3uRSJdlOKlLrqU5PSSo8ZrKYrE6pA620kZcGKnTqF9FaVMyISC+0RP6nrMJ
         Pa8g==
X-Forwarded-Encrypted: i=1; AJvYcCUoBSI+gHNrUnnO/J63iji0BQsD1lE9YDA7yzc0P5I2oZUz4AmF75+kNrIqpNotbeiIX+6bzWY08CqC@vger.kernel.org, AJvYcCXgMMrP+SV2itPj5lfL4s4pvcT5z9xj8DaUd6CmqTc0f7o7obJDcLep9R4manrTT1WlrIafgAxILOi5v01wpqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfk/AIsgaJ9dUNrmUfL1LSriewdf/Q09SVOvtbReUrGYHH5HR
	wxDHVBp497TpUQW2E1blmL+nvRbLy4LTlbGiir7tJ2IgNJvV+TU3w41Q
X-Gm-Gg: ASbGnctPzHehyIfOGiTLuK24kGj5T3aCpUzTOLQ2UtKS1CJVU7+8C3yRPn22oQSt92x
	T9LjI3Ir2X6glzsWetCQnLsIhZIDe2sbzD3z32sxT+mFmF6ZcO71iyAUW9tZ6K1QUZ0m4TWhZnu
	FaDbpj9aBUyzcKYIHRu+HyQGZOVGN1w1vgh64tv3f7xe2dYRqhGuxGDy2VJZx49RpaJiuSLnaad
	uperbzW2t4r6LUGdX+F0xgnRkCd39ksSvPWraK3hMQZmDzvV6aEitOdlGFqAdhJtz2h5NCFpBdW
	WPg4wr5rsF7r386YhCYar+OhCEhKbfwKSNIMYQYoheJUcqf33FgN84Q0XfQ//AD6lQLksXgWIeC
	RHePelwJvLHTSiW46ukOu1PhNZ+JmlLNFYgK8E3KGTk2SV68EqBa/
X-Google-Smtp-Source: AGHT+IFY0SLaBFXkzJuI5EVp2A8p77EVAtcc7Ba+/G4JrsIRg5C2bcRBKquGlsSNvaGt38E2kEU+VA==
X-Received: by 2002:a05:620a:a811:b0:7d4:2f2:a44f with SMTP id af79cd13be357-7d41ec42108mr75415285a.23.1750705764284;
        Mon, 23 Jun 2025 12:09:24 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f9a06e6csm417860185a.107.2025.06.23.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:09:23 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03AC51200043;
	Mon, 23 Jun 2025 15:09:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 23 Jun 2025 15:09:23 -0400
X-ME-Sender: <xms:YqZZaO5SpQ3ZYuDdTaKH5kB30Vw-FyLc6Yo3ZNurN9fFUzDEgjGWdA>
    <xme:YqZZaH4_RHd_4UfZiShZ9a8h7m6h9NvzVMvq7sNUmSh6czwiF6R2HHQpAGpmd5DQl
    9rM5A_rNoo_rejFJQ>
X-ME-Received: <xmr:YqZZaNeUotxMrc1oYdOTAFQK3P-p0l5x5Il1IjTDHSUdb29ropMaFwlhjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhf
    ohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmh
    hmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtph
    htthhopehlohhsshhinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YqZZaLL1CfAXc78MDA_HThZsiJOPaWHUppguaQkdRm9DUhUflQQisg>
    <xmx:YqZZaCJNVz_4kAieWRiIGwQyaCPFGdUIRxabiWXcn4lQl5M6Kb2cUA>
    <xmx:YqZZaMz_tn-HXO3gMGH-g_JWzL0un4BBTs_BCC4F01eWizUo06qO_A>
    <xmx:YqZZaGLDafVPWyCiDz1UCxnuVGeU8PLYCdkkf8udWtei4dvkyceIAQ>
    <xmx:YqZZaJYJm6b2b0uOCNY-Kh5jD9JR1ggYaNpgaSRjWY1IN-OdIEc3h9f8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 15:09:22 -0400 (EDT)
Date: Mon, 23 Jun 2025 12:09:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
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
Message-ID: <aFmmYSAyvxotYfo7@tardis.local>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623193019.6c425467.gary@garyguo.net>

On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
> On Sun, 22 Jun 2025 22:19:44 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sat, Jun 21, 2025 at 12:32:12PM +0100, Gary Guo wrote:
> > [...]
> > > > +#[repr(transparent)]
> > > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);  
> > > 
> > > This should store `Opaque<T::Repr>` instead.
> > >   
> > 
> > "should" is a strong word ;-) If we still use `into_repr`/`from_repr`
> > it's a bit impossible, because Atomic::new() wants to be a const
> > function, so it requires const_trait_impl I believe.
> > 
> > If we require transmutability as a safety requirement for `AllowAtomic`,
> > then either `T` or `T::Repr` is fine.
> > 
> > > The implementation below essentially assumes that this is
> > > `Opaque<T::Repr>`:
> > > * atomic ops cast this to `*mut T::Repr`
> > > * load/store operates on `T::Repr` then converts to `T` with
> > >   `T::from_repr`/`T::into_repr`.
> > >   
> > 
> > Note that we only require one direction of strong transmutability, that
> > is: for every `T`, it must be able to safe transmute to a `T::Repr`, for
> > `T::Repr` -> `T` transmutation, only if it's a result of a `transmute<T,
> > T::Repr>()`. This is mostly due to potential support for unit-only enum.  
> > E.g. using an atomic variable to represent a finite state.
> > 
> > > Note tha the transparent new types restriction on `AllowAtomic` is not
> > > sufficient for this, as I can define
> > >   
> > 
> > Nice catch! I do agree we should disallow `MyWeirdI32`, and I also agree
> > that we should put transmutability as safety requirement for
> > `AllowAtomic`. However, I would suggest we still keep
> > `into_repr`/`from_repr`, and require the implementation to make them
> > provide the same results as transmute(), as a correctness precondition
> > (instead of a safety precondition), in other words, you can still write
> > a `MyWeirdI32`, and it won't cause safety issues, but it'll be
> > incorrect.
> > 
> > The reason why I think we should keep `into_repr`/`from_repr` but add
> > a correctness precondition is that they are easily to implement as safe
> > code for basic types, so it'll be better than a transmute() call. Also
> > considering `Atomic<*mut T>`, would transmuting between integers and
> > pointers act the same as expose_provenance() and
> > from_exposed_provenance()?
> 
> Okay, this is more problematic than I thought then. For pointers, you

Welcome to my nightmare ;-)

> cannot just transmute between from pointers to usize (which is its
> Repr):
> * Transmuting from pointer to usize discards provenance
> * Transmuting from usize to pointer gives invalid provenance
> 
> We want neither behaviour, so we must store `usize` directly and
> always call into repr functions.
> 

If we store `usize`, how can we support the `get_mut()` then? E.g.

    static V: i32 = 32;

    let mut x = Atomic::new(&V as *const i32 as *mut i32);
    // ^ assume we expose_provenance() in new().

    let ptr: &mut *mut i32 = x.get_mut(); // which is `&mut self.0.get()`.

    let ptr_val = *ptr; // Does `ptr_val` have the proper provenance?

> To make things cost I guess you would need an extra trait to indicate
> that transmuting is fine.

Could you maybe provide an example?

Regards,
Boqun

> 
> Best,
> Gary

