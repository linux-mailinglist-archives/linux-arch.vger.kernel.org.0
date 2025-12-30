Return-Path: <linux-arch+bounces-15606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A0CE8B0C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 05:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84AAA300204F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 04:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A9288C2C;
	Tue, 30 Dec 2025 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOBNgV06"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386642D73A9
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070240; cv=none; b=IPRVNTO58km/+VolwuuO+58eeqYmSiK6a+w7GKUto4oefitr9FOWfAA8IlFYwSNt/ImG9UGqn50HJxZVXKaT53DdbuZmKSvgNsjIJ++rit4wllyFIKUzPOhLFMLervp9m4Qn7W4xhVHKG/s5cT/97SR37uOi6inH5FrkBQBPXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070240; c=relaxed/simple;
	bh=pfSjhiBCdWEueZV2JY7NvPpeGueAo/ur4F5F/8tuP2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe14H5yta8WxV4HbDOLdXvKczbiwvL/80519tni+YQCcDZqRV8x/yimB8HSOpCfL/BM1OProyZwfwsiwcYg5+feskBP+hTSnrbGZ8mWKDGiHCoq7xK1maweQZPmanWegEQiAkioQS+OoJGH/7Khq9Qlwq/Jdqlf2PSvA5smusYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOBNgV06; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso15392880b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 20:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767070238; x=1767675038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAQu8usZZgPqr6XefOMeBwVUvwr/9/vXnmhBkCIeE70=;
        b=TOBNgV06j1CjDiomX/VT+VmbIAps/hLd3GlUG42NA3DjUG4ukI+liKGoeaBx7jtRS4
         aWAW7TtXfCZptxyAW7TIwUb/ih/N+vwBcECz2hj/vvtk4dTaWjgLJv6a7qcGHACsk6BD
         KHESCyibSrLFzCnC/w5yGEwg6aWq4y9d7h/57fiJn+hN4GTzpDafAvuBzcwnSgSmDfDK
         H0kIAnqd5HrxJ4Tzw3fFHVejPQ7ekVXbqrcl9OOdAalQtIAZu9a4eXHVvHfk/odUY9Dh
         QTTOkkxcW4FfKi1M1UpFZ81ZZYaJmm1XusEHJYbi4Rt8+5BabvF46G+K64tiAgUeOL2f
         EZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767070238; x=1767675038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAQu8usZZgPqr6XefOMeBwVUvwr/9/vXnmhBkCIeE70=;
        b=uNC71iATIh2V2vYsvLfe+t9zsRcjT9OuO6bCjzSL+i4fhZvedoAYdzIyyPMTy14auN
         7qMuYW+UUYxAImv1fEkmtmvey+OCZ1rIqs+3ThwDLzUBVF1bj97kHTV9yXhcX6XnRIGN
         K4OpTpQGXJbQr8bQB58bcPNCNrdcFUWNwtTq4Ol8Uxnp4ypwfMU5H1Imh+G1REzph1PX
         uQSeDKZwA9xJIzPi6XXqvEjm+wBdYkoDG6RzBFu6uMacQ2stiouJCrcgdITVkCUrBnx3
         MMuRgEQ71TNBva5WsJHmIxjz8HJ8FyGNHt5MYMQG8j13ycgRFfAosxZckmZ+0oG1bYwG
         XqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtuFs2QJ/IidoG1REQ2Gfgv6rKnzjo02fQP+CFgK5x8SpkULY7SAdN7cq/0NZXDUVbTl0V+H4zkX3B@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRoXnTf1XIjVG70OKsFLTv+9FoiL/dYdX1PK9vqZSrR6Hr8QM
	15Oak/ZN+m0XWhMYH3Mg8NibQ2xvtPQmN7afourfR95d7j5awx7GkNhg
