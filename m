Return-Path: <linux-arch+bounces-15623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A825CEBF34
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 13:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C91033009118
	for <lists+linux-arch@lfdr.de>; Wed, 31 Dec 2025 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A16320CA2;
	Wed, 31 Dec 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaqYAudL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB9184540
	for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183718; cv=none; b=u2I/0hiu7CFdGObXRH8TnyKKr++LKAQgtTPB1Ny08ghf0JQzR9vH+Ol1EMAzJ6jau8vHGW44uy49Z6+utcdwW4AhKxWSPq4v/8EFj69D03eXq49PcJCpWFks8+NamWQetYFGy1Rn5D3UasRG1pgwKVqjkOoTe2veqD8Zmbm75go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183718; c=relaxed/simple;
	bh=vDYEFC/1ZVknYn2H4nn49xNZKvkbj0AVhwkeRtZjduE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Oj9EjCccMWX8g9vpMesXJydUOZ579Ayna79INc6R1GZ3A5UpezsXkutECBc7DjBfwkuoZyTUcZe7VAwUImPllU5FhStb0/9acxncM2+obfJubcqShkSCyr/mNR781Jplaj6DiUFvsSuwfgLy0k1R/CRkfugPdjp50RvLyEkV1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaqYAudL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so12226029b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767183716; x=1767788516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiPh9iNHDcZdxkSlmhXO/2HAlh7ZmUw+8qvd0QJAg2I=;
        b=NaqYAudLUQ2i1WChcDHg/9jIshtGewVU+rraXREV/nvJLlF7W0rhbO4BYq9/IJKQK+
         fbuRFFLGRKJcWKVlc6zxPyOtcDySIxhHay+4ztaHqR1Gtffok2uhvP1iCjhV+fTgsQtC
         woeloAIcC6RVwr6kJLXN7R4o65u+KUYDg/CXZaHkAIQr8+9F4+Yy21R+BtF+1joZZksp
         yg3Q1nkqMAx/fpfb9/QR7vcwlSpSZZMLLdTANt4KTEYzrjSjSyIGsDks+bkG46/7dnC1
         u86d6zhSRzrA0evDSuqvqGSIARR1+LkNONlwpFg4ZVb3lSZ0LTtMTZUFtqGRMKkYx6RT
         /QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183716; x=1767788516;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiPh9iNHDcZdxkSlmhXO/2HAlh7ZmUw+8qvd0QJAg2I=;
        b=JgN7KZqb4jQl0nfGF49gFd//PtItDZVi3AaBK3c7rzHexoTdBzKchtPh3M9ifC/vJH
         iKflGVDQzMq0CzFS6HKkptNYJb+YSS7Z/62Ey7mih3WDQf79bTtFLvB6WFfXuOnH9354
         P6Ux+i1rchI2IZZ2knJQjzP0jOcEq/QKWiM9qkqLoobOKWrcc2lGD1Hlu5eQSPTFmE75
         AU7y0/3KkerwW5S8wn65sRfubsCEgzhI1w9erNrFcZdOrcsw2fqNpmCTI9UMGZ2zEqpn
         h+I4fOhVwGBC4II+KqJMTIMGjAisNRNoTbD65DCrE0DKM5IO2YOGsWh0kTDqNcXUa3DI
         Xumw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzxmHf0NCfRrbx7jrbrZDIlBDkgLtCqWME2k1su6z13ir7o6tOXo8twoRf1DHPF8LTO/fJOyATO24@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvjgoJX/TeOHgHWlsAELUdN5f6CGJXScn7TRTY/64DudlZ/w+
	EyIu5ZjNyM4kBPEVClrw1cheBJyjLOIXGSqIK5ibfRGlmqPUszSwagu/
