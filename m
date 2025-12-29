Return-Path: <linux-arch+bounces-15573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A340CE69FF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 12:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13BDB3011907
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBA1FF5E3;
	Mon, 29 Dec 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+7Mvv38"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD04A0C
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009541; cv=none; b=J+29zEa+K6GTEDLg2teSk+MyhdBhBvuDLnnpIGXVIxel+JP5Wwd7TVLliDwBGv6RsQSSB38cgXPbYH/I7d5foa2Qb1CJU1Q50mu9yFEa1MgURmp+0iq0eMR4ske3L+GLDwDNC/allma/dZ7nNG+wd33mXqQefV5jORR/hw+JHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009541; c=relaxed/simple;
	bh=QdaHuz4+XalIyIGBrYqJORXm4OdGDdAIaAcu+Q5qbO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbW+0q4QinzMNOVd2sL+NA8eieFS2yWwKHB7fuu+a76UO27pQRYlnZfFglkZrK9iYAmEGy3El2Js6uYZT8k4MXgzOzIYJQH8+YvI9J4QP1izHyamOa7bd6O6/gM/tt8LUPZsghZito2W80Jj+ViS0WCoNjnQe2y/WxxjYevwYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+7Mvv38; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-888bd3bd639so120920336d6.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767009539; x=1767614339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwOlffPgoxBlHSMmCKnukNQHZsicEfKa4Lb6NhA2aGo=;
        b=d+7Mvv38OvK/kzyTci6Jc7Tn9ArYXK4orB2ucIM9gxKxAjURb970B5UABsLgbcCs6I
         nr36cA5T6novpUTwypf79QQn4bnhlq8WNwoFz72jSFIlNCtyDR0nAT24cerswolt89RK
         FNTy0os2/Eo0JQcRjPO3JHJLd1LjwVAsyd1NmgWCuj8DxIYM44OROAuTPj9ELxzx5D83
         gkLr7FDrQMqXuWAph1+V+1OaycvrTm2rxKnXKvR7TJSWhS0IAgH/tMmIKNB5AynyFmdg
         YDxk0vpTWjfFy8xAbX/77L7++sE6/OCrfh33JlYp8Zdpsd7Cq801p0EmuGj6Uw1Jg4NJ
         82OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767009539; x=1767614339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwOlffPgoxBlHSMmCKnukNQHZsicEfKa4Lb6NhA2aGo=;
        b=oOyxDoicyHewdX62ISWN2PdEf1NgmSDBh52I0qOJ9NB6gqyeQrbEROB74hiKbNR+4d
         IohT4j++PQyMUgm0kQt5QA/p40sOZp4Z5qgI1VtT8addL+RGSNXJeRpchwFR8fxi7Rb+
         JRVdd/IA2+DEpPx4KL+cpfeqgnzsRNqLu5eJZDjqqhIs4DY4EcWXgGUmuIsBEJS3w0GD
         GEzYw09hsRYzMHXibpyOoRE7oZjmVZPEAy37uipT0LsuF/8kFisKlbaVBPa6Z/DuQh5E
         8UL6HYX6VEXpL0H+nLz4KJ93nEuAXWfIHFZCFETXTLb77wFSBaTYvnD8h9/JbtcfvnTc
         8c1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvSdbBpTio3eD7TEz2SCx15pJRu910zInn4vL4VXIWTFip4ZKfgKoZvcfcd+tGMoSXU94B9vrvLxeE@vger.kernel.org
X-Gm-Message-State: AOJu0YwGifWy2UwvrVquCsgxpdx+OSJrcj9531dybAxs4F0fdo5NtRDz
	N7aKJ9l++UdoMZ39JF82hWISWIbCf6704IGJznIAlbmJ5ceAsCWbMbpAVt4bDQ==
X-Gm-Gg: AY/fxX7OOIDeFxcENzbhLDiPgJt0gxSIPqiaRmnG6GPkWxKmww+TFbfqScqoXED2o/z
	GPynKzJaoC9NlBDUThOqU8yAFNs0KdIxsraw1dvwwifovmLXnqaDlwxrhxc1bwqGpquy4qh289q
	dmWaS5Q28a28mfx3qC+KUV2MCdxaG101b3mLJbIsytpwgm/4wOact6/GH6Ll8z0wStcT/qljZmn
	KrHsW9UI6YQcf/aQ8GtdrtunRDJbT+w7fDMdRKqP7+Uo/PZAN2xn9+9v1Yy6F7iEIGe45TgAxPk
	9HsW75db0qgairOoOoHqqoFKKM9ihJ3lU9CHp1C105/F5BXX2DjajySKrsx5n1onaGS3PKxHVke
	nY+ZCCmiTObR1AO2JW19HvaCbaZ7dISh8jfCRmrlpv4qWDHAM5zBnFH0yllGtka3nsSWOgz25K8
	r6F1l+BSagTyt5jxWnpw5IN8LRiK/eSgUeJ87JQLr2lQzA8RzqbjxGSkZg1eMtKHl8iRPDX+mnT
	0AGq4gGI31vyiX4EfOTOb1rUw==
