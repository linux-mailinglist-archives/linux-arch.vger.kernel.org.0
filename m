Return-Path: <linux-arch+bounces-12717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B6EB0266D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 23:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49512A44DD5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A718D;
	Fri, 11 Jul 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb9k42uB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C11FECB4;
	Fri, 11 Jul 2025 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269701; cv=none; b=OcdIq67vFRWWJWdyQnqScHVZRLnWrMuWxOgH47UIIne+vOMJN7cWDLrYpL5uIABmXSR8ElSMNuOeuM3iM0yCJjXPV7a3hwMPpQ+sc5+UBb7zDrC3AB2Z+jNXy1RxlU926MuKzofsnZn6RqCMzhymaBBPuc1DtdMc4fNRW8JR1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269701; c=relaxed/simple;
	bh=8V8ejNYB3QXOIEBL61iMBdPzyE+6vjhOjCy9tOR4HWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OorZHFjNaDhsZ89Yl0YvrSKSm5twJWAr06DTlCJHiOhHmFxXITezmEPtI0Vfln87+OL5bFV44C19Bjkh9w/u3RAStzrafmu1YnQAfE+oiid8iRLa6GQuaJRCoR6m4ksivnG3rhtxsih0CZLngQN3VKA6AfLwV0/4SluaTNbziz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb9k42uB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso30311386d6.1;
        Fri, 11 Jul 2025 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752269699; x=1752874499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxb4wH8x/KAvU0TG5QbcaePRN/pYWDrgWrEuOMXDQ90=;
        b=jb9k42uBzi97howxu1JCRMcCw1eXQaOONQtNIrjwgZRjhdvMPPFrTxITvVNY9b4Ym/
         M1c6LiZGsQHmDt1JvVFRdiRd/4Z5tc4b/jVq9p9u6nnre6znGxCf8DqmiywhI830VbmL
         j7YCdHhdoFQXjvyRy7hyawzGalI7CKVmCcJkH6h6amrQ/MqLxAcjgYOCNBRFzCA5nS4x
         x3bAtyY5j7v8HaHj+vryV8YbQP2wjkXVWB24gt+J7yPFqDza4s4czsmtq7QPYN9YaKU+
         6FrGeRD47kAwkJfa73Tzb6lRgk66u+ZsjPakQdI13PFORhqcRCz8CDutiOKauziMFcfU
         jEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269699; x=1752874499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lxb4wH8x/KAvU0TG5QbcaePRN/pYWDrgWrEuOMXDQ90=;
        b=nQxFIq8FO+KFj20YUjtDrVlYbV4eramvadHd02HnMpue+TbLvr6mM/CaOicGXfbbvk
         j9iRTqnHI3Fdb3FoHVNLmq0Z82/+qvDfWhodZc5FjY5DZKflCxCf4Y9SD15kduQ0HiOy
         V3AywF6hVZ3mAFDMorYLx4A9U3qV1SEFaljyHNpo/aNk7bg7e60GbrfydrZT/irQcFKz
         sj3V8jmfg0cHCMSl1SyEUSobZ5CW0hiaIatFTazD+gO8QxJ2jkGFp6YlxAKqgrL4yTVK
         AxMjzop/V00n4l5PnDJLKAADtsT1t+ENM73chsoOxDykE6SN6J8q+YpvNbDfIf3Zw8cb
         Gt2w==
X-Forwarded-Encrypted: i=1; AJvYcCW3FfXEiY02e6zmAGCnglI1mTcefvo+FDNOqvsHh2aaQU/9vWQHpAfsOoHlEEVRPuHBmtVyKV3Wc30J9L+6+ig=@vger.kernel.org, AJvYcCWbsBxGMipPNi9PL558VbeDJAlTTK4c1VFH6HBV+OwQWmrGFn2dZctrVgqtYsiqo5qo7VaDwnG0o8ln@vger.kernel.org
X-Gm-Message-State: AOJu0YwsF6afi9gGRsP/rdj+S6c9Jvpr3JA7ueRZZOd7lpgPq5jEFO/e
	OQZRk5EImAQH+7tQHTMHOQTcdEZGtEDXrEo21lRIanIFaqZdvWP5mfK7
X-Gm-Gg: ASbGncsJWjqJP49zwF++yhWpgk6faoCWgorxBoH9M8pCEknCXwzAVvBeMndCw1KgkYJ
	RZoMRxNvJcU2DTDZETweD/kTjU5sL+r3VCjUIl5gNxDqL6GBp3GdxiD5/PDDTe2D5wLfWgBSBCx
	fImOip/3LcvQ1xFk4t0LZ4Fdlf5F5wdMCyrpl4Fu7DP1C8IKm0dlQnyhzLQAGqAkV+LwsKQMOIA
	gr+2LDAQkWLVz6QbCoBZjMHfKxNagzbRrePOHxzkZn7DW/WRey+SgPeqoZAnRnN8EKowXBZ4Dlq
	A5pKWQ1OKB+yVTDdJJ/TwDRxXjUvO/QInPJSvz9PwSDhScDVbx1PDwJ8x9HtDjFJWp7+OgyQ2HN
	SeslgiF3IPghgGyaQgS0ZqBMsNgnQnsEgDn7t71VGER+vsbJ+7ElSockRs6gFyK7S/Qm4FkgvpU
	5IxOnFuCdMbKrQ
