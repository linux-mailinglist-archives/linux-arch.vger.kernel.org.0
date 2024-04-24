Return-Path: <linux-arch+bounces-3936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9178B1368
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892881F2384F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153E85654;
	Wed, 24 Apr 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVDWgoj+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5112D05E
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986267; cv=none; b=cpnpsY1XOZNvWzYwDxzsvAOzHyHyEGT9vH+KtNjID8C1915dwFw3f6jWwYUMSGEkDSVr9/G6VE18m5rwUiaKKsTMhpco3jzTB0wo/aLJ0rPWLiXyxloWyIbYPZPFyKGXQ8N9dM5FP46a4AKaellqIDiZMW7mMS1+OsDMWqq10cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986267; c=relaxed/simple;
	bh=p+vioqJHMrVAxi1bLzx7AQ2vntcfu+EHzlTtU17Neoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=im0/15rloSXt6KhV6w+YUA+wrwmckzFpNsMKhusNLGo/pL/lAzJMQZ8oFfPx0pDNpziwad/waaUozirUwUnFHisT5qEP9a7V+wyAEpuxepmvL2w43rjZQ3+CoaVQG0eGU3N/vG39AAO+RWI5pV/XWsgLkfHDFPJ2mlqtnr68fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PVDWgoj+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3f17c6491so1470735ad.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986263; x=1714591063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEPqPttQfQibEvJLf164NSrzanGE7tc+dv4CafbEPd0=;
        b=PVDWgoj+r6wPynfTcoWtVvTh1T5JCBLWtLy25X9WgA7QXfztBCelHN09r/HNk1NuzA
         y49wQKQkMs/ybeKRbkAvj6ZGVawyyMpt/QtTxKGCPgzQjBSLCXy3KEazP9IPnRtB5Hws
         pB6aBoSK64X27WEVp05NGs7mGkGqAqi0pqYRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986263; x=1714591063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEPqPttQfQibEvJLf164NSrzanGE7tc+dv4CafbEPd0=;
        b=CO5UwI+C9nhSosEMSmwSn7ewDzDAla+LTPHqtWWYbGGogMmrkP+vbnRtRTLOtgSY1F
         mX/8u0+BrFsnrfSRJkqnQoJs3yGzplj83IlBJYpQAFop8zrbU5QKKcdUD4hVb0Aa7r9+
         yg4dn31ZqGnbf60Wftn+hrcYzdhWMZYDHLiX0dzGV8TDWx8agVRB7UmgIR3AzKFxXXPr
         DlUEJI1T8kCPd1z45DeP4NyljQ/AChGzy5ch+2LBPffVEQIv2B8Wti5FzHmNA/xlYeRk
         cNApG8NwSVPJVea628i4CC1ZaZy9zMx30aLAugo/b5K7aQqprrqkwUdB+pgTg+H7UDhN
         igPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy5lI6yYW4JdlEMcwnNqLsz2nROSnOiBEqTmx0v3fx9EO4kt2BssAOT1cMK5gD3GJZKPrPTDUSVoybTcqbuJG3vkTCN1jvAcozTw==
X-Gm-Message-State: AOJu0YzdNFLBhkEDLq3L/HE7hVRVgg1f19ibCqk4/6rtUisjFcrX8muL
	ucPfumYFY8/PoogetNcn/nlZyZ1jOU0jpJxMFvXWEUalKNGM8rC4CV1vqZDobg==
X-Google-Smtp-Source: AGHT+IG8y4hy7B6G3NmN+Im4mCezDRd9ywIoXz+NBZ5qvURqQRP/1I3KkB7n9jrCh4TwWAmxPr8I5Q==
X-Received: by 2002:a17:903:11c8:b0:1e0:bacc:9977 with SMTP id q8-20020a17090311c800b001e0bacc9977mr4180689plh.59.1713986262829;
        Wed, 24 Apr 2024 12:17:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b001e20be11688sm12487228plk.229.2024.04.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:17:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arch@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] locking/atomic: Annotate generic atomics with wrapping