X-Google-Smtp-Source: AGHT+IFzXq+ynGI24wv1yLcTVC4fQGx1cvQRkqSmIN6hhCsbXSpYjuakUMfNM2gQW1lzdctnUGV79A==
X-Received: by 2002:a05:6214:1d03:b0:88a:316e:dad6 with SMTP id 6a1803df08f44-88c5204d7bemr499292946d6.23.1767009538526;
        Mon, 29 Dec 2025 03:58:58 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9680c323sm219001636d6.13.2025.12.29.03.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:58:58 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4441F4007F;
	Mon, 29 Dec 2025 06:58:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Dec 2025 06:58:57 -0500
X-ME-Sender: <xms:AW1SaVO-ZYcTfkDU2e1aB29NECWBg4LQ1eqvS58QLHKWKpPkhmh2oA>
    <xme:AW1Saec6QuOA6W5HNxFlAH6KU0lOOcdA7AJODtnbBEGWqUHlxIEMuJYpdjAprhhpP
    oV73GYVYdTOpRrG5WuhGQIZVDMQK4-hbT4YU7k17-_cuu0U0fHS5g>
X-ME-Received: <xmr:AW1SaSSp_HukLQU-OASrDG0Hmi1n6iwDD5iI4IwVbpewF-wrnUlTCMG7Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonh
    horhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsjhho
    rhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrh
    hoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:AW1SaUeoZP0jhsKJpIPxpO7hKk2I5xggGYnzu9hT4SK_Ye8igV8t8Q>
    <xmx:AW1SaTtTbYBVw1QqgKAGjpkn6SMH49s0DfAP3qKIazA0zbRg3SVbXA>
    <xmx:AW1SaYJlfWnkah3tz85LUxbATKqrE_Ud5dbMYnl9rO7CRiVl3WYNCQ>
    <xmx:AW1SafZR5qrsuVXeddwczvojx_Y5IWDZyVxK40l3yGW0db9JShFXBg>
    <xmx:AW1SaTkx_MQIFWzsOYi5WDWP7cPiE-f81RHG7IkLsj14NtISZK_A7vAO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 06:58:56 -0500 (EST)
Date: Mon, 29 Dec 2025 19:58:48 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 2/3] rust: sync: atomic: Remove workaround macro for
 i8/i16 BasicOps
Message-ID: <aVJs-D4V1IpfzR7z@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
 <20251228120546.1602275-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228120546.1602275-3-fujita.tomonori@gmail.com>

On Sun, Dec 28, 2025 at 09:05:45PM +0900, FUJITA Tomonori wrote:
> Remove workaround impl_atomic_only_load_and_store_ops macro and use
> declare_and_impl_atomic_methods to add AtomicBasicOps support for
> i8/i16.
> 

I did the following so that we can drop this ;-)

1. Change function names of [1] and [2] from *{load,store}* to
   *{read,set}*.

2. Reorder [3] before [4] to avoid introduction of
   impl_atomic_only_load_and_store_ops!()

[1]: https://lore.kernel.org/all/20251211113826.1299077-3-fujita.tomonori@gmail.com/
[2]: https://lore.kernel.org/all/20251211113826.1299077-2-fujita.tomonori@gmail.com/
[3]: https://lore.kernel.org/all/20251228120546.1602275-2-fujita.tomonori@gmail.com/
[4]: https://lore.kernel.org/all/20251211113826.1299077-4-fujita.tomonori@gmail.com/

I also reorder a bit to make the introduction of helpers are grouped
together, please see at

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-sync.20251229

I feel this way we have a cleaner history of changes.

Thanks!

