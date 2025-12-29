Return-Path: <linux-arch+bounces-15579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF5CE6CFF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D48603015CDC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9E308F23;
	Mon, 29 Dec 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGuQeaEA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704C27AC3A
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013496; cv=none; b=cxXPGAhU/mMXSuVYljlWgIh39mkGKtDgFyFo2XuTeoANbARxMGOcpAZ8IqMLJuMXSj0y4H5d98rc9tUnwpYbbHMG5y0eGd4YCQmXDE4fGlS878UfVYzgMKVDxOBet06M1KdoxzsYOzPpkOO7LUL4Wn5D7S46X+Ob+COEWADZjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013496; c=relaxed/simple;
	bh=rLgjlSCJgAaj3TbHqjvCOUOJkeeo1I7mlP7KOfh2ZMU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ms3nbo/KJOnflgKGUt8Gyjl60Yf4Fd2JkDuckGsNh61JJiBC8N7yv1JV9fdYF5IsTUwLQ6iRMKDelqGrZ8hXe9JKfq6UogEwEB9yuvNuEteSYqJ7j8WWOgnG3gDgHQXVKF5ss5bbdu974upeOkz5fTyCruG3FXUcjeaY3+Vhe6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGuQeaEA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso9137247b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 05:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767013494; x=1767618294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKnTRTtVFK5++NzoKRWqtZlwERxHIGHMPpzZzv+1Al4=;
        b=TGuQeaEAU8INSKTdCSliJ7MqfNwkFCaYYC+xSXhricZmS5/YejNYTvRULjNnUpoCuj
         D3f45I40PAYSuEJBds1kNKx85yEkJIfUoNiY8vZzqN2K4hoEXZRuG5uOEU/FIMkw6uVN
         rfn+3Wjot2Jf4T2ibNoU72AUY1wrSVeakuKi2jh/x7OgZ46Z/s3PEGGZUZRkPXss1Tbh
         EGrZrRUqOltRkxzO/srPYAUFYJdc/IlTJoFYxeDFEn6zr6QHaeG276WXa858iFCjcEth
         oXiUUxcK+DbrY3QDQ5SExuwkoPsc/UJfWMTC55vv85tQWLcjQN2sb3Stw8pMwKgwPre2
         6TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767013494; x=1767618294;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKnTRTtVFK5++NzoKRWqtZlwERxHIGHMPpzZzv+1Al4=;
        b=RVOg37MB6jFir5HR4c79ARuxdTqfuo0XrA7k2KCNJ5suwci0r7rGbZd47HJk/bxWGH
         l5cdLMAbxVhWgQAngh0JZYKc63VfI0s1BpSH4mt8McqdKb4K6kczL5HPNFtK7s8X7ugl
         0KrULQdYrL7gjols8PVMqLe2nC0KVGNXKWY6lLElzG+XsvNNxjL/JtbbxQ1lukNs6ENG
         +iAcWK5dC8rz1knGLVUT1OtgU0YxaQHHdgyXYrknFLTFKVBb5YLFLV2F/BpWqKf/Nwdo
         xcAxdAGNbo03Kab8zit3kjAOjCetRYjPgaD2s/Pp/49J0cqHEshSphv0utyMaSRxFPKl
         Ql1w==
X-Forwarded-Encrypted: i=1; AJvYcCWHnVWu48Qywfplj5aSiv2HTi23cE6JpsNt/WnayO5f2fHRaYPL4x0Z8+PwYmu7dEOBIarseu+dsJ68@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nhBTHiC42ZbgN6yPCxtVJ+JokH9rOgoYM1JGmAkiQkd7ntzy
	pv8YDc4P7pQOljAU51stAA2zihREk8S8gDmtFxSCyPIlfDEVr9MVeEr2
