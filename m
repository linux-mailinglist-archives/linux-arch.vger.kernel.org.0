Return-Path: <linux-arch+bounces-12716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93FB0265C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4761D4E05F7
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4E21A453;
	Fri, 11 Jul 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSo7GwuY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2021C84A1;
	Fri, 11 Jul 2025 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752269125; cv=none; b=N0RjPAfZs8MQmOI+BZTbL44OgPnmBPaj0HghwKi7fqpkQ5bpy77UJ2iL9/tANVtmkQvpJVq9nQoN7UEng/F3/pFcDbeusRSnK6XPnR7HwllpwYzMTN9BD+FzVxvbY+CIvwiIZoIO6M30HZHOyoigqm28ix9bvUzp4b9B78wHSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752269125; c=relaxed/simple;
	bh=vC3PVXTJBIz2jeZWSCWKN0Xnoj9RurMpRQ9hz73geyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2yWdcs8PkVes8WoLaAx9UXehDX8dYtDzTFJLFghv3wqSsj8om0Z9k/2KPFaj2eEksdcvwrVPuKdJENNuHPWOFBIjG9ZrNJYoMHRWnpRZ1qUJ6i7SkIMQOO2G0DVFgmrj+g5Q6xM3BUecnDRPb7qhLcIwjOXxuBrI9E+7kdDgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSo7GwuY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d20f79a00dso352915885a.0;
        Fri, 11 Jul 2025 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752269123; x=1752873923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81AF1UakxRffZTLQAg4yaS1lBgs+aKnzFImbGXcyFbg=;
        b=gSo7GwuYueIVJcP73eNhk7a2JTqsg1wPODqM54cHUCFG3uZdBJEOrijPwPz283nPwJ
         L4MrdTo76Veu6NACCeH2Jc+l0E8xy5QxlUECb1+1+36i6VZMbI5PLBTpRS5TUZgt23dy
         f6onml/7SE9hfpvc61r34VGl/mYhezH7BSllZdK+CUKBn5XRD3wq4jVxBHZpu02k5cZ9
         xrbd0VL3kaBX4vbzz7d3uG1smp3djze+4uu5ME1AzaKYiC8Sbq+nt1t9nJ82EXeH1QQt
         iDx9ZNYYt6PYcs4/o5/4L2cH2bMhyugkp1FgmUE1wb40euUW2WpsYIb6Y4rUnUnT+Qdd
         7LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752269123; x=1752873923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81AF1UakxRffZTLQAg4yaS1lBgs+aKnzFImbGXcyFbg=;
        b=HAID6snOLm6OykIl8H7yL7BswnDHh9GxVJJwM6vtftUmtvpyX/eNIivSsxGw93Je7U
         fl4PUAd/2l4bHr6V6ELiAed/5YrngfGOIIODvyVoUOHwMpSPMB8xDGvJIcMPuGNXedPl
         hoWq9vRU9/oAzTrKmqO9lJI/FPlT+zuFXqNqnqu4wjLPIRKR+Ib6Nvat/43igK7o0H/K
         CnlSV1HChD12o67Cje2tzIPa/HUT4QKkw42bnNXWo6JWcsCxVZX5A2YRiVudJrFw1hnx
         p1E6PXtBTDraIY0qHRJD7j213dQliZLKTZvcDjdI8IGr6gPNjlZobnE3PJ8N7N76L5T0
         uiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrS4xuCyhQsNsFNn4lWx5qh3H8Z9UxnfOzGP0in8E4HiLObN8WUuqx1KMIm0pt6Ug42dpnB1bT7gCu@vger.kernel.org, AJvYcCXe5FfO0t6j2bxVf4USq5JWYQlhq/qyT5FhpK7FR/WiYAMeCcPZ43QRou5ZlCj//SGKEYcw1Qkb7OGRwHTi9iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uS87buQ3ALutgtCMQYZlfxt+tGNU41rytasybvuNcSizzVo9
	roN4eQ8ZokiEz8+RzbMnjdZLiA4iiSNvaT4j5b3oYVqRDi/N8RQ/iOja
X-Gm-Gg: ASbGncuUGaqJuNGc9VdlyjkpcWfn2E9x73bzDoQBKbzzxd15N/6/NwuybQFfwLOjDzJ
	wIlIVzAeTTHvQDL/KrgjweJshgzWfjMT0EqSIr5Tz56+pzOO9UJacvVcTyr8knMjXYMpL0+udn/
	maE4UuSzJNY2xDMFXf8Q118pmg4ufYL+imtNMAJYhws5M5Nvhu1WO59R2SC6LmX9M0s0sZvovtF
	e8orq5ntfJGhhp1GeVXp9eI+CCfIjXhy/7ATKQ58T1v9/QEftbStimiKOrDaICD4kbAkR+DRopA
	ZbfyMtG17Gwd5sgmsHyVKTRd2B0pyR0qFP2wlIMx7wgHT/2C/zsjnDA5Y3Q/umfcGh7vMpT/Huk
	5B405NxQgfrKQPGCm+OkO2p728jgV60TGV7+A1IaRAqQxmToF0/GYSw6z6t1tyv7MIXXcarhKQS
	UGyzUBa0q33EeUZ2farxd5Ubs=
