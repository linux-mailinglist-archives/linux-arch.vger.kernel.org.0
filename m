Return-Path: <linux-arch+bounces-12447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90496AE6C83
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065161C224E6
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526912E2F1F;
	Tue, 24 Jun 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE88l1xH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2D2E3B18;
	Tue, 24 Jun 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750782927; cv=none; b=gKTQgzBkg8xR2oj0P5wxx46H+9UjfTd1sNnRHIPLwu/1GvUAFG8OEb0F45RjLYMYO1+Hj5+6sKmJ2YESJsjM1+wfAEtuWWwNXT+gYj3xP/4IN9m8l4o3rQwS2oA5h4fHH2iPRbJwZrOMK9Q62SY4sTz+PSCHzPnhQ/kmaiy4Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750782927; c=relaxed/simple;
	bh=LjV6uqFkDZ7WeWyzUybyEtVZAFyO4GSfRKdGE3HZLG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X//VV2kfzYNUCnNFe1dWqykBWOYMnBJWXDciEeJeXsNCD1HVj2UGSi4JuIQL2YBh1DUupF3PkrRCEODwqzWB9O80QZOd8/O68MY/9+PdYE/gAS2SheMNjoPcviIv9YRBorTBtZ48xPA0mO3XpCrFx/BmbicnepH+UDPE+lX+w5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE88l1xH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad79433bbso53847086d6.0;
        Tue, 24 Jun 2025 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750782924; x=1751387724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QNqquuevQzO214EF0t3CB2Yl6DSj/hm7kyzxr3XDUE=;
        b=TE88l1xHckn9u7OhWVwWygLRzBQ1jj3Ekh8ORGMb9IzFQc9MXg0lsELe4Dz+qxH0jr
         zveFPAmsLqbQpMnsVZiOaUR/Hxa6+xoqONx4t0QdSJQOiZGiLBp/58faHVtFHyxxmlVw
         4YWXf2JqWrzV5paGaXc3wnnckoOTzlvrpQd6QUhGqJcZ06j/7zMfoBQMsSOmy5YEaPQh
         O8crvv5bxegIlS203x99OKU3gATdooBurEg0u5f5aewkvFc54KBiAQLdyhNWo2gGj7MN
         6Nb0yY+gQYs0jWHa1tWZGpOCYCzwHj1QLyt0Y3WyLY9Y/qufBw8S+Zw4KwWsnpxUdrti
         wEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750782924; x=1751387724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QNqquuevQzO214EF0t3CB2Yl6DSj/hm7kyzxr3XDUE=;
        b=gQQR+YUiYBZjsl/uMMvafSi5XZFsuFRg3ebNP8LVy226iSi/r924LmZ7MX2Nt2NXoS
         8z1f9PaoJSSK8yGXuFRkjgLGWwCcZZLJdzh940k3WJHgs1CAb6gFRIfxhrvxYp/ZBzOC
         EQ+siq/llPCUbJmYbu0gmzwigFQVZ6FouEs7u+DN9mSlfnb22/mB1Ho7uKrgrufFGOfF
         QbBRd/klHdHz8E+gYZKL4XPTb1o0ROB9+McEq+EfVx6uYz08t2er5tgfesy3FKVFawMN
         DOKg2jxlwtR+jDo6p/AVDGfHMUIMZeknAiuMJj4i3m+Dtx+jPGcCm22zDc/kFIAbVoYx
         bJug==
X-Forwarded-Encrypted: i=1; AJvYcCUfn09+0BsWb7cDzjU/vvjOyFkiqzF9kT5cVU6WoGMgNeC1mHt0Znb0v34bjjZbrKf7IGABag1C96zxmyeM@vger.kernel.org, AJvYcCV4mivcn22HTlb6zKfmYy53vbQYakUZLdvzvswcGInhMLJ7URU7VuD+os3ttv+gIiHP5fX/svula+Tz@vger.kernel.org, AJvYcCVWSBixJs4/qPKZZ32d0jSglOiwbrqPItaofVqiqkFlce60B+Rcg387Y+oh4DbRj5YsGL29kTeDW8IBTgWrGe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eC7f2Znm0WQDPS3q1wPnl+JqJGdncPywqieP/v5iwEamgvZZ
	ky3bOWdNL5XExHngQFvzv0/iMWSN9vkBxliPklD9+0rM/iKVT6YNzKVI
X-Gm-Gg: ASbGncvCMg8YWu/eyjexo5hOGSl4+ohRljMudsuyaCGGGPLMOMt49EEocr4JHnIfkZa
	M10aHIu0bAmMKKN3ZM7N0MZEmOUNRA9Mrza47y/PgSC+SbKN33Ac58Jd371bTRc0Iz9TsnyYLw4
	Cypxu06H6RH+3Raxhl8Xy784y8Qp3j++l+BOW0VKyRoshv42ZwfsyO75RH93g+3BOsceOdDtllW
	f17RMWxOH0zpTIQ1t6oYWJhcYToOTS5k7IU1mIcwu+B75uGC0k0X1a+hNv5a9Af8UJ2ER1lSFIJ
	gzj0RJqxeX9fMn39jC/xIy5+GIOPjhy+fA6FYg7S4nIO4eymEv7dUmNBJmJfgqeVVpdxoRnvgMq
	TMd1B1+Y4u91iZGA74o1NmCFtixo+Ewui58i8mmOIoElc/pHJ5NhnDAa7CHzZNXs=
