Return-Path: <linux-arch+bounces-15644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C82CEFE46
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 11:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421E1300EF68
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52C2F6920;
	Sat,  3 Jan 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAvCztPI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC330749B
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767437103; cv=none; b=BHBgOaSIqa9JrFFrALF9KGnbyiQ8K3HrrXBDOreSodeDSxrzSX9PX9kmFLaTj2j4IoHBse8BUl3pp633kS950NDOG6u+u4pHHr8fwdFgkaQWwRXXO8m/81Vi64HcJNb0PjXpl1nrKROHsghMoMO78OzoAEguBdUUX5v4VLs93K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767437103; c=relaxed/simple;
	bh=BQWi1Byg+BB4/cybELFHlvrxZ3qjbr+eBCCMEmKH0Bg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oIC+TfrhZBeCiYXq7Pgj95eTUZdG1vy/FbE/uB65y0KpUobu3svm+Q1EjQDWA6ir0RfLF5D3ETWOYsAOmzBzBiuCBNfCwMZ6udOyn7Bb/9698e3/+ukgLUywXiHW7GbHiVuAxo8oDDz0YielHIb9dBwBYWKJ31tYexEwVynpNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAvCztPI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d5c365ceso168977085ad.3
        for <linux-arch@vger.kernel.org>; Sat, 03 Jan 2026 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767437100; x=1768041900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA+YIWtnv62G+kj8CxQPw0EabsBETW7vVKKZB5YRNvg=;
        b=cAvCztPI/+6uMGI1GKL4j81IZ1ZtEaDjYy6aB2liag5Pi7OK1lk2gY9D5KCCC4fXS2
         kxo6ljfnI+rn8olio4BGdC+lUrTWd9prByHpSZX57/uuiRti7Uf23uTMUTmxUcOMQLK2
         zPbzrnarI5v87IOGd+MpCw2EWr+bmcaM1Fhrws8canrB+4zCdZJbSvLhPmTK3+KHW0vE
         9G7y/T7vcy79FXjgXqHvtD4FN2Zb+z1is2pBzDSJxN5bF1fuWYMW0v8caaRwC9vKUPWA
         F5PtdLzxnF0AfXTrgNbiVZJNFG7VvXlT10Qae3vT+n/xNdsoS9IRwCimFOmjI8OpdM0A
         1vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767437100; x=1768041900;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA+YIWtnv62G+kj8CxQPw0EabsBETW7vVKKZB5YRNvg=;
        b=NTGRBV6kezHz3zZraJHhuH7AUvf+kffq64x8mJqqw6SXaOyEbotQhETzxIkWr07UqT
         nLUPLkkyMYkcCTYhNqSxZ7oWu8N38La7LDPH8LEhuSQPayFwtM4jKLGgxSuO7wC4hiaZ
         9zTw0t1+z96Grfm54FNhcnZAjvqAXn/22o2Sb37o3lff2Z8vwB7jvDuctRxhf7HDBqg+
         3E7WNwTZBoZ8y3fmJwplX0e6bAtVSsthUhHWr+VX/0aRC03oRmQTKL/iIwWGdPL7kqqf
         S+Eih5LgYJtNWkI9+b6uX3a7ZYD34U9sK3f6j76l/iNZ7Ixt+wwmoZ3Zqd3+8YJQvUOh
         guUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn7P0k9p7SFr3OJvathtwEYj/JSPHLa7KuzPc8objxoMCq2Mrt37NWXfon9phBl3JzBtT0JD+K4ZMz@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqSSPJVpR8JVa5l+GxwPKh1DXEH5cPIVNGRp4wMySzTS9oYZW
	cWto1MxJBbPDnBPMuNC0JqL5dsYo77HiVtYpS+upwzwH5cULrnwORwMx
