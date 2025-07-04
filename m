Return-Path: <linux-arch+bounces-12568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C80AF9BE7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EA21C47CDF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201A2E371B;
	Fri,  4 Jul 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsZXzHag"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF972E3704;
	Fri,  4 Jul 2025 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663880; cv=none; b=lC4QClMOJ/b0dqTBaKYzJg5VIP+CEUNzDeBPO1Kr8/6BNCEXgDCGP3r+aeKVOo8ec76iqcw/NPrjLU4mT6+gH1IA6sQIcirpCuFPmEjojGrRkf1JWLkjV7bk334Zt1FEZ/7csV6mmSOKwV6KPVnaLnbnQAepXZp2qy1x944qScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663880; c=relaxed/simple;
	bh=Gr1AENL8omqeg58YziM5D+5S+Z8p5ITgVQxIMNJauqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyJ8SOv/DEGpbIgXjmAppRWIJAp8XxqLGsCBooAkKtVV412oIPeySBJKDNdRwEIe+eBtQ/sGjDrNRUjZvm5AXCgtXLn1oXbquQVFRUQL4RObkx5j470ugBAyV8Y6gXSGZ8s9TVgmETscS+qKffK3b4PAwqD/+wpatU7S9f9hmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsZXzHag; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d5d1feca18so153183585a.2;
        Fri, 04 Jul 2025 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751663878; x=1752268678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6g06lWeTWakOM4wiACkQflH/8oh9d55O8OKAmGD9Gw=;
        b=SsZXzHag9BOALbivKvsGFqe5N+7L8HChIlUVWZi07qq7xa14/LqspmvqNMwmPzHf2q
         ONb7k6smsTvYetdOWc49c2jTX2NE5NEQrax4rq709AbYyXly4JzU+7Qzq5hw8qSHyGMT
         NDZFUQnCxImwuGdWZHRk1B2Dqhr6MX99G3m7e72qqY7cb9ZsDn5xmPlvYLcaRifyVuKH
         pPOGHEhlrMF53Jbe8hzv+hj4TKDIkhHebIJYSgy5Bs41n/B1it2Ja3sZhFPKviA8Ri9m
         gU5mEth4O0BVqK+9Pq0Y7NtQZLnyGb3ddPsfwHI84Rwgsh+gCwebD1h2iRaMu7YE7Pnp
         DHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751663878; x=1752268678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6g06lWeTWakOM4wiACkQflH/8oh9d55O8OKAmGD9Gw=;
        b=BRQHloLUVB7SzItPAOh2TU3d4xarz8tW6KHDqkD8VDzhIZkJzkgtjfcamdat8eANhb
         VkHHaJbC2L32iq56pVDnRMcEm3ZpIow017HS3I4mA9klB3haxAkRIlBzETdkAX5nyC9e
         5GMFLpOwKyCLgwCHpxQNSyVYdYJWMu1tchlhqNmNToq+/s84tgBK7ZEtZJtUqzU9cfWF
         3N3JhwxyoPlHLRLFGdukA/60WPniUT7gk5AteSnaQwx3ZpRErIEV2ZJhbjU0Vb0FR5tn
         ZYm1oiCrDPolQuvssfTKHuq6ScPqJZL5K4eMqHOt4fzopoNzNcK3SdcSjx1Y0meAab87
         6Ftg==
X-Forwarded-Encrypted: i=1; AJvYcCUJYByekzDfnN3noZPTaRAlbkpoMgDhjFPW6/AcNkkXE85zoIDR2prZqWNvO6y6oLt4k0EVe7wNzXUOkGup@vger.kernel.org, AJvYcCVWKBIK5TPwPKlLpMWbp0aOjtW3KlrKVvxcn2c3NBWHOiezCkrKF8K5cxZjjhl0inMJECw7REddRqSA7PMOQFg=@vger.kernel.org, AJvYcCXRnA6c7iNmrFK63uNpA9yEz183rxJzO6NW2/TPBZ8Vy/qlSH97wcpGKQX7/dxFYY1A0YvLLXy+2U8F@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjBtCdAzYEvfBs9MAmHQ2h6Gv9A/a5vnQStnLHxwLll0qhRWZ
	CDElX4zPf1PUMMVje/41aq9jchO8u7sxXcSU4utA8ALk7BRlveuUf1Vw
