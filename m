Return-Path: <linux-arch+bounces-12620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF826AFF935
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CFD16E3C8
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872732C327C;
	Thu, 10 Jul 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGTTnFKS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839E2C15A6;
	Thu, 10 Jul 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127271; cv=none; b=DZK4+/oq+y3Q7AMWJSrz/qghxU/H6S8KOGZMlw7o9/Tz5tcSabRTuLT5RicEPYB72pyaInu3kidmpGqds6b4cD5cEbyMRFqCxp8iaqgiOD/8pGInVt6vWZZqO54eQ5qTwftLBXzL8oizNKX6gbq7rnXk/p23jAjhd0cWmJC/Rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127271; c=relaxed/simple;
	bh=Hfyk+YB11j3QGic3cuIdSw0oHyEEnTvIKxG+qiLIAyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnhLMiw3Pvv0isytA9oFlLnXeVh7GhM00nwxW6ZQgZto4VvFp986bIDUg7zKLZ/kReWjvLAuYB2ZmmP65kFjMaku7jD6i3PwUf7eXXgMWgkjPJ5vreinuDcrpSZE+vq2JS6lEpn9BsO4bFCq2LzNKNgPa+A3aqRYHPdaoa4ApPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGTTnFKS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a43972dcd7so7190671cf.3;
        Wed, 09 Jul 2025 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127268; x=1752732068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qCTul36LoYeO61iHyu+jO7qVkK0zfTJ8jaG4JYpY7YY=;
        b=UGTTnFKSlmd0tx3Q+yWX7KNtMpE29ZW8xrQxHokMyiEkub6eo5fSiatEiezBmCx5Jx
         4+RbN8TbnN2Xx4cBg56bCwTyqbgsnZAFRzbqhZ+Y1IGq+ck2Q50wcc73+ZdFIzFbNjEy
         vx0Lno2NDiCiDfGje1wigEafBfxS06rTRs2u1s37cBYc2P66JJQve56eR20TIp9+Npq+
         F10FE7I0VYDtu3QGrYG9bS7V2/WTfAPdNpHAIwIxlXjvGTvsSQB48Rz+/wcZ+yOW4mby
         RbLOkcYAuyW8fQcYwNPbwyVwBsk2I8qaY5gbzWfE3duK/4TmzBc+spV/orNPH3joeVQB
         HdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127268; x=1752732068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCTul36LoYeO61iHyu+jO7qVkK0zfTJ8jaG4JYpY7YY=;
        b=eeJ9UqgQe7pbwqgVhnSJnBUeWzZdfFGicJ8V3aJf3JoRSybAqh5CbRWjfS+aPZkrx5
         ppL3rK6WqMPW9kK0bCqEMrcpxhJ5fK0+QNQiLVAUYTnod0HuXPY8d/M3aUbN2cwy/wK2
         azHcSWThbBfDNQ4sXl+dfWfNxwNCnRyw8ZODqxRbhEf1OXTugXmJY/ueoN+XxwOBBf+/
         nN2FF0uN2+sgKP7eCp53I9wcWgd3nvWJZEPgDrkuRXCAO53XKuJwpzsEnurAwOPoTsox
         OfG/0eeC7uVi5zRTduykMVYo0V/8d3VNKdb8dyMqxHcAXF5nILUTG6qWeleOJWN7UsQl
         yJQw==
X-Forwarded-Encrypted: i=1; AJvYcCX86TY+u47i4YYIAVpHdbfMfi2j51C79aLgy3uuUFwwdh0rlIDu47duRA5DOZkqOWxK7BZC0mqE/VSI@vger.kernel.org, AJvYcCXQMJ4EuRoxkC8h5ePycC4vbeUVKJWOKkpGJPXL98blTEL0vuJ4rIs2gLmdwHZ7GAglWbhN3Jukl7TJO7AAb94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTReTGKhP2Ad0cDqp+wHDw4a0vDV6XD+RMSrF2G65zwgC9hKP
	joi2uwWSz8M+8gw1rNJDVBF4wKRkmx7t5Mqc9SZkV/8FRqPH2BqMo2Gd5DG3OA==
