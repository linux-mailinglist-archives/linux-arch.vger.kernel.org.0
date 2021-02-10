Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C824A316ED9
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhBJSgt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 13:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234173AbhBJSen (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 13:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612981995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U/kEUdiVTFSkXdDlFfnN0pNfEfW0SscYP5LvJr9uMD4=;
        b=R/tfgvZuQ4G37CYzZET2pIZtBvkJ7VLpKg3kEmvqYnS/ufIiuF3FsT5YF+k30ItpFVlbsl
        0AQ4qKgsb3CtXkE0NsYkFwCtfo+dcHNzGrNCgOp8v17Xx6NG92GbgGCxSyhcrd0T0+WzdS
        Jsl4DSnCKHyWdMaAUWTdAcS6IeszSnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-7FXvma-PPKic8Esl0H0dDw-1; Wed, 10 Feb 2021 13:33:10 -0500
X-MC-Unique: 7FXvma-PPKic8Esl0H0dDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7678801977;
        Wed, 10 Feb 2021 18:33:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 066025C1BD;
        Wed, 10 Feb 2021 18:33:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Waiman Long <longman@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-mips@vger.kernel.org (open list:MIPS),
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)),
        linux-xtensa@linux-xtensa.org (open list:TENSILICA XTENSA PORT (xtensa)),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-csky@vger.kernel.org (open list:C-SKY ARCHITECTURE)
Subject: [PATCH] locking/arch: Move qrwlock.h include after qspinlock.h
Date:   Wed, 10 Feb 2021 13:33:01 -0500
Message-Id: <20210210183301.453422-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

include/asm-generic/qrwlock.h was trying to get arch_spin_is_locked via
asm-generic/qspinlock.h.  However, this does not work because architectures
might be using queued rwlocks but not queued spinlocks (csky), or because they
might be defining their own queued_* macros before including asm/qspinlock.h.

To fix this, ensure that asm/spinlock.h always includes qrwlock.h after
defining arch_spin_is_locked (either directly for csky, or via
asm/qspinlock.h for other architectures).  The only inclusion elsewhere
is in kernel/locking/qrwlock.c.  That one is really unnecessary because
the file is only compiled in SMP configurations (config QUEUED_RWLOCKS
depends on SMP) and in that case linux/spinlock.h already includes
asm/qrwlock.h if needed, via asm/spinlock.h.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Waiman Long <longman@redhat.com>
Fixes: 26128cb6c7e6 ("locking/rwlocks: Add contention detection for rwlocks")
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v1->v2: Fix sparc too.  Add a comment in qrwlock.h itself.
	Remove unnecessary inclusion in kernel/locking/qrwlock.c

 arch/arm64/include/asm/spinlock.h    | 2 +-
 arch/mips/include/asm/spinlock.h     | 2 +-
 arch/sparc/include/asm/spinlock_64.h | 2 +-
 arch/xtensa/include/asm/spinlock.h   | 2 +-
 include/asm-generic/qrwlock.h        | 3 ++-
 kernel/locking/qrwlock.c             | 1 -
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 9083d6992603..0525c0b089ed 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -5,8 +5,8 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
-#include <asm/qrwlock.h>
 #include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
index 8a88eb265516..6ce2117e49f6 100644
--- a/arch/mips/include/asm/spinlock.h
+++ b/arch/mips/include/asm/spinlock.h
@@ -10,7 +10,6 @@
 #define _ASM_SPINLOCK_H
 
 #include <asm/processor.h>
-#include <asm/qrwlock.h>
 
 #include <asm-generic/qspinlock_types.h>
 
@@ -27,5 +26,6 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
 }
 
 #include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
 
 #endif /* _ASM_SPINLOCK_H */
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
index 7fc82a233f49..3a9a0b0c7465 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -11,8 +11,8 @@
 
 #include <asm/processor.h>
 #include <asm/barrier.h>
-#include <asm/qrwlock.h>
 #include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
 
 #endif /* !(__ASSEMBLY__) */
 
diff --git a/arch/xtensa/include/asm/spinlock.h b/arch/xtensa/include/asm/spinlock.h
index 584b0de6f2ca..41c449ece2d8 100644
--- a/arch/xtensa/include/asm/spinlock.h
+++ b/arch/xtensa/include/asm/spinlock.h
@@ -12,8 +12,8 @@
 #define _XTENSA_SPINLOCK_H
 
 #include <asm/barrier.h>
-#include <asm/qrwlock.h>
 #include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
 
 #define smp_mb__after_spinlock()	smp_mb()
 
diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 0020d3b820a7..7ae0ece07b4e 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -14,7 +14,8 @@
 #include <asm/processor.h>
 
 #include <asm-generic/qrwlock_types.h>
-#include <asm-generic/qspinlock.h>
+
+/* Must be included from asm/spinlock.h after defining arch_spin_is_locked.  */
 
 /*
  * Writer states & reader shift and bias.
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index fe9ca92faa2a..4786dd271b45 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -12,7 +12,6 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/spinlock.h>
-#include <asm/qrwlock.h>
 
 /**
  * queued_read_lock_slowpath - acquire read lock of a queue rwlock
-- 
2.26.2

