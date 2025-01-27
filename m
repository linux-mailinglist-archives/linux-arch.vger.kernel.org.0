Return-Path: <linux-arch+bounces-9920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B8A1DA31
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B609D18865FC
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74D17B505;
	Mon, 27 Jan 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae8BIFbg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B911607A4;
	Mon, 27 Jan 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994047; cv=none; b=sSqLm+fiONv5t87/T1eXxfsdqIx2ZsVULfki9B5NFcvZif27LzCmjN/AdxPCmL7Ynd3RiZW//WjNJuM/yL8rWoPVhYNUrYL1Ff4ci1vUhFaC9ocy3mFpLPCRwx8M9dPg+5+2YDM32uHxr+3EcmQVCbpWWMBnJhh2dkZr0H1/TMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994047; c=relaxed/simple;
	bh=vvltvsqkhSZ4zV6BYemVWLxTvnMXnejfNrK4rPX+kmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIm0zXQ0W+jjfhLP6sZmCoNS1TeVB0DsOMko+0rTGr4yvnC4mJ9U10ZaJ9OJmd/w+IIXfqzAenPflwHSc1cNftdQqbtJXNl2Nms012A8a5qFONUSwllRdw9a/zUuksIh4Kq8yPzQTGqnretZnLettk4tirImJXK+3xy/FSVfbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae8BIFbg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab68d900c01so369963566b.0;
        Mon, 27 Jan 2025 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994044; x=1738598844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq9/i3Ta5l2MI1vOWLuY/2sULLk+AJ5LvhrOAI9bZzU=;
        b=ae8BIFbgpWURN2jnqWDKWTeLkjIvOLUeZ7Su0s4ZHiUCge9oHxYZ8FC36c1mdmBpKz
         WtmMJOTdCZh/YM1uknIKPkpA2WVEbRDcroOATeBFRg9OWplL4yNzLvfP68Q3wI/89dOk
         FrzHLTYWNcIFrymWKCuotGCD8APD7QDJg9fseCFn/KuyXbg6jsUMlna81UcOYj5yr9uL
         bHmUVNresiJJAH9N7fSl2EMwBYR6FK8gef0V08QlJeOGUqx/pT1aeqsEG78dClbauv8O
         xXqY/OyKgFkZ3iIfFSYk9VPfDMAWItE03qS3NrypA5I4xgaebhu+Rfz+hHrUsjBruISd
         I51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994044; x=1738598844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq9/i3Ta5l2MI1vOWLuY/2sULLk+AJ5LvhrOAI9bZzU=;
        b=DoRr7ie5YGu5HGW1B0ksoUYCcTlHnCeEF6Wv0oFcxW9AwuuMGuP3EAacTeczpLfGpM
         fFjqtpWTmRBu6j5CzrwaXnOQKd5ZgwcwUKActUkOvyWxIPVrlNOkJDnDYKaV/lVQKomU
         PQO6K2IXpEIotRROmxktaHWbY9cYeIIjNmc4k7ujoJfcThvMgrrIpnBh9LujiSbxi3hD
         3U01zj2OEuCU6IVW288bDRecaWuAaPwSr9D3upOTyrSF9MVDxXSlJx5Zfyzg9viqqquJ
         Z/u6DzbIxDd5uixA6uFXM56cLt+SJetLAhAIJb4UdVYGKBs6w4JReSrY9j9yymBzFkGF
         EA/g==
X-Forwarded-Encrypted: i=1; AJvYcCUCXPodH7hMO1+mIHmwbwbEwvUBO7kRDcmg3RyCe0xmMwuc9LxVRF7htW21RSuX+mgIQrZlImov2qqSOlRD6QY=@vger.kernel.org, AJvYcCUngWLDu8ZpaUMTYPJ9rsjIvWM4rrwwEWx3V9pB3V+eqkaAs9cAX/F3xS84XXjpTRgfXc//qpNnmMGD@vger.kernel.org, AJvYcCUzVFBX6EDRuDw9PjfYAhafEkPhN1QvN0qY1INpACVVubR1UaqsHmBTidAD1htSna1vIjFpCBl9b7rjD0pZ@vger.kernel.org, AJvYcCVwOJK4y8EnnFQtrO4pSvTvUmi34PZNzSC+Ujdz7q/s/hNPJ722MlI3LRx3+zlkz7AtwFjdB8Ez@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JaQxyyTai6QJoThmuBf1mUsAbji+RyGbD4aF+EJ05EfEyQEY
	/3zcTq5HNNkB+ZCUAyTWjg5QpDwOcFiMF1mkL3xhImR6AWj1R6XVOMvRJ3jS