Date: Wed, 24 Apr 2024 12:17:36 -0700
Message-Id: <20240424191740.3088894-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424191225.work.780-kees@kernel.org>
References: <20240424191225.work.780-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12519; i=keescook@chromium.org;
 h=from:subject; bh=p+vioqJHMrVAxi1bLzx7AQ2vntcfu+EHzlTtU17Neoc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKVrRf2E4KMRiQ6V7SM0Vpu4063D54ihXAdSW1
 fcu1lTXPGOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZila0QAKCRCJcvTf3G3A
 JilIEACBFQIUJ2T51sviwA0k1wadwtR9Gb4WZamGcp9CqDySqaD1udUvFGRL1AULMABYirtFv0B
 +cyM6s8NSC83+hyRH+eUPvBXSUGSYhWNyebqJ8C3hD6WUAJo97b6AJAj5TcWRePFwg+KQl86uQF
 XOPdxxta6YmHtAZdwdT85XbTnUgfMoNwLhJz2KTXT6cQN0J9n713TUbFA+g2ReAcSPpHd78n3ih
 iIlaMyuQLBwWbqixUMSFrSuzC4xnm5w8oboBhMlWzUH7F2CStJnEJRCkcp90e9Dbzu/xwDFfp7J
 jql+lkTa358V9qUgeeJllBz0PzhcfpGLGwbqYRdv7JFTM2OYNhpjIvL92+IhXvtE5b/wGW/nM0u
 2x1R2RsYX/KKWU/rFZafAkgnZzjAlgEoiSSav9u3DPGBqeAmIY7da+HeASXcgUiBnvAR1eRqvjG
 QCA0Eboui0AzuTFvwgeuB9ljrz4Viu0wSN9sorlx+nvSbdmtB7GMAcG+1mhHtak21LoYf4d3LKi
 Rkpyx3GIfgvjA9Nu+e3v1s20oGEd7hwh5+tzJQvc6z9lpsEPt+8Ia4dhDGYmEm/mAw/7g/1ORVi
 +5NWw+Vci85gZpYHzTWJ919eW8XZZfN0rqTx7B2O3f/0cJbUUpVNkBsD6CR/exm6WYMx+QGwpfA QiKOHEwFSuvLsGg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Because atomics depend on signed wrap-around, we need to use helpers to
perform the operations so that it is not instrumented by the signed
wrap-around sanitizer.

Refresh generated files by running scripts/atomic/gen-atomics.sh.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/atomic.h                 |  6 +++---
 include/asm-generic/atomic64.h               |  6 +++---
 include/linux/atomic/atomic-arch-fallback.h  | 19 ++++++++++---------
 include/linux/atomic/atomic-instrumented.h   |  3 ++-
 include/linux/atomic/atomic-long.h           |  3 ++-
 lib/atomic64.c                               | 10 +++++-----
 scripts/atomic/fallbacks/dec_if_positive     |  2 +-
 scripts/atomic/fallbacks/dec_unless_positive |  2 +-
 scripts/atomic/fallbacks/fetch_add_unless    |  2 +-
 scripts/atomic/fallbacks/inc_unless_negative |  2 +-
 scripts/atomic/gen-atomic-fallback.sh        |  1 +
 scripts/atomic/gen-atomic-instrumented.sh    |  1 +
 scripts/atomic/gen-atomic-long.sh            |  1 +
 13 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 22142c71d35a..1b54e9b1cd02 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -55,7 +55,7 @@ static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 #include <linux/irqflags.h>
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void generic_atomic_##op(int i, atomic_t *v)		\
+static inline void __signed_wrap generic_atomic_##op(int i, atomic_t *v)\
 {									\
 	unsigned long flags;						\
 									\
@@ -65,7 +65,7 @@ static inline void generic_atomic_##op(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
+static inline int __signed_wrap generic_atomic_##op##_return(int i, atomic_t *v)\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -78,7 +78,7 @@ static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
+static inline int __signed_wrap generic_atomic_fetch_##op(int i, atomic_t *v)\
 {									\
 	unsigned long flags;						\
 	int ret;							\
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 100d24b02e52..0084867fe399 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -19,13 +19,13 @@ extern s64 generic_atomic64_read(const atomic64_t *v);
 extern void generic_atomic64_set(atomic64_t *v, s64 i);
 
 #define ATOMIC64_OP(op)							\
-extern void generic_atomic64_##op(s64 a, atomic64_t *v);
+extern void __signed_wrap generic_atomic64_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OP_RETURN(op)						\
-extern s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v);
+extern s64 __signed_wrap generic_atomic64_##op##_return(s64 a, atomic64_t *v);
 
 #define ATOMIC64_FETCH_OP(op)						\
-extern s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v);
+extern s64 __signed_wrap generic_atomic64_fetch_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 956bcba5dbf2..2d2ebb4e0f8f 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -7,6 +7,7 @@
 #define _LINUX_ATOMIC_FALLBACK_H
 
 #include <linux/compiler.h>
