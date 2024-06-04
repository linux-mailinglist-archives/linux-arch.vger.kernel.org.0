Return-Path: <linux-arch+bounces-4681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B08FB9CE
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5B282753
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF6149C77;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdcZuACD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F3149C65;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520681; cv=none; b=HKcfgItt/pYiOu2OvgWzmr8lETuFX6zBDop+CEgg9dvJ3nGt+KSUxaqNaeBS0LV9QHEVA/pCg4XAa1w1/iU2OST9TyUn8yxXaR/OfHROOmXzb8JBHAZC4OnpedzKTH1zUBSfl2SzQdrsh4nSEtolBtBHJ3ix3S0dGOcsoKLNwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520681; c=relaxed/simple;
	bh=rrXhYcuvAzSeNxJsE5K8KoOIiHuhtq2k88GjikEXdAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtL2SIIBCXYQdSe2lzeoKbfh/OJQu+hnjajlgEbjXgygP7ClFDL5G3yKZttNIJzaycdHEZSHaRKqEovXMmQvV4Ue/bUu83Uk/3Kjv7lOlfEv3k2H8x4zqsOnvkL7w27/QQ3+x7aCkLdkdiwYrQcrDlkxq5JocqcNDZgMQAhtjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdcZuACD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700D4C4AF10;
	Tue,  4 Jun 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520681;
	bh=rrXhYcuvAzSeNxJsE5K8KoOIiHuhtq2k88GjikEXdAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdcZuACD7jFzew8Y495MNxaKHldbX2iP8xvNHsI8eKkW0G2YxjlzAgxLkPd7oKKM1
	 FtjqK+2bGHncEj0v81ifGJ0r1L7ZaeN3jgpnYbPsQtUaR2olHVTXo6GYHoyQlp7GNg
	 lrr00++8r7myhmm/i00hZZpUcCfL4Ownla+JxAO/Q4d0olbXWR0MP4nHS0YB9gJvE3
	 XePnoEf9Z/MPRz+i2o9/b5sLuE2MhaK9dkUcTM6fzv4abfZ5I+ocQY7i8OBhKvyNKK
	 5FnRl9DLBNMAlJLeTa/Bb+tRy8NAPr0DOV2trLtmxlMSAmfDNMo4z+dhOpLwS8qpzq
	 d6nFjU1Iobj6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 08360CE3F27; Tue,  4 Jun 2024 10:04:41 -0700 (PDT)
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
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 cmpxchg 4/4] ARM: Emulate one-byte cmpxchg
Date: Tue,  4 Jun 2024 10:04:37 -0700
Message-Id: <20240604170437.2362545-4-paulmck@kernel.org>
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

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on ARM systems
with ARCH < ARMv6K.

[ paulmck: Apply Arnd Bergmann and Nathan Chancellor feedback. ]

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/54798f68-48f7-4c65-9cba-47c0bf175143@sirena.org.uk/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYuZ+pf6p8AXMZWtdFtX-gbG8HMaBKp=XbxcdzA_QeLkxQ@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Davis <afd@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Rob Herring <robh@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/include/asm/cmpxchg.h | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac4..a867a7d967aa5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -34,6 +34,7 @@ config ARM
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
+	select ARCH_NEED_CMPXCHG_1_EMU if CPU_V6
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 44667bdb4707a..a428e06fe94ee 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -5,6 +5,7 @@
 #include <linux/irqflags.h>
 #include <linux/prefetch.h>
 #include <asm/barrier.h>
+#include <linux/cmpxchg-emu.h>
 
 #if defined(CONFIG_CPU_SA1100) || defined(CONFIG_CPU_SA110)
 /*
@@ -162,7 +163,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	prefetchw((const void *)ptr);
 
 	switch (size) {
-#ifndef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
+#ifdef CONFIG_CPU_V6	/* min ARCH < ARMv6K */
+	case 1:
+		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
+		break;
+#else /* min ARCH >= ARMv6K */
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
-- 
2.40.1


