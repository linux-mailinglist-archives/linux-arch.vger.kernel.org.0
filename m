Return-Path: <linux-arch+bounces-328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAA7F309E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E02E1C21845
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD254F9F;
	Tue, 21 Nov 2023 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OqeuVnWB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290F197
	for <linux-arch@vger.kernel.org>; Tue, 21 Nov 2023 06:25:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso1968711b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Nov 2023 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576710; x=1701181510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtVyhAGSgxoCUXjWEvR6JSaSck3SbghSEmVuA82Ner4=;
        b=OqeuVnWBhBVwL4BhDqUp1/T5IIQOZIrg6ODry6HbSHtpxzIojyg4/QYSSZxgvdy2v8
         /TkbUokutA6fPZgyBCt+z1x3KIW3jxN5DfbuYN/aB0mUCI5etmuwDE49I+wWrgwNFxPB
         DqEJZKdO+4qseHxz1bz45qjMOk279EwOAphliF8WUPkBSbC9R/CvfRlws5aUSI2gnuOn
         /bT27Vbg9XpoWtFcRvziuPOpC6IiqsiiRxegRESK9M2qdI6Dn87/m8HztxMNYno8xFGY
         qdguKu+ESam6MVkbVmmTkUEI5SJjTIM1RmTrNN62r3Qn2OHy3XpaIkfbkeHM2vnkUrJ2
         5kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576710; x=1701181510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtVyhAGSgxoCUXjWEvR6JSaSck3SbghSEmVuA82Ner4=;
        b=fbkMOp2VIkPeQSqM+pFF+mHtmfyHp2wgUljypC3XA3DRgoz0sdgPIvpImNScSJpljr
         u1B9WAzlzd395De/TB2jEzOtqtmsKXMtKzVTepq42MZiCC9c+TOBKC4LpOLyIq159LwX
         EKIlhHbxthBi3BNWt++ZMuuyVUc07ZfOcwlXLfHb9wxa2+bWed9kAEozU9giWP9mCQbl
         SFvSnU8yKpwGFmUaaMG5YFV5WtDs4Rzr1RVGQFVVFKiqD3+rn8Ypsp/tL+TC1kq5dtJD
         J6e6BrBVGZWbKeX95L3alFrx6ma6X6TUSK+5LrcC/66XGUFQ+2ux92g9ZbwTMRLL0Mws
         WeWA==
X-Gm-Message-State: AOJu0Yx/1ZF3ajAYDpIo/JYpyOsH5AGE3oRp8Wfbew/NvMWPpm4RPOcv
	aiPLHnzLKW4tNnDef0r5WlhGoA==
X-Google-Smtp-Source: AGHT+IGFtHc4qKqJVnN1XjVMkiinlk0jG07pQ1wbI9nowl9FuK5wiYNBs1I2uzxLrjyzw/P8FvB74A==
X-Received: by 2002:a05:6a00:1d8c:b0:6cb:ba8d:96a7 with SMTP id z12-20020a056a001d8c00b006cbba8d96a7mr4393242pfw.14.1700576710440;
        Tue, 21 Nov 2023 06:25:10 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:25:10 -0800 (PST)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: ubizjak@gmail.com,
	mark.rutland@arm.com,
	vgupta@kernel.org,
	bcain@quicinc.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	geert@linux-m68k.org,
	andi.shyti@linux.intel.com,
	mingo@kernel.org,
	palmer@rivosinc.com,
	andrzej.hajda@intel.com,
	arnd@arndb.de,
	peterz@infradead.org,
	mhiramat@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mattwu@163.com,
	linux@roeck-us.net,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 4/5] arch,locking/atomic: hexagon: add arch_cmpxchg[64]_local
Date: Tue, 21 Nov 2023 22:23:46 +0800
Message-Id: <20231121142347.241356-5-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hexagonc hasn't arch_cmpxhg_local implemented, which causes
building failures for any references of try_cmpxchg_local,
reported by the kernel test robot.

This patch implements arch_cmpxchg[64]_local with the native
cmpxchg variant if the corresponding data size is supported,
otherwise generci_cmpxchg[64]_local is to be used.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310272207.tLPflya4-lkp@intel.com/

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/hexagon/include/asm/cmpxchg.h | 51 +++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..302fa30f25aa 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_CMPXCHG_H
 #define _ASM_CMPXCHG_H
 
+#include <linux/build_bug.h>
+
 /*
  * __arch_xchg - atomically exchange a register and a memory location
  * @x: value to swap
@@ -51,13 +53,15 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
  *  variable casting.
  */
 
-#define arch_cmpxchg(ptr, old, new)				\
+#define __cmpxchg_32(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
 	__typeof__(*(ptr)) __new = (new);			\
 	__typeof__(*(ptr)) __oldval = 0;			\
 								\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);			\
+								\
 	asm volatile(						\
 		"1:	%0 = memw_locked(%1);\n"		\
 		"	{ P0 = cmp.eq(%0,%2);\n"		\
@@ -72,4 +76,49 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__oldval;						\
 })
 
+#define __cmpxchg(ptr, old, val, size)				\
+({								\
+	__typeof__(*(ptr)) oldval;				\
+								\
+	switch (size) {						\
+	case 4:							\
+		oldval = __cmpxchg_32(ptr, old, val);		\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+		oldval = val;					\
+		break;						\
+	}							\
+								\
+	oldval;							\
+})
+
+#define arch_cmpxchg(ptr, o, n)	__cmpxchg((ptr), (o), (n), sizeof(*(ptr)))
+
+/*
+ * always make arch_cmpxchg[64]_local available, native cmpxchg
+ * will be used if available, then generic_cmpxchg[64]_local
+ */
+#include <asm-generic/cmpxchg-local.h>
+
+#define arch_cmpxchg_local(ptr, old, val)			\
+({								\
+	__typeof__(*(ptr)) __retval;				\
+	int __size = sizeof(*(ptr));				\
+								\
+	switch (__size) {					\
+	case 4:							\
+		__retval = __cmpxchg_32(ptr, old, val);		\
+		break;						\
+	default:						\
+		__retval = __generic_cmpxchg_local(ptr, old,	\
+						val, __size);	\
+		break;						\
+	}							\
+								\
+	__retval;						\
+})
+
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+
 #endif /* _ASM_CMPXCHG_H */
-- 
2.40.1