+#include <linux/overflow.h>
 
 #if defined(arch_xchg)
 #define raw_xchg arch_xchg
@@ -2428,7 +2429,7 @@ raw_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!raw_atomic_try_cmpxchg(v, &c, c + a));
+	} while (!raw_atomic_try_cmpxchg(v, &c, wrapping_add(int, c, a)));
 
 	return c;
 #endif
@@ -2500,7 +2501,7 @@ raw_atomic_inc_unless_negative(atomic_t *v)
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!raw_atomic_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_atomic_try_cmpxchg(v, &c, wrapping_add(int, c, 1)));
 
 	return true;
 #endif
@@ -2528,7 +2529,7 @@ raw_atomic_dec_unless_positive(atomic_t *v)
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!raw_atomic_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_atomic_try_cmpxchg(v, &c, wrapping_sub(int, c, 1)));
 
 	return true;
 #endif
@@ -2554,7 +2555,7 @@ raw_atomic_dec_if_positive(atomic_t *v)
 	int dec, c = raw_atomic_read(v);
 
 	do {
-		dec = c - 1;
+		dec = wrapping_sub(int, c, 1);
 		if (unlikely(dec < 0))
 			break;
 	} while (!raw_atomic_try_cmpxchg(v, &c, dec));
@@ -4554,7 +4555,7 @@ raw_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!raw_atomic64_try_cmpxchg(v, &c, c + a));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, wrapping_add(s64, c, a)));
 
 	return c;
 #endif
@@ -4626,7 +4627,7 @@ raw_atomic64_inc_unless_negative(atomic64_t *v)
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!raw_atomic64_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, wrapping_add(s64, c, 1)));
 
 	return true;
 #endif
@@ -4654,7 +4655,7 @@ raw_atomic64_dec_unless_positive(atomic64_t *v)
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!raw_atomic64_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_atomic64_try_cmpxchg(v, &c, wrapping_sub(s64, c, 1)));
 
 	return true;
 #endif
@@ -4680,7 +4681,7 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 	s64 dec, c = raw_atomic64_read(v);
 
 	do {
-		dec = c - 1;
+		dec = wrapping_sub(s64, c, 1);
 		if (unlikely(dec < 0))
 			break;
 	} while (!raw_atomic64_try_cmpxchg(v, &c, dec));
