Return-Path: <linux-arch+bounces-4680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C18FB9CF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AC82824A6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9007149C79;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfKUufhi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56C149C69;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520681; cv=none; b=BrprILRbzBW/+QeYczu/TzIGvXWAndGvTTsO3xHli2AhcpmjDp6v0EonDURRdv4nwj+5hOvxXtaC/HdyCKe7lnfMkNh4d1nSMWeyVGfKOz/JUzyPi6DE5l+IQyyRIDO5ox/XtC02iIe7jyx8YDrxG2Hq1oCk8NNeU7PPOzowSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520681; c=relaxed/simple;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNSmkvqog4i2ETofYD4mQTixpRjx+GqCfYZ6U3tRGAsQDA0ri04bNYyMubjwf17a2VFC01BjIX28tQdmKCl8btPFQuKVPd2E/jdh4KZUeezc/jItmWXWZ08TFRaOlfcfVQuvGKZUUhUG+v4b6ox1M1KQGgybIiHhRiR8/0zTaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfKUufhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69273C4AF0D;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520681;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfKUufhihelxky1Xwi2kwpbTuct2AOpwGA45g3lf3ZkFteqZwyHM80zBFEtCjHLVu
	 F8arywo58nGGrzvjXi5LmYsJSgGky84+emU3ZWWeOtd5CAfan355yNTGVTj+MZp9CH
	 +zJbtfcKjCPWB7wkmhNanJGMBy0TMMCiWIecVwdMQ9NKMHPvssPiWEWc1tmq80UGB8
	 oBLttlxdYLIkAK9T06/wJaevO1tCyWfKh2atjudmX6j+XWlRHStXeq2HbcPDnr4qRy
	 c4rx9SqCfJEfXV+oiKbK0tM6oh2xK4WF3nl4wrmReBZnDnio088/fW0urCs3nf7Bq3
	 CmDcv19v4Wpww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05254CE3F26; Tue,  4 Jun 2024 10:04:41 -0700 (PDT)
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
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 cmpxchg 3/4] xtensa: Emulate one-byte cmpxchg
Date: Tue,  4 Jun 2024 10:04:36 -0700
Message-Id: <20240604170437.2362545-3-paulmck@kernel.org>
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

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
[ Apply Geert Uytterhoeven feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
 arch/xtensa/Kconfig               | 1 +
 arch/xtensa/include/asm/cmpxchg.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f200a4ec044e6..d3db28f2f8110 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,6 +14,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de76..95e33a913962d 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -15,6 +15,7 @@
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
+#include <linux/cmpxchg-emu.h>
 
 /*
  * cmpxchg
@@ -74,6 +75,7 @@ static __inline__ unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
+	case 1:  return cmpxchg_emu_u8(ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
-- 
2.40.1


