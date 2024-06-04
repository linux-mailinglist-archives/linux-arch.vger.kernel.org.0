Return-Path: <linux-arch+bounces-4679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B388FB9CD
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A421C24571
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74FF149C6F;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNF05O/z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AF149C62;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520681; cv=none; b=uN2CT/nkV617qa+b4UMQFgvs/74EEKXbmgqdjpTWwLElgkEK13QcMz54+04bc1VcAHar+7TEGeQkuyghg8rcPkwbQvkbXYO+SMqC3QYBCshDJTk0E7uvMxaxk5WlIzGyVo9+Bxrkrlj5k2mmeXl8XO5dO5wiDig3Ls3jlilPsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520681; c=relaxed/simple;
	bh=m6rqAOBQ64nAVbwfoMwra9NFlfK4T5G41qjNyF62BxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKGwDRcUmhCNocGgcxI1pUEtT9ltzuVIJH8yP7s5BHh17zYl+9A2Ks3+92/J+DxUYxjPoapSkE4ERhC9VUzRB9n6mEaNhXp6FxoWd/BE1vg3m4Fj7czqKiu72IV4+fYZwbKYF9IZrd09OYwj8+JJeVKqDiJfv7CKuYmz+f0PsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNF05O/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C318C2BBFC;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520681;
	bh=m6rqAOBQ64nAVbwfoMwra9NFlfK4T5G41qjNyF62BxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNF05O/z83KdgySpuamBtdJNQPd+6KMd8DXn+woZXtYeUdCI1eSQfGWa6KtuuXFmR
	 MteA50UrqjFRjOjHRs/udBUOaJWKJe0HyRtAwUJgDy8V6V7k/GVcnEjUbX2MMmS/mK
	 P+lpopMYf4HzqNyqG1TKE6SyW1bm1zrwdUPGYZSPh9/ueugXY2d3O8MQphL6kohvDp
	 Qodja9iSGJwXRX+ySo0tt7Q1/2EOIm8z+DEO7fEMgFbUSH52SBB47s0hmw7B/Gk84Q
	 zzGFnjfhHlwGcq1Pny93N1jAVngBGUrVq4eXMBrbCCMihe9FGaegY6MEzlXhVHxyis
	 prjhj0VWrTClA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F3F2DCE3F09; Tue,  4 Jun 2024 10:04:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH v3 cmpxchg 1/4] ARC: Emulate one-byte cmpxchg
Date: Tue,  4 Jun 2024 10:04:34 -0700
Message-Id: <20240604170437.2362545-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.

[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
[ paulmck: Apply feedback from Naresh Kamboju. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: <linux-snps-arc@lists.infradead.org>
---
 arch/arc/Kconfig               |  1 +
 arch/arc/include/asm/cmpxchg.h | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index fd0b0a0d4686a..163608fd49d18 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,6 +13,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067dea..2102ce076f28b 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #include <asm/barrier.h>
 #include <asm/smp.h>
@@ -46,6 +47,9 @@
 	__typeof__(*(ptr)) _prev_;					\
 									\
 	switch(sizeof((_p_))) {						\
+	case 1:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
@@ -65,16 +69,27 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
+	switch(sizeof((_p_))) {						\
+	case 1:								\
+		__flags = cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))__flags;			\
+		break;							\
+		break;							\
+	case 4:								\
+		/*							\
+		 * spin lock/unlock provide the needed smp_mb()		\
+		 * before/after						\
+		 */							\
+		atomic_ops_lock(__flags);				\
+		_prev_ = *_p_;						\
+		if (_prev_ == _o_)					\
+			*_p_ = _n_;					\
+		atomic_ops_unlock(__flags);				\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
 									\
-	/*								\
-	 * spin lock/unlock provide the needed smp_mb() before/after	\
-	 */								\
-	atomic_ops_lock(__flags);					\
-	_prev_ = *_p_;							\
-	if (_prev_ == _o_)						\
-		*_p_ = _n_;						\
-	atomic_ops_unlock(__flags);					\
 	_prev_;								\
 })
 
-- 
2.40.1


