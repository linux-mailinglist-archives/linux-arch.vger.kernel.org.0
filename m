Return-Path: <linux-arch+bounces-12669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A5B01F4F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 16:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7FD1C2066F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3E1FFC49;
	Fri, 11 Jul 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2u4UAgP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFA167DB7;
	Fri, 11 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244762; cv=none; b=jyRsigsSxmVKuAkOir6jvM9To4I4MA0tZuzMRP5OsS/hOMmdYkGJ5Ki9v7DnZr6uG27yoPo/WMtSo03+rmxukYJCAWDJhc/zi+Ez8V5nzwqSoW3MpFZ5pull2fUjlhTj47Xlu3kmWj55k/Na98Spe/AewZvo90mouH7sYlYf9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244762; c=relaxed/simple;
	bh=M7+e+e1rmKuD/oko475gmT7iuj8HXmG3rZODkspkF08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV4soe47FAb6eda7GGSvx/BOLPoyqj7XAXAPVzo3TGjN6FuINRqrBVoKPdwtNqsYn/qwEr3hMiDlpTRkHRFox6/UU5M79aHvER2SKT1mviGTyVQ6OcGCrk5PRgtlnLO3uD8VcZxzynsk/QMa+CGn08SiYRvzDpkbfzK9E/tR4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2u4UAgP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a9bf46adedso22186791cf.2;
        Fri, 11 Jul 2025 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752244760; x=1752849560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FafGssQJy1j7DrCNrsdYFCExWgvC1bwETw0T/9WZrW4=;
        b=Z2u4UAgP/uDzJawE/yMHCQnN+2fGVV5DXnLkrXWPBCKFKjkuXyoPuhe/T/6nX5MM65
         MBYK2C9hcDbnxwu1LN717KBqHhzYkfIUs/Z9ZEzxlaSGrnRHSiJKlgLV0tT8bCSEvGZE
         o0aJBa3J9zlZiq8g9v1Wza4f0raAyYnSY5GzBNHQTO/h+1Ou09/F040juWYgeKG8N6Il
         eHyQuhw67S1IDlzC+DtzPH15QjWVP5dfTf1Zuqjp1DXpZl/5PW4AMs78jvJVZxIEzYgy
         7C1H2nTApGazc0cBnf88t6/hWk6Oiq4jH92Q5eE+6K1X9R6iYI3eOAdaFCcUj+UA2RMc
         1pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752244760; x=1752849560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FafGssQJy1j7DrCNrsdYFCExWgvC1bwETw0T/9WZrW4=;
        b=c0gmgBbD/0l6SGrf89jGH6ahOU8a6Rt4rtVzu69Wz58O1TMnIkvZi0jbloSYs8r87V
         biu5Kt0RCQzIEwm9C96VCE+Lb5yccaEbO3Csx4wHMOq6jT+EIXhCUuun88vS1s7DzfQl
         3TXPDL+0imBmgqPgwk4rXJwJRDigkLlIdyi3+6RSWCneEPao7ujJdqYBTGiHJog6HQRz
         Y8Riy1qlTYiDKQsMZm4g17rOdVFfUHzEH2soVdV6cl9JAE3xj1PYo97TObWpeEPtE640
         LXS2Ovbu7wvDiYsXLhUxrHomipIOUezMO/YzhwvWbh9uKVUFj9ym1dWBqQbRrdNb3Ygu
         CMuw==
X-Forwarded-Encrypted: i=1; AJvYcCUjiMKr/ksvn846ALNp7D3rtO5aYULxx+SPYWe8elkjm2W0bG3BNv4zKwfhEocTbjzFHm0i3+rmkflA3mURtOE=@vger.kernel.org, AJvYcCVSVnJeYJfmHWKHa3x3ibiOrVhGDa5YK0I+Z7H3YUajiwwCRrT0g5u3GSfzZqtdjc9I7Dz/cMqlFFCp@vger.kernel.org
X-Gm-Message-State: AOJu0YxVIWOlPguokHti1lYg0uzsCrVGnvgKyZhPjOuGxEH0X8aa6bT4
	xwHGtQm/ZUeSokj8/XyXrE2vqwA4GelUryHSRbvAMi6FN3N+7ipSZs+D
X-Gm-Gg: ASbGncsvBsQi63xeio8xqLxBp96M3uch1r719sfNtWHK+XLmO30FVbf1SNiYO1krbav
	QpkG3sz+Fs2ub43vE9nR12n38GHzZxjan8SGTlAjPbue1QIiTn8IiZYZ2XU5C1Ur2MKs5OccB4N
	5zSwjT5DGmPv5XNovmmggi/cjnFLfd38t2IG3Em/KPJlgn/9XVd1KbpRGRW6sML0p8yeeMQofYQ
	7TbAv8bROaKIkQYjHN2/JynD/9y3V7dCxD66+yqpEQKdF6WlNCKfdWBxix9I62p9nWE3UEuEm2E
	pY/iWIA/xvF7lSpHOc4cLWtPHD34vPDYQJCC538rRyzPISXACjdO2mcjm+ukvm9gnHUzBXPyBU6
	WB01qANPiQW7XCaxltq7yVqyK61nx6q97XODTffMaKFAvxpTkyhTACpGtpX+XBHRAOKMN1UzrFN
	EZDOYfOfn+KyrA