X-Google-Smtp-Source: AGHT+IHMED6K5lGCMSJ0yq1rcoBeti2f+RCAxN+T/qCub0Cjg/418vwbxIe/+Pn9uN9IhYOad0ZNFQ==
X-Received: by 2002:a05:6214:2f85:b0:6fa:b468:caf4 with SMTP id 6a1803df08f44-704a37c07eemr78816456d6.0.1752269698538;
        Fri, 11 Jul 2025 14:34:58 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3d3b0sm23705646d6.80.2025.07.11.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:34:58 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 77DC2F40066;
	Fri, 11 Jul 2025 17:34:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Jul 2025 17:34:57 -0400
X-ME-Sender: <xms:gYNxaGdBvTM2s0Cwz0fafm6GKM784HD_5eeJRdKuYE9mPCRcnZIy2w>
    <xme:gYNxaBvMHPdbNOmnyVNPtQdPtQq3qN4VWc5chnt765TQDk9Bjb9U-fGQvJLleFwQY
    GS4H8SsnlNSI4EfPQ>
X-ME-Received: <xmr:gYNxaMGIlu2mFzSUvC0MC5YgUisahE0Xrv42czcc7lJz4eLvF5dQJscyG00K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:gYNxaDdK03s5QNpo2cDyrHAsP8fp3x0TejBuUDEihB_RRTg3Sqq3uA>
    <xmx:gYNxaAtbT2KVKtTimwFiV8DkQkVW-wjD09WBKFaX8LW5AQanefDXXQ>
    <xmx:gYNxaCm8XSnaeJD0UodY7h2R6CNrSOmBpCjmoL538_vaF53_cDsejg>
    <xmx:gYNxaDD9cidslKocyagtnuUA9V_raJr4OQhLPREwhdQFwFV9LRv4pg>
    <xmx:gYNxaKzOXCGgQDgcNDWR25KxBuPJQwO9H4zaj24T3gCLLh1ydye-9qK1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:34:56 -0400 (EDT)
Date: Fri, 11 Jul 2025 14:34:56 -0700
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
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
Message-ID: <aHGDgEFXIx-aPQ_V@tardis.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>
 <aHESYzVOTCwADqpP@Mac.home>
 <DB9GF0U3JJWL.3FQFMRTBO52C1@kernel.org>
 <aHFlS96FTRgS0dH_@tardis-2.local>
 <DB9J417F3XRT.1XGPA6VLF9T8K@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9J417F3XRT.1XGPA6VLF9T8K@kernel.org>

On Fri, Jul 11, 2025 at 11:04:09PM +0200, Benno Lossin wrote:
> On Fri Jul 11, 2025 at 9:26 PM CEST, Boqun Feng wrote:
> > On Fri, Jul 11, 2025 at 08:57:27PM +0200, Benno Lossin wrote:
> >> On Fri Jul 11, 2025 at 3:32 PM CEST, Boqun Feng wrote:
> >> > On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
> >> > [...]
> >> >> > +}
> >> >> > +
> >> >> > +/// A full memory barrier.
> >> >> > +///
> >> >> > +/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
> >> >> > +pub fn smp_mb() {
> >> >> > +    if cfg!(CONFIG_SMP) {
> >> >> > +        // SAFETY: `smp_mb()` is safe to call.
> >> >> > +        unsafe {
> >> >> > +            bindings::smp_mb();
> >> >> 
> >> >> Does this really work? How does the Rust compiler know this is a memory
> >> >> barrier?
> >> >> 
> >> >
> >> > - Without INLINE_HELPER, this is an FFI call, it's safe to assume that
> >> >   Rust compiler would treat it as a compiler barrier and in smp_mb() a
> >> >   real memory barrier instruction will be executed. 
> >> >
> >> > - With INLINE_HELPER, this will be inlined as an asm block with "memory"
> >> >   as clobber, and LLVM will know it's a compiler memory barrier, and the
> >> >   real memory barrier instruction guarantees it's a memory barrier at
> >> >   CPU reordering level as well.
> >> >
> >> > Think about this, SpinLock and Mutex need memory barriers for critical
> >> > section, if this doesn't work, then SpinLock and Mutex don't work
> >> > either, then we have a bigger problem ;-)
> >> 
> >> By "this not working" I meant that he barrier would be too strong :)
> >> 
> >> So essentially without INLINE_HELPER, all barriers in this file are the
> >> same, but with it, we get less strict ones?
> >
> > Not the same, each barrier function may generate a different hardware
> > instruction ;-)
> >
> > I would say for a Rust function (e.g. smp_mb()), the difference between
> > with and without INLINE_HELPER is:
> >
> > - with INLINE_HELPER enabled, they behave exactly like a C function
> >   calling a C smp_mb().
> >
> > - without INLINE_HELPER enabled, they behave like a C function calling 
> >   a function that never inlined:
> >
> >   void outofline_smp_mb(void)
> >   {
> >     smp_mb();
> >   }
> >
> >   It might be stronger than the "with INLINE_HELPER" case but both are
> >   correct regarding memory ordering.
> 
> Yes, this is exactly what I meant with "not working" :)
> 

But be stronger is still "working" ;-)

BTW, replying you made me realize I should make these function
#[inline(always)] so thank you ;-)

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

