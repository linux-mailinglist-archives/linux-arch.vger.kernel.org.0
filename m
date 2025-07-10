Return-Path: <linux-arch+bounces-12634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E0B0057C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25823160D71
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4091B78F3;
	Thu, 10 Jul 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhqrnv+6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187E27056F;
	Thu, 10 Jul 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158582; cv=none; b=BzHSMm2Eg4KgCi16EE5AlyQEAeaEC+e9uCjKFmDHNsyj3nKh2qPPOOQvvkHkm/e5CxnX4HnCg1g5/On8nf4muhWAoXir1tKZa+lPRBqNILRuv06n5Y9fsa6frzORjpQ5kYA4yLlJEToxFI8cjdbr4gmzSzZYfZilT/HYQrDOF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158582; c=relaxed/simple;
	bh=5szyi6yH0oGGrfKIg9Xi5xiZ5wKO/TDCmsZjQgVklsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT7mKNZssvShnCQzYuYin1tTJEAZvBksjuHXufTdxiNxYX/FP/HlPtCsbp7zLSkZ06Dl40MLGFjfOjxEKsa0KqcoCPt0IPloEUS4IhBetMJ9nuivlXSPrOiklMFEkQmOYGnB9xQhjEpg7lZ8zCvQ/RkvDK/oE7iH6NUyyVUUg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhqrnv+6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fadb9a0325so8812276d6.2;
        Thu, 10 Jul 2025 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752158580; x=1752763380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4R+5ty4AWv2gsK8CU8Hv/60eryRGjAiYmsZeghCD00=;
        b=dhqrnv+6RRWhQ0go3+hNNlLLLEJsKgIAJvKXtYK/MhCRhCymFAQHlox0ulxFW4+J+Z
         ybuQLBN0bRC/c0A4GUWmO+RO/giS1KFcIo7sePOl63k0WMrZU/S1FPFKngNVgUm91KgY
         cw8iQjGplZjMoNk6bCBHXcPup7OosYaQfjYm9i9WJAz7GWOVEydtcyn7ZqzPkKoCM9Lt
         MR85WWQ3/MFaHsTMCWXlVWpDX+fDYAhhXno9gvLEt4IrbPVzzDEGHG6fjT3qAJNH+wL3
         RDetdf0OBYb5yQcqVDzzRI1JLlr/6ysecjqEoFYOLncR9V57LLhB6lPDSMwxoNy5F/nE
         RWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158580; x=1752763380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4R+5ty4AWv2gsK8CU8Hv/60eryRGjAiYmsZeghCD00=;
        b=KHQZo8qLjxIlKOtyHpKlP4MBCMYMupY/cB7v7Sq+zpDBZ9ryNbKfFfIW3pmmfaZN29
         yb5ML5i5H0LyHHtmhtrJtg2WsegMbIy9J8hzYCf9mT2D7sSRgXMtdpZ9l8o43iO6twJe
         nwg/84RGibA7/qcu23gqFhSzLAUR/+aT4gQIbXpWcWv/0cqq4HZ9Y6W8bR6EWLocWVA5
         hnNg8f4J6ejjPjmsNYA0idteINGtoIzeJOTAGF+FtDiVxF6yN8bAtH5Lvf+wBTfd0UHo
         GPOimvFWBLYTrDg/6CUPkuSVPVnmCGiQxMT5uncEjWgraxAhAhTf+CpXjDHmIJPpE+bl
         K9bg==
X-Forwarded-Encrypted: i=1; AJvYcCVUlPSxAMwsN7kFUTxhXl+63rIbnssTtm8oZYbfurtGsFVbKuCym1cZs+BJ6qqRfam8log4b8kSQQy2N+hA@vger.kernel.org, AJvYcCW7ffr7NqktxGhhoLJOuzbxCzWSQVFXOwFPkUljCzbdgdOT76aw2foLABqQ45B4INNjQQrsM8Me1vSu@vger.kernel.org, AJvYcCXcjNOG6BdLPiPE4B8qMCa++FkOFcatCFuN6w6jt+fdDjE3jI3pK8q+BLwz94C3vkOAsDaIa6H82oOWl9l4x/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDog4bcq5ZU/zbMEBqA3D1Zsx5yJScxUpPnOkZlP7rDNSN5v8g
	wYpMklcXaY9mP8HKPLuB9CeGYxETNCiX2EjquRdUd9224LKC0y0knBPn
X-Gm-Gg: ASbGncuPQE0AcTREvfHewQEl/mFwhUEo+cO54Q1CHTUiNhd/J9jtCJ61JaAXbnDun5H
	cupR77ABNwDVFQ+l+dlTEri+gbDPoyJac3XzSV20aLfuWQ+BiYfPEv+VFB0ZrdEIemWNpJ8goIZ
	xBO1DezFRBg9VQ5qYGwySBJwVlgp0Hy63TwvA3pj4qwx+Md+H533FIyaZ0xSwGuY5vRb4dkVk9k
	IN2gFFX4h8xeIMiI3zAtm6tyU2wtWOqunmY4wRTF2ou4StqkzKj2zqc4BXv7q5m/vjwilApLJub
	3G5or+jiZvMwsBLe88qe5lH0AeJNMti04duJFXLVMmmbmIB4IhAiL1FrMRBVQ+zAHx2ncv/t7oK
	SoZe5an8HHTqKLbllO4VqB4nT73UWX2pQS+p/nkhSMSaoAe3Uuzab
