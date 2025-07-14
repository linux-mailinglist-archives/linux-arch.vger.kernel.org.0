Return-Path: <linux-arch+bounces-12751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A1FB0448C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C4A7BA3A6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892912609E3;
	Mon, 14 Jul 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuKChJsS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE924728A;
	Mon, 14 Jul 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507255; cv=none; b=YzkOxE6Itha41/0fNAejJBJ1W7cdmlkdXx3BfTooviCR1VvBhs/HM0aachNS8fMV0MCaqCOLTBGj0MQrtO6X3ckHNa0Qb8wcVjnWGvM/WN5VHK8N6XTvD4l1ijyhrp7unz3GtmQDZiZrIirPKkiICx29kReriDBaRPujoAzb65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507255; c=relaxed/simple;
	bh=g+O+Onw4EEFGOhr3iVz4F85RgpHcqoS4Sf24nG8i2RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg6Kv214XkjY5dAHYglaHqYDELLNxhSBh4wfv3xr8uGdqcRD+Cce4i21kttpg4kqUbkAvrFhjZ+kkqPi1pGLvfZH+EzzzkoNjcZ2xsEhyC/z0R48ddpLrq9Ej8RNrHIIp74J7HgSxokzBSfBut05JA6HclaCTiRdo8fSoHOpoZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuKChJsS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e095510a6cso272951185a.1;
        Mon, 14 Jul 2025 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752507253; x=1753112053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1ah1KiBYa+nQwV3ZRjbCEW6rsly24N5LKmoT4ikCOg=;
        b=KuKChJsSHs/4J7lLPPny6TRmwphqP1BL+h3MA1EAIPEfMzecsPFBDwy1ADTbs7E7eu
         8SW83cwkvgvfd6gQQ8H1A1lZFXhXfCvA96q68zS2iVD5C/Tc69e8uqggL/bPAPt8Kzx3
         km3agXf5zg/4/kFbluyb2jxDLkBLNJJLuECKn6Cq8Z+PmtKNHhJzNvhCeUuiuEFo+uDX
         xUzuv0EbXnYWCSKk8sz6pvufQXcTqJHWX16ERiXrQgFFK0M8/tgu2UNkPNvKMyGjsrdD
         WKVcWdiZ4yP5DualDuCvu61ndKO4+avmuK74r44Ptrdzi6+a2qHw8l8ihqbxlVcSWIuA
         7fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507253; x=1753112053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1ah1KiBYa+nQwV3ZRjbCEW6rsly24N5LKmoT4ikCOg=;
        b=RTlKnW4ASOEbHktaaFxNo/TKgYZfJ+ibJm2IXgXB38pC6JJmCEQSXdfUP8eIq2nbOu
         46GL/JTokxB0DN9EB+gQtFZSovXVjhCafi8dpdKS4jpUYU6R/7JyI1TH4eTD2tX6/kTm
         3sapxh7ZszNILzxNDkGeV23FQ5GdfqzCtWP6SX2epNDecinNwfNxMgfyQQM8OIuVSr3B
         a+GO4kqwo9TFzqN7l9BErJfDDKEIAI/C9m4HfyEs0hoJCw8uABoNMgPFk7FvLMzFHwLu
         Si8YmZu6Wsg8sX8yIhczvb86NQqlQ90dm0uvo+cX45j6MmMgG5ZI0OtQ9DkFZXdeK2+i
         tXUg==
X-Forwarded-Encrypted: i=1; AJvYcCUY5irTrocIlWS7WeSqoddUiBk/ZdYQ0hIOCqjyPACJL2/QciNaHMpn8VIwaBxil9/+crudtTHRoXvf@vger.kernel.org, AJvYcCVvp6bmwUuiyxbzAQoSNIj4Cd0OBNfz4iDEF8+AgHEcvZrgEepd9n1CCmcUSRI2mNnO6nCXQoWJl/gn63wxN2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52PpLipTPuWd/LYz3lwCp6NwM/gY3f7XQtjdzCQBJGBi2/r/9
	ccz2PnsxfY1uBbRq09ski1nDPCIbDQXR7LjpcYwsOnSU8EeWByh75HP3
X-Gm-Gg: ASbGncviMAkDBF3SiQgZnQN4tKMNyTFyqwbqad2t320Vhxez5IMPV0BCmK7vE8va04K
	tf20jZhBTEM/vsymqp69mwuNoaLeAgGT2sdMBrW1vMPmg9daM3xtRs8s8hKlfdFGtWpyKOssnD4
	afej1tuzquA5FjYCdFWBTnq+fAaOuEuJ6X9Vohxj+O1ell3BaPrR7O2HxukaqFiymGkxG6C04o3
	QLVBLDtOfhPgJGAu5uIi0mwuiZ7RHbhqgycjW3nBx9azNoM3FmZKwefVkQRU+P6u+S/djbMBZAE
	bbaDPxe69X93IUJpU4Qz8gQekUaTqDWIAQPeCC5Yk8bx+vfIeoQQoYazgV+zidGyXyGlO+RtBys
	p6j20D0qo3nsU+iFOAgoFb0zef/i5BGphbE0/UJDc8BoBus9wXND00+beTDOJGSTzKmRZJSNkQb
	M7fA0l6MDDIHZe
