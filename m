Return-Path: <linux-arch+bounces-12720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F988B032C4
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 21:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C4D189AB72
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057D1DE8B2;
	Sun, 13 Jul 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j95yf55K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DF01FDA;
	Sun, 13 Jul 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752436295; cv=none; b=JS9Ph4jVn9SwMw+qSQ/u3qsASneJ9wRyy6IPBI/IUVe96au0VHl9ziPI2SS9nwsJw6e5u9Ej6TS52UBXqiW64wzxBF5fAnoZwlN8kmZjM/abPWib/T0hGkyIlKgW7+A9rzZzF7NrQqlB4e+7KRVI6YbEtJLB4bsDYsPjZuYbnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752436295; c=relaxed/simple;
	bh=nPQlDFSW9RIxdadQENtLULpU4fV5OoVXBUZbBVLLTY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScbbPIqCt03k2uYXQYa0hTfe+168BdEi1yan61ZYK4rJnTW3adUNC9MwoUka2wON2sXwsVeOHD92vP5cAASCDVFy1PHmpa7ZsGX//QXU/8NLCwKIyqVcJyHspsUkL9Rs/ziBSgU5kbzZp91AM8xrULHl8jmptBkR94YkeWVooro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j95yf55K; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5840ec53dso40288761cf.0;
        Sun, 13 Jul 2025 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752436293; x=1753041093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiYEGXk9WPqZkAOxoDJG4bxHhit6SmV7DwavSK2behs=;
        b=j95yf55K8tyl0R1YU21RVe2HBn1OGUICm2GJCY6H2U7/g08HnVTABhvmvtWbv67yDI
         C19UIfK2cKJE048DGXz/Fn1Ffir2Yeh5Bfy64GvPcm8+DcYYSQduUIrHvU/hnPWkRmuj
         XtkOKo4pZbPRKJ+8RsKjGCPhPWmXbtj/Wh2Jlq/Dgar0n5YzVs/FZ2WnzmdwXLUOmDxb
         mI8PO2c+9hb0G804Ueo0tsOCiuKLMH4F4r4NEK08UOUKIp6XmNOR6R6HtCewullCaF5e
         CehPq+z2GkRPtck4pUCWDuIuDSpodSKfK2owsnQHg1jOC2gmluVZ4Oj3HkVLkKIfxibK
         +y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752436293; x=1753041093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiYEGXk9WPqZkAOxoDJG4bxHhit6SmV7DwavSK2behs=;
        b=qNDMUq6K4uukBVds0g1HrB5SICGe8gIfjF77i8HCyD1pBez18gp2r6c4RiorNIN1OB
         k0tvjFBW83fV3DpWQioZbL1MURmR9eN21kCyRVHQX3tirpdGuu1kfE3DuB1S0GFETgDO
         O3UwJ07alz4t1rCCz43AmQ3TzVs8WoeUaQAlCd+OSwKzyClBHhnZZZcYG8WOCOt+SKOL
         t9IX1kS8zZ6n/WJNcWdhL1HZJqisqxC632rb8iSmjLZVcFBwV5bMTwCpSS/+sET9qHZz
         zGBq4ztJdifhYQ6sNROCHwXSqmp7+3xl3rd3KQRmE+ruweCHTJObiimIuMXwKjhjQEXf
         pGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZqp94FwyPL1QYrI3IxJ5JoXcGCL+cMb666zGz19D1WnDAfRmRXs00EcHWPWDMajZy0Dp2CZLo2KWt@vger.kernel.org, AJvYcCWtPGx+FwgyOE7qaQjEnMSdMdDgIa8FSZbzJ0Ju2OVkZmLXtmLWqY7RkXqeutaWo3MiZ4mn+onnkB0dFPJAces=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNA/QW4DB/LfJ6nYJ5xXG8Srk6PszSA+lTCAOnGJunTe11Blxm
	Sc2YgsirRIUOzeD1HsBd3ej8eACGL6jWi1k0qrM8FbpPzmQH7RUxk1KM
X-Gm-Gg: ASbGncstAL3uUxRPxZbYaoghWz/lrgGq/jBNzJwgY+JK2YKcwJwG2EP8e87gUDOGteI
	BvQUZaMl1+hI3/fDxVupIGfxODzD3vxCejj/Itu4+chpu7pOXUS7oyUzmbTuaSKnCZ9gulP2nZm
	+F1Gf5uttK5K5bL0BwCnb8Q26OA+pYhf08HpemRMNDN6ahf+hCDweLu28FYYVkxDrlZ1vm9nto/
	JthPhHCNxyQ6FwOLif98YkBMqKbN9YVN8ZsktstAky4aJyDUovWemPT9U3oJ2xdFQ4H5Zj0JwYs
	5bfOiUIcO0wQ8stVCiBqIjU96mTprzN7pBX8UEc3EgCkSpvQ0TO8+HBLfLN14ylv/RVQtsJ8vEv
	QGJ1WopV8INF9oN2E8bKuMVeEzI5irDzcvsdY88mAip+v5BxnYzq+PWP0AwlYGtBO6rCaEDXJTX
	h3EfvOrdZ+e3IbDIE9oSx8AOU=