X-Gm-Gg: AY/fxX4UKrjbrcHQsXHJIL3I8Z6vU3wQkj2OZrQCjPcezioV4SqhkP/1fL2YWy3ohVU
	7dfsfGTGNU0y2m3087kRftpNBZRaYRQaHyEScY5sMiBpGj+1XEASD4kMhfm/HLECGg1YLRi1Hde
	95qqiItkVKIcCVO9b/bbDLfQJTwClNE1ICEx/YZpy9JcUYNAMBG4EaOaIMyvlfoJOlmB2x62BGQ
	QQ4xXh6VwJKHYFvJVaZWsT5FQkAtPMxoSo2zkrsqLUiZtealcZAXUqzhQp4S/oV8moPUDST+/zU
	AximQu7itLzN0f5dnni+vIg2akHVSnmjaySweh5LJzYT+aknKv0T34rwSniALqdBXPefOMDmQMv
	Q9Ru4Jp9I0+aj+eEty4/c2tkYhVFzUH0LXRxoczC9TMqZvcA8OSGrgeTiJxOhfDADn6Xv8KXnhr
	yWubv6Qp211VOi+63sw1VGPyF1fVM9qZh8uP2LVsqkIRfieTA1qRV9Ob1rolkCLQ==
X-Google-Smtp-Source: AGHT+IFRltqB5h90bJgRJypmxdLSXnFioKVInc9YxdWoeZP/3RSsexZ217SSNT+4mgmdbFQb9uXs2w==
X-Received: by 2002:a05:6a00:420f:b0:7ac:1444:6777 with SMTP id d2e1a72fcca58-7ff646f9380mr30293750b3a.12.1767070238391;
        Mon, 29 Dec 2025 20:50:38 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm31100194b3a.11.2025.12.29.20.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 20:50:38 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com,
	ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	dakr@kernel.org,
	gary@garyguo.net,
	lossin@kernel.org,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v1 1/2] rust: sync: atomic: Add atomic bool support via i8 representation
Date: Tue, 30 Dec 2025 13:50:27 +0900
Message-ID: <20251230045028.1773445-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
representation.

Rust specifies that `bool` has size 1 and alignment 1 [1], so it
matches `i8` on layout; keep `static_assert!()` checks to enforce this
assumption at build time.

Implement `AtomicImpl` for `bool` under
`CONFIG_ARCH_SUPPORTS_ATOMIC_RMW`, consistent with the existing
`i8/i16` gating.

Document the additional safety requirement for
`Atomic::<bool>::from_ptr`: only bit patterns 0 (false) and 1 (true)
are valid.

Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/sync/atomic.rs           |  1 +
 rust/kernel/sync/atomic/internal.rs  |  8 ++++++++
 rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4aebeacb961a..2c998cbd300e 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -158,6 +158,7 @@ pub const fn new(v: T) -> Self {
     ///
     /// - `ptr` is aligned to `align_of::<T>()`.
     /// - `ptr` is valid for reads and writes for `'a`.
+    /// - If `T` is `bool`, only the bit patterns 0 (`false`) and 1 (`true`) are valid.
     /// - For the duration of `'a`, other accesses to `*ptr` must not cause data races (defined
     ///   by [`LKMM`]) against atomic operations on the returned reference. Note that if all other
     ///   accesses are atomic, then this safety requirement is trivially fulfilled.
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index 0dac58bca2b3..0e12955082e5 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -16,6 +16,7 @@ pub trait Sealed {}
 // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
 // while the Rust side also layers provides atomic support for `i8` and `i16`
 // on top of lower-level C primitives.
+impl private::Sealed for bool {}
 impl private::Sealed for i8 {}
 impl private::Sealed for i16 {}
 impl private::Sealed for i32 {}
@@ -37,6 +38,13 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
     type Delta;
 }
 
+// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
+// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
+#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
+impl AtomicImpl for bool {
+    type Delta = Self;
+}
+
 // The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
 // guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
 #[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 248d26555ccf..3fc99174b086 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -5,6 +5,17 @@
 use crate::static_assert;
 use core::mem::{align_of, size_of};
 
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<bool>() == size_of::<i8>());
+static_assert!(align_of::<bool>() == align_of::<i8>());
+
+// SAFETY: `bool` has the same size and alignment as `i8`, and Rust guarantees that `bool` has
+// only two valid bit patterns: 0 (false) and 1 (true). Those are valid `i8` values, so `bool` is
+// round-trip transmutable to `i8`.
+unsafe impl super::AtomicType for bool {
+    type Repr = i8;
+}
+
 // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i8 {
-- 
2.43.0