Regards,
Boqun

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/atomic_ext.c           | 16 +++++-----
>  rust/kernel/sync/atomic/internal.rs | 48 +----------------------------
>  2 files changed, 9 insertions(+), 55 deletions(-)
> 
> diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
> index 3a5ef6bb2776..10733bb4a75e 100644
> --- a/rust/helpers/atomic_ext.c
> +++ b/rust/helpers/atomic_ext.c
> @@ -4,42 +4,42 @@
>  #include <asm/rwonce.h>
>  #include <linux/atomic.h>
>  
> -__rust_helper s8 rust_helper_atomic_i8_load(s8 *ptr)
> +__rust_helper s8 rust_helper_atomic_i8_read(s8 *ptr)
>  {
>  	return READ_ONCE(*ptr);
>  }
>  
> -__rust_helper s8 rust_helper_atomic_i8_load_acquire(s8 *ptr)
> +__rust_helper s8 rust_helper_atomic_i8_read_acquire(s8 *ptr)
>  {
>  	return smp_load_acquire(ptr);
>  }
>  
> -__rust_helper s16 rust_helper_atomic_i16_load(s16 *ptr)
> +__rust_helper s16 rust_helper_atomic_i16_read(s16 *ptr)
>  {
>  	return READ_ONCE(*ptr);
>  }
>  
> -__rust_helper s16 rust_helper_atomic_i16_load_acquire(s16 *ptr)
> +__rust_helper s16 rust_helper_atomic_i16_read_acquire(s16 *ptr)
>  {
>  	return smp_load_acquire(ptr);
>  }
>  
> -__rust_helper void rust_helper_atomic_i8_store(s8 *ptr, s8 val)
> +__rust_helper void rust_helper_atomic_i8_set(s8 *ptr, s8 val)
>  {
>  	WRITE_ONCE(*ptr, val);
>  }
>  
> -__rust_helper void rust_helper_atomic_i8_store_release(s8 *ptr, s8 val)
> +__rust_helper void rust_helper_atomic_i8_set_release(s8 *ptr, s8 val)
>  {
>  	smp_store_release(ptr, val);
>  }
>  
> -__rust_helper void rust_helper_atomic_i16_store(s16 *ptr, s16 val)
> +__rust_helper void rust_helper_atomic_i16_set(s16 *ptr, s16 val)
>  {
>  	WRITE_ONCE(*ptr, val);
>  }
>  
> -__rust_helper void rust_helper_atomic_i16_store_release(s16 *ptr, s16 val)
> +__rust_helper void rust_helper_atomic_i16_set_release(s16 *ptr, s16 val)
>  {
>  	smp_store_release(ptr, val);
>  }
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> index 0634368d10d2..1b2a7933bc14 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -256,7 +256,7 @@ macro_rules! declare_and_impl_atomic_methods {
>  }
>  
>  declare_and_impl_atomic_methods!(
> -    [ i32 => atomic, i64 => atomic64 ]
> +    [ i8 => atomic_i8, i16 => atomic_i16, i32 => atomic, i64 => atomic64 ]
>      /// Basic atomic operations
>      pub trait AtomicBasicOps {
>          /// Atomic read (load).
> @@ -273,15 +273,6 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
>      }
>  );
>  
> -// It is still unclear whether i8/i16 atomics will eventually support
> -// the same set of operations as i32/i64, because some architectures
> -// do not provide hardware support for the required atomic primitives.
> -// Furthermore, supporting Atomic<bool> will require even more
> -// significant structural changes.
> -//
> -// To avoid premature refactoring, a separate macro for i8 and i16 is
> -// used for now, leaving the existing macros untouched until the overall
> -// design requirements are settled.
>  declare_and_impl_atomic_methods!(
>      [ i32 => atomic, i64 => atomic64 ]
>      /// Exchange and compare-and-exchange atomic operations
> @@ -332,40 +323,3 @@ fn fetch_add[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self::Delta) ->
>          }
>      }
>  );
> -
> -macro_rules! impl_atomic_only_load_and_store_ops {
> -    ($($ty:ty),* $(,)?) => {
> -        $(
> -            impl AtomicBasicOps for $ty {
> -                paste! {
> -                    #[inline(always)]
> -                    fn atomic_read(a: &AtomicRepr<Self>) -> Self {
> -                        // SAFETY: `a.as_ptr()` is valid and properly aligned.
> -                        unsafe { bindings::[< atomic_ $ty _load >](a.as_ptr().cast()) }
> -                    }
> -
> -                    #[inline(always)]
> -                    fn atomic_read_acquire(a: &AtomicRepr<Self>) -> Self {
> -                        // SAFETY: `a.as_ptr()` is valid and properly aligned.
> -                        unsafe { bindings::[< atomic_ $ty _load_acquire >](a.as_ptr().cast()) }
> -                    }
> -
> -                    // Generate atomic_set and atomic_set_release
> -                    #[inline(always)]
> -                    fn atomic_set(a: &AtomicRepr<Self>, v: Self) {
> -                        // SAFETY: `a.as_ptr()` is valid and properly aligned.
> -                        unsafe { bindings::[< atomic_ $ty _store >](a.as_ptr().cast(), v) }
> -                    }
> -
> -                    #[inline(always)]
> -                    fn atomic_set_release(a: &AtomicRepr<Self>, v: Self) {
> -                        // SAFETY: `a.as_ptr()` is valid and properly aligned.
> -                        unsafe { bindings::[< atomic_ $ty _store_release >](a.as_ptr().cast(), v) }
> -                    }
> -                }
> -            }
> -        )*
> -    };
> -}
> -
> -impl_atomic_only_load_and_store_ops!(i8, i16);
> -- 
> 2.43.0
> 

