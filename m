Return-Path: <linux-arch+bounces-12638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E492CB007FA
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E43189E6FD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F4027604B;
	Thu, 10 Jul 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXWJj5JR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58B274FDF;
	Thu, 10 Jul 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163035; cv=none; b=V9tlQcBQ/jiXkubE5aFbi5kHW8v8QdN02amIwyy5Jo2ZJdtcKSd4p6G+OnOmWNBara01IUX+lQNupOXdK7a7wIY9esnbPtsGPtBlDSQ4gkv7hTQkmT47bYqHbO8rv9aa5Vz7pXRtd+dEe0hID+09ZoJq7HmkiMOZIsPN5Dem3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163035; c=relaxed/simple;
	bh=+mABmYXOeNV8mM9HnoSX6J6gUSDBDbFmr1UdHiOlW5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THPzJniAWSRJg2BsVuJW5uhui9ZHz+gINbygGLQCrx6NJX0KvmlL7YEzJADYtef9QXY3Gnr7NgHYu6ITpssqw8qzmiCOez3/xc7w+cs21hUzMhMKHL00Wt6sbBPXeHzuHbgs9Rz4vqN8fOJosQOmQ7uph1z4cFvDCJCx/h6kRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXWJj5JR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d7cf6efc2fso118072185a.3;
        Thu, 10 Jul 2025 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163033; x=1752767833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TrK7hCfWutY70p0zkUOMvAeOn+WmB0RO4OTHpoohBs=;
        b=WXWJj5JR7X3l9mAXoLDjvw6N9IJWPiYi8KeuIUKYfVobcct7TsGwayxR1kvafzCJQq
         1sTAZK9Fj1IwgXJp3EiHJxNs1/ekKjRkdQitlRul7+c+RHdZUXsEvSNIYowaoIVrxchE
         LZgVsi8Kwa9op8YUOPFqFksAtNXiaTg2AV40AEFgPSpdiQCL2oPtgUWCWOuWejAOfBAQ
         4tzdo9Y+Tirv7LGEWu+XmV+J4/w4Cb9l/C56B8BhPGvMg8ZuFeljylz/1S0XzEmJToEV
         cPGsF44nz0+242R5zG+iEkczwHX2BTb5u0c9ZQAD7/ntKVfPx4Fei+HxLj4ULRz/K5b5
         xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163033; x=1752767833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TrK7hCfWutY70p0zkUOMvAeOn+WmB0RO4OTHpoohBs=;
        b=R7/VpBRzfyg3nP0u9rQ8dIwle+46nZm6yCJS33+UakDSIG4nCOiOU5TRq86qr3jTsD
         XsxGx9isJQVQ/CVioH4hNc6qgKHgyu1yWaVHR3YaIAnY7NAdGg769uq3uubGhHQ1B7L/
         qrGn5BHkdXFDEZoQ7513b1rwR/kQU0FojJddoufefyryiNSn4ZI1AWPURdP3X+Z82bjw
         wHPH0i6frjEtUotj3Vv4wtVUogDoi4m0MPhSMfL0MKimGDIGzhI3oAL/FkLoWvQKHF0Q
         wAw9bKSEI4TBVf/4OFynxpe5pGOaOugb015wZrk2tEfg/AQoPNNHVmbVmdVJqViXb69w
         p1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUPtoVAisJ6FW78JQvB831YjaEs9DgIKPe9XQjT99u8rDA12HGF81GkpSHUA0clUh3y36lfNMf3wx9qbW8RydM=@vger.kernel.org, AJvYcCV/iubmkx51yKZdERk2HjwriP46iHwP3FlAdFztyMBO2tUBpBc0Wgv2aUxrmteITOX6FC9hzjJSru1r@vger.kernel.org, AJvYcCXjIbKKG6R+Ggkt/BblslYhHqxp+w3jXsj+45dasDf6s10jBns6cAM5+mioJ8rl56gj5ifBF2ZZBvEnrV4K@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaVJJ4Whp//OrFg2jihzO4rODuUW6byVC49TwMWYMB2iPE8tw
	BjfENnu/A+nSOex8GRPpbLlPdV/VTeSzO5wkFlt3h/vtAUEnw5WK0fcm
X-Gm-Gg: ASbGnct6+Sf17xCcKCRpW7FUCcrYbDSVTmuSXOOVOSPdcCYNzqNylzAnIQa8YCSZLMW
	bouYsJSF4qqmAQV62kCRTDyoPrJypl1mBZA8LPf5oHHZqGfAkITKqkguxRBwJSfK3zGctwGiz/M
	B7v6pahNodsBJVjs482b1D5zmHt/CdCCdtr/hhkxUYotSlHoHXZE4SIISG+ouDuHGG+JCJ0mni+
	OX5usfkmSek48dGX1Jd1OX9CBsEXUhOmEx8JPvlnPwPWqmLIkP9l9/DsRWjNs09dSfN4Qd/nYvW
	tYnmGRUzt1LOk0VCFCrf8+91xbvA56rlr8rD3rqrfhrT8hmu0N2HZnkTjcUd3vVkPKsj5AD9GFH
	InqjV0ASGrlN9MhpGNa04QRo1Y8qWkb64q+VeQ1MT9p2DE9YIM2MG
