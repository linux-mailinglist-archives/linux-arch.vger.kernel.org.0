Return-Path: <linux-arch+bounces-12673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F29B022D5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB07B5A75CC
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10EE2F1FF5;
	Fri, 11 Jul 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgBzsX2S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A82F0059;
	Fri, 11 Jul 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255686; cv=none; b=egITNgJ3yAGKXgQ+qpkGZJ5hoiIWCIhjMqsMxFzrWx91NUfxG6PtfxPQe0oNgj9dyS5GYNiLp5gNZhUZSVe2zJngnncX6gYZNtjleEdQ5vu3PsHcIXjzTCXDt4YxTINqvfsJSFEVt7PHlcEbMtzQ/5+VYfWbgu5+PdniK1wKhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255686; c=relaxed/simple;
	bh=cLCnHVj8+ljirWOQd9O5cfG0RwK/Ng5yYUvNiegINwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=payXZ89FNK1XD+Tu2Jqq4/+yRzSoKTlfisrb3TMDUSHmoOaJwBsOFf6XA0BIZ9917jc4g9hSLFOl6YF/LDgcAjK3/5R9R2MPXqB3xjndM3+izsn9ke25b+b9peiJm1Szuvw4m22ipVEoPL8yai7ThhgSD1BKXlneNaIHiQo4jV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgBzsX2S; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3f192a64eso239585785a.2;
        Fri, 11 Jul 2025 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255684; x=1752860484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJrUSlSVEvMRxwYdMNbEMJhgahQGA2PT4SXVfE7Jw6U=;
        b=GgBzsX2SdxpCCgdBhLgXwZA1SQOI7swaG9r71707+FQJfZNwNt561NPKH6FdiWsRuh
         FS4sowRW79Xlj6y5KiBvfPpDxzMr1jJAF25/rTHGn3vaEqrKM7E1RgZrMVdTtZeBqsVm
         buDZLp8k5LLMaLC1rYX+na47GGpdv9t+zIx3dFXUoE9wwGQ0N5AyDGcq32Sm4lcOu07X
         iRcweF+olJO2Nu4WjIYvdcEpE8q62HCDmyVvyBrIx4JXcyEpo/A02SPFnj8qrWbuONvM
         VikSZAPytA+gyUlpWt7tmqr+eZeJG2j8vacgwigU5cXIQCqa+HNjvD4SlUN+XbZH2CQi
         BmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255684; x=1752860484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJrUSlSVEvMRxwYdMNbEMJhgahQGA2PT4SXVfE7Jw6U=;
        b=lcppWYez+FFylEhF5Cbiiq9S0dpWH2vDTlzW5jQhu+TOz06J/3zEROnpd3ti/QC/cV
         zdAqsD/SIMutV69m3crqXQG5RExUu16pY1B1Camrbp82067Tja7umPsdM1OCCad/hLTu
         IJu2q+UbWmGGgVvewDmNUdiybAfmRigva96UY7tyIbVJJ/6bCOltXTIxTv6Wqo0CxGLu
         f/DrhtrCTLB+OQiFfx1Difx68Abit0we+up3FgtMp7E1mhWpmae0QeIYUYtAY8n38e1R
         d1wy3HDsbLZVQ0E7YhSgy9Q23wRbT+FrfAqOT+3h3jG7G8flUDQyrS4br1EaNJu/rtdI
         HZbA==
X-Forwarded-Encrypted: i=1; AJvYcCUuDfBqqTNKePQSDAXT0rsRdGSSuRwgMoSJjHo5mxjq3+54dUO5yt+6lYXCqkE9z0DxmzzoiMdTqJM2@vger.kernel.org, AJvYcCWLrp+WbU1gjnSkRS4j+08kLnkyLP7GSwRrlqrwyvaKzYrIG/2xOiAoLEnZ3/F+e9htUWDTRxU2dp6ar2gxieA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkXx+E+2idPUk24xpHqnf6bTw7TMjl9jtXvF5dJ4ZTwMMDJ2E
	N+Ig3WHEt4EwRKkSBFfNixB7H/f41VskukIpHhYFdIywzmTldCFlgVOF
X-Gm-Gg: ASbGncvMXqfA4mlUa1Wh5vI1SocdGSMbcTlpyH+8Y3hNj6V28PiV1pag5LQAeXPswtc
	bVNsSAgh+LDyACosNUlBP/LrDzMzjWTYeUMc9/7TBRtOUZEVcns42dTvxelGGW4O5goFbk5SkNE
	8cv63u972FyyUSwqjdEfAldSC8TwBnOqoVx0PNd9uWI+Fkc9jea99G8pm9w88PB6/PaHHtAXtbg
	3G83y+bzKBi+oXW95bsWPyKqGIh4xMMzfqpIqz+vMWSly+Y90C8MsauHF84JmqYc3JNm1OxzBMc
	jNz4jOqNOAuA3lKtktCQK3TaW4ndikWXv+TBGv291lOLLyn1sY8hEqq8J0P3srA/APnicFmEcED
	yZQ7t5UBjKfgnoztp15DN6P7cXESRBoD0IUEN9BQQbtNggHuFXs54lakoiwXNNuSrIKTGgL08gO
	MdUf1Wne4t8E5v
