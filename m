Return-Path: <linux-arch+bounces-15632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F13CECF25
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 11:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA9D3003BDD
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00964287245;
	Thu,  1 Jan 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB/5dDKO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FA13AD1C
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767263273; cv=none; b=Hf2BXUhkI4cddVkSFXfZZh5Fu2qr+bTckcW79hyRD5eVQxzIhUh/BlYZKktmLFqUFHFmPkVpjIMC1Axsthy7kEom4MW6Eek14zx4NTDc4cePUvSA8LNIkQuAJ2pzJde4FfALAXAT2Q0peMRx0XrcxQ2NWcvfFnwhKvtrIVkCsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767263273; c=relaxed/simple;
	bh=b3MERlCpO5eAUyfKNi4xBSlLhTgFwdITcPb0+tRPkSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s96bDvUOZu6tcXjdR6/AFIHvKaaQc7AnEU1HpvFn2NZv4f+Jptl+fkL+Yze7+rUnBc5M32HMvxdPOYtUchEXToh3On27JK7h+NHiwrhz8BzDwyoJ/RJZ2rnI/lTcrOgwfvRYDgfjT04rC2aYnnqdUGmYuEKxGlhyIEs93w8g7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB/5dDKO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29f30233d8aso131868155ad.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Jan 2026 02:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767263272; x=1767868072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7k7k/M77RuhptL7oTBpXsHBZ5bueLiRVQID5HaGWlw=;
        b=dB/5dDKOYd0+6IiJkFchU4icLplv6yWAxvhYjSHPwT2VX6u1IN63s4amVgtWAXv57D
         nLBWoU+RMetdjnFhBAkalX8HSwdY0540sw5eZzqvc7mvDCrmnLOCL2nzCIMAalL97mDl
         CWr/r6gkkdJiIjaRlngE3INjhTQgV1ktsZWrqZZdxb25a1E1psSh0ut92o86Gfgleo8y
         z1wEEn+tUKEl8dpwvyCyKkQxNzXoGXPtC/B2vcoWNp8wXlinZqWjmy45+Ay3eEMZUwxk
         GBd6Ywm8nfjjD8slkCUcXoTlrwikf4H4rURN0xD3zmyVuiO9lVNZy6mXqNwco8pZ/1Yr
         sFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767263272; x=1767868072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7k7k/M77RuhptL7oTBpXsHBZ5bueLiRVQID5HaGWlw=;
        b=NVD7l/fdNSLJ0K/E+qALy9u9zySQWSlY5d1ONX0XI9SG8oJg85dg8IeW4KKXHe27iC
         8T9cYcXCK/IFf99s5ARHvEsj7C2oRBtLs1TEMWyqozgvJ8hjx5VQH1y20C7qJaKyK9+j
         XcwXMB8r2Fu2yAz4YyTtqXIotm5blNAPaAbfRXjuh2peiyRG1dUua4uZEAJLuqxWUnIm
         mVnl0ZKt35M/AemjJhPkk4dhqUddRgSwvvpKAg7l+kGC1NWmTaCDg3xOn1eR6oxux6Rw
         +UBctoKv+Fztod5qbHuVNDCwRHcIiWGWvZqbMlgrZ2+gxBR2PYcoABgQZZtjXImxdsAu
         fW2g==
X-Forwarded-Encrypted: i=1; AJvYcCVbfIPcOF69bsWyV9pz5GVdvaK1U6VliZyesHYwE2eUImR48+udMt0DcoUJz48SBT3ItqOCg0C03E0F@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQIc50vTTDds5c1MVojILUOpXHZJsaht6mFIB2rRM/CkfQzXQ
	xrm9qZ46Rfk7WfP2m5CRp2aHa/nSa4jrw09zZHUQTLdxIu64BuTTdqeN
X-Gm-Gg: AY/fxX6rzPLWCsjM6CnNXmIZIWqltzMA+oMkvItAj7d17OmwH/YHS0+OkFmm+ohkdu9
	yoGRZmutPMtWCeo3iVhuSKzaSQsXfAiYf7wedj20xkvhPSFbYvcWqKc0Z+tK2kI7gFZogy1gew7
	kncDcaIFImBl8DBoaCVoDT2tko29EwxDvgfFPVeZ/EdqC/PeLQrJOmEHHstECcZxVFsz6yw51ev
	qs8/Xc73MA75UjZIU0k4NUHJFAAd8hlIMV0+3IYjnIKy5p6rY2xZPtjTGFxCvSeVzS7O2Buutlv
	llcnVi5czUlcBOw4kHeIo/LKeFudUZwvUOZ3ly+ffAbjCjQi2rIkJ0U55tWQ83dmnfwVTDsRdiw
	FgQrXQY6SwKUqyF0taUAi/nwJabIqqsGLiSNQZryorkmHeWIJ03AyR4GjbNHi2KdLLDRzr+t5BT
	cxVUGIufdTmoQFkEZQkA6gVmAGaoVjwm6XiDLaZZ/tREroftdYJU15p/RFOcmK6g==
X-Google-Smtp-Source: AGHT+IE/pdvl/cmdFbtdsBCOIe3D3Xg1Gg2/JxQofyxtmGbShO8YYJBnBmbCAA4S5IUpoye7TaH79Q==
X-Received: by 2002:a17:903:2301:b0:294:f6b4:9a42 with SMTP id d9443c01a7336-2a2f21fad06mr303748775ad.9.1767263271638;
        Thu, 01 Jan 2026 02:27:51 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ef44e0b24sm11006734a91.0.2026.01.01.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 02:27:51 -0800 (PST)
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
Subject: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic booleans
Date: Thu,  1 Jan 2026 19:27:18 +0900
Message-ID: <20260101102718.2073674-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
AtomicType for it, so users can use Atomic<Flag> for boolean flags.

Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
particular, when RMW operations such as xchg()/cmpxchg() may be used
and minimizing memory usage is not the top priority. On some
architectures without byte-sized RMW instructions, Atomic<bool> can be
slower for RMW operations.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 4aebeacb961a..d98ab51ae4fc 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
         unsafe { from_repr(ret) }
     }
 }
+
+/// An atomic flag type backed by `i32`.
+///
+/// `Atomic<Flag>` is generally preferable when you need an atomic boolean and you may use
+/// read-modify-write operations (e.g. `xchg()`/`cmpxchg()`), and when minimizing memory usage is
+/// not the top priority.
+///
+/// `Atomic<bool>` is backed by `u8`. On some architectures that do not support byte-sized RMW
+/// instructions, this can make RMW operations slower.
+///
+/// If you only use `load()`/`store()`, either `Atomic<bool>` or `Atomic<Flag>` is fine.
+///
+/// ## Examples
+///
+/// ```
+/// use kernel::sync::atomic::{Atomic, Flag, Relaxed};
+/// let flag = Atomic::new(Flag::Clear);
+/// assert_eq!(Flag::Clear, flag.load(Relaxed));
+/// flag.store(Flag::Set, Relaxed);
+/// assert_eq!(Flag::Set, flag.load(Relaxed));
+/// ```
+#[derive(Clone, Copy, PartialEq, Eq)]
+#[repr(i32)]
+pub enum Flag {
+    /// The flag is clear.
+    Clear = 0,
+    /// The flag is set.
+    Set = 1,
+}
+
+// SAFETY: `Flag` and `i32` has the same size and alignment, and it's round-trip
+// transmutable to `i32`.
+unsafe impl AtomicType for Flag {
+    type Repr = i32;
+}

base-commit: dafb6d4cabd044ccd7e49cea29363e8526edc071
-- 
2.43.0


