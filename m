Return-Path: <linux-arch+bounces-15563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E398BCE4B81
	for <lists+linux-arch@lfdr.de>; Sun, 28 Dec 2025 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49CEF300D483
	for <lists+linux-arch@lfdr.de>; Sun, 28 Dec 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B81DF755;
	Sun, 28 Dec 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdZsEalU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7323EA81
	for <linux-arch@vger.kernel.org>; Sun, 28 Dec 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766923610; cv=none; b=eWzNM1gCyCk6lHQ/52smbASXrbEuv8NU23edHCS+1dEmGNYGCFk68BQeoznsHiFOQ344MHTU1vO35Q9Lc61mV+h/eQyw4B7gDz0Qb8klr6EuEk7/7c5vGYf4b3trDKUodNV3YVIebMEzEwRQg4JDo29EuVNsUGYYBeIfjm860sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766923610; c=relaxed/simple;
	bh=6f+9vheRBSIp53sJKd2FU0IPOAixNytxv8A2ghoZpA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6D12Rhy9G4XO0oz0tP9KvQNaiHgcJp4377sqMcWrbEpkXhyXt4badq3eTMPsUoP6bXiOdeDNTNQQ4oVjBm9G0kXRg86MRRHCj3S/wmlAuhFw7D8qnRb7NRAKbBiBONkf1WS3Bge92BdkYV5t5ZvQvWo0GXRwrQv7y2KhO5v7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdZsEalU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso9689041b3a.2
        for <linux-arch@vger.kernel.org>; Sun, 28 Dec 2025 04:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766923608; x=1767528408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h8C/PqE3VMHZYKO75kSrHKcH1eM5Y0IdJqxognnwlY=;
        b=cdZsEalUOCigcKte0EYq0nx0FZuOL2VVuRIcz/ja1RvRrx8hTGjc4HJ7t1ngQQyviW
         HVc7gItV4924KlBiRcOy5dyrdky7PVanPzEVzo17VDNyEJIUTuqhodyomFNXRddbSvd0
         x/qfzw8lSkpxfNeOavwsvTUw5Tp0RWk4MD5sP9hVb0xzykWNO3Pm0sxOZw9ooYxVYGFN
         SkjOEKQlgAHFx6vRvcWzD8Ec00o2YO7BAymdF73J5GBN+u20Y7s0AFapUuUiMFjb267I
         ntPWRFkGP0R370Gr7udK51nZ+mKgPKa566IBc617WKDOEWnqrM6eRbpChjKQlmuYBf7f
         Is4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766923608; x=1767528408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6h8C/PqE3VMHZYKO75kSrHKcH1eM5Y0IdJqxognnwlY=;
        b=XuExQ6epMqLFtXbDTBscCzipGDQO5leO0TuSMdcbVCHkWDaylju57MJtn0VYHhLxsD
         0WCoVlAXWwEThrKXLCZq0pv5r9gCo8bQPS+fNTtjp3J+8Vh/iPPZDYngyJoT/IlvOsFp
         PY/rbJ/5f657uEQf0luO2LKCSHxhZd7GA3k6Bi0K3g8ud0h09hVc3cvfNrSPeXV12+OU
         HCivkercGsPdYIwjWK0Q27E2reqLSss0A9VdmzBHvzlzC8DG1cebeUeuGl8f0aVnUFJ6
         Drz/hHdlBU28IsbfaCrO+xCsS0d2b/xvpJwXwyUP/mtHtcLzKF5Uklys4CZyX9KhuKz7
         YrbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXczmKGRGQJCpivg4t4bKYbhO2T2tbSoAmKlKckdbXGxDfcJ+N2DHvQ8fu8G+Wo53AParj4PvfwMs@vger.kernel.org
X-Gm-Message-State: AOJu0YycaRBzwkFBiG7vvY6/OKPRWCxWhkPF0GtC4E7kwPqXWSMc198L
	lQuEwSi5c5x/p1uiy9QEioRVWmv+sBTUk5jdH/AUzqAfaH3k9JoC4dYQ
X-Gm-Gg: AY/fxX4Q9BW+P1DCGC28Ehslrg6c1FA9zJ2y0k9iYit683YmXCWTmUbygUQY+aIa/2J
	MTyZ8W2SxyLq6vE5t11ieBgreLH7kZlv4h3Mq01WpaxDhbelEh/JycYciNFV9LoS8UPeatWRXtp
	Z8NEDJ+8A+LzYOgGMXmvVF8YJ+4Q/e/KPhrniXXx2k5WJQOKFCN3yCJnj4Rj1L+O3yB8fjNOuDD
	v5p4xL+uplJUhdzKvJJx7FZi0l88WWTdyEhMhfVvPFiW5IRs3TG3Bfl0xNt33VVhl73q8xRTqnv
	cDuJyMtc8jiGi7ieP1yJWngvAVqUzXoktWLE6om2+6fCyLSHqigBIw4NThXe+lW+5Vf39M9UxW/
	a7gvJRcfoS4xSER15NKghg7uP3JxpADBrlQPAHOeJ1W2Yja3XpU2GytsHoDWo8IsOg/iA0kaaIA
	Pw/wO5tSn4unFJUgNi31dxvXQKcJ5TEBigKYo7ec2ILNyP+9U5CFRH0YglGIBlag==