X-Gm-Gg: ASbGncvl5C8yRrfQo/ls1Vp9KdnpJFZpDikpdMOThqbXoFHMQddhFoBhFa1/oXkbAY4
	FnaMKG41H1TVI+DW931Bst/NToQGOtVS29nS2fgD3EccZO0H6Ag9W4K8nviLrbW1eAZcJm3DNNF
	M2K2ZMG9eZvZXyF5U84lwHBh4kn9Ll1AkatmMCIRiOIqpJCxWcALImQkLgBoVFwNK4jMHkmTHMo
	Lm8EmKKQfIOAnjzIq0Ck9AYVNVivAamJk5Fg07AO16jqsDGxK7lvaazCPwe3NFJ2MmkTtiH0oQr
	EFE4I7OksQve/GPXAIP7ZkBDBNd62Zzqz0N3xxs5mmNxDLfuMACwsxv5AeYN5naKuh3hr40hxoV
	1xdVkChI0qIFZJiscDJR8kmcK1SqOntaQb9Qi3R/7VXpddTadgP8q
X-Google-Smtp-Source: AGHT+IEJlsBZx6dHpl9RsUUxgTLqDALrxjEfaDIgQVI21SUcCVq4DhTazTvcK4hob885cEb39t66IA==
X-Received: by 2002:a05:620a:28d3:b0:7d5:c941:71cd with SMTP id af79cd13be357-7d5df0f8a7cmr423549785a.19.1751663877712;
        Fri, 04 Jul 2025 14:17:57 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d62f2esm18299906d6.118.2025.07.04.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:17:57 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 89324F40066;
	Fri,  4 Jul 2025 17:17:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 17:17:56 -0400
X-ME-Sender: <xms:BEVoaBIQSUOnYkRQcnuJPUMwIOPQGXiIuR4FyNB_bSVcGTijqAAJTA>
    <xme:BEVoaNIfGv-zpUkyCoyLaKYC1zPdEwnkg671-hUOFUivd3iJ7vU2Tc7xX9RBBxUQr
    fIOEj96rQvlg86LqQ>
X-ME-Received: <xmr:BEVoaJuQrn_XxAjvJ8Ij0nyMMdu3xg8TGRXeE8PgfQy-E8gwkq4z284_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdvfeeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplh
    hinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:BEVoaCZABjHPFPeiqc9tqN5SCsBWzAWFCCQgEzWbwOSN8qFsFPt6_A>
    <xmx:BEVoaIY4l9C2DyGXupNe41Y11gurZL-uYfIlHabzQrpvb3494SpwPw>
    <xmx:BEVoaGARmn3D5vqVASO2rKIezF5q70iJ7jreVTuai0T1eNUBowLeKA>
    <xmx:BEVoaGY3U52vC1QauLFjzSrzy5dWes_dAiDN9aCXbLz_8b90ZLFlYQ>
    <xmx:BEVoaEoH7U5xVys3nDxG0ZthHEWGzQ0CvMrzjNOrUKGwAeW6DT3Xwp8->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 17:17:55 -0400 (EDT)
Date: Fri, 4 Jul 2025 14:17:54 -0700
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
Message-ID: <aGhFAlpOZJaLNekS@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home>
 <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>

On Fri, Jul 04, 2025 at 10:45:48PM +0200, Benno Lossin wrote:
> On Fri Jul 4, 2025 at 10:25 PM CEST, Boqun Feng wrote:
> > There are a few off-list discussions, and I've been trying some
> > experiment myself, here are a few points/concepts that will help future
> > discussion or documentation, so I put it down here:
> >
> > * Round-trip transmutability (thank Benno for the name!).
> >
> >   We realize this should be a safety requirement of `AllowAtomic` type
> >   (i.e. the type that can be put in a Atomic<T>). What it means is:
> >
> >   - If `T: AllowAtomic`, transmute() from `T` to `T::Repr` is always
> >     safe and
> 
> s/safe/sound/
> 
> >   - if a value of `T::Repr` is a result of transmute() from `T` to
> >     `T::Repr`, then `transmute()` for that value to `T` is also safe.
> 
> s/safe/sound/
> 

Make sense.