X-Gm-Gg: AY/fxX62s3PiEgye7jYpAGDM3Ouu2JyvqtxMubE72QhAJEY25RXPe5uTWG1fz+S1y8T
	wDlgOvkIAPu4DeP2maH6FJzDsO3BDUvJczbKO2LOWbA36pWhPJxh0XL6Wkj6pzeAfSxFS4OrWqb
	MvWfDqoh9PzX1Mub+1zp7CoLXsxIlUr1tro1SwbjiKdmma+2XfKfRt/r7yCSLmt7xaMTGWR8Nqs
	BglcYFnMkPDCZZfzZSZQB2boFuoy5cW3ICbCx/Xhd40L1V5K0ZxVu4Vs1ahYOI1vNulhZ1TNdmJ
	HbC0PUHBWWFXNQGLi0Megw5B1WzQIVkMdyG7mMqHhxQ/jqYgPo5c2FZ8/sF1XFjQAMOXp9VClVj
	pMdrrddlSpTIiS2UpCXuL+SyDrjiZ3snGSdsoN3LWveEjVPXmrmRfvNkvXX3YGsfLQeTC00Cd3+
	dT/faEfBU3syvER5vBcm95fYt5PGqJACmeKhSjf6Wpo0vz78ssdu580baJpaEJXAlkK2s=
X-Google-Smtp-Source: AGHT+IHgRBUiAwedFLEDnGkAppIPgacg0XoNBYjGBwVc+gdL+Ywz2GyJ7W6RtYmgyvONjYhvcy8MuQ==
X-Received: by 2002:a17:902:e74c:b0:297:f09a:51cd with SMTP id d9443c01a7336-2a2f2214860mr469321205ad.14.1767437099794;
        Sat, 03 Jan 2026 02:44:59 -0800 (PST)
Received: from localhost (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d32dsm400578155ad.70.2026.01.03.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 02:44:59 -0800 (PST)
Date: Sat, 03 Jan 2026 19:44:48 +0900 (JST)
Message-Id: <20260103.194448.560764475765900721.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu,
 acourbot@nvidia.com, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20260101210430.6b210dc6.gary@garyguo.net>
References: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
	<20260101210430.6b210dc6.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 1 Jan 2026 21:04:30 +0000
Gary Guo <gary@garyguo.net> wrote:

> On Thu,  1 Jan 2026 19:27:18 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
>> Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
>> AtomicType for it, so users can use Atomic<Flag> for boolean flags.
>> 
>> Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
>> particular, when RMW operations such as xchg()/cmpxchg() may be used
>> and minimizing memory usage is not the top priority. On some
>> architectures without byte-sized RMW instructions, Atomic<bool> can be
>> slower for RMW operations.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>> 
>> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> index 4aebeacb961a..d98ab51ae4fc 100644
>> --- a/rust/kernel/sync/atomic.rs
>> +++ b/rust/kernel/sync/atomic.rs
>> @@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
>>          unsafe { from_repr(ret) }
>>      }
>>  }
>> +
>> +/// An atomic flag type backed by `i32`.
> 
> I would recommend that we document that the backing type is the
> (perf-)optimal type on the target architecure, so arch can decide to use
> i8 as backing type if they prefer.

I'm not sure I fully understand the intent yet.

Do you mean we should document Flag as being backed by the
(perf-)optimal integer type for the target architecture, so that the
backing type can remain an implementation detail and potentially be
selected per-arch (e.g. i8 on x86) via cfg?


>> +/// `Atomic<Flag>` is generally preferable when you need an atomic boolean and you may use
>> +/// read-modify-write operations (e.g. `xchg()`/`cmpxchg()`), and when minimizing memory usage is
>> +/// not the top priority.
>> +///
>> +/// `Atomic<bool>` is backed by `u8`. On some architectures that do not support byte-sized RMW
>> +/// instructions, this can make RMW operations slower.
>> +///
>> +/// If you only use `load()`/`store()`, either `Atomic<bool>` or `Atomic<Flag>` is fine.
>> +///
>> +/// ## Examples
>> +///
>> +/// ```
>> +/// use kernel::sync::atomic::{Atomic, Flag, Relaxed};
>> +/// let flag = Atomic::new(Flag::Clear);
>> +/// assert_eq!(Flag::Clear, flag.load(Relaxed));
>> +/// flag.store(Flag::Set, Relaxed);
>> +/// assert_eq!(Flag::Set, flag.load(Relaxed));
>> +/// ```
>> +#[derive(Clone, Copy, PartialEq, Eq)]
>> +#[repr(i32)]
>> +pub enum Flag {
>> +    /// The flag is clear.
>> +    Clear = 0,
>> +    /// The flag is set.
>> +    Set = 1,
>> +}
> 
> Maybe add `From` impls that convert this type to boolean?

Yeah, that sounds like a good addition.

+
+impl From<Flag> for bool {
+    fn from(f: Flag) -> Self {
+        f == Flag::Set
+    }
+}