X-Google-Smtp-Source: AGHT+IGl06bxiZxmOJA8LEaKTNR8p0l9I0xHezykgFuSkkx0FkmiFVNFycPYVBf4LvJGYXXZn65pPw==
X-Received: by 2002:a05:6300:210c:b0:334:a523:abec with SMTP id adf61e73a8af0-376aabfcab7mr25243298637.60.1766923607698;
        Sun, 28 Dec 2025 04:06:47 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dccd14sm27914829a91.16.2025.12.28.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 04:06:47 -0800 (PST)
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
Subject: [PATCH v1 1/3] rust: sync: atomic: Prepare AtomicOps macros for i8/i16 support
Date: Sun, 28 Dec 2025 21:05:44 +0900
Message-ID: <20251228120546.1602275-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Rework the internal AtomicOps macro plumbing to generate per-type
implementations from a mapping list.

Capture the trait definition once and reuse it for both declaration
and per-type impl expansion to reduce duplication and keep future
extensions simple.

This is a preparatory refactor for enabling i8/i16 atomics cleanly.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/sync/atomic/internal.rs | 85 ++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index 51c5750d7986..0634368d10d2 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -169,16 +169,17 @@ fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
     }
 }
 
-// Delcares $ops trait with methods and implements the trait for `i32` and `i64`.
-macro_rules! declare_and_impl_atomic_methods {
-    ($(#[$attr:meta])* $pub:vis trait $ops:ident {
-        $(
-            $(#[doc=$doc:expr])*
-            fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
-                $unsafe:tt { bindings::#call($($arg:tt)*) }
-            }
-        )*
-    }) => {
+macro_rules! declare_atomic_ops_trait {
+    (
+        $(#[$attr:meta])* $pub:vis trait $ops:ident {
+            $(
+                $(#[doc=$doc:expr])*
+                fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                    $unsafe:tt { bindings::#call($($arg:tt)*) }
+                }
+            )*
+        }
+    ) => {
         $(#[$attr])*
         $pub trait $ops: AtomicImpl {
             $(
@@ -188,21 +189,25 @@ fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
                 );
             )*
         }
+    }
+}
 
-        impl $ops for i32 {
+macro_rules! impl_atomic_ops_for_one {
+    (
+        $ty:ty => $ctype:ident,
+        $(#[$attr:meta])* $pub:vis trait $ops:ident {
             $(
-                impl_atomic_method!(
-                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
-                        $unsafe { call($($arg)*) }
-                    }
-                );
+                $(#[doc=$doc:expr])*
+                fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                    $unsafe:tt { bindings::#call($($arg:tt)*) }
+                }
             )*
         }
-
-        impl $ops for i64 {
+    ) => {
+        impl $ops for $ty {
             $(
                 impl_atomic_method!(
-                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                    ($ctype) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
                         $unsafe { call($($arg)*) }
                     }
                 );
@@ -211,7 +216,47 @@ impl $ops for i64 {
     }
 }
 
+// Declares $ops trait with methods and implements the trait.
+macro_rules! declare_and_impl_atomic_methods {
+    (
+        [ $($map:tt)* ]
+        $(#[$attr:meta])* $pub:vis trait $ops:ident { $($body:tt)* }
+    ) => {
+        declare_and_impl_atomic_methods!(
+            @with_ops_def
+            [ $($map)* ]
+            ( $(#[$attr])* $pub trait $ops { $($body)* } )
+        );
+    };
+
+    (@with_ops_def [ $($map:tt)* ] ( $($ops_def:tt)* )) => {
+        declare_atomic_ops_trait!( $($ops_def)* );
+
+        declare_and_impl_atomic_methods!(
+            @munch
+            [ $($map)* ]
+            ( $($ops_def)* )
+        );
+    };
+
+    (@munch [] ( $($ops_def:tt)* )) => {};
+
+    (@munch [ $ty:ty => $ctype:ident $(, $($rest:tt)*)? ] ( $($ops_def:tt)* )) => {
+        impl_atomic_ops_for_one!(
+            $ty => $ctype,
+            $($ops_def)*
+        );
+
+        declare_and_impl_atomic_methods!(
+            @munch
+            [ $($($rest)*)? ]
+            ( $($ops_def)* )
+        );
+    };
+}
+
 declare_and_impl_atomic_methods!(
+    [ i32 => atomic, i64 => atomic64 ]
     /// Basic atomic operations
     pub trait AtomicBasicOps {
         /// Atomic read (load).
@@ -238,6 +283,7 @@ fn set[release](a: &AtomicRepr<Self>, v: Self) {
 // used for now, leaving the existing macros untouched until the overall
 // design requirements are settled.
 declare_and_impl_atomic_methods!(
+    [ i32 => atomic, i64 => atomic64 ]
     /// Exchange and compare-and-exchange atomic operations
     pub trait AtomicExchangeOps {
         /// Atomic exchange.
@@ -265,6 +311,7 @@ fn try_cmpxchg[acquire, release, relaxed](
 );
 
 declare_and_impl_atomic_methods!(
+    [ i32 => atomic, i64 => atomic64 ]
     /// Atomic arithmetic operations
     pub trait AtomicArithmeticOps {
         /// Atomic add (wrapping).
-- 
2.43.0


