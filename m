Return-Path: <linux-arch+bounces-12577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD15AFA0B0
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE171C2589A
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535501EE032;
	Sat,  5 Jul 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfFeATXw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A667190664;
	Sat,  5 Jul 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751729932; cv=none; b=lPRdpq0HDZvJoyWpLIIAjscZpa/WeKzf6popn32C4+O8vxCYXinROOj2eO6rHiiLW7lYDDP6vaWLu8g8quQAmV7qGa+5bTnpPJ0ABexlciAJlt2tMa9jrZu8JPDomCqE2za+1B/cglntCcu1YAvAcIqiVdypBJIuIOhXV0HY7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751729932; c=relaxed/simple;
	bh=w/4wCIHiOILIKKaO3uWJyM2k8QFdMpFi1NUieOzGBYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmrg88uVtaJ2zXLP722E4n1B4BZQXIUKk63VUwvl4grzJ083GkJkIhKfHalldvauNrEkMz7HHLKx3KgSLDUM71tjRK0Uxd/k0Ej9Hl6oJyvjS+5etQLNH6wip+lekJzxybZIcntyNV+WWJG1/wRPl/lQqcjnXKVRlrUKzP9lvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfFeATXw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a43afb04a7so13507761cf.0;
        Sat, 05 Jul 2025 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751729929; x=1752334729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ/sN9PcRmYb2xZcV5QzwVvcoPQL3EnCzeZjvTEzM18=;
        b=JfFeATXw9wHkOGE+Ir1KBzsd0BhB7y1Wn6vg8f15059JsssJ/loktroNIZHAdrZUAK
         tsBmM6iGDl/oGam4P9kakybFzuF8LVyuntZnJsHR4inDAvODFLeyRkhus7Uu1pPLpnml
         DkjLcaNliQgUTa2vr/bVRKzq2CXu76KVdbANPel4lHIob2Oe9xXkdbzzfhZREWXmYmzO
         Vtmu2FMUxfkJkwBUKd0qrS8A+aFiMGZfbsehh2o6B6/t0Qkizob5AS2FO55osfV4MBUS
         cbTkSbuGsz9XddEc7hSxEuMZS5i4oCbv1CYWQZMt5epAk+F0oyPJALK4kE281ysvybiY
         MQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751729929; x=1752334729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ/sN9PcRmYb2xZcV5QzwVvcoPQL3EnCzeZjvTEzM18=;
        b=i8AAbSfbRJ2Kcz6F5egC9HsxYr8c4coK7Ze8ieEapoTMjPnp2lRzWzYELM3hg2/jfQ
         YGZbX21vOHtvHOuZaSmEGr70gQKZy83h3BOPYd6DXwuns9Kjz2+JjzZu7bGoTzlZNVQU
         NVEX7qLwNOjb0H3jRnryhtnNfJ/Ycj0SuJrdCL1aJSIy78c1BQhY4EQV9mqN2ozO6Fx+
         rGgApcnKUleRJnahDqS1mauo7aWbPxPaRuITGW9z5EhMGwQpYkEdAMfH2R4Qsf+ySd51
         ThIYFz7ZLue7DGqaeVaoTfas0Sy0XY/j0RMOm2skX5KlfUi7tKl+35JzYXYBo5508OV6
         6How==
X-Forwarded-Encrypted: i=1; AJvYcCV0NkkJWciVrpCXuJoQ+uJlPwWvBO2GqjYBV45jntiXmXU94radLn4mfzczugB6Z13g46JAWYzXh7PV@vger.kernel.org, AJvYcCWX5q3IqrV+dBlA8J69OJ+55fV5qouxfU30JFqzyjwSecvdWAN15ZZM/KZVetmXhoJ5o3si9060P9KbVxFjQC0=@vger.kernel.org, AJvYcCX4Y8Xm0QpEm7X+XSYVqQ3MDADzwai9GxN9kt9YuRaB+JaEp7xee6Z3bvbaISfEqF7G/FXpP5+3+9EZr7o4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/76LoiGljAfO+DqV+YcRlvyj6VHJbwryQnuh1LhylQ0RxkPi
	CjOXvuqI2OCUy3EBsgz8G8ujPLsaE8sMSBSNM5C/IshA6cpGzmxOmwNP