> :)
> 
> >
> >   This essentially means a valid bit pattern of `T: AllowAtomic` has to
> >   be a valid bit pattern of `T::Repr`.
> >
> >   This is needed because the atomic framework operates on `T::Repr` to
> >   implement atomic operations on `T`.
> >
> >   Note that this is more relaxed than bi-direct transmutability (i.e.
> >   transmute() between `T` and `T::Repr`) because we want to support
> >   atomic type over unit-only enums:
> >
> >     #[repr(i32)]
> >     pub enum State {
> >         Init = 0,
> > 	Working = 1,
> > 	Done = 2,
> >     }
> >
> >   This should be really helpful to support atomics as states, for
> >   example:
> >
> >     https://lore.kernel.org/rust-for-linux/20250702-module-params-v3-v14-1-5b1cc32311af@kernel.org/
> >
> > * transmute()-equivalent from_repr() and into_repr().
> 
> Hmm I don't think this name fits the description below, how about
> "bit-equivalency of from_repr() and into_repr()"? We don't need to
> transmute, we only want to ensure that `{from,into}_repr` are just
> transmutes.
> 

Good point!

Btw, do you offer naming service, I will pay! ;-)

> >   (This is not a safety requirement)
> >
> >   from_repr() and into_repr(), if exist, should behave like transmute()
> >   on the bit pattern of the results, in other words, bit patterns of `T`
> >   or `T::Repr` should stay the same before and after these operations.
> >
> >   Of course if we remove them and replace with transmute(), same result.
> >
> >   This reflects the fact that customized atomic types should store
> >   unmodified bit patterns into atomic variables, and this make atomic
> >   operations don't have weird behavior [1] when combined with new(),
> >   from_ptr() and get_mut().
> 
> I remember that this was required to support types like `(u8, u16)`? If

My bad, I forgot to put the link to [1]...

[1]: https://lore.kernel.org/rust-for-linux/20250621123212.66fb016b.gary@garyguo.net/

Basically, without requiring from_repr() and into_repr() to act as a
transmute(), you can have weird types in Atomic<T>.

`(u8, u16)` (in case it's not clear to other audience, it's tuple with a
`u8` and a `u16` in it, so there is a 8-bit hole) is not going to
support until we have something like a `Atomic<MaybeUninit<i32>>`.

> yes, then it would be good to include a paragraph like the one above for
> enums :)
> 
> > * Provenance preservation.
> >
> >   (This is not a safety requirement for Atomic itself)
> >
> >   For a `Atomic<*mut T>`, it should preserve the provenance of the
> >   pointer that has been stored into it, i.e. the load result from a
> >   `Atomic<*mut T>` should have the same provenance.
> >
> >   Technically, without this, `Atomic<*mut T>` still work without any
> >   safety issue itself, but the user of it must maintain the provenance
> >   themselves before store or after load.
> >
> >   And it turns out it's not very hard to prove the current
> >   implementation achieve this:
> >
> >   - For a non-atomic operation done on the atomic variable, they are
> >     already using pointer operation, so the provenance has been
> >     preserved.
> >   - For an atomic operation, since they are done via inline asm code, in
> >     Rust's abstract machine, they can be treated as pointer read and
> >     write:
> >
> >     a) A load of the atomic can be treated as a pointer read and then
> >        exposing the provenance.
> >     b) A store of the atomic can be treated as a pointer write with a
> >        value created with the exposed provenance.
> >
> >     And our implementation, thanks to no arbitrary type coercion,
> >     already guarantee that for each a) there is a from_repr() after and
> >     for each b) there is a into_repr() before. And from_repr() acts as
> >     a with_exposed_provenance() and into_repr() acts as a
> >     expose_provenance(). Hence the provenance is preserved.
> 
> I'm not sure this point is correct, but I'm an atomics noob, so maybe
> Gary should take a look at this :)
> 

Basically, what I'm trying to prove is that we can have a provenance-
preserved Atomic<*mut T> implementation based on the C atomics. Either
that is true, or we should write our own atomic pointer implementation.

> >   Note this is a global property and it has to proven at `Atomic<T>`
> >   level.
> 
> Thanks for he awesome writeup, do you want to put this in some comment
> or at least the commit log?
> 

Yes, so the round-trip transmutability will be in the safe requirement
of `AllowAtomic`. And if we still keep `from_repr()` and `into_repr()`
(we can give them default implementation using trasnmute()), I will put
the "bit-equivalency of from_repr() and into_repr()" in the requirement
of `AllowAtomic` as well.

For the "Provenance preservation", I will put it before `impl
AllowAtomic for *mut T`. (Remember we recently discover that doc comment
works for impl block as well? [2])

[2]: https://lore.kernel.org/rust-for-linux/aD4NW2vDc9rKBDPy@tardis.local/

Regards,
Boqun

> ---
> Cheers,
> Benno