X-Google-Smtp-Source: AGHT+IGI9wrJlk/EdUfzrnlCQdEcpgrX6ATeWyNj8eMASX/i9ZN1VLo/n+ONfa1cHmdrIXJcsnr9cg==
X-Received: by 2002:a05:6214:4015:b0:6fb:5f97:510f with SMTP id 6a1803df08f44-7049506ab79mr54563026d6.44.1752158579491;
        Thu, 10 Jul 2025 07:42:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497dcfc37sm8761616d6.115.2025.07.10.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:42:59 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 524EFF40067;
	Thu, 10 Jul 2025 10:42:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 10:42:58 -0400
X-ME-Sender: <xms:ctFvaAcE0iyTokvcj511T3GmrdPd12ZhuaIp6jzMZ4lL4EI73Vsa3w>
    <xme:ctFvaDtqT9dkquEesECpobe1DIsR3AMO4gzuMpqX4BF5DaGpvuHO680seBbsUow1T
    k-Xx6HPw13mXOmE3A>
X-ME-Received: <xmr:ctFvaGGctGKiFLg56nZeqHmXGhiSenZf9gEPnMEs0LX_inggxd56PBRFww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehloh
    hsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlih
    hnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:ctFvaFdlwzav-bMXb6DU3p5OMDDaBu6zYT4n09Dg6KyC6BpaTQ2ufw>
    <xmx:ctFvaKunaXRztOHCjPKQIQUqTpzdkw05qe7fEqzODp_3hlqV1ZZewg>
    <xmx:ctFvaEkc6OKIzkTs6cP7sNAmZxzY7Z0pXF-QEFBAmzJ1kmHM_pgncw>
    <xmx:ctFvaNCqOtcdGugFVUn0bTcYLYGE5JfFgr9eNYz5Kp7SwJ3B0ntc7A>
    <xmx:ctFvaMx73y5lXNEzdvWTfjWGV9hlBQSccSHDi-o4dFNhhkoabp-dwiRQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 10:42:57 -0400 (EDT)
Date: Thu, 10 Jul 2025 07:42:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation types
Message-ID: <aG_RcB0tcdnkE_v4@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid>
 <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org>
 <87v7o0i7b8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7o0i7b8.fsf@kernel.org>

On Thu, Jul 10, 2025 at 02:00:59PM +0200, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
> 
> > On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> >> Preparation for atomic primitives. Instead of a suffix like _acquire, a
> >> method parameter along with the corresponding generic parameter will be
> >> used to specify the ordering of an atomic operations. For example,
> >> atomic load() can be defined as:
> >>
> >> 	impl<T: ...> Atomic<T> {
> >> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> >> 	}
> >>
> >> and acquire users would do:
> >>
> >> 	let r = x.load(Acquire);
> >>
> >> relaxed users:
> >>
> >> 	let r = x.load(Relaxed);
> >>
> >> doing the following:
> >>
> >> 	let r = x.load(Release);
> >>
> >> will cause a compiler error.
> >>
> >> Compared to suffixes, it's easier to tell what ordering variants an
> >> operation has, and it also make it easier to unify the implementation of
> >> all ordering variants in one method via generic. The `TYPE` associate
> >> const is for generic function to pick up the particular implementation
> >> specified by an ordering annotation.
> >>
> >> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > One naming comment below, with that fixed:
> >
> > Reviewed-by: Benno Lossin <lossin@kernel.org>
> >
> >> ---
> >>  rust/kernel/sync/atomic.rs          |  3 +
> >>  rust/kernel/sync/atomic/ordering.rs | 97 +++++++++++++++++++++++++++++
> >>  2 files changed, 100 insertions(+)
> >>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
> >
> >> +/// The trait bound for annotating operations that support any ordering.
> >> +pub trait Any: internal::Sealed {
> >
> > I don't like the name `Any`, how about `AnyOrdering`? Otherwise we
> > should require people to write `ordering::Any` because otherwise it's
> > pretty confusing.
> 
> I agree with this observation.
> 

I'm OK to do the change, but let me show my arguments ;-)

* First, we are using a language that supports namespaces,
  so I feel it's a bit unnecessary to use a different name just because
  it conflicts with `core::any::Any`. Doing so kinda undermines the
  namespace concepts. And we may have other `Any`s in the future, are we
  sure at the moment we should keyword `Any`?

* Another thing is that this trait won't be used very often outside
  definition of functions that having ordering variants, currently the
  only users are all inside atomic/generic.rs.

I probably choose the `ordering::Any` approach if you guys insist.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