X-Gm-Gg: ASbGncujoCU/epLXdA3jhPsIqUVy+bd7GRhZvId6vJJmZ5VYJ+jFipLjmPXk7JhDsdd
	6VVI3yK8T7cjfBkxsCH0/W6DTHcRAQ8XEqkhknwMQjX/uUy3ikId963iXVpu6J0mGDbFgxSxMBs
	M0nQbVJxPF8sVI0YrDFxvcV0cbM9KiTmhQtjBNqDLGv8/DHWD+SZ0T1M8dzz/cgo4b3T+qwmfWU
	vRpmWbrGKJAPD5ngcFX8X6wuHn9fgiXHaV3D/Gdcm1UGd2c/wJO8kPUJzNvlWylV9J1nNpayiLs
	LdJEyGi+FKXECiQtvp7ndzZuQsQFyFCBXyxRubHvKmihCQYI4GvxjHwU2Js20RRuS/UKTXAO3Wi
	hSKrMy2GmTybdXBDpV8T0/HBm9MtKyb0S034c2ah9PR3+mFT7qWeU
X-Google-Smtp-Source: AGHT+IHHL3ASU6E+ZFGjAUSSw8MAtj8MqQKtAXgxglUudRNSb0T3m7GA1wjGTuBfhU+3i1PbN0FVyA==
X-Received: by 2002:ac8:5e4c:0:b0:4a7:1401:95a0 with SMTP id d75a77b69052e-4a9985fb1efmr80488841cf.2.1751729929224;
        Sat, 05 Jul 2025 08:38:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e1ebsm32428561cf.59.2025.07.05.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 08:38:48 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1CB3F4006A;
	Sat,  5 Jul 2025 11:38:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 05 Jul 2025 11:38:48 -0400
X-ME-Sender: <xms:B0dpaNimO6K0-B0n5C_YLNI9P_s-iGWW2Lef8H1vDMcvo6SyNP0Tog>
    <xme:B0dpaCA2YhIhPsXfSiVjgZs03X31GWmAkZkZ6AHLGlItDl1KA_htQdKRduUXI61iQ
    BoEx3c_z2TIdY7qxA>
X-ME-Received: <xmr:B0dpaNEjUq210UAEMj0F1QwuBe5DIRTYiHvlOsu7dJEwZQdcwTP10IT4bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvieegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghjoh
    hrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:B0dpaCRyth8SKKS8vPob41UvF3jXdic9JSmUREsRFh2Auk4fB1d9vg>
    <xmx:B0dpaKy1rhj1W45y0sJtO6DZFP_TS35g1o3vXj5pN1UC62JxWKQJTg>
    <xmx:B0dpaI5-Ep3QQYm_vwQ8ZPs6rpDc9bKXq7c0UPCbj_tipsdkPZFZhg>
    <xmx:B0dpaPwHGcDlwPB3nLWeEQGy5PwAz9BnR9pGCNVJ10UQj0waolf6Cw>
    <xmx:B0dpaCib1TTHSYgcqGKyvfgP95y_JWQS98B3QWk0b-LDSO0kUtypeLfb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Jul 2025 11:38:47 -0400 (EDT)
Date: Sat, 5 Jul 2025 08:38:46 -0700
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
Message-ID: <aGlHBqoqTA2PCXbJ@Mac.home>
References: <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home>
 <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
 <aGhFAlpOZJaLNekS@Mac.home>
 <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org>
 <aGhiEZ4uNzEs4nah@Mac.home>
 <DB3YRHR9RN8Z.29926G08T7KZ0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3YRHR9RN8Z.29926G08T7KZ0@kernel.org>

