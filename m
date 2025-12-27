Return-Path: <linux-arch+bounces-15561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 781BFCDF978
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4597A3016DC7
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E031327F;
	Sat, 27 Dec 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctOWTegx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF30313E22
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766836841; cv=none; b=aSmhyRj4PPES0dLEsF4xFXXRrOIw0z0txxn+BW/DVShBYjoQqB6uMVtSQn81OJV1uFcG/Cewb/4jqd3W0KjLW697PKBfI70gKRkWembqBKLA+Tn/JgP+VygGA+Vl/C86IeN4QPtBxshKVSJDrurjE82XbQTkH7sPcgEHYISvPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766836841; c=relaxed/simple;
	bh=2+gojjXC5489gStc9Vf4UCwASb7aFcNsuLLVuV8mSCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng9K6KJ4TLlPerY2iNW+XifJxYsnG3g+rRHVUiO8jT0wDxt0nENGSuGcV2pEYigksRlBMVf9731vsuzJ/d9wYcwNO1TDrU5DQGcZK40hOL9//XNRAUyNro6cT5wJiO6w+6ZuZIrSX3gDxtMyDZeTTFGVqLVeJ/GLgYsTV2BDOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctOWTegx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29efd139227so104242485ad.1
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766836837; x=1767441637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+LlPF9KPxuFFiQuNb5zRw123ChrQq6zb7ixGx9xwBI=;
        b=ctOWTegx1w5/D489MWuC4c9YtfJTtyffyRqCzAqSArSwVj3qiHeoivtyXWhHlSfmuY
         oHcLrxmPlH0ipnX4EaljIF6eD+kDk8cO0Ve8ptGkl8Bho6SO8DgAW3QfadKihASwW5SX
         T2RUCvrXZCC25xz9c1rus4m1oFz2AV3ng1h6JqaaVwkB1If9uV0EDbwHM5xPAgiN7dc9
         3gHRfQvFWxuhUZ/5FnWc3rQUZW/8cTazETaP0NlUwxn4FPZ1b8HnI4hnyymop7oBY2p5
         mJgLk1VGqXro0wvyHm7adTRvLwPVPyEsybnkN580PbjVObXMEJXD4teBUBEKT+kd9YQo
         W6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766836837; x=1767441637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+LlPF9KPxuFFiQuNb5zRw123ChrQq6zb7ixGx9xwBI=;
        b=NYWE/lXFWp9bE0emdquDDoHmTPIXujpLNPU7iPEwxEOKURdck8d6b0qul95YxrdszF
         Yt23wd0Qf8iT8hxlEWG3opLvDeZIJcnCVk8fz5Pxx8Mjra/UJXEXyECrZEA8kPFPtRZA
         e+DQ/ZWsgrIfikh+1BaT0Js/wFbc1Kd0upHe4OAJ9P3wXND1VAtyLmMm7tDVNNXNOrZ3
         LEpHHcXib5Hpt2K2TOkj96zK1r216xVNnkbH54Sdg22Zz92hyQsJsWb10xiOw1yQl/UB
         drEI8H6BsXveP+R2T5k10hyRFonZQaRO7OaEAbVfZW3Kqj1BIFKsuDTXULp4FLQfsp1w
         vmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpUkfoTn3kB3SU+eZUauPJFHCwTaldUUIDmdGSRjKqY5PH/IlFtqthILDTUlrKayzttyyFu8a+fg9F@vger.kernel.org
X-Gm-Message-State: AOJu0YyefSNK3GJOl30ieehyif//F41qi5UGTeBC+IbPnUbkAeyS2bLU
	Cq1x817AMdMpZaZauDrRcc6TaLvABusTMCffywlH1R/ZOESAWpGpbXPJ
X-Gm-Gg: AY/fxX7NAjksM81hsM4f/lcgbpXSBPq35sIEACtjmALVlfnaGKw4wLRp01ymijAhiMo
	DfDhEz3SbQvHv/en9VbAQo0AD50X65DPIbAN8p1XdK1yb3Bncz3GNw7wYAO4FHUi+p7swlq6+zI
	y4FWCHTP508d9qw6rua4FD80CaAKscBodkJhc4lqmbPzJ86vtLcuEVkQZY0oHBKAZHv1FR5XzYt
	H3ClwN6VCZ5HEYTzZW4D4rJPL20wsOugEt6NjIOFlq6gNrOFrGvbIz7ql2SRWph6XrvicUXVZK1
	TDbCusm7bGYIj0XgRhj5EhbKklHVM00Cr1P77HS01sqrdzXEbP37xa0k0T8wLnd1OWDCbXNpnFW
	7cd5zGV6JgSrtoeYvVpB1Oq6/n5HVsRSAtwCP3FQzLKMqF7eYTj7gtYxuzn+7aQJNcDriTYTdzD
	v6EOzg/V0Cl+pWWHz0OdtK5/iUzuJqkPo1NK1Bp2pZXajpCQfvZGJUojqrvAG5dA==
X-Google-Smtp-Source: AGHT+IGg4GXny48XkuPAKbQUa4NfxQCd6QV2NeuR0YiaRH+Y9p9r1rs466sAvQQY/Rn4POhBOpPbKQ==
X-Received: by 2002:a17:903:249:b0:2a1:4293:beb9 with SMTP id d9443c01a7336-2a2f293e220mr190872155ad.58.1766836837525;
        Sat, 27 Dec 2025 04:00:37 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm231033165ad.50.2025.12.27.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:00:37 -0800 (PST)
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
Subject: [PATCH v1 4/4] rust: helpers: Add i8/i16 atomic try_cmpxchg_relaxed helpers
Date: Sat, 27 Dec 2025 20:59:51 +0900
Message-ID: <20251227115951.1424458-5-fujita.tomonori@gmail.com>
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

Add i8/i16 atomic try_cmpxchg_relaxed helpers that call
raw_try_cmpxchg_relaxed() macro implementing atomic
try_cmpxchg_relaxed using architecture-specific instructions.

x86_64 uses full-ordering try_cmpxchg().

On other architectures, try_cmpxchg_relaxed() isn't implemented; so
calling try_cmpxchg_relaxed() ends up using cmpxchg_relaxed()
implementation.

arm64, riscv, and arm v7 implement relaxed-ordering cmpxchg.

loongarch uses full-ordering cmpxchg().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 589c070f589b..3a5ef6bb2776 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -120,3 +120,13 @@ __rust_helper bool rust_helper_atomic_i16_try_cmpxchg_release(s16 *ptr, s16 *old
 {
 	return raw_try_cmpxchg_release(ptr, old, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_relaxed(s8 *ptr, s8 *old, s8 new)
+{
+	return raw_try_cmpxchg_relaxed(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_relaxed(s16 *ptr, s16 *old, s16 new)
+{
+	return raw_try_cmpxchg_relaxed(ptr, old, new);
+}
-- 
2.43.0


