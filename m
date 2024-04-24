Return-Path: <linux-arch+bounces-3935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B117C8B1367
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE3B1F23609
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FE84A50;
	Wed, 24 Apr 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gU3iIYOF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7D745D9
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986266; cv=none; b=S5JeD09Y1DKJ3aqc0W+erXmvW34kq6cYzg5NcTOzB2AC+PGs6ziGmOEq68FFE4wFurcZbkkMZqU5XdLgVj7cM3GL3pddkW/QJjugOJYmw9x6OCPjYdMcjqV4MHTXTF5QfgqF3arcAL9AKX2ZH18kZrU/enLb6dFMhdCohBxfJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986266; c=relaxed/simple;
	bh=xwLB8JfQnGZ+68nfRnKXcpeprEGbIQ5N7eZM3lFRlVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/Tz+KnGCeMWsO+9kPdb8BR+Yqa3XTdAhxTXH12CCfv33K6cjjODknK5lZ9CH89QXa07tWHsV4NePdyQWSaSKw25lvEbot1Ihi8irqN7mf40RZB9ybBELI+7Lrtcp6HD5rMkb7ImZRJPAa+nD44FT2JNahlt9PBMBz5Uwx4QP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gU3iIYOF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f103b541aeso245203b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986263; x=1714591063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ovZNJsNh+Q5y3YBgmePtlPx3aXBNKsLPIMy6gD2e/k=;
        b=gU3iIYOFFuzLzxS0C2y7iC7rAUJK7SjM6UkJuLmQd8VBcNvUgb8ThJ/BGL6AUnGQAT
         WJ3nQv1wHgGdYe3aL5pRYtbbFHl0hUSxGDLYftKgaOSMr9r7591C2n00pobVT7nQfaZE
         3SjWAH+l8RIx56ZVOc62Y1FhH1PsdNI1IMeVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986263; x=1714591063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ovZNJsNh+Q5y3YBgmePtlPx3aXBNKsLPIMy6gD2e/k=;
        b=EKiZ/Kx7BocertU27K+y9fkatzB77ooZqg4FKg6H9JGw07yZuQBRk+SLDZRZwSPWca
         38F45N6f2oiDMv/LUO5v3kiveYmXSKwRSRbqf1l/yvsWgetrGaskuRTAL1fqu/acbZae
         7/vfaa5FW1xxUb/YmLvwUW7/JFkxDfnrUJqqkWeixRLlgWDMC12QwV151BozJFiwcsks
         rws5u8ZWUXnrGwbOtaXrxi7rWpGFU4yPv+3LPpPLh0OPPATBlaWfJUEvoFoDdixEHWBQ
         3yZQidj883A/Z9/9VrPEeYQ4zLCLMyiynDCGB7AnMY5ZpAPwcuvBc585tGQ5jvtmo1BC
         r36Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7mP0xF1C1S6FCEpCA2U7i63PsQKXEwYOidP6Ufo9qiMr1i3juFb0fqpW8u7QvvJVyrsUo2yZKMyBhFGbEP6MwnW/M/FbP6HyfYg==
X-Gm-Message-State: AOJu0YygjiunZjk/3YtERHR5DiIQ9S4SarWwqyKq0wCN/WmenYdSoIoz
	l/a3QyxPwwXPeMoEZWicOXWFJQJg7EEBGcIErbmX1lwACr0OChTjNGaHqV076A==
X-Google-Smtp-Source: AGHT+IH5PxCoRC7r3PuTmsotsJWh4LNkWmqcpOxpDSEhbERbm5LugRo2mXC3N2+7jUPKaLXdawyW1w==
X-Received: by 2002:a05:6a00:21cd:b0:6e7:3939:505e with SMTP id t13-20020a056a0021cd00b006e73939505emr4435012pfj.2.1713986262601;
        Wed, 24 Apr 2024 12:17:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a056a000a0700b006ea8ba9902asm11784540pfh.28.2024.04.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:17:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] arm64: atomics: lse: Silence intentional wrapping addition
