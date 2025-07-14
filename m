Return-Path: <linux-arch+bounces-12729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3592B035FC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1588F189A9DF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1622A7F2;
	Mon, 14 Jul 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6yMqVA0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00834226D00;
	Mon, 14 Jul 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471440; cv=none; b=p2PZkcleCYcbIijCmB0lh6iVgdWY/oH7f8U6H2j1PisRWAbLDAwGxvABbnQLhyHGHyoA4psLfkOFDveFdQqjL04wJAyHeCwDYpWgyN49tKNTxoDvj09HvaEVroomD0sPiL5odZo9SX5DqJQEivPaWViDwWbJWWamUtgNkn+J+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471440; c=relaxed/simple;
	bh=2Y2Wya5dyH5eO2lH59db9rc2Hj7wst5vUMcXtoDrUgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6fx6FBI0cyYiyMoP821cn4yAjPFbtHnLQdNq0JnPBwYPtGneCLWAGgf1+jiHGHZapECX/j0m1/Ju9Qeyu1OIxmkIhH7oRRnlyMCkLZGd6lorUZOHFfkL8Lile2HigJT6qfqPOaMTFFH7ZoSToWXZxTiXU8Wd/JanxIw51ny7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6yMqVA0; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facc3b9559so53097346d6.0;
        Sun, 13 Jul 2025 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471438; x=1753076238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNsb1w68dGNOSxkM6AOd5CDMWTKk35ep0cbt9dftdl0=;
        b=U6yMqVA0pQypbUCIx9vue0vjQ+5h1kxI0qd8vVi2GxWWbc146nOp57ZoVbPC8ni+cW
         8C2D9rCD+Eii+LhYp1MB0tFALuYq3/puWZYtCNsU8RDsG7oXD5/1PTfXM13zfDRxUJNB
         znb2KCQfzevd9NMbYLZSazesWMew1a9JM5fjLT8TNBYEZ3pbrxRxFJmz86efc9+IYGoh
         udk/9tiEgq87lmVkAU9choOkPbQ8LBLllCUNnkBlcB9bQKO1WRCIHGG5mJTcOaAOgbPe
         aiwCCzky4givSbYwkjV1e/y4aej52ETvolDqzvGar8tF0KOG2FILKAUHWgVggtkmxAM/
         iH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471438; x=1753076238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNsb1w68dGNOSxkM6AOd5CDMWTKk35ep0cbt9dftdl0=;
        b=kWVwa79gehNXcJ2tAjfN23TLBabofyUwjkBzOIvgvx2YeExfHyz+ffYk5KE7cpzADB
         rCFQSkUyHwsxIkizIuKR67rfJPEVVxDENNxSHbcr9Rmbg5ArMd15FhJqwhc2H2BSX4dr
         qt3BEAX6j7Km/O3iELL4AlSte3Aha7rnsf7V6biCr9CGpI0Nk+jCtUMklLHCU6jyawDX
         HUxZStSMlOxP8IDtRY8ngNU2KWrnQ5/VSnuHp8kYHgTOG2qIEux6wpk+T74N+MCePNVe
         6oRAu4BXz2FNcXXwNLhkBxgFah9dnUKBJ2PjbYmBf8AAfFH1F+YmoPT6Ba8dbeXWZYXo
         rpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBxQzcv5DsHbsxY2pA2Dn3x6qBCnN14KyytLZ7SmbAq6YFw7PUNHGFZQherTSh5BrPIR4r9JRvqrVBBfp6C0w=@vger.kernel.org, AJvYcCXy7jXyaGJKAJ9HTa7G1wYqUEQas7UDu6+jqpDUR8WEAfDGlICmlA28cXJEEUPFwkqeafC8hoP/S0p7@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6LAIaDrghN4heteqAGHjGi1TDGoOYPGzm77NlS40guv3sowF
	mPXDx6P/eSBw+WZwZ8NfrfliYoYYkWqvS2uQkrdcFf9cD/4wqBQcJSZg