X-Google-Smtp-Source: AGHT+IEPMlsFrV06xtIotQuWrty2uBXXPCKpsgJkwOxW5ihx34pxGRbrnlY3mm+GvFIAEGYs+rloYg==
X-Received: by 2002:a05:6214:20c4:b0:6fa:cdc9:8afa with SMTP id 6a1803df08f44-6fd0a50af00mr284466746d6.17.1750782924419;
        Tue, 24 Jun 2025 09:35:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0954430dsm58565536d6.65.2025.06.24.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:35:24 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5D63D120006A;
	Tue, 24 Jun 2025 12:35:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Jun 2025 12:35:23 -0400
X-ME-Sender: <xms:y9NaaOjA-JnUE8R0_6UFw33RJauVdhVzIfbHzE2yMSdpGvuYjVdm6w>
    <xme:y9NaaPCuEFpGDLx71ItSOxUXlBYSaz8VjvkSMlHpy8m-VkcAyfl7dXTvHQEtMUq7u
    h1-jSoyEtKoiHZSHg>
X-ME-Received: <xmr:y9NaaGF05rK9iRfoFHdreuq9f0NsfObOes-lzSyr9oD4ET5jRZcmQ3moJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:y9NaaHQf_uRax2x0Xhu1rzQgl4Kolr71lvGkDvqzPlai7wN9K06e1g>
    <xmx:y9NaaLxgqaMZ_S0VZZKkoxYRRzs9ADvECjlCrhaN8vInW0xI2eI0FA>
    <xmx:y9NaaF60PZIgYbS5s1acOYfINQtagIA8ZAkUMjjo4BOQzRIwWLW0YQ>
    <xmx:y9NaaIzRl_HuMXe8Tq5E4pVBz_gVSFH53EUbIvhcIR7yLs66nYSNkg>
    <xmx:y9NaaHjNqOH6cY_twN0wO59ZxG7DFG5c5NhxTK41Ce42jTCmJkqNSr5g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 12:35:22 -0400 (EDT)
Date: Tue, 24 Jun 2025 09:35:21 -0700
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
Message-ID: <aFrTyXcFVOjWa2o-@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
 <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org>

On Tue, Jun 24, 2025 at 01:27:38AM +0200, Benno Lossin wrote:
> On Mon Jun 23, 2025 at 9:09 PM CEST, Boqun Feng wrote:
> > On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
> >> cannot just transmute between from pointers to usize (which is its
> >> Repr):
> >> * Transmuting from pointer to usize discards provenance
> >> * Transmuting from usize to pointer gives invalid provenance
> >> 
> >> We want neither behaviour, so we must store `usize` directly and
> >> always call into repr functions.
> >> 
> >
> > If we store `usize`, how can we support the `get_mut()` then? E.g.
> >
> >     static V: i32 = 32;
> >
> >     let mut x = Atomic::new(&V as *const i32 as *mut i32);
> >     // ^ assume we expose_provenance() in new().
> >
> >     let ptr: &mut *mut i32 = x.get_mut(); // which is `&mut self.0.get()`.
> >
> >     let ptr_val = *ptr; // Does `ptr_val` have the proper provenance?
> 
> If `get_mut` transmutes the integer into a pointer, then it will have
> the wrong provenance (it will just have plain invalid provenance).
> 

The key topic Gary and I have been discussing is whether we should
define Atomic<T> as:

(my current implementation)

    pub struct Atomic<T: AllowAtomic>(Opaque<T>);

or

(Gary's suggestion)

    pub struct Atomic<T: AllowAtomic>(Opaque<T::Repr>);

`T::Repr` is guaranteed to be the same size and alignment of `T`, and
per our discussion, it makes sense to further require that `transmute<T,
T::Repr>()` should also be safe (as the safety requirement of
`AllowAtomic`), or we can say `T` bit validity can be preserved by
`T::Repr`: a valid bit combination `T` can be transumated to `T::Repr`,
and if transumated back, it's the same bit combination.

Now as I pointed out, if we use `Opaque<T::Repr>`, then `.get_mut()`
would be unsound for `Atomic<*mut T>`. And Gary's concern is that in
the current implementation, we directly cast a `*mut T` (from
`Opaque::get()`) into a `*mut T::Repr`, and pass it directly into C/asm
atomic primitives. However, I think with the additional safety
requirement above, this shouldn't be a problem: because the C/asm atomic
primitives would just pass the address to an asm block, and that'll be
out of Rust abstract machine, and as long as the C/primitives atomic
primitives are implemented correctly, the bit representation of `T`
remains valid after asm blocks.

So I think the current implementation still works and is better.

Regards,
Boqun

> ---
> Cheers,
> Benno