On Sat, Jul 05, 2025 at 10:04:04AM +0200, Benno Lossin wrote:
[...]
> >> >
> >> > Basically, what I'm trying to prove is that we can have a provenance-
> >> > preserved Atomic<*mut T> implementation based on the C atomics. Either
> >> > that is true, or we should write our own atomic pointer implementation.
> >> 
> >> That much I remembered :) But since you were going into the specifics
> >> above, I think we should try to be correct. But maybe natural language
> >> is the wrong medium for that, just write the rust code and we'll see...
> >> 
> >
> > I don't thinking writing rust code can help us here other than duplicate
> > my reasoning above, so like:
> >
> >     ipml *mut() {
> >         pub fn xchg(ptr: *mut *mut (), new: *mut ()) -> *mut () {
> > 	    // SAFTEY: ..

Note: provenance preserving is not about the safety of Atomic<*mut T>
implementation, even if we don't preserve the provenance, calling
`Atomic<*mut T>` function won't cause UB, it's just that any pointer you
get from `Atomic<*mut T>` is a pointer without provenance.

So what I meant in this example is all the safey comment is above and 
the rest is not a safe comment.

Hope it's clear.

> > 	    // `atomic_long_xchg()` is implemented as asm(), so it can
> > 	    // be treated as a normal pointer swap() hence preserve the
> > 	    // provenance.
> 
> Oh I think Gary was talking specifically about Rust's `asm!`. I don't
> know if C asm is going to play the same way... (inside LLVM they
> probably are the same thing, but in the abstract machine?)
> 

You need to understand why Rust abstract machine model `asm!()` in
that way: Rust abstract machine cannot see through `asm!()`, so it has
to assume that `asm!() block can do anything that some equivalent Rust
code does. Further more, this "can do anything that some equivalent Rust
code does" is only one way to reason, the core part about this is Rust
will be very conservative when using the `asm!()` result for
optimization.

It should apply to C asm!() as well because LLVM cannot know see through
the asm block either. And based on the spirit, it might apply to any C
code as well, because it's outside Rust abstract machine. But if you
don't agree the reasoning, then we just cannot implement Atomic<*mut T>
with the existing C API.

> > 	    unsafe { atomic_long_xchg(ptr.cast::<atomic_long_t>(), new as ffi:c_long) }
> > 	}
> >
> >         pub fn cmpxchg(ptr: *mut *mut (), old: *mut (), new: *mut ()) -> *mut () {
> > 	    // SAFTEY: ..
> > 	    // `atomic_long_xchg()` is implemented as asm(), so it can
> > 	    // be treated as a normal pointer compare_exchange() hence preserve the
> > 	    // provenance.
> > 	    unsafe { atomic_long_cmpxchg(ptr.cast::<atomic_long_t>(), old as ffi::c_long, new as ffi:c_long) }
> > 	}
> >
> > 	<do it for a lot of functions>
> >     }
> >
> > So I don't think that approach is worth doing. Again the provenance
> > preserving is a global property, either we have it as whole or we don't
> > have it, and adding precise comment of each function call won't change
> > the result. I don't see much difference between reasoning about a set of
> > functions vs. reasoning one function by one function with the same
> > reasoning.
> >
> > If we have a reason to believe that C atomic doesn't support this we
> > just need to move to our own implementation. I know you (and probably
> > Gary) may feel the reasoning about provenance preserving a bit handwavy,
> 
> YES :)
> 
> > but this is probably the best we can get, and it's technically better
> 
> I think we can at improve the safety docs situation.
> 

Once again, it's not about the safety of Atomic<*mut T> implementation.

> > than using Rust native atomics, because that's just UB and no one would
> > help you.
> 
> I'm not arguing using those :)
> 
> > (I made a copy-pasta on purpose above, just to make another point why
> > writing each function out is not worth)
> 
> Yeah that's true, but at the moment that safety comment is on the `impl`
> block? I don't think that's the right place...
> 

Feel free to send any patch that improves this in your opinion ;-)

Regards,
Boqun

> ---
> Cheers,
> Benno

