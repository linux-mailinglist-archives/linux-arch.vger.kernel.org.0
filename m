Return-Path: <linux-arch+bounces-15607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D932FCE8B0F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 05:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 001463002045
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940762D73A9;
	Tue, 30 Dec 2025 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgv6dLCe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE826CE1E
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070243; cv=none; b=sruoGUwgyWuCvHBoQLhQqKr58OTWEVpRsMCvIjgj84CwyUJgRoSJ9iQBWNY4j/Il405qIjnxrl4mqrUIESlCNA7z+PFgVKxrqn8QCXAyRSOqd7DcCGlypsfVXW6CiysDCqqZ+gvsftLcGnrhfcwTke5R7TWt0uz69g1xB1MZMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070243; c=relaxed/simple;
	bh=Hp8DN7D/yTHZZuYL6cvL6rGmqaVhTJhqpDL41o8WHio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmyjNRAxz0JDYGJ8rv+6mgKMGnyVaPLzv5S85nxHOmi06bB4ElFy23/jQ5r5eGRlbYmvoITdGqxvRd0wdgIQHGhCJeAQgXgSslbLmTB4DdhdjPuXicYTMe5GTR4OAsPdMSvIiLXdIj0TNFEkNidTxXsiDOiQnurciSuqvntUW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgv6dLCe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7fc0c1d45a4so8558490b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 20:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767070241; x=1767675041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTgqKg/NyZLs05GYEiIMrHKONV7wwa4BNTXrO2B8hPs=;
        b=Fgv6dLCeQO++tv5hKfxJWXgPc5IgcFLT3FNEsRSIcU/zgTvdhiq6UeC36mz2eiSj4u
         zTmnw7zubC9R2YCyc33IHN2RRpEeOpF9smbEpV84VY6bao4HyoUIuJb4LLchx9ynHsFb
         HUIYltWR8Bv5+7RgnUdVK7c6yqVO3a8KPhvBJFyd0owW9CktB/aaPRdcLmIt7gyjrGRG
         AMWtEICiKGED+Gjy7v4uw6/NVv385Wo6Mwlv+PqmPlMrKXDIr4zUDGWFsJ6QPDk3wNzK
         8ftJSvjPFtrvgVJBqYxDOtCN1LJ6hFQgGfMtIXUxzDvGUXDmMhTyWPoFVwfSY/RRnKBq
         qykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767070241; x=1767675041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTgqKg/NyZLs05GYEiIMrHKONV7wwa4BNTXrO2B8hPs=;
        b=If+iYbmPWyQ6XP/7ou3JXTdtwDCy/OvNcqeOYUMmtnoVuOzWz4JL4b6Mtwvi5accE7
         /6ZNbEfoOR2q2n40+SYdZwzqyiZoeMVBLL9CLMYuN+Tn1Eic2komR7DDmttfJYd7ycxd
         z+Pj4nUJXfMhZwjSu39oCozjg8KMjJ3esTvOahn/yxWzQXvuq4c5XYQ0GU9tLMkS3rwX
         Up+9sUp9SENWeHvBOnHOGKJ82nG84EiYzQ3Itt7ZXYzadXk1T5XRJb5L8+C0cCX0zOct
         FV1iZRS/YtOE3JsMtp9xr0UEOB0oJPvZG9bX8A2zRdfG0R7W2ERo4BfFAAwg6Ks0EpaV
         t76g==
X-Forwarded-Encrypted: i=1; AJvYcCXD23qga6DuPPzpr6yPAGmTZoTp2Pa41F8Fui7K3ML9PUn6cn/WOI6d2I3Gtv0f6QtL9N+NCwKEBUjt@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBEum2urkTVSn2PZHyOy6/2hzqdRaNPwFovAIaKxlPJYpzxZV
	mkMSHlzuGmOl83jVFohin5LvO6it4nIrMup/tD1RZ1kumD7+uRV1jQLk
X-Gm-Gg: AY/fxX51CaA/N+mjZRrxYr6ju3+WO+BJw4VYpj+RRINE9q1y7upITPkU2fxWohijsyG
	u8QHmyU7rmO5wKI0x7naKHBPuRhjVT9f959aKhJaq8aq1ayV97Xv70nrqu9oV2bygaUjuSWXj+B
	fDi55yLDT0sYmHLozQ0gtm1B6tBvOfNZLAaDwxvZTKZFUhJo1f7FZGZ+UOGgFr2rR2rLuZHFGPJ
	zcbQ2sq6R80e39I2g08ix987EYHTC4A9DzYXouhgYmSlWSK9ZjzYrHZr3lMnM+0Um8Rwa5IhBrR
	Hn/9jneh3sQIie8vUxDy/cUa7cmR3FdpgbAJlyBAa2mGzFfUuqwI5zHTD9EeR3QeVRnYecsLIYH
	+qRSRizPkQDe1ApZ4+4G/f8gtGS6k+swzC0/gkU+uUNV2N/XtlKewGwT1a284h8ZuKykqxEttuW
	v0iI8ljLZburGMSWPxed5owyNE7Ji0kaxPXsrVBE7l7afIOXTYctvU7vob/E9CAQ==
X-Google-Smtp-Source: AGHT+IFp/furovjQLO4bXBkp4xN3goFxeJ8eFSrn0cqg2OMY1aa1X8jUq7WSnLEQmATL6Ib38PpzvA==
X-Received: by 2002:a05:6a00:140f:b0:807:c2b9:38ec with SMTP id d2e1a72fcca58-807c2b93f63mr13436515b3a.15.1767070241311;
        Mon, 29 Dec 2025 20:50:41 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm31100194b3a.11.2025.12.29.20.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 20:50:40 -0800 (PST)
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
Subject: [PATCH v1 2/2] rust: sync: atomic: Add atomic bool tests
Date: Tue, 30 Dec 2025 13:50:28 +0900
Message-ID: <20251230045028.1773445-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
References: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
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