X-Gm-Gg: ASbGncu+9/AF0dJkuHvxfUa65G5KSx00lHYZIWenNLQLvqdEOIDor/+usZaCVd4ufRp
	cw+oKjIgXUJMfLIhqn/ZOjS0uf7fS4WPXhbTVjk9dj6JMjY42vTd1iQ5mzzHLkhoBYyMy5LYxug
	ek0kWPdLfI0ua08kRuQOys85LpWNUjrZ/9YzO3TNxkp9NCqgmXfo7aX1m5M6qla3S1zgxKmqjsV
	eQeEznnZsLcDop2wn6ycmY4Wsx6F4ZTviQ302FyijSscv0BzcptxBPgEaKFfnPUQJEpQBKtGVEh
	dSTkhlQoEizYCOay66x3ZCktkOC77HBxBuzTFNd1VydAkaX6jsb/GYdQ/1PPh/QUU7L/6oB8xLA
	Qk8dvtPmBskeethluzkrDjXXBxPw75cfoHmvpsoLW6HBhWnQI3sLgtNdziQ4RJdTMghYuTG8P2r
	vMIaVRYiiQrkjD
X-Google-Smtp-Source: AGHT+IEBbGV+Zh9vJlvwZsK9o53Aw2K7X16dnHr4RRkgnzj9zoHHmmsypvxfF5TeSgxDZmCyQDhWYw==
X-Received: by 2002:a05:6214:5405:b0:6fb:51c:395 with SMTP id 6a1803df08f44-704a3aafe67mr165372656d6.41.1752471437928;
        Sun, 13 Jul 2025 22:37:17 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b4968sm43985616d6.27.2025.07.13.22.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:17 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBAD6F40066;
	Mon, 14 Jul 2025 01:37:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 14 Jul 2025 01:37:16 -0400
X-ME-Sender: <xms:jJd0aOU4zXlINNjWD9l_MIAwKixv1tCuTmCYJeNvPn_QJawbuJsxgQ>
    <xme:jJd0aMFgbJCFu7x1U8rMTmDCzUaSVIGgmEvM2MB56DmRXlHJ6wJliZXJGS2B8ljWu
    ZDAnZ10T3ZIjemg_A>
X-ME-Received: <xmr:jJd0aG_3DbHcuyefxf2VXCCi8QlfIfJ-RyHdpHW7HMnVauX2iqKne2YH7Q>
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
X-ME-Proxy: <xmx:jJd0aE2-he8k--0IbLRpfo_91Esw5DHSGScmfTwnbJRIF9mHg2KTvg>
    <xmx:jJd0aGmM3hGqIuaK3bbMF5-yh7bl7FaN0n4gS0Lu_C7BM2Ur0ghvvg>
    <xmx:jJd0aC81WJbvj49Mu7AQXz-iZGiwDvf3GjLqpu7Uj-AClM-or1DI7g>
    <xmx:jJd0aL7oW1ywGEpXeu-K1OZUAVisFWZzVKZQizp5Bc7L_n_nUtYmfg>
    <xmx:jJd0aCKuEjcigkKRkCOi3mvoqCuV4wvkSRYJ7VwWQb1s52coLlqqihgg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:15 -0400 (EDT)
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
Subject: [PATCH v7 7/9] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Sun, 13 Jul 2025 22:36:54 -0700
Message-Id: <20250714053656.66712-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 54f5b4618337..eb4a47d7e2f3 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -48,3 +48,98 @@ fn rhs_into_delta(rhs: i64) -> i64 {
         rhs
     }
 }
+
+// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
+// `i32`.
+unsafe impl generic::AllowAtomic for u32 {
+    type Repr = i32;
+}
+
+// SAFETY: The wrapping add result of two `i32`s is a valid `u32`.
+unsafe impl generic::AllowAtomicAdd<u32> for u32 {
+    fn rhs_into_delta(rhs: u32) -> i32 {
+        rhs as i32
+    }
+}
+
+// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is round-trip transmutable to
+// `i64`.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+}
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `u64`.
+unsafe impl generic::AllowAtomicAdd<u64> for u64 {
+    fn rhs_into_delta(rhs: u64) -> i64 {
+        rhs as i64
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


