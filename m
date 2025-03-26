Return-Path: <linux-arch+bounces-11144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C8A72057
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF305175BAB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636A23FC4B;
	Wed, 26 Mar 2025 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31740GuF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7264B49659
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023104; cv=none; b=Ttasjhbfc9Rnu9NjxdL6lnXeriJ773CP0g37n6+6wEN+BYoTOj3Fcp/4ftftDoNmFZu2hJgvYt8IuEyUtYi9rffhSK5ViHQs4mGCTjTVGxZ8+RhB8bZ3HRiSbT4ULqumJOzi2UNbchlr42ljFaeDCgUXnstorxyNW8Sk6spR3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023104; c=relaxed/simple;
	bh=BO1ttHHiSBXUaku7Uu8c0+AsAe9OPrk7r7SPVpYVrDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gh6fNJUL/oBWkhQC/mHnlBfrFLqFfCr7CmYDJXog3VPvOQ+KsNLEzbt9XyaOxHYKzNgEdlQI4MUR4UxH725Qwh+xPNxSDb9S7DYnvEqAg+7PbejGHhKOmN06IBw24xUMhOHRMb597WuItk5kMdrXQzMikOniNJF7RFjG00h+2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31740GuF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso18895e9.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743023101; x=1743627901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGg+6F4aN96UIgi198Gy3oIV+lDBtGNm2oHXG/52Ti8=;
        b=31740GuFOUAOJEoEYmYt06AAkqz31/wLWp+ND5fOg4Xp8Mmt/luJSjtGuJGlfRu2je
         GUD16Ob/JnZJMZ+CGoOCAVkQr8C3CVswDXM4DvvX+yE+wmefi12dIc4VdK0NqifvqGsw
         yyWO1j7rCO4ABdq+XtE589CPa9zdSf3eHCXnOC1xtHtMuVbvgTRN2hTZP08JJcYZpBAV
         W9fOcXIeysFzjYd24IZneitQZ+uRLAvKBdisgBq5w/seRWHuyKqwuqT23GNTfB7BZu7P
         I5yXOZFQzLtSgU2HVXn48TEQyShClU5f6rvX0f7hkQ0gWdrT0/Hyc4bBDHqiIuN/Nu3v
         RaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023101; x=1743627901;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGg+6F4aN96UIgi198Gy3oIV+lDBtGNm2oHXG/52Ti8=;
        b=bF12W18ww/4o7nCwnRT1OGu3mOWntNy6iBWgUwdpcR74ThCGj5g7tCASUCZlrST6yU
         SShQl0lhWP7Inzl4/PxAQ67o0tmfccHVOOlXAX0EvSZRyBdQ+kravjTVO7pkwqa1ICn1
         N+Mt+X9nCXSLQOpP5fBWFejIKQeB2xeAkB+9Oa6qmY109cKwISKtAClgHMY66IrNOY3t
         vOrRlhUdFZaBzbySmjLDwDsbcIE7D924wddT2aedlDMnY/smCT+qR+NSw8oBXP+PGeT8
         vjsdSecel+oIMFlVPnl9qyCMoKCRDUTxXpON/KA1FgmbMEmX1CEMrVTK4/33MhgoOc9G
         8dPg==
X-Forwarded-Encrypted: i=1; AJvYcCXfGoA4JjJIM2GcKlO74QDXEcYfb7soOrA1Dt/3lBS27jAq5gRaaOFu8t8dtXJJsuTKDAk/qS+sOEQc@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXpeVRGeVsEhTqnKDtv2IUfB1n/mXCP/BG//A3wwzESQ6B5DE
	ezuldgt2ro2wm0yHdK7Z5dHdYrQJnKUBG1GD7Tum3x4RgvXgUtB7YIKTcOq/wA==
X-Gm-Gg: ASbGncva8UadjE+KqKYWZIK3508mO6IY0zxhQ/dPMbxLtXVEHWAVtXJ1s83eSj+MT8K
	EshkXysResC7F/RGqqLtz9tipp/6LV7ELnEGKwMw3ygY/Wr41v/XnI/9wGBLGbcvCz0OgHso8bA
	OHn9L8C1Szz962nJEdbjQ4MwaaIe41a0LcGjrZKevyjGAD8+Q3Mr3HSTOI5BBKkyA5iqC75pjzF
	BHVsoaYraaQYpZjGbT3QhFNBSo/kSJdiRynL41PdqDm6SjbfVJ0cthG3lj8vd/xT+nF6fdvbo/A
	UKGy3yhK2NoJ3ocXiHVmQyNuZxXWoaTz
X-Google-Smtp-Source: AGHT+IHg/3v/cfe2Oy5MvruqsLylxRVpyyU/aAWQVcEDJcN7MUgkWXX5GxoHJ1izSCLDjNQshKuHpg==
X-Received: by 2002:a05:600c:1c90:b0:43b:c2cc:5075 with SMTP id 5b1f17b1804b1-43d86e88f33mr89565e9.5.1743023100339;
        Wed, 26 Mar 2025 14:05:00 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:df17:be3c:4c24:1997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e66c7sm18117401f8f.79.2025.03.26.14.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:04:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Mar 2025 22:04:36 +0100
Subject: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned
 read
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
X-B4-Tracking: v=1; b=H4sIAONr5GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMz3aLyxMQS3bTMCl0z4xRzU1PzJOMUCwsloPqColSgMNis6NjaWgB
 kgX1vWwAAAA==
X-Change-ID: 20250326-rwaat-fix-63d7557b3d88
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743023076; l=1492;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=BO1ttHHiSBXUaku7Uu8c0+AsAe9OPrk7r7SPVpYVrDA=;
 b=+1QRVRGwI1lHIfXryidjFzwPJDU/R4I73316cD2DkqSWPb6lTI+9s6bP46AebpyUF3IZhZsyi
 JvjlfxZUaE0CViffB1yZjXYLxoBPcxQAxLbQbu/Tb+IwdwWpRHx86Lr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When arm64 is built with LTO, it upgrades READ_ONCE() to ldar / ldapr
(load-acquire) to avoid issues that can be caused by the compiler
optimizing away implicit address dependencies.

Unlike plain loads, these load-acquire instructions actually require an
aligned address.

For now, fix it by removing the READ_ONCE() that the buggy commit
introduced.

Fixes: ece69af2ede1 ("rwonce: handle KCSAN like KASAN in read_word_at_a_time()")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/r/20250326203926.GA10484@ax162
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/asm-generic/rwonce.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index e9f2b84d2338..52b969c7cef9 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -86,7 +86,12 @@ unsigned long read_word_at_a_time(const void *addr)
 	kasan_check_read(addr, 1);
 	kcsan_check_read(addr, 1);
 
-	return READ_ONCE(*(unsigned long *)addr);
+	/*
+	 * This load can race with concurrent stores to out-of-bounds memory,
+	 * but READ_ONCE() can't be used because it requires higher alignment
+	 * than plain loads in arm64 builds with LTO.
+	 */
+	return *(unsigned long *)addr;
 }
 
 #endif /* __ASSEMBLY__ */

---
base-commit: ece69af2ede103e190ffdfccd9f9ec850606ab5e
change-id: 20250326-rwaat-fix-63d7557b3d88

-- 
Jann Horn <jannh@google.com>