X-Gm-Gg: AY/fxX6xo5zWN0q+K7vBO9YIcBujAR2ffsbDQjRBkgTqPwwOjY3ZvU8Y5mTDgZ6SsKY
	f0/Z8TI7UUx40ORtmgwWFO/PH5Bsui80ABgNWq9aMDuRkl66Nk8PriHnndclLqVv7+9L5U3LXdP
	aK3UiOvIyemL95ZicrGey7/PEslsShRxP1xz9cMRUlvc75YPRfbRrZ/o4TKRUdal1X2PYErarzz
	g8NWDtRujxCuUUUp8t1G71EqAKS9AgVNfoQtgqtr6YZR4qFZx7YNWQ33yQw6vAmkC3PSBIZf517
	1bOuKdHF/Ap84Hq9T5EcXvDwzkrDSgMgpngwmJIIWBecKYF1kWUmIw5jzmvZnoIJ4HDFU8iwwE6
	4CCdJeNLaOh2K5TiKg67FPEAIe7Pu5v4V5/kGglpj/JceIOHccVzgmUU7H/5bMv/vuvd6gfTspW
	WNcJ9Zcvi4VBas7XRBU4Wy4mwp0ldukrRZvMg0pEFxljYaQM/wvO47i0k416xnvxnfgp7NWEv+w
	dr2vg==
X-Google-Smtp-Source: AGHT+IGCPpsotuqJzVwWm6AVrbRp1pOK2NL9HwFso55znU7oRCLuvWqfntnKqktZRhIFbRTkvtXXFg==
X-Received: by 2002:a05:6a00:1e6:b0:7ff:9b5a:a73a with SMTP id d2e1a72fcca58-7ff9b5aa78emr18630772b3a.28.1767013494190;
        Mon, 29 Dec 2025 05:04:54 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f300sm29540865b3a.54.2025.12.29.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 05:04:53 -0800 (PST)
Date: Mon, 29 Dec 2025 22:04:39 +0900 (JST)
Message-Id: <20251229.220439.1905548071000498132.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 3/3] rust: sync: atomic: Add i8/i16 xchg and cmpxchg
 support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVJ0gvxe0nYtOXAO@tardis-2.local>
References: <20251228120546.1602275-4-fujita.tomonori@gmail.com>
	<aVJzlTWx4ybMi1ym@tardis-2.local>
	<aVJ0gvxe0nYtOXAO@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 20:30:58 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Dec 29, 2025 at 08:27:01PM +0800, Boqun Feng wrote:
>> On Sun, Dec 28, 2025 at 09:05:46PM +0900, FUJITA Tomonori wrote:
>> > Add atomic xchg and cmpxchg operation support for i8 and i16 types
>> > with tests.
>> > 
>> 
>> I think we also needs the following, otherwise architectures may
>> accidentally enable Rust but don't have the correct atomic
>> implementation for i8 and i16.
>> 
>> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
>> index 248d26555ccf..a4e5bbd45eb2 100644
>> --- a/rust/kernel/sync/atomic/predefine.rs
>> +++ b/rust/kernel/sync/atomic/predefine.rs
>> @@ -5,14 +5,22 @@
>>  use crate::static_assert;
>>  use core::mem::{align_of, size_of};
>> 
>> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
>> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
>> +//
>>  // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
>>  // itself.
>> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>>  unsafe impl super::AtomicType for i8 {
>>      type Repr = i8;
>>  }
>> 
>> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
>> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
>> +//
>>  // SAFETY: `i16` has the same size and alignment with itself, and is round-trip transmutable to
>>  // itself.
>> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>>  unsafe impl super::AtomicType for i16 {
>>      type Repr = i16;
>>  }
>> 
>> I can fold it into your patch if that works.
>> 
> 
> OK, the right place should be at AtomicImpl instead of AtomicType:
> 
> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> index ac689ce8ee8c..f4760e3a916e 100644
> --- a/rust/kernel/sync/atomic/internal.rs
> +++ b/rust/kernel/sync/atomic/internal.rs
> @@ -37,10 +37,16 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
>      type Delta;
>  }
> 
> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>  impl AtomicImpl for i8 {
>      type Delta = Self;
>  }
> 
> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>  impl AtomicImpl for i16 {
>      type Delta = Self;
>  }

With the above change, won't it cause a compile error on architectures
where CONFIG_ARCH_SUPPORTS_ATOMIC_RMW is disabled?

If that is intended, I'm fine with it.


