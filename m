Return-Path: <linux-arch+bounces-3495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E3689CB09
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3028B289C4
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691CA1448E0;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy8cbsHj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F114430D;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=bag+Ny48dNbKq5+zwYPwZ1D9S8bB7tL/vYtV34L1RdbsN24p8BiPGkI77F1KKhudtu7B9JcZ7AeTPSx354ysBOwjCRq/5hQM0mXTtJLOQxXfRgHYSEpjIRfTvDXDxbbjZ8AuNLeCXRkslHhFOQyptJ3at5ewH21iT/BLJKJiaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=tfMsSeoEnAanJOvsNUK1ZSGwuyHwUMHJZxMmkLFM9oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLG8OP9znCSa5Goao/gOZWYveJEFF0FtIm0AjeGx56ZGaksJoSU0r1tOwZPztmPj5qLJVYNLX2tq1RwkSarZrktK+0/XuJVyx8VnmEZiHxKUFdESPThGNOla/tupvkwljy4d8kVOneGOuw93W94FMLFQoebpiGeWOsyjv5DDV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy8cbsHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12396C4166B;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=tfMsSeoEnAanJOvsNUK1ZSGwuyHwUMHJZxMmkLFM9oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fy8cbsHj41PBvy142ggT5VF4bjQpqQj5tVH6mMSOeBiI2gWJSNxGwfIrWI5dgXs45
	 8H+qV+/sPsvmH2wG5HAI26Xrsz8vHSMDr+6ahlihXdJbd8VOe0fcsHzFFra/eMs7S2
	 wTfHCDyLbT8x6oo//Wy9DTDKgKwPq3LysoiJs8TQ7qw+l2xmPXciuiq/UUzdSKfcod
	 5josUU5CMZy+Al/Tz2qZVrW7p/Mle95lxAwRcPOvlIbjSO0t8reXFUbwYJzDQOR0k1
	 l/uFbi6BvFPyCRxBgF/O9AILZGqmKaCtvyb6FrmC8fTV7BmUs6SAEitXued40oo2gf
	 VAaoRDF/lE/0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54D52CE2CD2; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH cmpxchg 10/14] ARC: Emulate one-byte cmpxchg
Date: Mon,  8 Apr 2024 10:49:40 -0700
Message-Id: <20240408174944.907695-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.

[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-snps-arc@lists.infradead.org>
---
 arch/arc/Kconfig               |  1 +
 arch/arc/include/asm/cmpxchg.h | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 99d2845f3feb9..5bf6137f0fd47 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -14,6 +14,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067dea..c3833e18389f4 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -46,6 +46,9 @@
 	__typeof__(*(ptr)) _prev_;					\
 									\
 	switch(sizeof((_p_))) {						\
+	case 1:								\
+		_prev_ = cmpxchg_emu_u8((volatile u8 *)_p_, _o_, _n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
@@ -65,16 +68,27 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
+	switch(sizeof((_p_))) {						\
+	case 1:								\
+		__flags = cmpxchg_emu_u8((volatile u8 *)_p_, _o_, _n_);	\
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


