Return-Path: <linux-arch+bounces-15534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF0CD83E7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 07:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADFF302BAAA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7917A2D738E;
	Tue, 23 Dec 2025 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asXweOHP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3E2D3A60
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470940; cv=none; b=fWjhOh+q+RN1pgU/2DOQ27g5WEsngyc5n2KN06tnYV4YbL9jzUz56J3Y2sdOEVWZZ/e5b2QlaK4m7HyyZEJauF7GQm4frW100IN//Co67C5f/j9PW1RNaV8kV7qQ1IAz9bzERdgS59/9knB5bu7FuBQsfBB8NtF+umNWyfvC9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470940; c=relaxed/simple;
	bh=OvsQthW770yxENUXStYMksug7LfpS2AgweNaEp49SqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdyIw4gLion/eSESYp5STk2pvlUGtSPc4IRk3p7BV/cvRdnk+Pz/xZkOSKCUOU+3ejt0xFrrCLqBEE6kwTIA/RtURwiPg1ps/VqCN7dJHcT/vIk62uW7BgjsPKm2+MTKwdTyUnkIaXMZZDvQlWzixHjWsiD+iybeq4DYMY0h2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asXweOHP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso4827863b3a.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 22:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766470938; x=1767075738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3w5zbPApeRzvnGzxav5MDuWlnN3SbnXqPeI7CxYT+M=;
        b=asXweOHPw4oFGbcv+NyvgyJB0TUroa1PrbO4M3uvIFgtqGIO4b2dmHUKQdPUmGAB7U
         ygvWO7AbcST7svNgwUOe6RIUK97fLASeK0zIACXG2Vikk1YHW9wWbki4CMsj0VzU6BoF
         dr3KxoD7NSNN1mnnEfUPowDzbgK1BkoV5MRmwdyJSYKtyna47gmVyXoJN65weGQGo8VS
         PMql3AIaPIc4oLjP1PyzSjmf/BDb5qMuWAqQ6PAI+6fAl0B7XEYPWKa26QPZ+2XHMx8n
         UVbMmXw6Prh43bObMLGp+ZmrCJMFZC0cGEUoBt8Z0sUX60223JgkNdyTAgDRgyIEnpMb
         XlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470938; x=1767075738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3w5zbPApeRzvnGzxav5MDuWlnN3SbnXqPeI7CxYT+M=;
        b=hkX3tb0ZP9T821p8VhExA+lzIY13in2uBbX13NVsKIrrRdiwf4ITB9i1hzP4dNB/jO
         7EHvO0HktrECYQcVtfwvg7QEWg4tB4Wl5eSdX10geCJeVmAYLrtQdO/0WpQTtz9z4jOJ
         eIY7l8awePk9CUN7inbniUpB5AnHj1wwdWNpkYLVSYWJMdS1y/lnR2j1oK5GJXXUO3v3
         kDUu0VkULPYJY7RL6fnhr+eSHhx1uEEwkQH8Y/XCXB7gSklyhR0YMMJ7tvr04+bZf0yB
         PKVNBPIIOQFmqInhKdAU/e5RMGnAewaqqHxyarOdozH0Ygc4DVBVbJh03gl2ciVi6T7N
         r8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXtSsbXdyPhIpal3KtE3GSLvirWlZ07D8pj9ADgZXBBBcbQShYKy6AOb0f1/hTkykbD6bIrIWxb8vvI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHRYuEQcMRuTbGirO3QqGNm/uPU/KIt64h3zbiYZVjmQFMp3T
	C2kx+NINaytdXO82eB6QzLx+GxvHFpqNCxPf6Y94X5Fn5nt1jWqL0LmX
X-Gm-Gg: AY/fxX72Eku4NsNXGqLCgUwU8RE0Imyk4Wqqdd0VgiLhQFGCZ41hYiyvYwOqKoDpDEF
	ebLrcEh3KM1Th2qj9JTHRwOuW+Cojqcb4xN31Wg/zVyJS2Obljw89JL+NgmewF4jUghWWIvrPu1
	UaGPzLGBj7tmePKchnERcn7hsjccY7oeLAUmA5IEL2e+BAIzQ6yeeICha63tOPn5A+zPxtvMtPa
	a0ZOWf9U0Tmk97gdUmW04nsZoO09sagi2y3ivGs0vDHJO1fNig42QqcKpqm6F9ps1tEA7zT4UcC
	GhPnZj/6ezjg7sc/mQEJrVvC3H2ETGr9Vv9mO4JM3fgj6wrSzoiQRUFxiATAh/q4LjjkAtyYSXh
	OyqfgDbEUP4hBX1/3scIJ3TqpDt0ojYpvhTXfhNWzYi1Dnk4Vd4NqxZpuiedP8NUQ0K7I6rE2XY
	ODySxqg2OL5D+m8pQo5kOUO1qWaRZIWDMsZBHvMK2TmXr9VF2eRGvN7A37J79UJA==
X-Google-Smtp-Source: AGHT+IEhvmpcoeiUAZvA5rhSi6UGGcejl2p2zgmpoBbNe1/2AFX9Poh5cZH1/+Tjrv6xlF5XlHIyHA==
X-Received: by 2002:a05:6a00:4298:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7ff650c7d8dmr11403476b3a.9.1766470938078;
        Mon, 22 Dec 2025 22:22:18 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm12395362b3a.35.2025.12.22.22.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:22:17 -0800 (PST)
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
Subject: [PATCH v2 1/4] rust: helpers: Add i8/i16 atomic xchg helpers
Date: Tue, 23 Dec 2025 15:21:37 +0900
Message-ID: <20251223062140.938325-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223062140.938325-1-fujita.tomonori@gmail.com>
References: <20251223062140.938325-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add i8/i16 atomic xchg helpers that call raw_xchg() macro implementing
atomic xchg using architecture-specific instructions.

x86_64, loongarch, arm64, and riscv implement xchg with full ordering.

arm v7 only supports relaxed-ordering xchg; __atomic_op_fence() macro
is used to add barriers before and after the relaxed xchg.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index fedf808383e0..b1ce7c038ac4 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -2,6 +2,7 @@
 
 #include <asm/barrier.h>
 #include <asm/rwonce.h>
+#include <linux/atomic.h>
 
 __rust_helper s8 rust_helper_atomic_i8_load(s8 *ptr)
 {
@@ -42,3 +43,20 @@ __rust_helper void rust_helper_atomic_i16_store_release(s16 *ptr, s16 val)
 {
 	smp_store_release(ptr, val);
 }
+
+/*
+ * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
+ * architecture provding xchg() support for i8 and i16.
+ *
+ * The architectures that currently support Rust (x86_64, armv7,
+ * arm64, riscv, and loongarch) satisfy these requirements.
+ */
+__rust_helper s8 rust_helper_atomic_i8_xchg(s8 *ptr, s8 new)
+{
+	return raw_xchg(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg(s16 *ptr, s16 new)
+{
+	return raw_xchg(ptr, new);
+}
-- 
2.43.0


