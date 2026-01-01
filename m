Return-Path: <linux-arch+bounces-15630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030CCECD44
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 06:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBA430084E1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F381F3BA2;
	Thu,  1 Jan 2026 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQnS0G0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7A15746F
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767245778; cv=none; b=JbBNitd0EQI/z+otmH0HEhKt/hqxTQmPGq5QWN7nn6zt41wVDcIaua2MUptFKaucuk9ok4afoSwIp+ByxjedAdAU3U8VLJfPpkqgiP2EDfwb4Rmj7fbvBxGTzHOLHLD/RGlnxSTISjSG3eWt151Nmh8QqVBNI7zOpYQEc/11IAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767245778; c=relaxed/simple;
	bh=Hp8DN7D/yTHZZuYL6cvL6rGmqaVhTJhqpDL41o8WHio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzF0MtilXybINSWBTaX1yBjHYCEvS7EIMlBJsCueq+xUpOYCXzT4svcUJRx+G1gqYDOtSSIGcDv1lwo7kkAqkO/5x+2kNtvg5O27PJJP/HxPd17KLhMNIBWE9ePc/or1HaoK+HfgbWHGlsIxTD/patX4USJ1o1ltkz9iPBsy4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQnS0G0b; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so7846602137.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767245776; x=1767850576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTgqKg/NyZLs05GYEiIMrHKONV7wwa4BNTXrO2B8hPs=;
        b=PQnS0G0bkc6ODdsVioKeWGt61MBk/nvH3wVNmeGBetR97XxQJvIDdFjzN2gV8Huaq4
         WyaAbg3oX6PSy1UBAYAz7e22LK3O6ybr+igWuQsML463S+gzFQouEfyORleeRrAHvWbi
         wTRp6hYOCHKk1My6VUVA6b6V9hXUmsm1iurTWZe7V+rKTkLibemQTm7oHLNIp3/dKMpQ
         EwhdFGVCE8eogDbIqiGf0L4zv8+vhzIyke+9d5+FgmctttUIP9v7unUwd2uURsKHG3RI
         gh1hTVTk11Q43Iuv4kku6tWlfkyr+ivanJ2cTZqEdCIbtsLtQo2kesV64q7QexPTb8T1
         FN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767245776; x=1767850576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTgqKg/NyZLs05GYEiIMrHKONV7wwa4BNTXrO2B8hPs=;
        b=Eusdc6oTZltN9hi7vxmIOhBS+uN3BbTM4d8BNm6QT8NdiRognfm03KYI3SMgAeU9/u
         SQk49NE5iMiYzFww0kTnxWafHeHD36ILAaAqS4IDLfvSBwNbckty25oloJBa9yiMF4wS
         4bjJZFlGn/u8hnAXP8Yx+v4+O2y+/10X0xsWcevlInw37CaIsQXvaTK2vLAzm06fkdOh
         Ua/dNxMYECMkda7LdFcsrR9/AP6rOL0tLUFGs6HYsJQRauWCy4eWhs99AuUnyvNzamiN
         mDkOt9WZf5pRURH4hsWT90TKHrKOAsK3/+YFM1sKZ4gdUg5nre91NcqmfTVEzcG1e57w
         IQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLtdEvzO8QgfIRvqZnJI9qkOU7UzPSye3Dutj4BzakIY2OrHhbs5tDN9vJZNY7Ajee2wMRTPO27Icy@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGnPG/PxU4FTp9tAkU2AfA3j1PbNqwr+OdplwE/wiXHbSKwQA
	FRUu/C/O1KDcelN87ffoZbn1NhjzeIzgHYiAyHQnKlZBO+u6AzBSLJW0ASpBUQ==
X-Gm-Gg: AY/fxX7B1mwVD4i1i8GBf+MVB3sk1SE8ybiMKwOwLvrZURznpntxsn8w7uQUxTdbHuk
	pPu73o/9uhcQh50MHiHyH18UQep1FQ/SZXz9fQKnQdhZ1BhERS/UZJHUKz2P+y2ae7a1yCKUZxr
	Xrzq1hMAKH43LOy65CgVwLv6JgaxH3y4Bbkza2sHChBMmnGhF3L8CWf/feHQHqBye7Hw7saHLbq
	FjzqOLGCGCpsQvUGNmQGs7gdd/ROB3hONXFGtGMhxDVibrSPOfdUyaL8j5VEcNaVqsKcWo3+8Po
	N5BsyqF2U73R6lomYd8GqsrtDAdUPrqB7CEyLkt3DtakV+lyFwHKTe0PFFMl0JRLUn1PIiVsktx
	B1YADTdz6+bm69iS8aNjPoiHri3SR1qnOgZX34QdQZAjKxH+qlxNWkZbB+hY/WW4vOpJPFoFjR1
	r64PmnAzJYxofKsw803g9RuTjd6jofCQSV5y5rZn49LKLl0XPVsCFLJiDmo5iat2q5YKGpYDG4
X-Google-Smtp-Source: AGHT+IEZZpaRTAmD7INNOuGELczB4YgTQeCBkJGfEePqpcBDjYe/OyBFzHcCZC3d+qr9KR+GYjqSJg==
X-Received: by 2002:a17:903:2ec4:b0:2a0:8e35:969d with SMTP id d9443c01a7336-2a2f27373bbmr345376845ad.39.1767239435700;
        Wed, 31 Dec 2025 19:50:35 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm341874445ad.34.2025.12.31.19.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 19:50:35 -0800 (PST)
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
Subject: [PATCH v2 2/2] rust: sync: atomic: Add atomic bool tests
Date: Thu,  1 Jan 2026 12:49:22 +0900
Message-ID: <20260101034922.2020334-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
References: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add tests for Atomic<bool> operations.

Atomic<bool> does not fit into the existing u8/16/32/64 tests so
introduce a dedicated tests for it.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/sync/atomic/predefine.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 3fc99174b086..42067c6a266c 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -199,4 +199,20 @@ fn atomic_arithmetic_tests() {
             assert_eq!(v + 25, x.load(Relaxed));
         });
     }
+
+    #[test]
+    fn atomic_bool_tests() {
+        let x = Atomic::new(false);
+
+        assert_eq!(false, x.load(Relaxed));
+        x.store(true, Relaxed);
+        assert_eq!(true, x.load(Relaxed));
+
+        assert_eq!(true, x.xchg(false, Relaxed));
+        assert_eq!(false, x.load(Relaxed));
+
+        assert_eq!(Err(false), x.cmpxchg(true, true, Relaxed));
+        assert_eq!(false, x.load(Relaxed));
+        assert_eq!(Ok(false), x.cmpxchg(false, true, Full));
+    }
 }
-- 
2.43.0


