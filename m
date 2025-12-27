Return-Path: <linux-arch+bounces-15560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C02CDF975
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 13:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62B0E3000DEF
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED231328F;
	Sat, 27 Dec 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw4IwGKM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD31E0DFE
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766836836; cv=none; b=ViRp73/UNDzXecUxU8IgiTYYVj7YkafyMUW+9cAGMpDJxa1kyIBhukW03lwCazObeTigCbdAZdv6YrQ4F626Bpmv0WHzOMu7e/lYq1YvRfs5ImcPC5/SPwyF5mPmvBQLlI/Ql7Y2ru2/2NjJgAanNjCqgCx8u1KAETQKepWTd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766836836; c=relaxed/simple;
	bh=Pm6POzEQ75BlVylbif0HEf7s27urrkneJ5sq4z2K3gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAasoNDw8cnq6PZVEc7Wku7AuvmrHpdnjqG9tQgOZIPzv48pu7bB+Y6j9SGKpZVJvCZQImbzkTQJhKgCrlHc/fLZbQZv+fVDv4Ugb9Din+PrcvdYxqW9Y0IVGzFWBryXbBadORkC3Jz1JJWeQowgo4HE+TdaaqkLwrBKo5hXMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw4IwGKM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0a95200e8so69542925ad.0
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766836835; x=1767441635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it2hF68oCwswMjVaQp64DMJGQxchhxVsTvSR1+FnkUw=;
        b=Gw4IwGKMYqAeX+As3E6Xuu2gN1PhZRoGBuCfcdmGii8M4vHR58PyiDe3Mu2tfodiO4
         gVb1JJOAqhNCt898QbsukVUIh6fm0fPQndTx/PHh8eTdlEVvIzRAT14EXpmeebvEK67w
         hPxKa9A8aUFT/lAOhgNlH7vqeEQ9i61HFotu9Y5R1uNRCutm/if2XdIbHHczpRurYIpf
         vky12fLIqFvWperDf2wHNetQoohHvIVbcsSekhUaEaPFw+7p0F1XnZHEwtwvRG56Imoa
         M+l45yuH2vwrkCdbY1cJ0gbMeA4yqq7VFreNZ3mW5IRBwjYYsdEl+5YEBOwkL8kyqNpV
         ogPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766836835; x=1767441635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it2hF68oCwswMjVaQp64DMJGQxchhxVsTvSR1+FnkUw=;
        b=f+g5T1H6FcxzDj5mpteh/VGGvONgfQbtB7W4URvz+QTs145dxrNBEXfOyeA5KtjBcB
         7ew4m6fmq9IXUnIRBF9/flt+YH+PZhVIQSVQjJLRrKumUMP2UQiAVMdH6brKl4N0fmQa
         wSQ+vJ/cpWLDli3+g3nazDcVKHkDMxjjQ6g8VD0e7OLuMr9kwJJBseEj0NjrcD+zXsjS
         J7Lv1JfFXav/TJdiA3D9mcrh2nJgXws3iJaRcQw5MkY7DGfAAp+bwQIq19Gei9ZN+nQP
         TuhhJoZPT+ULu8dLkEqvcKNSCVcw2hkvWpDRGAL7deldEf/JNivDFUTFhMmDzPEBqtTF
         XTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTepaE7i1ce24dm26uRmEEUceXZHJKSDodvrQSvyGfM4JjhggEY5imp0eyBDhogUu5KxbaQ5XA9It4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25/mxKZm+FxtxexMgq2cKMW/Zk5QPradKnIS4el/osq/ATEt4
	JbYmW/bnnHBCjmUXvmbyoxtd3hxbWEmBltvXzdjotEZUJH2Lq8lw+mb9
X-Gm-Gg: AY/fxX6i3hOLUnIP/7KUGV4yZO7lK/jokhyJDog2THooONVCY/AuohFdzUiZx8ABHHk
	++MS2x7S+g4RT5jcAMI0thRBDdDpH8Z6LEGNYejJ8b3hS9RC+HZt6+O05KXvjI3B4YVC+OEjoHX
	nBzR2JgMfqEVAvxhScJC1rX8oySlhV+8+gNVnlqhByrOH3N1NEuz527UscOD+xz+Tqin4mmx4Sm
	BT857FeYLwUa/DIAhoWo3PmAMtIZ6ZjA/Wr+j2sRmnB86x2308iiWIMcI85ZwO1xaU++YhhJOBR
	rsKqMVniIMsMX8KZlz18CQVZu8+2DNHlSIDJ2Bn5g1MT+2IHXSnBhSLV9Fg4rXHtQCCphdC0KbU
	daEeVHVW8Y61j+tJz43FqiqE/PUt9VU44KPRvk9bgSQwAaIZ+HhNYyXEggCi+l9FZBIYvit26AS
	2JTjnwd3yv7mUDgniYyQBAbog52WT/TSpA8k13s6tEJELM9e6XdhPKx44k7itvGg==
X-Google-Smtp-Source: AGHT+IENUd7yFv5tVhyGggFo64IK9mERVcs/A5DvQaJYTBeN0PqEm5aAJX1uvH65Tl/mwgzXBzwXIg==
X-Received: by 2002:a17:903:b83:b0:295:5972:4363 with SMTP id d9443c01a7336-2a2f1f6bcb9mr270722215ad.0.1766836834702;
        Sat, 27 Dec 2025 04:00:34 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm231033165ad.50.2025.12.27.04.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:00:34 -0800 (PST)
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
Subject: [PATCH v1 3/4] rust: helpers: Add i8/i16 atomic try_cmpxchg_release helpers
Date: Sat, 27 Dec 2025 20:59:50 +0900
Message-ID: <20251227115951.1424458-4-fujita.tomonori@gmail.com>
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

Add i8/i16 atomic try_cmpxchg_release helpers that call
raw_try_cmpxchg_release() macro implementing atomic
try_cmpxchg_release using architecture-specific instructions.

x86_64 uses full-ordering try_cmpxchg().

On other architectures, try_cmpxchg_release() isn't implemented; so
calling try_cmpxchg_release() ends up using cmpxchg_release()
implementation.

arm64 and riscv implement release-ordering cmpxchg.

loongarch uses full-ordering cmpxchg().

arm v7 only supports relaxed-ordering cmpxchg; __atomic_op_fence()
macro is used to add barriers before the relaxed cmpxchg.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 69a258ebbfa0..589c070f589b 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -110,3 +110,13 @@ __rust_helper bool rust_helper_atomic_i16_try_cmpxchg_acquire(s16 *ptr, s16 *old
 {
 	return raw_try_cmpxchg_acquire(ptr, old, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_release(s8 *ptr, s8 *old, s8 new)
+{
+	return raw_try_cmpxchg_release(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_release(s16 *ptr, s16 *old, s16 new)
+{
+	return raw_try_cmpxchg_release(ptr, old, new);
+}
-- 
2.43.0