X-Gm-Gg: AY/fxX5XgBT+i2dc3jEHjTebSdlfYubbAdV8SGgQBbEXDIfw9xObWZ1bBnUe31N5D++
	zge6y50j2qmG3XNVnw+ZuvTWB2hvuBjlUxrKvaJHmJJpH3zElwMoYAvxM0lJnqu6l75S2JUHmzA
	cgzxST8qNoFyKLjaPiA7ojpEHdABTCDg2A3FHdvqoDj1byiKYA5cfhLJUO9xiuIq3M6Pn/wMvOP
	WezIWfQPLbnLTGAFff2UbMDcalMnpfJ8upHWvao9nbXI+ugyjZzaoF+A0mP24TcOcxi4+pVZi/8
	/caNkMvqDRHzXPPrPU0Si+QLZLJ8/duszfsGuYxAJPjG6upNCg0E8jYZ2W0DTolByLU7UK6lm5H
	vlTxgcJFdE0cg/FUxDVrFgeUjuTjjvUuToXnfNJCiy9mGcfBS0Oc1IgUkal6kNASFy2G45wJeAj
	SoYKvIjIAkEpLGgmx5+ES6fBedTSGgoFjp/AW0yMapPByEuncLMdTwzeO9mLfKrwnX1Vg=
X-Google-Smtp-Source: AGHT+IECgioPTsy7O8h4IMn7prBqsQJ/6jdGSCsU2tlyHIbj0RAMCS1DIWe+8/Sx5YpAoA1u+jIUjQ==
X-Received: by 2002:a05:6a00:140f:b0:807:c2b9:38ec with SMTP id d2e1a72fcca58-807c2b93f63mr16449954b3a.15.1767183715580;
        Wed, 31 Dec 2025 04:21:55 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961c130sm30128093a12.3.2025.12.31.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 04:21:55 -0800 (PST)
Date: Wed, 31 Dec 2025 21:21:51 +0900 (JST)
Message-Id: <20251231.212151.889123388469793161.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 gary@garyguo.net, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/2] rust: sync: atomic: Add atomic bool support via
 i8 representation
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aVRWDgb29OkHAGnY@tardis-2.local>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
	<20251230045028.1773445-2-fujita.tomonori@gmail.com>
	<aVRWDgb29OkHAGnY@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 06:45:34 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Dec 30, 2025 at 01:50:27PM +0900, FUJITA Tomonori wrote:
>> Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
>> representation.
>> 
>> Rust specifies that `bool` has size 1 and alignment 1 [1], so it
>> matches `i8` on layout; keep `static_assert!()` checks to enforce this
>> assumption at build time.
>> 
>> Implement `AtomicImpl` for `bool` under
>> `CONFIG_ARCH_SUPPORTS_ATOMIC_RMW`, consistent with the existing
>> `i8/i16` gating.
>> 
>> Document the additional safety requirement for
>> `Atomic::<bool>::from_ptr`: only bit patterns 0 (false) and 1 (true)
>> are valid.
>> 
>> Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/sync/atomic.rs           |  1 +
>>  rust/kernel/sync/atomic/internal.rs  |  8 ++++++++
>>  rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
>>  3 files changed, 20 insertions(+)
>> 
>> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> index 4aebeacb961a..2c998cbd300e 100644
>> --- a/rust/kernel/sync/atomic.rs
>> +++ b/rust/kernel/sync/atomic.rs
>> @@ -158,6 +158,7 @@ pub const fn new(v: T) -> Self {
>>      ///
>>      /// - `ptr` is aligned to `align_of::<T>()`.
>>      /// - `ptr` is valid for reads and writes for `'a`.
>> +    /// - If `T` is `bool`, only the bit patterns 0 (`false`) and 1 (`true`) are valid.
> 
> This line is unnecessary, since "`ptr` is valid for ..." means `*ptr`
> has to have the valid binary representive of `T`.

Understood, I will drop this in v2.


>>      /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
>>      ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
>>      ///   accesses are atomic, then this safety requirement is trivially fulfilled.
>> diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
>> index 0dac58bca2b3..0e12955082e5 100644
>> --- a/rust/kernel/sync/atomic/internal.rs
>> +++ b/rust/kernel/sync/atomic/internal.rs
>> @@ -16,6 +16,7 @@ pub trait Sealed {}
>>  // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
>>  // while the Rust side also layers provides atomic support for `i8` and `i16`
>>  // on top of lower-level C primitives.
>> +impl private::Sealed for bool {}
>>  impl private::Sealed for i8 {}
>>  impl private::Sealed for i16 {}
>>  impl private::Sealed for i32 {}
>> @@ -37,6 +38,13 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
>>      type Delta;
>>  }
>>  
>> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
>> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
>> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
>> +impl AtomicImpl for bool {
>> +    type Delta = Self;
>> +}
> 
> I don't think you need this impl block.

You are right. Only the backing atomic types need to implement this. I
will drop in v2.


Thanks!


