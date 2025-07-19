Return-Path: <linux-arch+bounces-12869-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F185B0ADA6
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3755B3BB7BD
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87B22E3E9;
	Sat, 19 Jul 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCRA026r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DC224B03;
	Sat, 19 Jul 2025 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894529; cv=none; b=bhA8zzpQnQkGqqFOnoT6vnJaEcqdxf5R2p3cGH85zkypmXcj7tD17v3T53dGIpovZgx/e/jAMUSzJWU7iIOJHEYh99hCsvYHtyWe9sJU8ZT4aF2IZqIr84m2XVmzC868cNhhrYCtB43+n17qtK3HlVmfkA69Sr4fQrU5B/ghEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894529; c=relaxed/simple;
	bh=9J8UzkIID/XiEhOWXJ9BC39wu1fLwBzVqB38wRzp7CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I890fa8L3wh+pAGmT8qMguaGY++tMNY/znL84/vrIawfex8Ig+2J7mjz9sNEP66Fe0w96nIb8ANleCNgqf0yrUjZnDXv6qjKveJ7v6zCAZsINKCObcGyHpj9Y2uHoiJzx2VThiOMQY1RDi5c/GMfxH0NOrLwfn8S2CfQFlZuTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCRA026r; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e1f3b95449so365340785a.1;
        Fri, 18 Jul 2025 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894524; x=1753499324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRV31OgwoLIyVdat05xKwhcifuZryi7XwOha7Q+Eics=;
        b=fCRA026r6S/gYav/vzSOjmjyadEJCKWFWoX7HP530/EieU8Ln/kEu5l2n49+c7OCIC
         rl4qsGng7v7018GIqJqD346QuC3yGS9J6kMlhrXDbCiztn9S/0ExwQDCsjGF+YdKMTi/
         +F+WfUusFsrx3gDgPG+KZG4vQeT1cSVK3YPa8EUu1ZWoYK271xptVHq5LTxne8L5d9aT
         5KL2yUwcy+ccCedfv0fNupAmioZJpYxiXeJAhmX+q4pPabnX6UkVQ/0B4X7nMHW47LDV
         kFMvhWdYnPVBDa9+uBTFyq4nLLa4PfgDuuHhujWVakGvSmXTGRQGJdBjZlQbAYgwuwDG
         Ot1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894524; x=1753499324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRV31OgwoLIyVdat05xKwhcifuZryi7XwOha7Q+Eics=;
        b=JscYjmwIgySLOCU6gXqq7/W0NtseQQqkjDG4ppu9dMfD3cnASRT0c0kXqVo2taQO8b
         1CRMcfEfqQ5uSrOXaQS3qVYcgxarU0ucv6ApQJdq/LyUcOqTFB/jOO0AqzAoMW9/0lZq
         g47P382borxnNLBgWfGBD0Nag7EZbwF5I4LoC66e3O3cwHIzNhfZbSXxEwbisQcqVv5G
         +Qg8PUL6fclV/II8yZdT6DMBVJiA9UkCDWtviCrNM292n7TEBPlkIbGdA9fbwZRlLet5
         xb8GoqLYSZ3GxfulOwBo4PXuRY8bHneEvRs4DbIlXjPGdie1b9hhwGC+Piqux1GWj4FW
         QxxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZVQOMlyBtgan/tVszI7iuP6nCEK/kNWScAbRhQGPMQTAZgvhwxs1JU8tkMpDFG5uMOEwwgksC1YsbEgW6MSk=@vger.kernel.org, AJvYcCXGszCg7Vx7CkaaoBYqSb9NoXalH3lEX8VHkm9p/eZGRzLCDo6w56OP974LyvBDmUWnltGTLgMSp98X@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJ7OtWPAHsW6Ez+ubixkYXWdzsMfOolItdOtlJz1w6KuklEAI
	hbnBHgKGrvbzabmCN/qAQ9naEDFHQwEYu1GKhseoUsKA3551bPidcnG7
X-Gm-Gg: ASbGncsp7XetkDpGCvf+rjFxtFtzGXlB8y5EMtSA+kPBbc6TYhq8rZ8uRVEp2YFWMyo
	k7EAUOgQ0sWRJ4W+AO5XtUy8hjIKKY62i723mOJMSyuXUh4jnTGUdlfhppF6r0uzsDs9Ryee1ZI
	MFSCxENSNhZ+z47SXoc7jKGEL12tISdEpV1X97stNwmaWd9nngdWYHc5r87OKYdb9pv9jCl6VFi
	8c/kj+8s20CYZUmqLj46YEKit1fzDV3kNLQJvMG1uVaHRSIOevqet8uLETu43KShY6boqkN0IcM
	9gh+d52zV3wJoPTzm9wxp9CXrc5FPdlxNt9dCkwDZ1ET1IycRJIlLN/c0BtbH2kdEICQngLbG+d
	Phw+ToDfHaMSt3H3FDPKl1qubznTkQpDleq/sC1ZnI/xwrTO503d+kxG3c6do6IUGKbph22wkbM
	DcoOiqttvjMV9IlVPL8J5SVHc=
