Return-Path: <linux-arch+bounces-12868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E316B0ADA4
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BC7B3884
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3A22686F;
	Sat, 19 Jul 2025 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WheyxYVk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DE221DB4;
	Sat, 19 Jul 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894526; cv=none; b=UQPOgRqFLDlQW2GJ1CDFWaA/HTEyA8g5RS/O9bu6gcvmjAY7qf7ScKLMQeEhFIka8MRXuMBM+ZvNXLc6dlMd+cghI5cYG+R7lXJsKPB1qYJvZ3aNE6N86IgjVZT8m0RsU6YvrtpF4jPVuVzanH42Z9SATQfublHKFeqCtUFGf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894526; c=relaxed/simple;
	bh=TP3jTUuLChJ7+2IgzREnNWToIcGobJhvfGdbfGdDts4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdNsq5yVsRTb4mLIKCZlaUScNagt+LgsFc53u6e99rE5sbsoKdTk1XYMvGM4zZf1PaEL8a3WYOq7hEslUxztdYMRMnJwRwXW8nkMXSjGQQgLmnn+eKzh417HcZzJylWc/kn7J+ESPzWnecuhDDEz8ecc4izPrgwX/ku+3qoeckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WheyxYVk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4abc0a296f5so6468531cf.0;
        Fri, 18 Jul 2025 20:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894522; x=1753499322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9y3yhhEc6XLO5qpQuSE85PA8k6DmYNYdfRyagczjJ4=;
        b=WheyxYVkYPhEIhxKYf2kTVvCibp238tP9naldjvon1/dex5hGekmm5TRX/GeSc4wpl
         A72HPQwUkTpitj4VylcFEb8yagFKQGzzJYrIanEehWtqaU3Dkv3zAqbEW/rJAkEXC4gv
         xiVssvHoHIeSqr4lUoAU2/eh7jl6gO/zHHk7dpwFzgIgeXHF+2RjZfOJlcSVPcWFmSOR
         p3Wz2kBBEDpCl7hcfIPZXPn+/NW11TcqqHqqvUbXWaOHn6/hx3dIZKotHVyfGHMotLmt
         P29rW5SsA/BrG5tnZYxaeo8LXQktjSeIP0J+XqGB5/cr4jquIS553lKEsCz1sfDdz6PK
         NTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894522; x=1753499322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9y3yhhEc6XLO5qpQuSE85PA8k6DmYNYdfRyagczjJ4=;
        b=xHOJgPCDD3BUad/qZ+KU/RbjplWH2Xe8SUCj66OP/jEu9Bcc+514qXDF8zJrCNm87b
         yyJ8DJQb8/nD256o+q9FLxENFOsdDNPuAJIxfsPkl2acWPsGH3Nt+pNU70Y1fYBg6Zs9
         72gC50KsYjXXfWqcmKHP29RV63Be+NvWRT45AtXKasWl27JER7qtRjVsviDOps4gDlBn
         Q2Y61Kubpsayex6/414nvxNOHbAH9keZFankLlK2siDSpzyM0XvTFi7QBCe4jhA3tSFV
         oYJY6k7OK7UWA+TTEyjXxDJliOUhNUCmw8kDeYJaFvTFH4ZG2x9yjBPK/ytLu/dUpDmr
         AXIw==
X-Forwarded-Encrypted: i=1; AJvYcCUUZYXZYa8Z/bOXQUG1YuN1hIVgw0viQGTaT7n4+ZfmntmF3fVL9RH8YJQ9Eu+6/5EKVwPYp5VGZnytqJ02aCo=@vger.kernel.org, AJvYcCVHMgDN3vmLF3Ee51agRNNM0eFpH4D41oWINCe3yZ+ETdEU0QY9PBQiJeXvga6/LSpABGJPlUvTYtAi@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfAUeUPfOfjP9bdxp/qXT+woo5+sjAvnvzaNsu+pn+/N4pM7N
	1gLAxPA5MhrO9uU1d7Tk6WqZjxhh23oyZfqsndOg1/vwm9nuHEhAXOP0