X-Google-Smtp-Source: AGHT+IH5xDylD/6MZCspt9o4GAG8jxcNA6PZtUrSOr3+k0K3lrw0sxOp16rSOwxUVU5CIJaT09n7Kw==
X-Received: by 2002:a05:622a:10e:b0:4a6:f416:48b6 with SMTP id d75a77b69052e-4a9fb92e587mr186226371cf.28.1752436292525;
        Sun, 13 Jul 2025 12:51:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9ededcd5fsm42418971cf.68.2025.07.13.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 12:51:32 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 39322F40066;
	Sun, 13 Jul 2025 15:51:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 13 Jul 2025 15:51:31 -0400
X-ME-Sender: <xms:Qw50aDyQsGYzFN43RjiBN1oLYKEL1H9n3OLwQ4tHNN6VZDivnKHXgw>
    <xme:Qw50aMy65KPpd0jrB-Zrf03GOwr7o1Kw5QSdulxhr6wpYY9tTJzp4LCrO2hemwXeG
    rODEhGtnN0hGD39LA>
X-ME-Received: <xmr:Qw50aB4wVqiDti74aw21J6npBQJbyYRFrEU3LlpimRjZU1fP3lybfEH0cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgfffkeduheeliefhkeehfefhueefffevleevkeffvdfhvdejgeeggeevieetjefh
    necuffhomhgrihhnpehvrghluhgvrdhsrghfvghthienucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepvdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:Qw50aNAahx-9azlJQvPLFtMp7OgKC8pVTXQpcMJeeRBzRI0zno-nyw>
    <xmx:Qw50aDCiVJ50W0sS6E_53UE-6sPPEOzX0V67DVpjhEQq-cpd4zCSww>
    <xmx:Qw50aOpEpCGAvR9EsZpH-Ag3m23HDOBNpGXJKvDGBf9xqi4fIMHxIA>
    <xmx:Qw50aF2dRKwWV5bRVPmNAOv3PtFef-_PfjfpjiXdMoHuTBFuWoj1dw>
    <xmx:Qw50aNVvArT2iKsw2cWK16gvHiBWPc5sWIL_HmuqW-enS28Rsqc4vjvZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Jul 2025 15:51:30 -0400 (EDT)
Date: Sun, 13 Jul 2025 12:51:24 -0700
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
Message-ID: <aHQOPPhTRI2mcEKq@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB92I10114UN.33MAFJVWIX4AB@kernel.org>

On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
[...]
> > +/// # Round-trip transmutability
[...]
> > +///
> > +/// This essentially means a valid bit pattern of `T: AllowAtomic` has to be a valid bit pattern
> > +/// of `T::Repr`. This is needed because [`Atomic<T: AllowAtomic>`] operates on `T::Repr` to
> > +/// implement atomic operations on `T`.
> > +///
> > +/// Note that this is more relaxed than bidirectional transmutability (i.e. [`transmute()`] is
> > +/// always sound between `T` and `T::Repr`) because of the support for atomic variables over
> 
> s/between `T` and `T::Repr`/from `T` to `T::Repr` and back/
> 

Hmm.. I'm going to keep the "between" form, because here we are talking
about bi-directional transmutability, "from .. to .. and back" sounds
like describing round-trip transmutability.

I also re-aranged the doc comment a bit:

/// Types that support basic atomic operations.
///
/// # Round-trip transmutability
///
/// `T` is round-trip transmutable to `U` if and only if both of these properties hold:
///
/// - Any valid bit pattern for `T` is also a valid bit pattern for `U`.
/// - Transmuting (e.g. using [`transmute()`]) a value of type `T` to `U` and then to `T` again
///   yields a value that is in all aspects equivalent to the original value.
///
/// # Safety
///
/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
/// - [`Self`] must be [round-trip transmutable] to  [`Self::Repr`].
///
/// Note that this is more relaxed than requiring the bi-directional transmutability (i.e.
/// [`transmute()`] is always sound between `U` to `T`) because of the support for atomic variables
/// over unit-only enums, see [Examples].
///
/// # Limitations
///
/// ...
///
/// # Examples
///
/// A unit-only enum that implements [`AllowAtomic`]:
///
/// ```
/// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
///
/// #[derive(Clone, Copy, PartialEq, Eq)]
/// #[repr(i32)]
/// enum State {
///     Uninit = 0,
///     Working = 1,
///     Done = 2,
/// };
///
/// ...
/// ```
/// [`transmute()`]: core::mem::transmute
/// [round-trip transmutable]: AllowAtomic#round-trip-transmutability
/// [Examples]: AllowAtomic#examples

Thanks!

Regards,
Boqun

> > +/// unit-only enums:
> 
> What are "unit-only" enums? Do you mean enums that don't have associated
> data?
> 
> > +///
> > +/// ```
> > +/// #[repr(i32)]
> > +/// enum State { Init = 0, Working = 1, Done = 2, }
> > +/// ```
[...]
> > +pub unsafe trait AllowAtomic: Sized + Send + Copy {
[...]

