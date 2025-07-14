Return-Path: <linux-arch+bounces-12745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04EB04261
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4BF169008
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825E25A320;
	Mon, 14 Jul 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDpgHVEB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF367234984;
	Mon, 14 Jul 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505175; cv=none; b=GCAXsQWKCr9/OrdyXg7lElzzezy4Me772Y89nx5+1lqd/+Ja3DgU4t3hAjR9zdLpHdkF8LG+rgGSCZf4n6VAv2HI6oflI1GplgTK5171F4xvkNMxCvx4+eNHlc6MISihLCL2mwpIBrRvHBwK838Dc1cr3eXpQHoCeVr756IbW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505175; c=relaxed/simple;
	bh=gnPNfGNhvz8u1TxFQVMlnCmvFMjVfxzTigxWK8CCFAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHzz8n7gIMGgGrxOfFc9TJNGYg+KbYMMt4wMkTy3JG+OtHMd/A6a5BtYpK0qZ+Egackxn38+p3oM3kW1uFD8PT0SCgy6linKiBI0sqIjHtIl0tEZvLjUaCksJDkK5XczMho8wPImn1zEsQEiZrA1SPq98wRUtkQM/X1zCvIKPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDpgHVEB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fabe9446a0so36416036d6.2;
        Mon, 14 Jul 2025 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752505173; x=1753109973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emm0Lj04Ala0s2Dvnm1J6cHglimWIHUYLnLqb+co8Ck=;
        b=SDpgHVEBGR4y3fB7kWQ9gsQWNksFHV5a5JACXtyQ2zth3h+bVhsMk6rb5sOZnC/2q2
         F11xcxc3hgebeEaG9gQCZs4Bsfut6mM0JEe44r/DWJ6WWjBG8FHBEYHc/UE9kn4ut+CC
         9sPkzdMw02LKxW/mpIlC1qwWzNd5Ib9wdu4yLJ6I7Llspq/6i6e1v3Umy7Ey0srr8079
         aP3hA/v/5RBL96oqFsVGgRdXHtk4wdyctkA8UFJbONZNtGuR9/wh6f5cpRZZ3TPnpjZv
         ePCIomgAbmfxo1cxFo1VPOHS8vJ6EfPjcqmjkYwGQubNP1QinKwXMqnw+x3AyjSd6cbA
         sZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505173; x=1753109973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Emm0Lj04Ala0s2Dvnm1J6cHglimWIHUYLnLqb+co8Ck=;
        b=WBKhAqOuwl/Jl1Nhju6tBGdCqMtgcGN8IlNkQ4/gJl21pTYsVbFr90gFzkLlSDf2l+
         sDaEHVEk7GyCMr7e7+Jq5jYM1WjDPBMO1hqDUyvX5HYUaDC7I9fhW4fHkLm5QSYa7XJm
         f1tV7ucQ7nXoEsdeCKlNR7iLExCsP/HmCAHJWzM1GI3TA8NMqiGk1ZeRS3TZhg7Oe0dm
         47IRhDoaTu+AauImkNMhybQJheK8VX9H/HVytDXEOr+6eg2KHi9ThtfUqEA+GN0BV7l9
         gPMX7AfMHPSoKjk+k0J8iARAsKg8z+WVObFz4g/fAJh++gcJwiOnDdqYJgpKz4YP2Hz1
         gLzg==
X-Forwarded-Encrypted: i=1; AJvYcCWUk5heyZDc3xQ0M8iBXWift0JxXYaArjX30GqH1Q14ynVQtwSxhpGkkSLAtRYY3cY1qVI7QPfmDIJr@vger.kernel.org, AJvYcCX3y4x5p75aOnziI98wQ1PjOcY7KVtWrUtNESnQ8bvNZ9WFm+U/ZortdlXB0gAkwGI9uUuw2PEbuHn34hGCcxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDp+OGkyE6eCYNGJCLck6hP4nnX2La35ZOwCI5kkwo11nQXFg
	iH31jEJ/a/LglwGAfAYUE+AkbwpRQnM10Ko6EvERQKkTRcSyzzNQ54/k
X-Gm-Gg: ASbGncvgMAgyiBXYmXLhgV6rYDfTzqV+Zgvl21XlhzWZ4ar3QY96iCf8bxNZux4CJaQ
	DQl/YRrQpgTZCU7MABgmFR5w+wZLjpaihSo05V/CeLqL58rUY2L9JcqQNONEwXiin+Iwqa/1bjf
	E8N3G0BTSimBcBJKyT8EguQKH9Hdco3XVhhxmNK8ZXH6bsXeQnB5Up+XfF9Nalt7peEnFbxF4uJ
	zvxg32/1hamtO2JP8RYd7R5SvUKk/YEih6+waxR9F+/zIs4yMGwnEcTOlFyX5HmpZOX001XPEyz
	a9Ye0k5Lx0UMqVTIl3kYRoeKzrtiUjSE6uCjB/jfT7+zNeulgeE/kGTvoIik60JlpsslWCdT2X/
	qZ2OpilriTnObq3K0LiwJu90mtTv3Tuj4deLQ6W4n4aWfF95dHiE3ygCCyoSfCw/vJ2wm0L0M07
	ZRwrJTmTAbYf1b
