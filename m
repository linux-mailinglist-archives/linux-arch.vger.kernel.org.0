Return-Path: <linux-arch+bounces-15558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1187CDF972
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 13:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEEA230010E4
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B1A291864;
	Sat, 27 Dec 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDVdfMrT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3D1A073F
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766836831; cv=none; b=oBZE7AGGgD1Q/pzIe899TPyJUP3/KP5dpfSdYfldLPlLNa4GQZI4DHw57Lkx+Um8Ibd6+QFABEoO4P5TsUuXOqQdeG9NB2321NP9MhSESLmYIOqGlTa+dfNCHFmjmC2Wd4mb8h+R7fhB07x63IqHYwkw9zMseipd5tl5RBbJqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766836831; c=relaxed/simple;
	bh=AFWGLbkRWJTV3azRGHJBzfft5t4VYcRGpJrctz2a3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRDyNg214nZ313aUb7RCeiKR10cEwmswRxmQTuPru5+H1XayNMvGDqQ/ygpbXCdBU0USWqBjocyD6am7dYI1Oz3XIl2cucS8xdEThqMzpb9g39sFVrWyeOLveVChfdtZZK/bh9L1HFfDZLjGMxocSSaddDcKDTTeEVSCve9y9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDVdfMrT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0c09bb78cso57493395ad.0
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766836829; x=1767441629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw6SY9UStiOcgMEQgkV7a5z9GXrjOJJZqWGx3Libi+o=;
        b=QDVdfMrTnpfz9UVO66oTQesaV/KAcDnr/p7vxAiZbqDt+JO5xyV8Ah+NCEq/MnnoSK
         +j2VWI4RkLwj5QakSZY6iCpCvnC2IgRoxPJ675X6vkVD1+NOWHXTI/7BKjvAMg0tETVj
         Mn36t8Y8R+HKt1Ec25GphnL+ZwdSNLB7cIGzl167Jg5mIfjmYi8ps1BFIcMu+786qWdE
         opwaGMGk15MO9N9oo1FLocoCiW7cgqZfNC6N4yaSLl0C2U/CFXoREcrTTuE9YcPtUJga
         N8jufh8uGuA5Bb32GJLwgpWi48pjCzIjk4ThQAAcpEVulWDlXa/G3fG1AOPRtGF4C+bl
         NPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766836829; x=1767441629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vw6SY9UStiOcgMEQgkV7a5z9GXrjOJJZqWGx3Libi+o=;
        b=PANsI7wkhFI0ghK8TnRv0KHjJoS6Ug/t+LNqB+/205f10Dw+8PqBgzKwuhnXCrkSiU
         6Ze3CKfmaGDzJOS5YYynyIYQeSzyPBxFo9eNWDFAINLApyLWkD9KDg8ANqnBVZhELLtt
         JxQ6CcffJub7u7/Mvx1MHYsQrPVWtxS4mWlvFnM6Y9THWSkpCUJIcNa2gp/lU/knjzAm
         N42usmAeFZWH0NuB4pwsyZOcSepH1ntfxQoOctS0oYqAY4H8w3iBDgbLO3O0K1NrEKbw
         vldh9luAI1I2yv+qFVcP8XOAJBRNYQPT/Z42mHXjEWV814ITmx8qBVSvuNpgBYYiyfiz
         utiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYcW90BEBm8w8I9mCDZg8DrUL8WnRfmjyHRyISM5Jemzoa9+3savQZ7EsPiDfb2H6oRWAtb91F32kY@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2FwGqrF+Vk1NYym9QjIrYcnEDt9qworoJHJhhjGLLIjfA6E4
	GxokNIZ5K7OyXKngiIegrgdbqTQ0atByce7itz1eJolBh4MhMz5z/QGg
X-Gm-Gg: AY/fxX74ZttmKgQZwzHSe0GWDzJyoVmrhBL3I1BtlHWp2J1uGGmz5XKgEPTdfr4JsFy
	RAnDx0ToxCeyc/1WAE1PI2XUeUFCKQxWVJNs+hr5h7CJ9aYJQyG/XknFAMvW2zcDui2TbMDTU1K
	LbIwbSftSan/0XZiXRx0ouG8cm2sb50mtrnFnXrltANkUSQayTr7yrl39z2WpV5O4JK3AXkrIXk
	EE4rfxnoPTGSYDU1Q97GLWqmW8XR/HaqSrIhThPH8ZM2ig9rSsF30aN+WtbQFBVn0hiaA8FEv/U
	NLIchGj/bK7uI4sA+Xas1zasHf/SziSYtpYH1id5eEgveha5QyivEmkpE7AP4LBPCfqiGfYnIUy
	17VjIIo1A1xPil4AWAESMihC0M+K9uQ3RFE003GmQjFHIBljFbsqGXb8kSdt2vxlUWnzf/zd29t
	CIWruAd7h/t8SrUHBu6WSKVC9zHD34GBfe4+gZFxzvOGan/t7Oy+Lt2RH4XrZvqJRbnYrpGe/q
X-Google-Smtp-Source: AGHT+IET3e/1gpTZXe2/wzXT9fMbbdgZ0Aaw4yoLIf24Lza1zTnz6HFsZfyl5jtmfvWULJUEe0mNFA==
X-Received: by 2002:a17:902:f70d:b0:2a0:fb1c:144e with SMTP id d9443c01a7336-2a2caab67afmr304760695ad.7.1766836828577;
        Sat, 27 Dec 2025 04:00:28 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm231033165ad.50.2025.12.27.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:00:28 -0800 (PST)
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
Subject: [PATCH v1 1/4] rust: helpers: Add i8/i16 atomic try_cmpxchg helpers
Date: Sat, 27 Dec 2025 20:59:48 +0900
Message-ID: <20251227115951.1424458-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
References: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add i8/i16 atomic try_cmpxchg helpers that call raw_try_cmpxchg()
macro implementing atomic try_cmpxchg using architecture-specific
instructions.

x86_64 implements try_cmpxchg() with full ordering.

On other architectures, try_cmpxchg() isn't implemented; so calling
try_cmpxchg() ends up using cmpxchg() implementation.

loongarch, arm64, and riscv implement cmpxchg with full ordering.

arm v7 only supports relaxed-ordering cmpxchg; __atomic_op_fence()
macro is used to add barriers before and after the relaxed cmpxchg.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 089f31bc8de8..9d62f659c8d2 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -90,3 +90,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_relaxed(s16 *ptr, s16 new)
 {
 	return raw_xchg_relaxed(ptr, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 new)
+{
+	return raw_try_cmpxchg(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s16 new)
+{
+	return raw_try_cmpxchg(ptr, old, new);
+}
-- 
2.43.0


