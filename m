Return-Path: <linux-arch+bounces-12622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A5AFF93B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0217A5A2D40
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A22D3A70;
	Thu, 10 Jul 2025 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvTivo36"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89C2D1F69;
	Thu, 10 Jul 2025 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127274; cv=none; b=gHLWkxYBX6J5hhS/8Pi7jKYawhZ+ldRDO8/5/7prxHdh/b12luIkY+UusyjMiKqgUNE8GMjtgldop5GJ/FkXXt4JTSTkzcppQoD6mb37U62ZT7qVYBH66qbwLcGiov8tkxIdfbxaXDSibzsFYqQuJW5b0XuYQH7xnfNfGb0Wc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127274; c=relaxed/simple;
	bh=I5bn5qP7xSOtXY8A079H4Bc+7+COegZ1IBZqWTzUO1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1byekw8DgQGIFkoZCWjBkvc6czs+LzegkmJBPIFReZqpYzVg9RYIMnUYimyZBknFXaVyv81JW8SW/UXfPDsU44s4L31rgV7QhKaLTGqkzDDDIBc/CD9Dra7FD/FJjhhu18J1K+8xXCUdlEtTg/5GcVZ+gcDtHQwMPLhzN5VJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvTivo36; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fafdd322d3so6995876d6.3;
        Wed, 09 Jul 2025 23:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127271; x=1752732071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Ob5dAYv6h4uYB8Uy4Mcs5XI6WfB0FBUZ85NYAMmg8E=;
        b=mvTivo36bMZ975kSB4VdEgvJ9U5VAHcGjBk9IaIpHSRkDP7mfIjnFB0KYk9B4MOBjm
         MPz1FtEZSkBK/bTN5v9q46adGiJWCIoYQFsFsHVwN7yoW5+c2OtzBL00NhkCbJD4votd
         4clIaC1eI+Bj6Z8Q3MyeRmYfEZfIS1uFukuqeVIq61B7d7H1LOp7W98xt5m3CP5OLVP9
         ReQBkw8gJzG90snPzHBUYxEo6st1pDASWMhq6eyfSPhXERO1sapaaSclpE+CF6r/Inz9
         0T1yymnGpsbY8Ia1ATcWQK64jXGg8uvU+Boh82zHauFLQdSxGI08dNgExiip+HYmGrhb
         v06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127271; x=1752732071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ob5dAYv6h4uYB8Uy4Mcs5XI6WfB0FBUZ85NYAMmg8E=;
        b=gfjk1UTClGMP/CJI9V1obo2Fp4Brik1joPy1/oYhMRbh/eS9N9n9acZopfJ2juLpIY
         UR3otCupNNaCXY4/oGihrlpon439xK/tn0gnvNymWOxYGHTRhgg0VBl9j53fDHhml64D
         qG+eSXE3PlXeE5n3JFD05MPGKZG3hALSzjIoyMpXUBpCyqyWoirI1NJVoMZ6Q9XM0Yj5
         87yAK5MJ57Sa+j255iq8V8PtuhNsHdQhLXYamivJj8q4E+pYr88Cctr2kM8oIl8qPaW/
         OhENshDy1+YuW+egPTiQGNlF/VnSohQil4xriTqn02gaykHMBWjMJpwEzbtGAlxapNpd
         ygHg==
X-Forwarded-Encrypted: i=1; AJvYcCX3GDEkm2o6+v9UZDOBGDbFSA8y9CcbxwYZHGE4cmrwbcJztNauTWq1si0AT3/4UfgnvulksDK/8vgyQ3lrz3Y=@vger.kernel.org, AJvYcCXdLiN143lqoWlhl/qzTdwYLkuZGPFzn8WwTrGIkpc+JjY0FIvL3d9twK7q+d8ZgVeDVkIOkRKuZyxn@vger.kernel.org
X-Gm-Message-State: AOJu0YybEGO33EEaxnKeQIMCMtwkZEgJXs/g59bNUFjBX2UL7WemkfuI
	LsKyPNz8cPhi5fMX00zR2Zg7KwQ4jJO+O3WfxU7omVBaLFIgOMgZ1Mw1