X-Gm-Gg: ASbGncuP/kCng+v/FzohZwXMxgOgV1PJ1DxwlRQH6yq84UAxWIxqXrU3ItMgtGi/Xel
	WxwM3dE+WbyG7w1Qx3wy/UDBtu7PyeZIbKYdWf7VZn+KWVnSp3jBf4Qh4MAQUuk7AkZcuM1f029
	+T+SGAZMy6PBOl5kyMPdnzAwaFb+HfW3U7Yj0AmJ7Lhgx5+SbwC9M3eNgVo7TAE5qQjPWzXvAjl
	pVakcCyRWkvqdlEXWHth5ny4XXinPg0XnKzSPZgRaM44/vTRPk46wjUovvz2zDvRhacvtiZgmTp
	JiKBdG0Eju5UbQ==
X-Google-Smtp-Source: AGHT+IGps2FOyGZFh29HU88UQXaUARQyvefInzqR9JwB8VX2QVMTmcMPtTLVQtl0rzI1dpYkZKybuQ==
X-Received: by 2002:a17:907:72d6:b0:ab3:4d1e:4606 with SMTP id a640c23a62f3a-ab662910720mr1670846366b.3.1737994043332;
        Mon, 27 Jan 2025 08:07:23 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:22 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
Date: Mon, 27 Jan 2025 17:05:06 +0100
Message-ID: <20250127160709.80604-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250127160709.80604-1-ubizjak@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
---
v2: - Add comment to remove test for __CHECKER__ once sparse learns
      about __typeof_unqual__.
v4: - Do not auto-detect compiler support for __typeof_unqual__()
---
 include/linux/compiler-clang.h |  8 ++++++++
 include/linux/compiler-gcc.h   |  8 ++++++++
 include/linux/compiler.h       | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 2e7c2c282f3a..4fc8e26914ad 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -128,3 +128,11 @@
  */
 #define ASM_INPUT_G "ir"
 #define ASM_INPUT_RM "r"
+
+/*
+ * Declare compiler support for __typeof_unqual__() operator.
+ *
+ * Bindgen uses LLVM even if our C compiler is GCC, so we cannot
+ * rely on the auto-detected CONFIG_CC_HAS_TYPEOF_UNQUAL.
+ */
+#define CC_HAS_TYPEOF_UNQUAL (__clang_major__ >= 19)
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index c9b58188ec61..32048052c64a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -137,3 +137,11 @@
 #if GCC_VERSION < 90100
 #undef __alloc_size__
 #endif
+
+/*
+ * Declare compiler support for __typeof_unqual__() operator.
+ *
+ * Bindgen uses LLVM even if our C compiler is GCC, so we cannot
+ * rely on the auto-detected CONFIG_CC_HAS_TYPEOF_UNQUAL.
+ */
+#define CC_HAS_TYPEOF_UNQUAL (__GNUC__ >= 14)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b087de2f3e94..a892c89ac28a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -191,6 +191,26 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
+/*
+ * Use __typeof_unqual__() when available.
+ *
+ * XXX: Remove test for __CHECKER__ once
+ * sparse learns about __typeof_unqual__().
+ */
+#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
+# define USE_TYPEOF_UNQUAL 1
+#endif
+
+/*
+ * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
+ * operator when available, to return an unqualified type of the exp.
+ */
+#if defined(USE_TYPEOF_UNQUAL)
+# define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
+#else
+# define TYPEOF_UNQUAL(exp) __typeof__(exp)
+#endif
+
 #endif /* __KERNEL__ */
 
 /**
-- 
2.42.0


