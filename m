Return-Path: <linux-arch+bounces-12790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF4B06797
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 22:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A14563B13
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3329B796;
	Tue, 15 Jul 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxQGQwt3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8326E70F;
	Tue, 15 Jul 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610443; cv=none; b=ZsNbD08vhsLZKeVuhBgTEwKAZt/1d3ozkXZV+TFiEIzSMm5l8xuSwkNU0HpvRsR0m6AvmAgfpe5cAMBrRnDgiio2A43psezwIL/72OxE18Wfr/szXKUu7hvMm+UAYNl0nG27U9+gOFcke2CE0/D/qZH/kENmTIG48PsuDnxzNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610443; c=relaxed/simple;
	bh=tUKIxIa3CaOakXSITwT1h1ZlJa811sXdettoWNZ629U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuaHhCCEYYuKxGsV/PtdhMPuehtLBUqikGDpk53qNlIC9GF7eifw5uammK5PxumH2/tthT/I2b3ZhJFBb7sVmrqh9pcy3TwvY5lxv1A8+w/5teS18kAr5ch91M7gtzj0mJRihbyJMOb3ir9VC1vCdm1u0u3HJrvGs2Npfv9fiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxQGQwt3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-700c7e4c048so96556946d6.3;
        Tue, 15 Jul 2025 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610440; x=1753215240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7xFafhakUM1HbJhSYPMWQX2H9PQ7AUwvEZGQtQZ7k0=;
        b=BxQGQwt3Lvgnz0itbNEh7Z4Gsuf95KuW8k/9IuYYs7QCBfZ7xDtKV0t2KTUWqGolwc
         vwpJO2/6Enf7ZsX1/Xdg8RjkbRwerV/RWxitG87qDzxC1Du2OJp2D9v/CmWi27Cx4CI5
         32EVKsTBPtniEyO+c6r9RQmRfJBOxbFrqJBd9BpuNWMvKiSYf2L59QMqO0/ICGn+xcG5
         6oli9trFrx2tBLic3wCBcNqH3U940ic+Pzk9VXVkuIJnedVZMwa3fQDrUoF9F5qbRCNG
         R0KFeuB+CFjgPrufkGIZ2XEe//FCCucIpjOjaDVlSDF4tGANNiFGqgga7EKw6m83uW4l
         qp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610440; x=1753215240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7xFafhakUM1HbJhSYPMWQX2H9PQ7AUwvEZGQtQZ7k0=;
        b=BeR1NxlGSoUu7e7jwDVfshbf4ekMthvr/ozFTGM4KmlswgZ8v4bsCrYWh9+G+UAZjh
         2TfyPbqa0Wbc8+E07p+yDA3+GL1qdUKW3rne6J2SRvIIPpkN2dpA3BFPfvpMAHpHGIVg
         sUSMvD6LZQwyUyzt4pftCu+ii9sGG6OvSPr3sBI46Psb8YhwyFWJcNKnf/7amQ8pq31j
         vyV/yYLc96hf2unVppGQ0zbFHdEA+tPxZgNi/9df3NTx7KTJXuKAJUoqaKEKujjcRCNu
         7sMUMa8ym8G9VPcrh1POI99DGWVBk/VcR3u/gXPM2ZQHV85cM/9FnNam64o8EkRd2Hkr
         4m7A==
X-Forwarded-Encrypted: i=1; AJvYcCVGLPi50w+GNsB5K1nPShM3KMR5Ecc+pf/aS47NtR5pQlsnfK9CWkiZJrKkZVQNTq8gk7WIi6RoY4YM@vger.kernel.org, AJvYcCXr3sd+HbFxllSMBLrbofUFcUDBYX1GnrVfx7OkH4UWJ+58Ai/hJ+NXZ+nba3zoep23T4P8nuNcmlDErsLCaVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhUwFvDRwqfy3Q66q4YS8txQ65coaMxBQD7T4ps1uodEHy5YD
	sbg8QdPYztz5ga37W40WN6xVMDNzLOfMlLCKVy4jqYqetLuv+1OpDYnB
X-Gm-Gg: ASbGnctUaSloGfs801V41NotY1xblNGuFXUx/RW9LX9lBwSJsHEK6MiyCzAWGECvm5O
	yw7JHln9pyCUdj1lz4WCXWLkm3sGcbJAUg/keEERLhNYgmJ36HaFy9qhq0z5WThID2UWxnsVGaZ
	M337QkDyAG+wATjQFGVHmWeafP4U89TX5BDaJpBxwAzeP8V053MuOMJ31g3ab2Ha0iuToq/pR72
	o7adnBKeALtFKJiUa2hm0TU/V5M9pl6gTQKY1oKTI93whFHxdD5eBnBK7TLz7kIXQ/hjPW5Wr1C
	AaTIlUeWlwkp4sjKVkriFLt7ZMi8TIsfbIoQWRXhNMyLGuTgqM9hLb5UEeQUC4oNE8WtkpbzuNM
	Tp9FO2TrFpt2ezr4GSBbcsP4V/FFhGu+M26Vy9sSzQEYH+z59I8uSmSP5ujKsIaYV1+krvotnU0
	QdO8VRk11CXsmB83wsvwE6ZoI=
