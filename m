Return-Path: <linux-arch+bounces-15611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB116CEACC7
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 23:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66A9B3004ED9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A53257821;
	Tue, 30 Dec 2025 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3R2zfv4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D24139D0A
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134742; cv=none; b=fv4/dNvaF7iWkk1R1n0cFiWgnyp3SZmLeQZmHf+kEgL3/wTdSf8CiMqFHqHHGQrUb68kELtTw8Z1O9DzzuVgdjA3a/PqH4DCY/G2N5R1nkrr+iIN9w94WdRXV60uskywYPKsLAOni5q9Sf9LCrINk3N5ss1UQwmSm5Xg7SzdKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134742; c=relaxed/simple;
	bh=48BXp9duWstmXM2wwFjUjd74Fd/KCHgqIDUXsjbF5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO49W2V+axBbDF9oAjztLyLNN2fvPjNM0Tx4qVO+uB304D/A8I2eCC8/GVfCv/xEM2+xUkfH4wti288QrateERfHb36OscGJ6wYaYaoY6oGQJAUr/SY74EpTfHDZGIVV+kP5GjE+OFe2WVx8MsamJkRpODLCnqWLKVwRGi1VhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3R2zfv4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2ec756de0so1103999885a.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 14:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767134739; x=1767739539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK5YGZOzvx/5nggsiNqHVrVY4+9Wea1elwiHJ9WZ9mk=;
        b=k3R2zfv418trZ7EdMTfsfHRQZwxYF7R0b5hPSfraD1aQDuGQTF33J5CpCak0d+UY13
         U5RWAsDRr3bgIqOTgo3qNwM1B4l9KlsspldlzAWYDMROzHbgH6I8EU8FFBMQQh4rq/Vk
         7urXlOJuefnMnAuOq6OMpiFfdIAiDQfazbzcTINpiQQD85u76EstlMcPg+9Lu364Dwdj
         cM9YZCdEHm1cdkY4aHzHiWjIjKXXKcoUVNabqt7gCMDmJtT+NDURFG4NObj9BGpLAvJe
         GVTozJXVC/CaGAV/gigfxYwxQO1Oirv7ruuYE3L0wmU4+WAIG2vdpA54iEKDe+Z+Hn6C
         ZI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134739; x=1767739539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XK5YGZOzvx/5nggsiNqHVrVY4+9Wea1elwiHJ9WZ9mk=;
        b=YYRBdc2idBEHExMStDpMqWs0cxtoMK2mrr/1uRJhxx6nvbI8l4rp3Eh5FwWRklguHa
         nJbzpztHBoO8Nns1yiY4BUlzKs+eUhU2FJ0er4wjtHEuNAcqvRgS4DUbgFJwUPXJq6QZ
         c9SiVtjS1uGapHfIfxJ5MAamdcaRuP3jIwLZDlwQXIbuVBzHLJbet+ZlBShRU27jP7Th
         tkK16o2vMfYiPh1OkyUnREGVO7Lkz6QpjNy/cq8P+phrzB7d2Nh1icQvQGiPqxgO3Un0
         Rlgk4C5m9NOUEM0YIQ/qB/gxFjXQeifmnvRbb3tG5jybDDFrTNEPUtu7bLdQeRwxZwvO
         cw/w==
X-Forwarded-Encrypted: i=1; AJvYcCU468qsYRrjiZEQhhdh7/WNNiOi9L5ElACiIaAU+Q1ShrXpLUL13wTw3FZ5lE67W4Zuerd4+yIu1tzW@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzBm7Ov5Yl0L4dYgpsBmVB6ftJKYo0o8aRrcquseQw+6VxuMQ
	FFjP8GjFm2RHhjgiWmcGqf5ozDAqF140rF9TeOgX20+k13THd1c7B7r9gxkPTQ==
X-Gm-Gg: AY/fxX6OfFgSZtE3bwvCdDkzAZOPU0fo5E+JQiyy3Sp3FS4sZAmdxSiFm5XhH9jfwLx
	ncMK6YIq50HykwYVbkiWNKIZKp0l4+1tbcDRtxLjgg/tI9RGnSDqiOmZcaSEKp+Xed7ZkDkDBy/
	kGasLGw0rWM49YZovv1v5JPD/udvLhmvN7rby9Sw5fBO0jx++/WaOBuUfFODJ8qMyAE4e52e0Kq
	3emDmO9JxPJfyq44MWykf3VBl1TSqQiuo9HTg29b5WwfQZpzwcMx+UBk7dTZejgm2bvj9UrpFsp
	AvmAeyB/GilihMEZ1PPAwnpOIibXKalzMz+/wrg0FwWKzP9e8P3Z1yviKfDjZqecji74LoXFLR3
	6rc/T6k6+UIncr0qzSzFHPASdsuh7lokDWnyizVlfZalEmVxpobeu4KKu79fs3b9J4n2xbS55Fu
	m6CeWcjYl4T07w3kSrW3Q1Q28SMqV9pPVU+PFE5Cze++epvLc12smYflaNNw0qcBOqNK0L88st6
	YcBYx9cMMZWPUw=