X-Google-Smtp-Source: AGHT+IHyjjzUNmWjmhlbi3o/iAlT48Spt+HaBYBPfrzRKfoQhkBndr62EEj/V4AfCEqT9BforNYfrQ==
X-Received: by 2002:a05:620a:2f4:b0:7d5:e374:e2bb with SMTP id af79cd13be357-7e35592ffa7mr694036385a.27.1752894524039;
        Fri, 18 Jul 2025 20:08:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c4780esm157275585a.55.2025.07.18.20.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:43 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E1F01F40066;
	Fri, 18 Jul 2025 23:08:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Jul 2025 23:08:42 -0400
X-ME-Sender: <xms:Ogx7aDfA4tJzZly0obynakDeyqGD_0yTpnRhx7CBtrQHi6oNVnJEfw>
    <xme:Ogx7aKuqwrH9yBsGu0GhdAwFYAbSBlCZ5_97s704Zyf9C3jRtBwwcIhaCMNZ5WNbc
    T3IkW3eO7_LqFu2Xg>
X-ME-Received: <xmr:Ogx7aBGs63i8NpuV0-KwfCG-xvtllxlfVktwlpzUC4yFMaS08YWQv3PM6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ogx7aEczjTriXADfzaLRZHn3o9hHLJfzFA7cmpcEjnTJI7h0SvPokQ>
    <xmx:Ogx7aNv2m1mLc0ZAqcnTIydGzrfqMfMaM1nBFNJRWsdyFFkaC6OW9A>
    <xmx:Ogx7aLnzuEzgEW3vvW_aJD0ooVFQxUIUNz2plUwit5KU0RpT7gUlfQ>
    <xmx:Ogx7aIAF9UGHmBoFgo-HML_sk6abb3KOMtU7fhohcIk397ZPisSgLQ>
    <xmx:Ogx7aLw48kdIMys3zQ53OR7QV9xtyZuz0YqBzUo3pmd8QAul4fWkz08R>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:42 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: "Miguel Ojeda" <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Wedson Almeida Filho" <wedsonaf@gmail.com>,
	"Viresh Kumar" <viresh.kumar@linaro.org>,
	"Lyude Paul" <lyude@redhat.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Mitchell Levy" <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Alan Stern" <stern@rowland.harvard.edu>
Subject: [PATCH v8 8/9] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Fri, 18 Jul 2025 20:08:26 -0700
Message-Id: <20250719030827.61357-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250719030827.61357-1-boqun.feng@gmail.com>
References: <20250719030827.61357-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AtomicType::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available. To do so,
an internal type `isize_atomic_repr` is defined, it's `i32` in 32bit
kernel and `i64` in 64bit kernel.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/predefine.rs | 54 +++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index d0875812f6ad..feba77372bb8 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -2,6 +2,9 @@
 
 //! Pre-defined atomic types
 
+use core::mem::{align_of, size_of};
+use crate::static_assert;
+
 // SAFETY: `i32` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i32 {
@@ -28,6 +31,36 @@ fn rhs_into_delta(rhs: i64) -> i64 {
     }
 }
 
+// Defines an internal type that always maps to the integer type which has the same size alignment
+// as `isize` and `usize`, and `isize` and `usize` are always bi-directional transmutable to
+// `isize_atomic_repr`, which also always implements `AtomicImpl`.
+#[allow(non_camel_case_types)]
+#[cfg(not(CONFIG_64BIT))]
+type isize_atomic_repr = i32;
+#[allow(non_camel_case_types)]
+#[cfg(CONFIG_64BIT)]
+type isize_atomic_repr = i64;
+
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<isize>() == size_of::<isize_atomic_repr>());
+static_assert!(align_of::<isize>() == align_of::<isize_atomic_repr>());
+static_assert!(size_of::<usize>() == size_of::<isize_atomic_repr>());
+static_assert!(align_of::<usize>() == align_of::<isize_atomic_repr>());
+
+// SAFETY: `isize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for isize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl super::AtomicAdd<isize> for isize {
+    fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
 // `i32`.
 unsafe impl super::AtomicType for u32 {
@@ -54,6 +87,19 @@ fn rhs_into_delta(rhs: u64) -> i64 {
     }
 }
 
+// SAFETY: `usize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl super::AtomicType for usize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl super::AtomicAdd<usize> for usize {
+    fn rhs_into_delta(rhs: usize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 use crate::macros::kunit_tests;
 
 #[kunit_tests(rust_atomics)]
@@ -73,7 +119,7 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
@@ -82,7 +128,7 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -95,7 +141,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -110,7 +156,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.39.5 (Apple Git-154)