X-Google-Smtp-Source: AGHT+IFo5HxxuRZ6u/J4mgSOUZlvRs5fgOEFkl8u0k1/U/qjbOqofWDsz0TnG4Ksq/SUnO8IHLWzvQ==
X-Received: by 2002:a05:620a:2906:b0:7c5:962b:e87c with SMTP id af79cd13be357-7dded1f04ddmr2015685a.44.1752163032749;
        Thu, 10 Jul 2025 08:57:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb079eesm110174985a.17.2025.07.10.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:57:12 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F1A0F40066;
	Thu, 10 Jul 2025 11:57:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 10 Jul 2025 11:57:11 -0400
X-ME-Sender: <xms:1-JvaG3YDd-0_A6g6b4Gbf8FEuPVgU0NxEniHcMQlz7zsEPsm7ra3g>
    <xme:1-JvaKl9pL1Nt-udWykYtO-WFqG6oFZJY8soHK-j_LlIN93qssLYwKIE8Yct8WvR4
    suxhyODHd3oI4GiIA>
X-ME-Received: <xmr:1-JvaDe2yjEjJvvdykzVaF_sTJ9FldzzDXJBV3wq76wXTWIdxxPb57xgkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlih
    hnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:1-JvaHWpqqP39ns8iX2QesksUcEImbUsie36qAkqad4a0lYDViwfuw>
    <xmx:1-JvaHGcvGlxRvDKt50S3P_H53q7ShTh3mE3Wh--AXWPGvGmAFmNBA>
    <xmx:1-JvaJc4rDlhruJUoTeas9x1kPn1_quLXTUh3gKR5ND2XN6_36HqiA>
    <xmx:1-JvaAbMELaLB8Vdfebc7b33lZ4OY60-7NtHJhYnbqEAG5w7V_vylg>
    <xmx:1-JvaMojquPgJlEe8muVgwWgLwNU6uDTQeyFturzlSlCOv15QvNqedFR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:57:10 -0400 (EDT)
Date: Thu, 10 Jul 2025 08:57:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <aG_i1aQhkBa6k8JZ@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid>
 <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org>
 <87v7o0i7b8.fsf@kernel.org>
 <aG_RcB0tcdnkE_v4@Mac.home>
 <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org>

On Thu, Jul 10, 2025 at 05:05:25PM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 4:42 PM CEST, Boqun Feng wrote:
> > On Thu, Jul 10, 2025 at 02:00:59PM +0200, Andreas Hindborg wrote:
> >> "Benno Lossin" <lossin@kernel.org> writes:
> >> > On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> >> >> +/// The trait bound for annotating operations that support any ordering.
> >> >> +pub trait Any: internal::Sealed {
> >> >
> >> > I don't like the name `Any`, how about `AnyOrdering`? Otherwise we
> >> > should require people to write `ordering::Any` because otherwise it's
> >> > pretty confusing.
> >> 
> >> I agree with this observation.
> >> 
> >
> > I'm OK to do the change, but let me show my arguments ;-)
> >
> > * First, we are using a language that supports namespaces,
> >   so I feel it's a bit unnecessary to use a different name just because
> >   it conflicts with `core::any::Any`. Doing so kinda undermines the
> >   namespace concepts. And we may have other `Any`s in the future, are we
> >   sure at the moment we should keyword `Any`?
> 
> I don't think `Any` is a good name for something this specific anyways.

Well, that's the point of namespace: providing contexts for a name, and
the contexts can be very specific. I'm sure we both have used "any" in
English to refer something specific ;-)

> If it were something private, then sure use `Any`, but since this is
> public, I don't think `Any` is a good name.
> 

This essentially means we keyword `Any` as a public trait name, then we
should document it somewhere, along with other names we want to keyword.

Regards,
Boqun

> > * Another thing is that this trait won't be used very often outside
> >   definition of functions that having ordering variants, currently the
> >   only users are all inside atomic/generic.rs.
> 
> I don't think this is a good argument to keep a bad name.
> 
> > I probably choose the `ordering::Any` approach if you guys insist.
> 
> I don't think we have a lint for that, so I'd prefer if we avoid that...
> 
> Someone is going to just `use ...::ordering::Any` and then have a
> function `fn<T: Any>(_: T)` in their code and that will be very
> confusing.
> 
> ---
> Cheers,
> Benno