X-Google-Smtp-Source: AGHT+IEN00Lo4cBd6OwqcL4wVIeZqi3JBwRUPiSstExgyXkxrdsPV1jT8r+HnbjYVBvAiR/AWrB76w==
X-Received: by 2002:a05:6214:f6f:b0:6fd:24e8:7b04 with SMTP id 6a1803df08f44-704a399524amr204039356d6.33.1752505172434;
        Mon, 14 Jul 2025 07:59:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39c9dsm47646236d6.66.2025.07.14.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:59:31 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37821F40066;
	Mon, 14 Jul 2025 10:59:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 14 Jul 2025 10:59:31 -0400
X-ME-Sender: <xms:Uxt1aFVrB1b9a65mM4HncjklN42eaCeYIqtMLk7twC7mStzpeMMU-Q>
    <xme:Uxt1aHF6xD0N25-uQwxrGtiNrvTdqOE2CwT84bumWZZewDXRN3c3NhHJcyNULOsJD
    4vCV4sZRxI7obTdwg>
X-ME-Received: <xmr:Uxt1aF8H5fT_ce_BycXPBBPvUw1-0xqmM5N797Vzr2TnlpRt5A5C1DZ7Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
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
X-ME-Proxy: <xmx:Uxt1aH0nqdtKBZvCAN9D2L86sDCr5vqgfF2PUzbw8g1v-6tSC14lsw>
    <xmx:Uxt1aNl1swUhAY-1NAx43kNqACFPpgRYlV5FP1AVyuzngKBAto_15g>
    <xmx:Uxt1aN85-gTrsC92OXjm1ngaNClxF9lR7_14s3_bChRk03f3MQ3PbQ>
    <xmx:Uxt1aK4HzvkQqrlcqDP09uYidPt4KrBWYVMNeMKpMJOaeCYGBCuTjg>
    <xmx:Uxt1aFJ6tW0cornniR3noqwb9WCuh3W4e6yqBrHQQ30jNoWDQr3iU-pu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 10:59:30 -0400 (EDT)
Date: Mon, 14 Jul 2025 07:59:29 -0700
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
Subject: Re: [PATCH v7 3/9] rust: sync: atomic: Add ordering annotation types
Message-ID: <aHUbUZZ-8Z9kspds@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-4-boqun.feng@gmail.com>
 <DBBP3E8PZ81U.2O0QHK1GQXKX2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBP3E8PZ81U.2O0QHK1GQXKX2@kernel.org>

On Mon, Jul 14, 2025 at 12:10:46PM +0200, Benno Lossin wrote:
> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> > Preparation for atomic primitives. Instead of a suffix like _acquire, a
> > method parameter along with the corresponding generic parameter will be
> > used to specify the ordering of an atomic operations. For example,
> > atomic load() can be defined as:
> >
> > 	impl<T: ...> Atomic<T> {
> > 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> > 	}
> >
> > and acquire users would do:
> >
> > 	let r = x.load(Acquire);
> >
> > relaxed users:
> >
> > 	let r = x.load(Relaxed);
> >
> > doing the following:
> >
> > 	let r = x.load(Release);
> >
> > will cause a compiler error.
> >
> > Compared to suffixes, it's easier to tell what ordering variants an
> > operation has, and it also make it easier to unify the implementation of
> > all ordering variants in one method via generic. The `TYPE` associate
> > const is for generic function to pick up the particular implementation
> > specified by an ordering annotation.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > Benno, please take a good and if you want to provide your Reviewed-by
> > for this one. I didn't apply your Reviewed-by because I used
> > `ordering::Any` instead of `AnyOrdering`, I think you're Ok with it [1],
> > but I could be wrong. Thanks!
> >
> > [1]: https://lore.kernel.org/rust-for-linux/DB8M91D7KIT4.14W69YK7108ND@kernel.org/
> 
> > +/// The trait bound for annotating operations that support any ordering.
> > +pub trait Any: internal::Sealed {
> 
> How about we just name this `Ordering`? Because that's what it is :)
> 

Seems OK to me, I then also followed Gary's suggestion:

	https://lore.kernel.org/rust-for-linux/20250621121842.0c3ca452.gary@garyguo.net/

and dropped `RelaxedOnly` trait.

> That sadly means you can't do
> 
>     fn foo<Ordering: Ordering>() {}
>            --------  ^^^^^^^^ not a trait
>            |
>            found this type parameter
> 
> But you can still do
> 
>     fn foo<O: Ordering>(_: O) {}
> 
> If we don't have the ordering module public and instead re-export from

Keeping ordering mod public helps rustdoc readers to find the module and
read the module documentation (where is the best place to explain each
ordering), and also I made `Relaxed`, `Acquire`, `Release` and `Full`
refer to the module documentation in their doc, making `ordering` mod
private would cause rustdoc issues.

Regards,
Boqun

> atomic, you could also write:
> 
>     fn foo<Ordering: atomic::Ordering>(_: Ordering) {}
> 
> If you want it to be extra clear. What do you think?
> 
> ---
> Cheers,
> Benno
> 
> > +    /// Describes the exact memory ordering.
> > +    const TYPE: OrderingType;
> > +}

