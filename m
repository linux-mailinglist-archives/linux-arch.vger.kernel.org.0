Return-Path: <linux-arch+bounces-12639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547CBB00854
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCB87B2ABF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52D2749CD;
	Thu, 10 Jul 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agWVMjGu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E417A303;
	Thu, 10 Jul 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164181; cv=none; b=iaX+o/eMMR0XuxLjAcvuw04rF5WOJ6OdODYxB0b9T9JVyltp/2O8/h2CPEzFdmzpn70eKE1+S2wYANKrD9vHEk8kgRTSimsX3vJD8D9R/wNIkXJIUDqjUanS/k3o2jbAHj22yyCByuTnCZCT6nVfupJ/Y4kQcqFrjZpfAuco8hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164181; c=relaxed/simple;
	bh=qJz6fbDEwKR2n0fhRoYqJTEv9xrZ4rc7vxiYqtlCqFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm6HLeyXoogIyrc/z7NJcM2lPoXmuvboVr8+05JrslTkZ3Kg1OuZqPwDm5RaUHhHWw2zO15O07lEBf2QlkQHDoYDuXHhpAkmKvODexMdr3n2mGzl21nJScOpTaq9yc6uzXc+pJwk2qhom9axeRtAjt6BR+pf11Zkp6645CEVAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agWVMjGu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d3dd14a7edso174101985a.2;
        Thu, 10 Jul 2025 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164179; x=1752768979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e38L05MDqdYlj/kHUFQccsi1c7uERaQIJKOoZdkmzQ=;
        b=agWVMjGurqRtKQHzJzRqyURIzAiIHNpzOkrXPNq6O10eb/XWNjV3fnl+0MLctesUOS
         /3Za563UwUz+yMr7tUz2hl4t/enHDSSACymj2h8bm3/3ZPEeBJI214PkW5pcmU6Cxlon
         fazaWr/Jx/jNNM+AdUFE2etbqZXdidL2yyyPfNki+Y1R8AFBt/EENPsnovk5e0DCrCjS
         41BfUV1DtFw8yoLRs4b5g0ZQ12n7s6LlH133N97bpVCdhNOF3HQsMreMtdSzRV7+H2ji
         UhfgHmGhkSEWnhaJpUJu9C6Q9+A7GWrw5ls1OHElxp5Z3RJjmdTXoesgUm4ZyCJKQ2I0
         RhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164179; x=1752768979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e38L05MDqdYlj/kHUFQccsi1c7uERaQIJKOoZdkmzQ=;
        b=Ub+81sPdnDTqals2GCGaBi6zUXE+3e92hbUYfLI1PVz9bzU73AtdXq0FCFurpHcp2O
         bMcpUIMzOtP1jpDh3+w+9uWhL5Ud7Ge5MpRXhjM9dQVDRHTBSrMwIyfqlHo2fIgM1sPh
         2Uh8XEm2JpryXfe1i4DzlPuvNQfvA88lF1myRdmG3y0RNisWw1U6sgPzvwtar9GbPdZN
         aiUMlLJ1Wft99Nk6Rawfbn42AuSNnIcKEyOMIXmpgPOLXSsUOaZdsdSk0w5AmNpIvUM+
         XGtQi0SI5kftPYX0g+SU5bzNRpgLyd4HIUPm8fohFr4ynQrez00/GyJsmw7J5BaFQXWL
         SF7w==
X-Forwarded-Encrypted: i=1; AJvYcCW+9NJY+eMP70R20QXQ/lo+32SrybdHDyAsuDZk9LTf4xHZzAdRio7SEqp5ppfbOXoiCs7vYA1PoLBJN9cz+yA=@vger.kernel.org, AJvYcCXpJaQLUvugQtYmXn9Y63lWQESwMqFxV/IvAalIDIVgt8yFnOwvqayB6p8dFPM7qVKS57fVWx/woXcB@vger.kernel.org
X-Gm-Message-State: AOJu0YzeX25Alaz3c63xBdq6XIUhuID9MdjR6jAJj0y10EGrVzpWVrfy
	QmWxrF6xpp+yG305n+HIAQbHCE31EjKB2tY52AbGytY/JzqVKoSIkXLN
X-Gm-Gg: ASbGncuIFXAYafEs62cj8mQO4f1Lzn1G7hMejyNwfzkSAjB3HGzSH4IVi6InSd0ve/P
	RZ2aC91AMTsshCSlvez3hmezA+trbRlqUkBQ0qsXGyy5hHVy/u5oAmsD/Pi5GOGh1zbCXvhjYlZ
	hkqubbW33x1fTcbqdm7CEhPxkOOWZ1nSLEWCcb2cvYSs7enIm2wTix11l66k+w6kx2NRYoKtGCN
	jrT/sEzXxB608gSfWtRfmQ6xNtFu/bdg5xjfAD4Dom0nHL5kQ5nxN6FbJ+DAQVKcvG0AsAbZob7
	OErvVGTj7vqLpykgkaTe5TheraGBuCSR6mNYWfdh93DkNEptVuaY7BhKMfDLAuiyIkSq+aQNLv6
	//53msnDpxtgEGFCyQ8Rea8g1HrRbkdaymDF9mv6R2Tg3ywIWkno8
