Return-Path: <linux-arch+bounces-12731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72775B03604
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2782A16F50F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F1230BC3;
	Mon, 14 Jul 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtDMzsyZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BD22F389;
	Mon, 14 Jul 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471445; cv=none; b=VnLTDO2IWsOVckl4scCLmF3NAE5M86cpQm0svCgRlRsjuFJjOi4hJkaxg9VEeBgVMnREO1PvaeEmqUcK5A+lAGJLR+McatK93iVKwQajUMl2OTxwBcQmzmx/KqrWBf7hde5pBdgOjJBFDyxYexa//ATrgITUtaxBbCfymcF1tSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471445; c=relaxed/simple;
	bh=Xx7XrimI1grrY3rjitNo3nkWmAHUSiS/xYf9TETdwcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUQKMWTOmu+HwJY0yMW0onWsxg/eh4SFQRoX+tVHkk6RhBj9D0xBxbVrTK3r4+yMC4XNiTelmLJLBcUcD1EvdcdUpevCoEgyV01c5TqrR8k2owpGW20ZBcYlDFbr/XcUbJ7BcbTCsAfHcamaMiIxPWBkua4cZEsKuwEA+HlW28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtDMzsyZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so58093126d6.3;
        Sun, 13 Jul 2025 22:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471442; x=1753076242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9o14AcfIbJR88gN5wImGuKOPlipr5VAPIVjAMRfZdsk=;
        b=QtDMzsyZ4ZLEG2Hvbs5kDlQt8CGoY6gE4utAlgIM2XjATzBbUEBwgl/Qqgk6LcDRDi
         paLHnGW0h8or/SzrOs0B7Pma8RBeFHD05f8dTVVm3rSdBJhT/NcpNXcJ9x9Mlup8gtCw
         mSEpukXrw79IFuAR2YdGlFRxCtJ80qeT/EVHzecLYYgPh4HjtO1et70y2Iw3IJqF1PyS
         FAdEIKOCqaCJ1fVdswvCOeyLZalDSC8HD04ghekaLfVd6LxAmJSTKPMjADWEhr9sL5Wo
         +8Bu7OoGG9Zf+xyAxrIO1UZowzdhGydAEEUTx6Q0QZtUaY1J6q9uWgFbO4rm0SYttgzb
         03/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471442; x=1753076242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9o14AcfIbJR88gN5wImGuKOPlipr5VAPIVjAMRfZdsk=;
        b=cIcgBN4CoXGfG3qkNyiVoJFwRQenQB08KB1eJcuueM8eOxTRrZNKJyEOailTGoWhd2
         qgffuMSQSDPSAfcG3Dv4kWXLbFVgv6LkBZm3UtP2UvA99Zed9i3+5hSbpdaaAEq9D5Ij
         OYE1Ed8wAlOlAsHV4sYSZ7L4Q+96+jNYq07Uw4ToG095zI4FikdPMq4X/IlGjUuJRfbJ
         9ERwD6GJG06tS5pQNWEFoU0IQEjH6979QmNScm5m4lpcGVpBDOkcyb1gBQhvR0KDbYsy
         mjM3oMos4HkWmEkBQe20wjrZXAECXfPBcY785d2IgawCjptRMKukb8zVQd1FkXQ6gb9F
         /2sg==
X-Forwarded-Encrypted: i=1; AJvYcCVMNs/8yz/Jmmpu8WVmSD/BHJzPpLG6cHlMAS/8qOri/R1POF+d7izRU4LujVVEXQJiXZJomgwDwx85@vger.kernel.org, AJvYcCXFPVIAIl3ECxfR+Qqhg0YGMd51jePnEG/2eECxDrCV5E8Q1Q7AUITLgzKxD/gQ4LiFXk7i0k3x22H+8YM5EfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDRFk6Vt48O0tV78FqOv0VyaDgXl92xN8vnDqmLA5hlEz2oLZ
	hfuybQVezd2uk8nVeNMzUvyrX9W/D7DAgdilDkwNXtOcrn6rIt6/eETC
X-Gm-Gg: ASbGncutGhDmyAdWcyRsLb9bo1WPeBHcwUXRQ5Qx9fg0aXJYNOOVFqDgCrbDZuUrlzt
	eug421DjF6vMW33GDNclu4N9gUDepWwj80FzHCffFkUqrqk3VM6+e/4K85Zt7mchu3kdypgqSLY
	WNrvqqwO1tXCWPW5ZNEA4F2pxvyWoFKXXQmy31k1hbGvdTWFFzbqkyKdGlrKQAZ3cdLo3LJgoO7
	t8ge+WSXRB5uM8Dx3B/T1ZewDAeNq1Y+GoithzPwleWxN8O5qLStdBW2zueXcpGo7Ojc3rMWzho
	V4PWVLM6lQl4/8P17L00hmQwjtuk638pOtw9xYwmyx9A5w3W+SlgGVW5Jo4GtuazkFX/KoTWRp0
	N68Z7bjE7kNiAw82myOP2rTCep3eZzy+xMNayoyFCupJ3Nzf/SGYxGG1A70r+9QgpSN13WPfz3P
	M5nx685x3ESIvS