X-Gm-Gg: ASbGncvWeA730RYvwRBrJa/ROGlZhcRYhggXurm8epbZUJESKh5EDw3DI/LaG/sCRth
	EcajEujEVC84LyHwTj6ax0/K9h7WxNeBR1eOJIh5lGiefJI8FJ1RK6hurUhs3hNS/1TcAtfWKBO
	s44nML+m3R/kWx6RiKrtQ2UqNaY0VHDZeeSRg6i1N0vqlyu4cJsHIzAfSB2JodNlLHPD0rpvjse
	bDIpuZVl4kzACaer/RJSEM5j9Nw6hyQysNIpjDIIBir0t5IhDL7WKy70kWTgoHTJB8yhfGwc54W
	1LLheiu/+zNo0pqx2kYqCKoAAaYOwW4zsxuWGyGD6eRuLtuKhqvmXsEfuTZ4TsasbvXV4/GSx32
	RE+2/YPV3wrNwdOGEfeGfITu37KW4qW8eM0FLLCPWiI/dfl8//P4YG9B9daActaxQfunUUv2DXf
	t7NizQXhYMJeRleaVWyZZIMHM=
X-Google-Smtp-Source: AGHT+IEkVdjbfr5P+zUooTumLYMu1V6g2Av8CBL01ZTkirc8lOzIIL/2TISrhK6wped1NkU4/oiqAg==
X-Received: by 2002:a05:6214:f04:b0:702:d60b:c037 with SMTP id 6a1803df08f44-704f6b08b25mr175496856d6.29.1752894522411;
        Fri, 18 Jul 2025 20:08:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm14661536d6.35.2025.07.18.20.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:42 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7BECEF40066;
	Fri, 18 Jul 2025 23:08:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Jul 2025 23:08:41 -0400
X-ME-Sender: <xms:OQx7aILMwMtMBwZfawLWn21L9Q4iCCHhtUiLtp4hVy4maQXA6QCnbQ>
    <xme:OQx7aJw-u4CPkpGP_tD7eISVwqiE2JAb4a9rVciISW-QCohrgQ-aRPHtF9Zopl5ZP
    flII0AIBWCXRJUPAw>
X-ME-Received: <xmr:OQx7aHZ6u62OpbFyapODk-HMIEiArem_4dpm3gxROFWosBOBKf-uS1qcqw>
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
X-ME-Proxy: <xmx:OQx7aN5_mFlsg9FP70C1IbZnt56Zn2rXKt55yLcq_IXJTFurN2pW1g>
    <xmx:OQx7aAD8GxeXotTuxOZvKCSrYf93UlIMmUWdfAMAjqjKdWnyDK0cow>
    <xmx:OQx7aLtVA5viUrQQrt567xdXwNCS1C0Cubqb-OcigyiXR7g3_sdWIQ>
    <xmx:OQx7aNtjgy96cSrW5A2jvhuXvfKE3-ga8mAf8xuEPXknPFJ48qmMhA>
    <xmx:OQx7aHqZr3vKXsx3JKD8KiUltSTzxaUx7mw2Laj92QMPV6ZtD_-zjUh_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:40 -0400 (EDT)
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
Subject: [PATCH v8 7/9] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Fri, 18 Jul 2025 20:08:25 -0700
Message-Id: <20250719030827.61357-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/predefine.rs | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index a6e5883be7cb..d0875812f6ad 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -27,3 +27,98 @@ fn rhs_into_delta(rhs: i64) -> i64 {
         rhs
     }
 }
+
+// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
+// `i32`.
+unsafe impl super::AtomicType for u32 {
+    type Repr = i32;
+}
+
+// SAFETY: The wrapping add result of two `i32`s is a valid `u32`.
+unsafe impl super::AtomicAdd<u32> for u32 {
+    fn rhs_into_delta(rhs: u32) -> i32 {
+        rhs as i32
+    }
+}
+
+// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is round-trip transmutable to
+// `i64`.
+unsafe impl super::AtomicType for u64 {
+    type Repr = i64;
+}
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `u64`.
+unsafe impl super::AtomicAdd<u64> for u64 {
+    fn rhs_into_delta(rhs: u64) -> i64 {
+        rhs as i64
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::super::*;
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


