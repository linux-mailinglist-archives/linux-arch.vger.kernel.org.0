Return-Path: <linux-arch+bounces-15537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F47CD83F0
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 07:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53AE301462B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AB2D12EB;
	Tue, 23 Dec 2025 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESdJ31ml"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0A2D3A60
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470949; cv=none; b=N6tZZjQECMZPnxphrZfs2/AYJVXmDhZXO6+mOPfScI4xJz/lGvVeuq15+aUHFK0KdJxC50dw+0pqt07YIBhHKrIZ/RzweBZTavDy0kGAb6GhuYUPHRMHwsaGBsWP/ytcUcLimQ9NGpgzcSoht9h6fuopb+sCS+NHxenkDHVtbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470949; c=relaxed/simple;
	bh=CAzqIn1NxWbBnmsyzqSrr/LhlLLbLy8JxidNUttic+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHh/vYuaRCLnOFgt9d8/Z9NIuYO125gbWXxSFR4lhGSlwkEreEkAwFZEPnj050XvAJ9n1TEuIhMQ1J3RqQcTtV4whXZeJh58aVo3MNXap12QDsB8gojScEyZOqOaWpyOtqyGs0iSAVMVOJ+Ayf0OxfAzn5YJUFH8LBPx/mVabQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESdJ31ml; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so4221173b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 22:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766470947; x=1767075747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwIMmpL7HRi3JDgDXRqtgrbht8A5w6aG4m2Qtk/qxLc=;
        b=ESdJ31mlXxakeopw5PLJVswl8qxENHJJ/owvnF7qc0HMHp5IcW+nOEmaCYY13V/yJF
         0UwyI5vXFs87zinwo8LrWL0ZSTbHBIbHYkb3/e8Zv9ViIMP+loQZQmfHSKZNm0qFFGbI
         cFVhVFJVm8G/iAgb2p7/Wwo8Wxtfmb5Muk8QhehZ3NjDAciL90uyucTMFV/0HOzvohPq
         5W7pYrfaerub7/Wmw5w/vTXUdN40EJbQWoTeL8n3NnhnbAW7ZRbmXxIGBZ1JSxTAVm9x
         H/sYlh/X9agxIpYZXovKuk6zsjVt2kGlvwXSMsnZQzpHhajM3UtuvkNvUbu+q4kOmD+O
         Vfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470947; x=1767075747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwIMmpL7HRi3JDgDXRqtgrbht8A5w6aG4m2Qtk/qxLc=;
        b=N424LeuwL6utEHu4TFrOVVFQsM3OMbAWC5GK189afblsMyN+c8tDkVl0mnJREqrHNZ
         Gt9GmDTIsp/ej8Y2n7D3NOq1nSCDb757/dDC0rNf3/kLKx3gXvxU4Loi+mpoVlBRylIH
         KbuWvmldSVmWYQGEK4ZvfsUO7DFYdELFcRCm8Yp/5DBRLUht9CnDOT2fM0GOzW1uy7Tz
         zIbZtxSYGcmhHCxLgrRCJu52GL1UwfIJ/n3lwbCP7KLdDUEsImX7m/QHqrdKbDoMVNei
         2Bhkafpri+DJ7UAVG8eoicKQqdHiqCdNbDGEjKAN7DQR4x8o7gc/1xQ4wIzE/+1G2uuR
         N+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUF/rYT9Tt6hkLuJuoUp40zx+e34nE0HA1VPm6WsO83ih9AioCMSiapjYg7aa0tNnvo+ldkmxIytZfu@vger.kernel.org
X-Gm-Message-State: AOJu0YysM2m93XKGlktIqe7QfhmmE5IS/I0d3rujHUHCj3QdnZ5FNHmt
	62GUUCiTc5mowT+ZACzHHIrNo7A6TrO3ipfkDf64hbMfSCLaocMe6DXj
X-Gm-Gg: AY/fxX4qpG1gjHoVzOPylYA99SkiZ5txIxXlwCYSzaCbVKDEHF4qyOvOIrYC/elF8Qn
	MdJ6Vpv3maQPuXrKVz1sGZ3xNLVnAAUq66mBW4Fr7tx4vXmvME/lhIVhgbZwsWDozxoYp3kqOtv
	P9Tm7EUrzXLNV8/1hyVbfPx36wzTQNzNaNfW3wQhfKwDKyPQg7IL78RVd1Eg59E6AzcQcwV4lHk
	k+zUTunS8bP4XTru0NIMnApG6965x/neJdKbHYadtGyU7svr5D8WqfhCWolBrxCeuSbRermKAQB
	eR7I23S29Vr0E7PdTFhuMppsSow9kS7YHWdyX4BBo9GVgeiWA0zYWVCTtqrAIri4GmgRV646g8b
	PKL3vLTpPUTQ8/upOLsZSXBIXO5a0k5vrY6zEfpjl0Of4rboHpTbZYksrdtEXcmlyPzH8gs8uu0
	ZbN2JTzwcm1dSeEAqCgDhiOWsx46hX27/CxDreMAux91VD+8tdetBhN1tyxoeJuw==
X-Google-Smtp-Source: AGHT+IHPU+0SQ+q0XOYb/8CVg8fHZEnjX9/sJMBQ6gXaryp0fDKm7joEP0BYIYZXLRSjCH3RsQpDeg==
X-Received: by 2002:a05:6a21:99a7:b0:2cd:a43f:78fb with SMTP id adf61e73a8af0-376aa1efc33mr13239340637.48.1766470946893;
        Mon, 22 Dec 2025 22:22:26 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm12395362b3a.35.2025.12.22.22.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:22:26 -0800 (PST)
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
Subject: [PATCH v2 4/4] rust: helpers: Add i8/i16 atomic xchg_relaxed helpers
Date: Tue, 23 Dec 2025 15:21:40 +0900
Message-ID: <20251223062140.938325-5-fujita.tomonori@gmail.com>
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

Add i8/i16 atomic xchg_relaxed helpers that call raw_xchg_relaxed()
macro implementing atomic xchg_relaxed using architecture-specific
instructions.

x86_64 and loongarch use full-ordering xchg.

arm64, riscv, and arm v7 implement relaxed-ordering xchg.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index a48bb632dc44..089f31bc8de8 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -80,3 +80,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_release(s16 *ptr, s16 new)
 {
 	return raw_xchg_release(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_relaxed(s8 *ptr, s8 new)
+{
+	return raw_xchg_relaxed(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
+{
+	return raw_xchg_relaxed(ptr, new);
+}
-- 
2.43.0