X-Google-Smtp-Source: AGHT+IEcFHrrYSnrwFhqhrk9tfxFNzDW4C13SuHJUTonHuOx1CvcqAtuBC6NXdqwFyUvNyOH4KWBcQ==
X-Received: by 2002:a05:620a:708d:b0:7d3:ed4d:f865 with SMTP id af79cd13be357-7ddebc9346dmr618146085a.32.1752255683529;
        Fri, 11 Jul 2025 10:41:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f7d11sm242440585a.38.2025.07.11.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:41:22 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1FBECF40068;
	Fri, 11 Jul 2025 13:41:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Jul 2025 13:41:22 -0400
X-ME-Sender: <xms:wkxxaICFJ46BxfQFwqZtzFxeTeNAilTvmuVO-4QAqttNLn8I-bQHAQ>
    <xme:wkxxaMBAlmRcN8Xjcw10oA50F-WGycKcv9gtD0Ky1zkkgSo-nYKDySdRkQEP2e9wG
    2_roNOOZXim6qyYcA>
X-ME-Received: <xmr:wkxxaAJxNUfuvPRGZGYu24Z-oKjyRhTMBknx6X8uuWfagOkQFUyJA_uJMhZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeelgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:wkxxaOSTEuPnQhYpOqi7fLV7VbzHWxLG5CGVoBsQ2lPk3sqmSCC5hA>
    <xmx:wkxxaLQn7yXgpOYzqzLbhg-5g8ZQ7HdRVbgqvg3gx2rCyXzXMfuRTA>
    <xmx:wkxxaB62E0DsNYDK1Wn9uvODd414YWUPab0U4a6p1ZVFvVyxZu3otg>
    <xmx:wkxxaIGIXDX85jJHDtw4fKSFA-cqUcZrxsSTWzfWRaPPxna0jduSiw>
    <xmx:wkxxaCnmo40D1mtQOvNhFdKkstEwx7sI1oGb8HQA7L4npbpdBCj_NSXE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 13:41:21 -0400 (EDT)
Date: Fri, 11 Jul 2025 10:41:20 -0700
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
Message-ID: <aHFMwB-aL7Lj_twN@tardis-2.local>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>
 <aHEiE0OoA3w1FmCp@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEiE0OoA3w1FmCp@Mac.home>

On Fri, Jul 11, 2025 at 07:39:15AM -0700, Boqun Feng wrote:
[...]
> > > ---
> > >  rust/kernel/sync/atomic.rs         |  18 +++++
> > >  rust/kernel/sync/atomic/generic.rs | 108 +++++++++++++++++++++++++++++
> > >  2 files changed, 126 insertions(+)
> > 
> > I think it's better to name this trait `AtomicAdd` and make it generic:
> > 
> >     pub unsafe trait AtomicAdd<Rhs = Self>: AllowAtomic {
> >         fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
> >     }
> > 
> > `sub` and `fetch_sub` can be added using a similar trait.
> > 
> 
> Seems a good idea, I will see what I can do. Thanks!
> 
> > The generic allows you to implement it multiple times with different
> > meanings, for example:
> > 
> >     pub struct Nanos(u64);
> >     pub struct Micros(u64);
> >     pub struct Millis(u64);
> > 
> >     impl AllowAtomic for Nanos {
> >         type Repr = i64;
> >     }
> > 
> >     impl AtomicAdd<Millis> for Nanos {
> >         fn rhs_into_repr(rhs: Millis) -> i64 {
> >             transmute(rhs.0 * 1000_000)
> 
> We probably want to use `as` in real code?
> 
> >         }
> >     }
> > 
> >     impl AtomicAdd<Micros> for Nanos {
> >         fn rhs_into_repr(rhs: Micros) -> i64 {
> >             transmute(rhs.0 * 1000)
> >         }
> >     }
> > 
> >     impl AtomicAdd<Nanos> for Nanos {
> >         fn rhs_into_repr(rhs: Nanos) -> i64 {
> >             transmute(rhs.0)
> >         }
> >     }
> > 
> > For the safety requirement on the `AtomicAdd` trait, we might just
> > require bi-directional transmutability... Or can you imagine a case
> > where that is not guaranteed, but a weaker form is?
> 
> I have a case that I don't think it's that useful, but it's similar to
> the `Micros` and `Millis` above, an `Even<T>` where `Even<i32>` is a

Oh I mis-read, it's not similar to `Micros` or `Millis`, but still,
`Even<i32>` itself should have the point.

> `i32` but it's always an even number ;-) So transmute<i32, Even<i32>>()
> is not always sound. Maybe we could add a "TODO" in the safety section
> of `AtomicAdd`, and revisit this later? Like:
> 
> /// (in # Safety)
> /// TODO: The safety requirement may be tightened to bi-directional
> /// transmutability. 
> 
> And maybe also add the `Even` example there?
> 
> Thoughts?
> 

Or since we are going to use fine-grained traits, it's actually easy to
define the safety requirement of `AtomicAdd` (instead of
`AllowAtomicArithmetic) now:

    /// # Safety
    ///
    /// For a `T: AtomicAdd<Rhs>`, the addition result of a valid bit
    /// pattern of `T` and a `T::Repr` convert from `rhs_into_repr()` should
    /// be a valid bit pattern of `T`.
    pub unsafe trait AtomicAdd<Rhs = Self>: AllowAtomic {
       fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
    }

Thoughts?

Regards,
Boqun