X-Google-Smtp-Source: AGHT+IFSKRxEte1QaA1H5Go9CtUQyuCEC2zrhMa8WdRw87GMAgfHqEdwaEhwf2VDl2HqfCn3z93Kjw==
X-Received: by 2002:a05:6214:262c:b0:704:9596:b894 with SMTP id 6a1803df08f44-704a36062c0mr77709596d6.13.1752269123167;
        Fri, 11 Jul 2025 14:25:23 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497db3253sm23591726d6.105.2025.07.11.14.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 14:25:22 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2AC2AF40066;
	Fri, 11 Jul 2025 17:25:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Jul 2025 17:25:22 -0400
X-ME-Sender: <xms:QoFxaGwKm046rbKSuTkGGogiy9YUqj9OJE1_fBcFbAytVTIMMFTrQQ>
    <xme:QoFxaDzhwVBkNIcPleebQ6eIT4bxDIHvuNo1FfDib9ZInX9KrWD4tsKSQl4CJEUrc
    Pg9VaJ_XrpuMHkypw>
X-ME-Received: <xmr:QoFxaM4tSIJz5h9Py6xa8pkPe5lBfuQeyEtjXWjiPmXd1Qtit_bhu09QOvuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedtieeghedv
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:QoFxaMA-vNNviVajjsoHRzvMKL6dJv8QvCh1W_ApA08cHRoB7cAZPQ>
    <xmx:QoFxaGCPflidngcM2V3-EEQ07cX8Lm2eAHnexAs-GkS_Gro0f5Gmfw>
    <xmx:QoFxaFpi11gKItmo9z72GHFLox-qBRNNJh8uzc39jDp7DuFHmPl_ew>
    <xmx:QoFxaA3GulzrE8l2u55pNr-1wTSLO1IF_52K1NcNd9j57V4N_OsjRg>
    <xmx:QoFxaMXiHyGYfY5LkpsW1UmvWH3deTChwLzTVgTAOZAzYkXGCjZH8F10>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:25:21 -0400 (EDT)
Date: Fri, 11 Jul 2025 14:25:20 -0700
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
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHGBQLSzOq6RsqKt@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
 <aHEQKBT68xvqIIjW@Mac.home>
 <DB99JZ3XMHZS.3N0GLG94JJSA9@kernel.org>
 <aHEWze8p40qeNBr_@Mac.home>
 <DB9FX5XAK4JJ.3GTCC6Z5EHARV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9FX5XAK4JJ.3GTCC6Z5EHARV@kernel.org>

On Fri, Jul 11, 2025 at 08:34:07PM +0200, Benno Lossin wrote:
[...]
> >
> > So all your disagreement is about the "extra safety requirement" part?
> > How about I drop that:
> >
> >     /// Returns a pointer to the underlying atomic `T`.
> >     pub const fn as_ptr(&self) -> *mut T {
> >         self.0.get()
> >     }
> 
> Yes that's what I had in mind.
> 
> > ? I tried to add something additional information:
> >
> > /// Note that non-atomic reads and writes via the returned pointer may
> > /// cause data races if racing with atomic reads and writes per [LKMM].
> >
> > but that seems redundant, because as you said, data races are UB anyway.
> 
> Yeah... I don't think the stdlib docs are too useful on this function:
> 
>     Doing non-atomic reads and writes on the resulting integer can be a data
>     race. This method is mostly useful for FFI, where the function signature
>     may use *mut i32 instead of &AtomicI32.
>     
>     Returning an *mut pointer from a shared reference to this atomic is safe
>     because the atomic types work with interior mutability. All
>     modifications of an atomic change the value through a shared reference,
>     and can do so safely as long as they use atomic operations. Any use of
>     the returned raw pointer requires an unsafe block and still has to
>     uphold the same restriction: operations on it must be atomic.
> 
> You can mention the use of this function for FFI. People might then be
> discouraged from using it for other things where it doesn't make sense.
> 

I'm going to keep it simple at the beginning (i.e. using the one-line
doc comment above). I added it in an issue so that we can revisit it
later:
	
	https://github.com/Rust-for-Linux/linux/issues/1180

For your other feebacks on patch #4, I think they are reasonable and I'm
going to apply them, except I may need an extra review on the doc
comment of Atomic<T> when I have it. Thanks!

Regards,
Boqun

> ---
> Cheers,
> Benno