X-Google-Smtp-Source: AGHT+IFmUKHtXtb7dpJhb3zmSZ1eVrPeDqvK2CSHNEiPnxRXmpl4kr66ZO7VxCg9aDpOs9IfcA6Fkg==
X-Received: by 2002:a05:620a:3190:b0:7d4:4b9b:3eed with SMTP id af79cd13be357-7de05769905mr2084229985a.25.1752507252602;
        Mon, 14 Jul 2025 08:34:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e407sm48780616d6.23.2025.07.14.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:34:12 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 74DFDF40066;
	Mon, 14 Jul 2025 11:34:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 11:34:11 -0400
X-ME-Sender: <xms:cyN1aHmQVSMW2S2kEq1pJPrebkugzUZZx7YSPkqXy92gzTKnBgbOjQ>
    <xme:cyN1aMWimFINoAGnOsd9k2-95HuuNjyfZvtfXxt3C144lclHGnYiYmH2XP1GkvWtR
    FfmAOs2ELA7odHkGQ>
X-ME-Received: <xmr:cyN1aCOr5XRn66xwYrCaGaBmW8Mw1sEOEIic3APIUkO34OXuYJTEcin3Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdefvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cyN1aPH5wN_4PmpthNSngTdrYOPJjgSl15y13eQUJj_aQD9DH9kFGA>
    <xmx:cyN1aD1J3MVqK-QZtu3f2ou6mS4vPSyPB9KByu2qLhsCR4qjF8R-wQ>
    <xmx:cyN1aHMTeBwM7TrQisU8VdSZ1GfDbQmh4LIhCesL8I_3ljXaHCvUGA>
    <xmx:cyN1aLKjTvhAQH3Na9-PBi3nibRPE6UbgVpON2CqydagPKOgBL6Lnw>
    <xmx:cyN1aAaAU6I6XSTTQYdwSmB3rGmKKNGqPScIUTdw_qwz8-ZlwVgyLlI4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 11:34:10 -0400 (EDT)
Date: Mon, 14 Jul 2025 08:34:09 -0700
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
Subject: Re: [PATCH v7 2/9] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <aHUjcSI_r0rYdTwc@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-3-boqun.feng@gmail.com>
 <DBBOXLF23VVA.2T3U6GBOZ3Y20@kernel.org>
 <aHUJYTv4_wsatAw5@Mac.home>
 <DBBV9KHTEM3E.3T10KY9JN754X@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBV9KHTEM3E.3T10KY9JN754X@kernel.org>

On Mon, Jul 14, 2025 at 05:00:56PM +0200, Benno Lossin wrote:
> On Mon Jul 14, 2025 at 3:42 PM CEST, Boqun Feng wrote:
> > On Mon, Jul 14, 2025 at 12:03:11PM +0200, Benno Lossin wrote:
> > [...]
> >> > +declare_and_impl_atomic_methods!(
> >> > +    /// Basic atomic operations
> >> > +    pub trait AtomicHasBasicOps {
> >> 
> >> I think we should drop the `Has` from the names. So this one can just be
> >> `AtomicBasicOps`. Or how about `BasicAtomic`, or `AtomicBase`?
> >> 
> >
> > Actually, given your feedback to `ordering::Any` vs `core::any::Any`,
> > I think it makes more sense to keep the current names ;-) These are only
> > trait names to describe what operations do an `AtomicImpl` has, and they
> > should be used only in atomic mod, so naming them a bit longer is not a
> > problem. And by doing so, we free the better names `BasicAtomic` or
> > `AtomicBase` for other future usages.
> >
> > Best I could do is `AtomicBasicOps` or `HasAtomicBasicOps`.
> 
> But you are already in the `ops` namespace, so by your argument you
> could just use `ops::BasicAtomic` :)
> 
> I'm fine with `AtomicBasicOps`.
> 
> >> > +declare_and_impl_atomic_methods!(
> >> > +    /// Atomic arithmetic operations
> >> > +    pub trait AtomicHasArithmeticOps {
> >> 
> >> Forgot to rename this one to `Add`? I think `AtomicAdd` sounds best for
> >
> > No, because at the `AtomicImpl` level, it's easy to know whether a type
> > has all the arithmetic operations or none (also the `Delta` type should
> > be known). But I don't have opinions on renaming it to `AtomicAddOps` or
> > `HasAtomicAddOps`.
> 
> Ahh right yeah this makes sense. So let's use `AtomicArithmeticOps` if
> you insist on the `Ops` part.
> 

Done with AtomicBasicOps AtomicExchangeOps and AtomicArithmeticOps ;-)
Thank you!

Regards,
Boqun

> ---
> Cheers,
> Benno

