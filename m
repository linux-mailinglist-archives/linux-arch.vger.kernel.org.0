Return-Path: <linux-arch+bounces-15535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C20CD83EA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 07:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC1C301637F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12B3002B3;
	Tue, 23 Dec 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Ou3jbl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6732D46B6
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470943; cv=none; b=mRiBlJWVBtOaaS/U+5vMPHDwRVhGQ4St4T8xdHdAIYR8QjDuMA9E0kUqGmWbiOWk4jwPNywWD6HX2ESL3JWk4XCgw6+IIAgm26oZeHsPm+bQpu87iUE6RxCw+6XJ6g2n+yAzWy/Crf1TfDUPHXBhZqBKq/sAbwMaAH/PHZoRPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470943; c=relaxed/simple;
	bh=DOVkPJG3lvTG1P1/w1DxTKFAXHDLe2qBnB3vVI1BMHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tF20OXM3v05sP9rp+iLurLKC3ddk0ce0MgleXiiCd0oVKmz338CS4Udoqqng/zrH4s/iF4QzcGA08Crq3/FKG/K2NvT02gLVzwUL+tGjZ80IdPoK0PcgNZ8tdNJ07F0eb6VWPSYt2DR7eSP3gHSCXXcy/vf6LPJDgeEcr084V60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Ou3jbl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3899190b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766470941; x=1767075741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3T+YNpQoIpsOk5YdZgWkJdrxHL3UXeLUpUXbUijkBM=;
        b=E3Ou3jblsD1RaMb+GiNIY2EY33gggn4B77VNroWkyN6ewgv33zjPdr6MDMvxATVv3j
         +kifwO4H7AQNc8fqw3T6XNhkhod1NWaDF7mH5TwvyQncJFStl5vpP/B5Hna/KlpSKo6H
         PkeDYsnfkfQw3SyyuZCkdobpWy412mY9YDxYONhKcB/rSQ8oIqZjteGOQXxWeATbpXjH
         LZwy9qKvPUveLJMD6SfpUyQUngNMF4RlE65c9b/VquEtpAhylfKMf03ocFodTP4boSvt
         OzrGA0BjaOsHWz/qVlRaJOB7PndUktEULtLT7NtaWr7M14dHErTmCrWTCSiYQ7+xv614
         T2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470941; x=1767075741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3T+YNpQoIpsOk5YdZgWkJdrxHL3UXeLUpUXbUijkBM=;
        b=bjoAFLPxZ6WWGbRZgIQ3h2JZzF7oLF3oUrVIGriLN7WO6a/gzPrdeFBZjBBZk0Fri5
         H0ss2XHXstjNyyufkIPw0jbUYtL5DGL1eEJrfnKFrmye37WJ3rGMOq+//N/qDLQn6p/+
         IKwC1YbiTqnTgXviHRReeZxw2uHJsaYTaFwyPgWVNSOx+EwT+lnLoy0HYLMa/M7bCdha
         6dJDa649M+G/OpY5SN1OivG2FpxJRMxohTd/aaz+EejcQH2oFacr6MQYbyFDY8ihDBMo
         VLjV3yycVSFj4Z5MlHqrBHpVhy991YB+EEwHA6OkM1Xr1DWwyMoM3cbv90sd9ZIUE6og
         MvzA==
X-Forwarded-Encrypted: i=1; AJvYcCV/7mAMmgCbaWBTmHKeXt8vDtULbsRrP0LXvdfZUMcUkYgCAF452T+99VN26H0krF9wHYWRXv5fURT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3/1SDwrb41eDerfHGxZ+pDNz03nEn2xD0HlItsX8jX/VPBL6
	QkrdRGuqJz4NsrSgDzEH4q807HqsEXwHy48azath82rtpk85NfvaKsWB
X-Gm-Gg: AY/fxX7icbGkk9c/T+/g5KnD7SRPtprt+cVGETmxRWxWjnLYSnyvGE+SmKryHtl9jRE
	sn9OlixNMteNz+1lcCbXafJKEL4RFOBpp+Lh3Vbnx13OY5MSzCxVEuNL4ZBd5OvRVpxYsjMz1L6
	Ew/LnFqq4CGUzJheXZaiWn6MO8r1QgX6PiviRhPmRzWf9ZnL9SuAyls/i5rpVI7IPz0Ws2OIzBB
	PmLIblA9fcyISjMez6d9HrwKhZAMRY3cD3F3kZpz2X9xWjcJMHfDC+7Dgff1kG7IUVDsVS/FeTJ
	C/ea0FZKOfFLovf58FExZnTz2jM4TfQ5beGBfy0lZSCp/jRajktDTFx54QZBo8k4SvBTd0fdhAS
	Q41iRVtVDin0EE6eBV6m12abr0HdAHfBaAV94BNo/NechCO4qWlSLyc/672L+/CdET81tjq1u+a
	8jkDxKCHWGmEGdi8u0NFnAULy8xigDHpXgbT7jDCBl9mUAE1A+iWfBfzMozCKlbQ==
X-Google-Smtp-Source: AGHT+IE+AnsHPGT2gHmseMSQVjaFwvryWLOJ6QpIC1PfRgT/9tJ+p+HB7RP5errRD/T1gUNACNSGQA==
X-Received: by 2002:a05:6a00:e11:b0:7ac:9d93:3efa with SMTP id d2e1a72fcca58-7ff6420d8b0mr10972124b3a.7.1766470940944;
        Mon, 22 Dec 2025 22:22:20 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm12395362b3a.35.2025.12.22.22.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:22:20 -0800 (PST)
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
Subject: [PATCH v2 2/4] rust: helpers: Add i8/i16 atomic xchg_acquire helpers
Date: Tue, 23 Dec 2025 15:21:38 +0900
Message-ID: <20251223062140.938325-3-fujita.tomonori@gmail.com>
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

Add i8/i16 atomic xchg_acquire helpers that call raw_xchg_acquire()
macro implementing atomic xchg_acquire using architecture-specific
instructions.

x86_64 and loongarch use full-ordering xchg.

arm64 and riscv implement acquire-ordering xchg.

arm v7 only supports relaxed-ordering xchg; __atomic_op_acquire() macro
is used to add barriers after the relaxed xchg.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index b1ce7c038ac4..538e0b10a15b 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -60,3 +60,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg(s16 *ptr, s16 new)
 {
 	return raw_xchg(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_acquire(s8 *ptr, s8 new)
+{
+	return raw_xchg_acquire(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_acquire(s16 *ptr, s16 new)
+{
+	return raw_xchg_acquire(ptr, new);
+}
-- 
2.43.0