Date: Wed, 24 Apr 2024 12:17:35 -0700
Message-Id: <20240424191740.3088894-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424191225.work.780-kees@kernel.org>
References: <20240424191225.work.780-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=keescook@chromium.org;
 h=from:subject; bh=xwLB8JfQnGZ+68nfRnKXcpeprEGbIQ5N7eZM3lFRlVk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKVrRbqMbwLvcfN/CYeO2dTbShkdvlexcHwL/5
 YEg6VqdugyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZila0QAKCRCJcvTf3G3A
 JmxbEACdESTOy4jkKFG20/bUsA+2niWwljmd0zr7tKnSdR7jpksWerZepL1D4SjqYa4O/LavsJ5
 lFd/o7p1MTmSLppqZ5RNFhrAXffGJhvjZs/LhFSfihaH32GxNP/5smFSj95gTaKIgpghcplMG5J
 ByNnCX4z1k1dih5igMvnndR1vEj3i5zmohj/juFh6Gwur0F0eZDDT/hKmkzXLs89XHe4T8D+9mw
 +Ak5yTBAesLT4zSQ7cgFT4ihOnocVSo/S6GGmN4SNypgaWIWVr528R6/4/jlw2bssx8Sbkt2fZi
 vzwM8TMrof0cGiMS0h3BEPIlHo5o465p4D6Ns2/40gF9l/5yMIr2RrOIDyQisudC/hM3NGnrVt6
 Rpr3L2g9GgwoqTupgCCes+a3Z/pL8Ehn2iwtlW3+8nMbU0vCQLI10C34kkBQyz7tzEuA+/d0yf4
 EgjvKrBdM9sIoKmoI1sDwkDcII5r5mROTGOv4FEEj8Kh7W5aVZhk9k8uoYmuiYnG102+zY7hSe3
 zI5EKKzAoFfA1FRCUqbu3rd/sdd9swVFJgjLylGG2OwkUn7DaH1HAEm4w05ft2MnZnWZmiuaoKS
 jPCSl6Ouz4rBGE4yLDtYT/3JLzIFZWH/GWFyXG3+I4o1/A6qeIn5xvfrkMOrWLLJby5smfXa2vt f4Zqx35NAt41MRw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Annotate atomic_add_return() and atomic_sub_return() to avoid signed
overflow instrumentation. They are expected to wrap around.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/atomic_lse.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 87f568a94e55..a33576b20b52 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ATOMIC_LSE_H
 #define __ASM_ATOMIC_LSE_H
 
+#include <linux/overflow.h>
+
 #define ATOMIC_OP(op, asm_op)						\
 static __always_inline void						\
 __lse_atomic_##op(int i, atomic_t *v)					\
@@ -82,13 +84,13 @@ ATOMIC_FETCH_OP_SUB(        )
 static __always_inline int						\
 __lse_atomic_add_return##name(int i, atomic_t *v)			\
 {									\
-	return __lse_atomic_fetch_add##name(i, v) + i;			\
+	return wrapping_add(int, __lse_atomic_fetch_add##name(i, v), i);\
 }									\
 									\
 static __always_inline int						\
 __lse_atomic_sub_return##name(int i, atomic_t *v)			\
 {									\
-	return __lse_atomic_fetch_sub(i, v) - i;			\
+	return wrapping_sub(int, __lse_atomic_fetch_sub(i, v), i);	\
 }
 
 ATOMIC_OP_ADD_SUB_RETURN(_relaxed)
@@ -189,13 +191,13 @@ ATOMIC64_FETCH_OP_SUB(        )
 static __always_inline long						\
 __lse_atomic64_add_return##name(s64 i, atomic64_t *v)			\
 {									\
-	return __lse_atomic64_fetch_add##name(i, v) + i;		\
+	return wrapping_add(s64, __lse_atomic64_fetch_add##name(i, v), i); \
 }									\
 									\
 static __always_inline long						\
 __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)			\
 {									\
-	return __lse_atomic64_fetch_sub##name(i, v) - i;		\
+	return wrapping_sub(s64, __lse_atomic64_fetch_sub##name(i, v), i); \
 }
 
 ATOMIC64_OP_ADD_SUB_RETURN(_relaxed)
-- 
2.34.1