X-Gm-Gg: ASbGncsoFknMKn3R7mwiivlj3sdJaWJ7Xg7602gSil+X/R/AAOqi34PBvCrBuwqCgp9
	RMqiuNoyw+pZUzWzFrsRNRaMXPa1f7tXB6wppNmRwk3WvDvzwCxtEn+4wjv4byGvVnJJ4hCt9zB
	+iaMSqikZy6JYd7viXXM5n02XRFHQFRe6rhhRDC+h9Up4I3bYFZxNbYZpsAqb0lpAu34gFHPxaX
	jLhmhuKn1Baz4mddxco/B4tPEsKIPaQ8OmOWdlfk8KSR43Dt9byA3aR3lrhnRiVhIqxwtu1WLTE
	dk09CZY+zU2c1lYutl4V/qyow2XSKw/sEdvAtyHlb0JG9eTdw08LI4BXsqt6rUyyfKv9qadHaC9
	ceO7tHAWYT4j5DD/+wxzWNmvoYd3i7nIIEJwJubnin+RicdtPHw9m
X-Google-Smtp-Source: AGHT+IE9w/ELvtmgq0Wl+HmrVt63xyjSLjpZHrqKDNbh9jcyRRGILMKadm6VJspuHyORAx4nst+m1g==
X-Received: by 2002:a05:6214:401c:b0:702:ca9e:dba6 with SMTP id 6a1803df08f44-70498081a37mr17837936d6.16.1752127271002;
        Wed, 09 Jul 2025 23:01:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e3146sm5190806d6.41.2025.07.09.23.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:10 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0CF3AF4006C;
	Thu, 10 Jul 2025 02:01:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 02:01:10 -0400
X-ME-Sender: <xms:JVdvaHzE3eLtNFnqqgOSyR-_0HVX0FVY6uq89FPeATIXhD4vC9on1A>
    <xme:JVdvaAx6Fcs3jOH9PKJRmYRGeRP8zX6YAQNuuWap2uazKLdYbVQE5vlMnc3OEZcrg
    VobVbYaf698pNDnjA>
X-ME-Received: <xmr:JVdvaF4e6_JbdrHHWFChsrpK712IrAYw8u34bsXZpvKwYG7NwvPKF2pchw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
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
X-ME-Proxy: <xmx:JVdvaBAM_tHkV936ixg8oN27pN0tRU3_u74tU3zrPl-dcaCpDmuRsA>
    <xmx:JVdvaHDauF5v9-7JUHWbi1fXRdyhwRP31PbLaidrPGEqOYyPNNA4eQ>
    <xmx:JVdvaCq42XE7sd_WlVUh2CgFMoa0Ju0As5lgI24r-pli7ubIbLG_Jw>
    <xmx:JVdvaJ0vkpfj0aWuJutAIkL1j8h3wt2G3z3xCEhK2HlHUCTu5rA1Nw>
    <xmx:JldvaBU1b-j_Aw8lvArK5Y5r_bh-4dk_3pNgEDJAYnT94DUHYKp0gQ6P>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:09 -0400 (EDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Wed,  9 Jul 2025 23:00:52 -0700
Message-Id: <20250710060052.11955-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250710060052.11955-1-boqun.feng@gmail.com>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index e676bc7d9275..e1e40757d7b5 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -53,6 +53,26 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
     }
 }
 
+// SAFETY: For 32bit kernel, `isize` has the same size and alignment with `i32` and is round-trip
+// transmutable to it, for 64bit kernel `isize` has the same size and alignment with `i64` and is
+// round-trip transmutable to it.
+unsafe impl generic::AllowAtomic for isize {
+    #[cfg(not(CONFIG_64BIT))]
+    type Repr = i32;
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+}
+
+// SAFETY: `isize` is always sound to transmute back from `i32` or `i64` when their sizes are the
+// same.
+unsafe impl generic::AllowAtomicArithmetic for isize {
+    type Delta = Self;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
 // `i32`.
 unsafe impl generic::AllowAtomic for u32 {
@@ -83,6 +103,26 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
     }
 }
 
+// SAFETY: For 32bit kernel, `usize` has the same size and alignment with `i32` and is round-trip
+// transmutable to it, for 64bit kernel `usize` has the same size and alignment with `i64` and is
+// round-trip transmutable to it.
+unsafe impl generic::AllowAtomic for usize {
+    #[cfg(not(CONFIG_64BIT))]
+    type Repr = i32;
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+}
+
+// SAFETY: `usize` is always sound to transmute back from `i32` or `i64` when their sizes are the
+// same.
+unsafe impl generic::AllowAtomicArithmetic for usize {
+    type Delta = Self;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
 use crate::macros::kunit_tests;
 
 #[kunit_tests(rust_atomics)]
@@ -102,7 +142,7 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
@@ -111,7 +151,7 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -124,7 +164,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -139,7 +179,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.39.5 (Apple Git-154)