X-Google-Smtp-Source: AGHT+IG7i69rdabJU4rCgv47216T/BQiZX74rLkmqajWAIdu3sM+sbPVU9v9PkHjIiFax5nwv660QQ==
X-Received: by 2002:ac8:7d0a:0:b0:4a7:14c3:7405 with SMTP id d75a77b69052e-4aa35e677c6mr57233671cf.27.1752244759405;
        Fri, 11 Jul 2025 07:39:19 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9ede76d65sm22250241cf.41.2025.07.11.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:39:18 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD947F4006A;
	Fri, 11 Jul 2025 10:39:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 11 Jul 2025 10:39:17 -0400
X-ME-Sender: <xms:FSJxaPomWN0RXF4YL3OPPbNk0-4TlQoNQGmaP654lZ7Idwn7VJTzQw>
    <xme:FSJxaLKd1nVamV4_WdbqpYfSr4_0VTYpxTe7XT6VKNkgc43DjolEdxqbxr7Rrt7l2
    ARAK7-w1A4ez5fieQ>
X-ME-Received: <xmr:FSJxaAxwNv7SF_RvT1nWAFqlll7HRqzPfNP-R07dV0pqXoODAfgXJl-LjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeehkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:FSJxaCYn2nwj2LJUfEy6CFRGqD1Qo_cViDz7slCYE6CuQ2MG9CtNpA>
    <xmx:FSJxaM4mDusLEsrKkZR-mRnhkzgCanL2F9Jl9fI25Nyn0aHBPio_lA>
    <xmx:FSJxaDCwb78MsA66_pNzY4yDY416kLdfNaa930Zc92wuL-nDDOaL_g>
    <xmx:FSJxaCsuyjaSIP9EQO5e7j13oI_1UvTszZZWSodCFwSoLKhZmWmE5w>
    <xmx:FSJxaIsr4tClwP__41Ow6u40S9uL87BCRUxIW8zIVtKuchr3DA606lEB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 10:39:17 -0400 (EDT)
Date: Fri, 11 Jul 2025 07:39:15 -0700
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
Subject: Re: [PATCH v6 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aHEiE0OoA3w1FmCp@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>

On Fri, Jul 11, 2025 at 10:53:45AM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> > One important set of atomic operations is the arithmetic operations,
> > i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> > make senses for all the types that `AllowAtomic` to have arithmetic
> > operations, for example a `Foo(u32)` may not have a reasonable add() or
> > sub(), plus subword types (`u8` and `u16`) currently don't have
> > atomic arithmetic operations even on C side and might not have them in
> > the future in Rust (because they are usually suboptimal on a few
> > architecures). Therefore add a subtrait of `AllowAtomic` describing
> > which types have and can do atomic arithemtic operations.
> >
> > Trait `AllowAtomicArithmetic` has an associate type `Delta` instead of
> > using `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is
> > `i32`) may not wants an `add(&self, i32)`, but an `add(&self, u32)`.
> >
> > Only add() and fetch_add() are added. The rest will be added in the
> > future.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/sync/atomic.rs         |  18 +++++
> >  rust/kernel/sync/atomic/generic.rs | 108 +++++++++++++++++++++++++++++
> >  2 files changed, 126 insertions(+)
> 
> I think it's better to name this trait `AtomicAdd` and make it generic:
> 
>     pub unsafe trait AtomicAdd<Rhs = Self>: AllowAtomic {
>         fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
>     }
> 
> `sub` and `fetch_sub` can be added using a similar trait.
> 

Seems a good idea, I will see what I can do. Thanks!

> The generic allows you to implement it multiple times with different
> meanings, for example:
> 
>     pub struct Nanos(u64);
>     pub struct Micros(u64);
>     pub struct Millis(u64);
> 
>     impl AllowAtomic for Nanos {
>         type Repr = i64;
>     }
> 
>     impl AtomicAdd<Millis> for Nanos {
>         fn rhs_into_repr(rhs: Millis) -> i64 {
>             transmute(rhs.0 * 1000_000)

We probably want to use `as` in real code?

>         }
>     }
> 
>     impl AtomicAdd<Micros> for Nanos {
>         fn rhs_into_repr(rhs: Micros) -> i64 {
>             transmute(rhs.0 * 1000)
>         }
>     }
> 
>     impl AtomicAdd<Nanos> for Nanos {
>         fn rhs_into_repr(rhs: Nanos) -> i64 {
>             transmute(rhs.0)
>         }
>     }
> 
> For the safety requirement on the `AtomicAdd` trait, we might just
> require bi-directional transmutability... Or can you imagine a case
> where that is not guaranteed, but a weaker form is?

I have a case that I don't think it's that useful, but it's similar to
the `Micros` and `Millis` above, an `Even<T>` where `Even<i32>` is a
`i32` but it's always an even number ;-) So transmute<i32, Even<i32>>()
is not always sound. Maybe we could add a "TODO" in the safety section
of `AtomicAdd`, and revisit this later? Like:

/// (in # Safety)
/// TODO: The safety requirement may be tightened to bi-directional
/// transmutability. 

And maybe also add the `Even` example there?

Thoughts?

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