@@ -4690,4 +4691,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 14850c0b0db20c62fdc78ccd1d42b98b88d76331
+// 1278e3a674d0a36c2f0eb9f5fd0ddfcbf3690406
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index debd487fe971..af103189bd7d 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -15,6 +15,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/instrumented.h>
+#include <linux/overflow.h>
 
 /**
  * atomic_read() - atomic load with relaxed ordering
@@ -5050,4 +5051,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// ce5b65e0f1f8a276268b667194581d24bed219d4
+// b9cd8314e11c4c818fb469dbd18c7390fcaf9b3c
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 3ef844b3ab8a..07c1625a2d92 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -7,6 +7,7 @@
 #define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
+#include <linux/overflow.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT
@@ -1809,4 +1810,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 1c4a26fc77f345342953770ebe3c4d08e7ce2f9a
+// 01a5fe70d091e84c1de5eea7e9c09ebeaf7799b3
diff --git a/lib/atomic64.c b/lib/atomic64.c
index caf895789a1e..25cc8993d7da 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -67,7 +67,7 @@ void generic_atomic64_set(atomic64_t *v, s64 i)
 EXPORT_SYMBOL(generic_atomic64_set);
 
 #define ATOMIC64_OP(op, c_op)						\
-void generic_atomic64_##op(s64 a, atomic64_t *v)			\
+void __signed_wrap generic_atomic64_##op(s64 a, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -79,7 +79,7 @@ void generic_atomic64_##op(s64 a, atomic64_t *v)			\
 EXPORT_SYMBOL(generic_atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
+s64 __signed_wrap generic_atomic64_##op##_return(s64 a, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -93,7 +93,7 @@ s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
 EXPORT_SYMBOL(generic_atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v)			\
+s64 __signed_wrap generic_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -135,7 +135,7 @@ s64 generic_atomic64_dec_if_positive(atomic64_t *v)
 	s64 val;
 
 	raw_spin_lock_irqsave(lock, flags);
-	val = v->counter - 1;
+	val = wrapping_sub(typeof(val), v->counter, 1);
 	if (val >= 0)
 		v->counter = val;
 	raw_spin_unlock_irqrestore(lock, flags);
@@ -181,7 +181,7 @@ s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	raw_spin_lock_irqsave(lock, flags);
 	val = v->counter;
 	if (val != u)
-		v->counter += a;
+		wrapping_assign_add(v->counter, a);
 	raw_spin_unlock_irqrestore(lock, flags);
 
 	return val;
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index f65c11b4b85b..910a6d4ef398 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -2,7 +2,7 @@ cat <<EOF
 	${int} dec, c = raw_${atomic}_read(v);
 
 	do {
-		dec = c - 1;
+		dec = wrapping_sub(${int}, c, 1);
 		if (unlikely(dec < 0))
 			break;
 	} while (!raw_${atomic}_try_cmpxchg(v, &c, dec));
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index d025361d7b85..327451527825 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -4,7 +4,7 @@ cat <<EOF
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!raw_${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, wrapping_sub(${int}, c, 1)));
 
 	return true;
 EOF
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 8db7e9e17fac..a9a11675a4d7 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -4,7 +4,7 @@ cat << EOF
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, wrapping_add(${int}, c, a)));
 
 	return c;
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 7b4b09868842..0275d3c683eb 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -4,7 +4,7 @@ cat <<EOF
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!raw_${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!raw_${atomic}_try_cmpxchg(v, &c, wrapping_add(${int}, c, 1)));
 
 	return true;
 EOF
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index f80d69cfeb1f..60f5adf3a022 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -297,6 +297,7 @@ cat << EOF
 #define _LINUX_ATOMIC_FALLBACK_H
 
 #include <linux/compiler.h>
+#include <linux/overflow.h>
 
 EOF
 
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 592f3ec89b5f..fbc6c2f0abd3 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -146,6 +146,7 @@ cat << EOF
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/instrumented.h>
+#include <linux/overflow.h>
 
 EOF
 
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..ae6d549c9079 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -75,6 +75,7 @@ cat << EOF
 #define _LINUX_ATOMIC_LONG_H
 
 #include <linux/compiler.h>
+#include <linux/overflow.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT
-- 
2.34.1