X-Gm-Gg: ASbGnctwQD4ZFZVSc2i0MIgW+wUhmR7WQSmOELp/daDWnuWMJtwvV/epvATIgFm4NCd
	Ig5p3cnLEWvE8a0LUdI3jyhiQnayJJs/Rk0T3AVFHpp+JY0cSK+IiNoRsISeaFdKJDspXWk4hhf
	72ndzgEDmenNz2P3wfjPpInYDjDQRntUMwwCJI6v7CkbSvGJAc7o7Yp1Zh1UamHHllbXbkKlp/k
	gu/dKaKolYzPtee+IX4qLWH9QdBp75/sQ3Xs5l7hMyp2vurLRUoajfZO1V2hxGTldPbr/3QB5k7
	ZZ582KGfhrKXeXN7iYIfWzTAdlyqcYnvev4fjsh2RAD0ZoQGvw1Rvy+eK4BJfzcirwAqCBaLYxq
	6lXePo81/F/t3OhyY1DxCMOJNl7u8NyXeTr68IEC2JV9uPyzlwGM2
X-Google-Smtp-Source: AGHT+IHdAf4ekh0wIYWPLlJGBcN1jwPbal29cw38Chcz4Tlb7KgoYWolNrVn3J5kyGDUbF7TWRRYFw==
X-Received: by 2002:a05:622a:992:b0:4a3:4d46:c2a6 with SMTP id d75a77b69052e-4a9ec719caemr18734411cf.7.1752127268127;
        Wed, 09 Jul 2025 23:01:08 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc5b4bdsm5620471cf.25.2025.07.09.23.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:07 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E303F4006C;
	Thu, 10 Jul 2025 02:01:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 02:01:07 -0400
X-ME-Sender: <xms:IldvaFu7MugQ73StMcjwvD60JveFkiZNTCPfFSjL-8bSXuQgs_9LTw>
    <xme:IldvaP_wol0HaZ-BcOnRnawuedKq9sPCf4w20rHrep7kUSqh4CRWh_BTuvH8TAlis
    2htvyCXgENOc48-Eg>
X-ME-Received: <xmr:IldvaNUVCdTdwAukqBG0xh-i460GwUCul7CM-W_6eFXUQBYJJtIju7Vhtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:IldvaLtTyeuTujEOtvRArZ7LDwc82Y9K9ms0IaOpXhL9kJ865Z4tPA>
    <xmx:IldvaD8ATli688QEl01RCZjbMeuCe6F-2DLLTHmrjP1S-wMXUso20A>
    <xmx:IldvaE3LJhPtkNBupYGSJmzS4oTtjnfCec4pbqnDcmGAAtZS-MpOsA>
    <xmx:IldvaITH2IIBu9wh3C-gu8Q_eIJ2wI1NvXIpd8SaT9zPOkWSKVJJDw>
    <xmx:I1dvaHBs69z86RoaY3j1GNV_3RBQjGZ0JHDJ_L_BmKsW_PCZj2WKwfU1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:06 -0400 (EDT)
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
Subject: [PATCH v6 7/9] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Wed,  9 Jul 2025 23:00:50 -0700
Message-Id: <20250710060052.11955-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 99 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 26f66cccd4e0..e676bc7d9275 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -52,3 +52,102 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
         d
     }
 }
+
+// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
+// `i32`.
+unsafe impl generic::AllowAtomic for u32 {
+    type Repr = i32;
+}
+
+// SAFETY: `i32` is always sound to transmute back to `u32`.
+unsafe impl generic::AllowAtomicArithmetic for u32 {
+    type Delta = u32;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
+// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is round-trip transmutable to
+// `i64`.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+}
+
+// SAFETY: `i64` is always sound to transmute back to `u64`.
+unsafe impl generic::AllowAtomicArithmetic for u64 {
+    type Delta = u64;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::*;
+
+    // Call $fn($val) with each $type of $val.
+    macro_rules! for_each_type {
+        ($val:literal in [$($type:ty),*] $fn:expr) => {
+            $({
+                let v: $type = $val;
+
+                $fn(v);
+            })*
+        }
+    }
+
+    #[test]
+    fn atomic_basic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_xchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(old, x.xchg(new, Full));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_cmpxchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(Err(old), x.cmpxchg(new, new, Full));
+            assert_eq!(old, x.load(Relaxed));
+            assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_arithmetic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.fetch_add(12, Full));
+            assert_eq!(v + 12, x.load(Relaxed));
+
+            x.add(13, Relaxed);
+
+            assert_eq!(v + 25, x.load(Relaxed));
+        });
+    }
+}
-- 
2.39.5 (Apple Git-154)