X-Google-Smtp-Source: AGHT+IHJozt3f+ojIXaL0YmFLWxTUamIZY9TjGksGKQkUrOQV9kg9o5Js9x38WbBIRg4VOWyeYCXew==
X-Received: by 2002:a05:620a:3726:b0:7d4:451:b8cb with SMTP id af79cd13be357-7dde9b5e387mr16954485a.4.1752164178277;
        Thu, 10 Jul 2025 09:16:18 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdebeb7fasm110680985a.109.2025.07.10.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:16:17 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 34CD6F40069;
	Thu, 10 Jul 2025 12:16:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 12:16:17 -0400
X-ME-Sender: <xms:UedvaAZzkqA4y-cGMCDXhpnP5iUm7BEXqqGZ0eUqDCTSALRe49hJKg>
    <xme:UedvaM7GC3k1K3EeNd_1dLbW8KFVJom3BlpOnEXM0NDKo10dLzU80gt52cAFyO8Ws
    v4q1uC6yHqSxTlP7g>
X-ME-Received: <xmr:UedvaPgYmEx6Hjh4M-dt6OV_SzTufwnw2GgvL_ZqOLOG-PFgxQSlK10aCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UedvaKIbw_sHaSckgITENpmw56Jjxg6e8QxxTssYV4es8AlV5ddMAQ>
    <xmx:UedvaJqnNSqPoM8DT1t1bKQi0m22-aumA3PfFbujDO8bkh7SoOohYg>
    <xmx:UedvaAzPCMXdsGHR10Wv25vwkPCt4m5eysWGDiSlx34Xt7hgapAl1Q>
    <xmx:UedvaNf5hWVSwyquZXYio9wVymOgYsWVBCoYi5YXTeaDwoaunvBkAw>
    <xmx:UedvaMdrZFotRxzxKBSQ7xt2JlnMdNGnIWZMFnBUhOZvMNlJ2lnxViCs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 12:16:16 -0400 (EDT)
Date: Thu, 10 Jul 2025 09:16:15 -0700
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
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <aG_nT3H8J-h2qwr5@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
 <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org>
 <aG_Yah5FFHcA3IZy@Mac.home>
 <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org>

On Thu, Jul 10, 2025 at 05:46:56PM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 5:12 PM CEST, Boqun Feng wrote:
> > On Thu, Jul 10, 2025 at 01:04:38PM +0200, Benno Lossin wrote:
> >> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> >> > +declare_and_impl_atomic_methods!(
> >> > +    AtomicHasBasicOps ("Basic atomic operations") {
> >> > +        read[acquire](ptr: *mut Self) -> Self {
> >> > +            call(ptr.cast())
> >> > +        }
> >> > +
> >> > +        set[release](ptr: *mut Self, v: Self) {
> >> > +            call(ptr.cast(), v)
> >> > +        }
> >> > +    }
> >> 
> >> I think this would look a bit better:
> >> 
> >>     /// Basic atomic operations.
> >>     pub trait AtomicHasBasicOps {
> >>         unsafe fn read[acquire](ptr: *mut Self) -> Self {
> >>             bindings::#call(ptr.cast())
> >>         }
> >> 
> >>         unsafe fn set[release](ptr: *mut Self, v: Self) {
> >>             bindings::#call(ptr.cast(), v)
> >>         }
> >>     }
> >> 
> >
> > Make sense, I've made `pub trait`, `bindings::#` and `unsafe fn`
> > hard-coded:
> >
> > macro_rules! declare_and_impl_atomic_methods {
> >     (#[doc = $doc:expr] pub trait $ops:ident {
> 
> You should allow any kind of attribute (and multiple), that makes it
> much simpler.
> 

I didn't know I could do that, updated:

    ($(#[$attr:meta])* pub trait $ops:ident {
        $(
            unsafe fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
                bindings::#call($($arg:tt)*)
            }
        )*
    }) => {
        $(#[$attr])*

Thanks!

> >         $(
> >             unsafe fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
> >                 bindings::#call($($arg:tt)*)
> >             }
> >         )*
> >     }) => {
> >
> > It shouldn't be very hard to make use of the actual visibility or
> > unsafe, but we currently don't have other visibility or safe function,
> > so it's simple to keep it as it is.
[..]
> >> I'm not sure if this is worth it, but for reading the definitions of
> >> these operations directly in the code this is going to be a lot more
> >> readable. I don't think it's too bad to duplicate it.
> >> 
> >> I'm also not fully satisfied with the safety comment on
> >> `bindings::#call`...
> >> 
> >
> > Based on the above, I'm not going to do the change (i.e. duplicating
> > the safe comments and improve them), and I would make an issue tracking
> > it, and we can revisit it when we have time. Sounds good?
> 
> Sure, I feel like some kind of method duplication macro might be much
> better here, like:
> 
>     multi_functions! {
>         pub trait AtomicHasBasicOps {
>             /// Atomic read
>             ///
>             /// # Safety
>             /// - Any pointer passed to the function has to be a valid pointer
>             /// - Accesses must not cause data races per LKMM:
>             ///   - Atomic read racing with normal read, normal write or atomic write is not a data race.
>             ///   - Atomic write racing with normal read or normal write is a data race, unless the
>             ///     normal access is done from the C side and considered immune to data races, e.g.
>             ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
>             unsafe fn [<read, read_acquire>](ptr: *mut Self) -> Self;
> 
>             // ...
>         }
>     }
> 
> And then also allow it on impls. I don't really like the idea of
> duplicating and thus hiding the safety docs... But I also see that just

At least the rustdoc has safety section for each function. ;-)

> copy pasting them everywhere isn't really a good solution either...
> 

Yeah, perhaps there is no immediate resolution, but open to any
suggestion.

Regards,
Boqun

> ---
> Cheers,
> Benno