X-Google-Smtp-Source: AGHT+IHrRn1XRiDw/2DyKdGpKsc5IOMs7BMfn8mm3TPOI8x/zXqt8VKyWJgjpZf3JENfhaBRucNqDQ==
X-Received: by 2002:a05:6214:3108:b0:6f5:38a2:52dd with SMTP id 6a1803df08f44-704f4ae09b3mr14680306d6.31.1752610440141;
        Tue, 15 Jul 2025 13:14:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d5bb30sm61431486d6.81.2025.07.15.13.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:13:59 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE456F4006A;
	Tue, 15 Jul 2025 16:13:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 15 Jul 2025 16:13:58 -0400
X-ME-Sender: <xms:hrZ2aOQguYBXCYizaoVh_Mdfktc64JY-qla5uQzihAIcsmn4VJuo4g>
    <xme:hrZ2aFRCYXZF_m5gyZBUzl32IIprvgIHmZOKsvsJS07eMn4NG_1kBOHPpfrpqawyK
    r-bQz9oT5e12j35cg>
X-ME-Received: <xmr:hrZ2aAYVgAoIF8GfhOOgZ1tIlsNhzL7Q5PTPwzqhKpVxgvO9q12jqzu7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheejiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:hrZ2aJgB5sSi041ryIYq-gU1d_POGyWNLM_6wC6wHezuv96sf4OD-Q>
    <xmx:hrZ2aFiVdHs4FKDuQO2lB7M6xJnVVjWgfcDUKUiyL67hbnrQDrfDKw>
    <xmx:hrZ2aPK8lNUOlcQNfk6yu80aGvui298V_azJ5IUmFGxRjDnWFpagIQ>
    <xmx:hrZ2aMXo3uwPapl6ZtLUT263SCHYrwnRdSMK-aYwOdXEMLJTGX2BoA>
    <xmx:hrZ2aB37U4kCta5eSQqRGpgMmr28HUYMGgU0WMHea8rCWctUAMCGcXld>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 16:13:58 -0400 (EDT)
Date: Tue, 15 Jul 2025 13:13:57 -0700
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
Message-ID: <aHa2he81nBDgvA5u@tardis-2.local>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
 <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
 <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>

On Tue, Jul 15, 2025 at 08:39:04PM +0200, Benno Lossin wrote:
[...]
> >> > Hmm.. the CAST comment should explain why a pointer of `T` can be a
> >> > valid pointer of `T::Repr` because the atomic_add() below is going to
> >> > read through the pointer and write value back. The comment starting with
> >> > "`*self`" explains the value written is a valid `T`, therefore
> >> > conceptually atomic_add() below writes a valid `T` in form of `T::Repr`
> >> > into `a`.
> >> 
> >> I see, my interpretation was that if we put it on the cast, then the
> >> operation that `atomic_add` does also is valid.
> >> 
> >> But I think this comment should either be part of the `CAST` or the
> >> `SAFETY` comment. Going by your interpretation, it would make more sense
> >> in the SAFETY one, since there you justify that you're actually writing
> >> a value of type `T`.
> >> 
> >
> > Hmm.. you're probably right. There are two safety things about
> > atomic_add():
> >
> > - Whether calling it is safe
> > - Whether the operation on `a` (a pointer to `T` essentially) is safe.
> 
> Well part of calling `T::Repr::atomic_add` is that the pointer is valid.

Here by saying "calling `T::Repr::atomic_add`", I think you mean the
whole operation, so yeah, we have to consider the validy for `T` of the
result. But what I'm trying to do is reasoning this in 2 steps:

First, let's treat it as an `atomic_add(*mut i32, i32)`, then as long as
we provide a valid `*mut i32`, it's safe to call. 

And second assume we call it with a valid pointer to `T::Repr`, and a
delta from `rhs_into_delta()`, then per the safety guarantee of
`AllowAtomicAdd`, the value written at the pointer is a valid `T`.

Based on these, we can prove the whole operation is safe for the given
input.

> But it actually isn't valid for all operations, only for the specific
> one you have here. If we want to be 100% correct, we actually need to
> change the safety comment of `atomic_add` to say that it only requires
> the result of `*a + v` to be writable... But that is most likely very
> annoying... (note that we also have this issue for `store`)
> 
> I'm not too sure on what the right way to do this is. The formal answer
> is to "just do it right", but then safety comments really just devolve
> into formally proving the correctness of the program. I think -- for now
> at least :) -- that we shouldn't do this here & now (since we also have
> a lot of other code that isn't using normal good safety comments, let
> alone formally correct ones).
> 
> > How about the following:
> >
> >         let v = T::rhs_into_delta(v);
> >         // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
> >         // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
> >         let a = self.as_ptr().cast::<T::Repr>();
> >
> >         // `*self` remains valid after `atomic_add()` because of the safety requirement of
> >         // `AllowAtomicAdd`.
> >         //
> >         // SAFETY:
> >         // - For calling `atomic_add()`:
> >         //   - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
> >         //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
> >         //   - `a` is a valid pointer per the CAST justification above.
> >         // - For accessing `*a`: the value written is transmutable to `T`
> >         //   due to the safety requirement of `AllowAtomicAdd`.
> >         unsafe { T::Repr::atomic_add(a, v) };
> 
> That looks fine for now. But isn't this duplicating the sentence
> starting with `*self`?

Oh sorry, I meant to remove the sentence starting with `*self`. :(

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