X-Google-Smtp-Source: AGHT+IESE4crps8PhtSzDrAOWDrm2KzI0zn0B3XfHBbsttw5F1shqymidXfpwmyQaGoA6cgzOQ1H1g==
X-Received: by 2002:a05:620a:4689:b0:88e:4d7b:f5c8 with SMTP id af79cd13be357-8c08f666ff7mr5160819985a.20.1767134739578;
        Tue, 30 Dec 2025 14:45:39 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ee7bfsm2600236385a.51.2025.12.30.14.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 14:45:39 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98FA3F40068;
	Tue, 30 Dec 2025 17:45:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 30 Dec 2025 17:45:38 -0500
X-ME-Sender: <xms:ElZUafwy9Ao8FYH3GZ753TYq6nXK-W-GTQu7VN0CRNWSXXvjXO6LIQ>
    <xme:ElZUady8hf3cVnJ3vsnePavLhd9DUcNPrPbGz1_ZOGptLjYShQnvFV8N1sqCkGUDG
    uX3jjZRx8GoT0tt0jiNokE1v6XypWTuAxZDzGvO3AWPkedmmadZwQ>
X-ME-Received: <xmr:ElZUaXUcWZW8v1z9Z35m1zULkRpH3AOGAUVfBB0mJKa410yt9BuosnhBpfxa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekuddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtoh
    hmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    sghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkh
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    thdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepth
    hmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:ElZUacSHCGbB9zOXpxAlBkRbP6GpNhcLq_EAAjcVfUhmSRsLE6n-UQ>
    <xmx:ElZUaXTJObZqb-9tpi8_uzJqqbmgRk4KGtpk2kSPiqEZmDTrni5fiA>
    <xmx:ElZUacfxTm65uXhhEC1hML4oue1d7kuthhMDNZUfFV8-loRoN7w0RA>
    <xmx:ElZUaVcJwSHE5xN2SpsH57Qf4qj9enO8snRmV8m3QHbF9zqcMI2qYQ>
    <xmx:ElZUaYZrSQw6Tu8wLSLuPoMkVeDn7skjAX2hIYyYwuQvWpfvEym-rUkG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 17:45:37 -0500 (EST)
Date: Wed, 31 Dec 2025 06:45:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/2] rust: sync: atomic: Add atomic bool support via
 i8 representation
Message-ID: <aVRWDgb29OkHAGnY@tardis-2.local>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
 <20251230045028.1773445-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230045028.1773445-2-fujita.tomonori@gmail.com>

On Tue, Dec 30, 2025 at 01:50:27PM +0900, FUJITA Tomonori wrote:
> Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
> representation.
> 
> Rust specifies that `bool` has size 1 and alignment 1 [1], so it
> matches `i8` on layout; keep `static_assert!()` checks to enforce this
> assumption at build time.
> 
> Implement `AtomicImpl` for `bool` under
> `CONFIG_ARCH_SUPPORTS_ATOMIC_RMW`, consistent with the existing
> `i8/i16` gating.
> 
> Document the additional safety requirement for
> `Atomic::<bool>::from_ptr`: only bit patterns 0 (false) and 1 (true)
> are valid.
> 
> Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs           |  1 +
>  rust/kernel/sync/atomic/internal.rs  |  8 ++++++++
>  rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 4aebeacb961a..2c998cbd300e 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -158,6 +158,7 @@ pub const fn new(v: T) -> Self {
>      ///
>      /// - `ptr` is aligned to `align_of::<T>()`.
>      /// - `ptr` is valid for reads and writes for `'a`.
> +    /// - If `T` is `bool`, only the bit patterns 0 (`false`) and 1 (`true`) are valid.

This line is unnecessary, since "`ptr` is valid for ..." means `*ptr`
has to have the valid binary representive of `T`.

>      /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
>      ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
>      ///   accesses are atomic, then this safety requirement is trivially fulfilled.
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> index 0dac58bca2b3..0e12955082e5 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -16,6 +16,7 @@ pub trait Sealed {}
>  // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
>  // while the Rust side also layers provides atomic support for `i8` and `i16`
>  // on top of lower-level C primitives.
> +impl private::Sealed for bool {}
>  impl private::Sealed for i8 {}
>  impl private::Sealed for i16 {}
>  impl private::Sealed for i32 {}
> @@ -37,6 +38,13 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
>      type Delta;
>  }
>  
> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> +impl AtomicImpl for bool {
> +    type Delta = Self;
> +}

I don't think you need this impl block.

Regards,
Boqun

> +
>  // The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
>  // guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
>  #[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> index 248d26555ccf..3fc99174b086 100644
> --- a/rust/kernel/sync/atomic/predefine.rs
> +++ b/rust/kernel/sync/atomic/predefine.rs
> @@ -5,6 +5,17 @@
>  use crate::static_assert;
>  use core::mem::{align_of, size_of};
>  
> +// Ensure size and alignment requirements are checked.
> +static_assert!(size_of::<bool>() == size_of::<i8>());
> +static_assert!(align_of::<bool>() == align_of::<i8>());
> +
> +// SAFETY: `bool` has the same size and alignment as `i8`, and Rust guarantees that `bool` has
> +// only two valid bit patterns: 0 (false) and 1 (true). Those are valid `i8` values, so `bool` is
> +// round-trip transmutable to `i8`.
> +unsafe impl super::AtomicType for bool {
> +    type Repr = i8;
> +}
> +
>  // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
>  // itself.
>  unsafe impl super::AtomicType for i8 {
> -- 
> 2.43.0
> 

