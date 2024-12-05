Return-Path: <linux-arch+bounces-9254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA09E5A00
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ED9169BA8
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A171221457;
	Thu,  5 Dec 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1NEN0vU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36721D598;
	Thu,  5 Dec 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413383; cv=none; b=STJCkBgq9NW0cw7lkV4dmCXtA1FzmsFWVXG0N+qxWHc+hDG89/DPazY/uMDzXE410wHhzKXLPNTgQJu0HEvP1kiUSFMF9vzBjDtVvs8JoM0Y273u/1Q6x7E+7oLz1YUIcSikSLmKhIoS5xVnZ47brom2stPQ1Re5ClQr51R7bHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413383; c=relaxed/simple;
	bh=unFCMuepgf1SQbq5AYrK8xHbDJUoge6TMBDvQpYj520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjR+K7vL23gcKqp6uDcdI0XiGhQ6Ej2BtHsSaqFFq46ZoxhY2uD18U2O0gDFhi/Ww+ZH+nXOMyl2/gs5M8M8jbLDm9IT0TdKhvGynrkRW9iD8BX3mVc9v+rCWIZ+b9EAuPsCiJOHqZAS4Z6YXY09pRcl3eqAESi6VI7WimzBFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1NEN0vU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so11372355e9.3;
        Thu, 05 Dec 2024 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413380; x=1734018180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+7I9gi8mucGgoO85kNahA3U27ot3S0RhfZIOhPcQEg=;
        b=h1NEN0vUEoWlo9MYLfR8mIwXQTJoVQgQ5DeLt84drU7UWhI2vXuO7s6xeDyLu5QzBs
         fmp8RT/RI+FLkbKdFM1vXqmBUJ60vy8kOW9zTqNXEgjbpJ0z2Z6nUNB7WtUj8Fq9awrE
         DPsPc74f3fXvO8zQci0HxefJ4jCX5/F2gaSe1aWn6jWIlceQ0A7YASh8Hby3P2W1agBu
         zKfbu7OZ2qdnWgOxIjXOqBueAw8NerjuJGaZDxDsEWpW/SE8E+9u+jFG83vKmjFta3ep
         /UpGxug478g7Cpsp1ZQR9i5YFWZWLn2B4mq5ONEbglWa+IoMSLuuSreGLDhs0FYT1AUt
         tStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413380; x=1734018180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+7I9gi8mucGgoO85kNahA3U27ot3S0RhfZIOhPcQEg=;
        b=rcoU/7sTIYMu+HjczdiiRTi/K6NZkc7dhd/AZQsJR3Tjyl2wUc3QYz0Fm9LxKmD6tE
         sJqdSjFTs+BjyJA8PiYU81UQ2RoYHdiAGX62JND2t6ZD9AIqKvbn44TU4Y8vHhSr69VR
         inFVRUZ/VEPM7qaD9HWGlmP2sfdoHq+xQOSUcp+X4wGCOK/WkpYcPXz/iXF9+CydQxBG
         TI5OcwW1+/mZAMwJHM70DBlmYcjev5WV+0gug0+AiAaOMRUKz+dmhIYjih6qEAkdXUIh
         JlTSx3gka2vaVRv2hfjyMMR5GD1Zcp+x9fmdinbkQXwQq2l2N8A0KJd6hIPA0nArg24g
         yvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUrLl6RzSUlVLNAUpGy26j1m+CxDT77M/x/gfSz+S+ajItHDjjCxaGCZEgSjnqlQXYlPnGKIRd3jttB0F59PQQ=@vger.kernel.org, AJvYcCV3vxBpdMNw+njvj3SifsIniJ4vHhnEG4/IP//IZ1/WKaFYYbkT0r8iyOgonLN6rssi2wEacgCI@vger.kernel.org, AJvYcCXPkNokZtGyyQ1n1hQH/MzEBgOlDmEr4igtjjyYDjI6hOjFf1+hHhvauyEvd8d5HXEcEODnphZ49w9a9z3T@vger.kernel.org, AJvYcCXtzOlXxlD+suMtV0gzZL6uHVUrQcV1AKsVnsqcpW+bs2szupeagxzinID5VNPy/si7VW2u1S5gYDKc@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwgPgEGZ7CwJjzdtZ1Zl1VWTg+hih+Ym3hSry7KrjY9Wp6Vuw
	4NgWiFGwhItesiRlIfdum8vE4j0VAcoXARgtGUySmDWJt0jz/AhY
X-Gm-Gg: ASbGncuCozX2YVO/jab+c4G13jsm3HDIuL3g8LXexnkt9ITSvYnCeZO1JMTeyhfV7WJ
	wtlJnYyi2L2oQMvmuSDHWN3SDEcYO9gEpkPeBPS6ANqpPXEFNpZPwx/FAyCIcocbRQ824B85Ik7
	ARIjTzJMbcsv8sivMC7K+JXzmT4d93HScZXgbzGJKtkGNRDOilfzcEqy5XUUDnVjR34ajunW42Q
	Kdgwhs0iyFXpgU07YkYEguqtnHkq5RukeHMebnstDxwxtaMVfcP2ahgMv4=
X-Google-Smtp-Source: AGHT+IGfxs/UDP+NchJ2Ajwu/cJXwUlfvxqHc9BB8+DQufR3ysgRKYw2o+8A68R7dOOef3F4mH8x2w==
X-Received: by 2002:a05:600c:83c8:b0:434:a962:2aa0 with SMTP id 5b1f17b1804b1-434d0a1533emr87442155e9.32.1733413379677;
        Thu, 05 Dec 2024 07:42:59 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:42:59 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
Date: Thu,  5 Dec 2024 16:40:52 +0100
Message-ID: <20241205154247.43444-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241205154247.43444-1-ubizjak@gmail.com>
References: <20241205154247.43444-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof operator
when available, to return unqualified type of the expression.

Current version of sparse doesn't know anything about __typeof_unqual__()
operator. Avoid the usage of __typeof_unqual__() when sparse checking
is active to prevent sparse errors with unknowing keyword.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org
---
 include/linux/compiler.h | 13 +++++++++++++
 init/Kconfig             |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 469a64dd6495..ec0429d7a153 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -321,6 +321,19 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
+ * operator when available, to return unqualified type of the exp.
+ *
+ * XXX: Remove test for __CHECKER__ once
+ * sparse learns about __typeof_unqual__.
+ */
+#if defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
+# define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
+#else
+# define TYPEOF_UNQUAL(exp) __typeof__(exp)
+#endif
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0f..c1f9eb3d5f2e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -894,6 +894,9 @@ config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
+config CC_HAS_TYPEOF_UNQUAL
+	def_bool $(success,echo 'int foo (int a) { __typeof_unqual__(a) b = a; return b; }' | $(CC) -x c - -S -o /dev/null)
+
 config CC_IMPLICIT_FALLTHROUGH
 	string
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
-- 
2.42.0


