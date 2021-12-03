Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1521A46731C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 09:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379126AbhLCIMC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 03:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351103AbhLCIMB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 03:12:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072EC06173E;
        Fri,  3 Dec 2021 00:08:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B45AF62963;
        Fri,  3 Dec 2021 08:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C601EC53FC7;
        Fri,  3 Dec 2021 08:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638518917;
        bh=KxH7ZGxVJfrcf6JYVcVHtDcyryoNErHSgyXmxhiT11I=;
        h=From:To:Cc:Subject:Date:From;
        b=MM898awN9WfEXhnii4ChAHzhExx0NwP6S7X/fowg1zrBLgziKiv7K2aD+Zr+zJF1I
         zfjWXTsOQ8/UBbdibW6PV0Q9dklH2IcWgHzRAAl4I9302qbCj+qO7e4G8wLy/ndeQd
         Ht/8JbdQMDYn2ftCsGZ8asGmKeBAlC/Y0+gyr12A02k010jd5YkyLxBt/04HwjuQZq
         r2oH42a3lBuZR6LrbCPexQPX/gEr+09oehLCuxC4Q3Th5nrfmv8o7/latrhqak28oV
         671QzCH/v+KWjKg2O278qIYQU+Wke88Ur/MpXcwxrbWg11RxVH3skXf4shpXYlxIvy
         FuRBk9avNtuSw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] futex: Fix additional regressions
Date:   Fri,  3 Dec 2021 09:07:56 +0100
Message-Id: <20211203080823.2938839-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Naresh reported another architecture that was broken by the same typo
that I already fixed for three architectures: mips also refers to the
futex_atomic_op_inuser_local() function by the wrong name and runs into
a missing closing '}' as well.

Going through the source tree I found that I also had the same typo in the
documentation as well as the xtensa code, both of which ended up escaping
the regression testing so far. In the case of xtensa, it appears that
the broken code path is only used when building for platforms that are
not supported by the default gcc configuration, so they are impossible
to test for with my setup.

After going through these more carefully and fixing up the typos, I
build-tested all architectures again to ensure I'm not introducing a
new regression or missing one more obvious issue with my series.

Fixes: 4e0d84634445 ("futex: Fix sparc32/m68k/nds32 build regression")
Fixes: 3f2bedabb62c ("futex: Ensure futex_atomic_cmpxchg_inatomic() is present")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-mips@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/futex.h   | 6 +++---
 arch/xtensa/include/asm/futex.h | 2 +-
 include/asm-generic/futex.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 9287110cb06d..8612a7e42d78 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -86,9 +86,9 @@
 		: "memory");						\
 	} else {							\
 		/* fallback for non-SMP */				\
-		ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\
-							uaddr);	\
-	}
+		ret = futex_atomic_op_inuser_local(op, oparg, oval, uaddr);	\
+	}								\
+}
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index fe8f31575ab1..a6f7d7ab5950 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -109,7 +109,7 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 
 	return ret;
 #else
-	return arch_futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
+	return futex_atomic_op_inuser_local(op, oparg, oval, uaddr);
 #endif
 }
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 66d6843bfd02..2a19215baae5 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -21,7 +21,7 @@
 #endif
 
 /**
- * arch_futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
+ * futex_atomic_op_inuser_local() - Atomic arithmetic operation with constant
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
-- 
2.29.2