X-Google-Smtp-Source: AGHT+IHrL78L7nYkPxpZf9whcVqknp6Yf5dLicLrAotiRmMUMxMDJa2AV0OPspkgKmrWBtKNoC1D8Q==
X-Received: by 2002:a05:622a:480c:b0:4a9:befe:c13 with SMTP id d75a77b69052e-4a9fb85c9d9mr167555741cf.9.1752471442433;
        Sun, 13 Jul 2025 22:37:22 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab7755b45fsm551571cf.39.2025.07.13.22.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:22 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 636AEF40066;
	Mon, 14 Jul 2025 01:37:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 14 Jul 2025 01:37:21 -0400
X-ME-Sender: <xms:kZd0aFrI1NRpxvwzzlHoC4Sp9IfZiY5D9GNIN5q0OWKQCGxGnWTrGA>
    <xme:kZd0aFzUgy1MCLsKTA4_Z_M8A5_TLzmZUqG45rPIIP-rNvffGsqvt_rjhPzyxJTHH
    OLFmTUL6J0sHb60dA>
X-ME-Received: <xmr:kZd0aMxqsxbvQ_XFrBdVtbqQnIU5ZSvaa5534-QighMZCXOQNuFleeJDXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:kZd0aFbXC8L9o4J0zu-g4Ry02tX3aP_e_CgXDQwtgmxmjkp1ty1J8Q>
    <xmx:kZd0aFn9eqld5PRW14qoqqD8eocbeD9tMyQ_tR9pMHPL9G9vXn_yZg>
    <xmx:kZd0aCG2tWJdFdDnD_vAcj8ytxwY7PsXfVqio4zOkJmxfj3edcGXQA>
    <xmx:kZd0aEiFjwoRzO18CKwLc72Be-tCkAVaCyF4hWGgMw_gndIdQI8v-A>
    <xmx:kZd0aMlZ9aOFCyUbhUeDBcYweMgDWT0yzETowaJM-ffXVU0tSL-ih8Zo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:20 -0400 (EDT)
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
Subject: [PATCH v7 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Sun, 13 Jul 2025 22:36:56 -0700
Message-Id: <20250714053656.66712-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714053656.66712-1-boqun.feng@gmail.com>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
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
the binary size of kernel if inline helpers are not available. To do so,
an internal type `isize_atomic_repr` is defined, it's `i32` in 32bit
kernel and `i64` in 64bit kernel.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 50 +++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index eb4a47d7e2f3..3c1bb0c4d396 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -49,6 +49,35 @@ fn rhs_into_delta(rhs: i64) -> i64 {
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
+crate::static_assert!(core::mem::size_of::<isize>() == core::mem::size_of::<isize_atomic_repr>());
+crate::static_assert!(core::mem::align_of::<isize>() == core::mem::align_of::<isize_atomic_repr>());
+crate::static_assert!(core::mem::size_of::<usize>() == core::mem::size_of::<isize_atomic_repr>());
+crate::static_assert!(core::mem::align_of::<usize>() == core::mem::align_of::<isize_atomic_repr>());
+
+// SAFETY: `isize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl generic::AllowAtomic for isize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl generic::AllowAtomicAdd<isize> for isize {
+    fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
 // `i32`.
 unsafe impl generic::AllowAtomic for u32 {
@@ -75,6 +104,19 @@ fn rhs_into_delta(rhs: u64) -> i64 {
     }
 }
 
+// SAFETY: `usize` has the same size and alignment with `isize_atomic_repr`, and is round-trip
+// transmutable to `isize_atomic_repr`.
+unsafe impl generic::AllowAtomic for usize {
+    type Repr = isize_atomic_repr;
+}
+
+// SAFETY: The wrapping add result of two `isize_atomic_repr`s is a valid `usize`.
+unsafe impl generic::AllowAtomicAdd<usize> for usize {
+    fn rhs_into_delta(rhs: usize) -> isize_atomic_repr {
+        rhs as isize_atomic_repr
+    }
+}
+
 use crate::macros::kunit_tests;
 
 #[kunit_tests(rust_atomics)]
@@ -94,7 +136,7 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
@@ -103,7 +145,7 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -116,7 +158,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -131,7 +173,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.39.5 (Apple Git-154)


