Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F08222169
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGPL2X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 07:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgGPL2X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 07:28:23 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6974D2074B;
        Thu, 16 Jul 2020 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594898902;
        bh=NmaDjWnidDv8ZRl7yVZMR6adac4yMJAr86FhFbJ4wqw=;
        h=From:To:Cc:Subject:Date:From;
        b=E7LA0cA68QUICdVkFR1WtGBQxmBEKl/7pjFJVXYq78eoCcVFDwuDOWctHUPqsrO9k
         M3F9msSMFT3XlzLiQZOAlxz38jGOsygpzQ6mMxhxNbmasPSdZlUrvvdATSE33/YVW+
         0qP55FUKJl9CQW+lF0gcLh0jQJaMhnQqNguCR1/c=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
Date:   Thu, 16 Jul 2020 12:28:16 +0100
Message-Id: <20200716112816.7356-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Although mmiowb() is concerned only with serialising MMIO writes occuring
in contexts where a spinlock is held, the call to mmiowb_set_pending()
from the MMIO write accessors can occur in preemptible contexts, such
as during driver probe() functions where ordering between CPUs is not
usually a concern, assuming that the task migration path provides the
necessary ordering guarantees.

Unfortunately, the default implementation of mmiowb_set_pending() is not
preempt-safe, as it makes use of a a per-cpu variable to track its
internal state. This has been reported to generate the following splat
on riscv:

 | BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
 | caller is regmap_mmio_write32le+0x1c/0x46
 | CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
 | Call Trace:
 |  walk_stackframe+0x0/0x7a
 |  dump_stack+0x6e/0x88
 |  regmap_mmio_write32le+0x18/0x46
 |  check_preemption_disabled+0xa4/0xaa
 |  regmap_mmio_write32le+0x18/0x46
 |  regmap_mmio_write+0x26/0x44
 |  regmap_write+0x28/0x48
 |  sifive_gpio_probe+0xc0/0x1da

Although it's possible to fix the driver in this case, other splats have
been seen from other drivers, including the infamous 8250 UART, and so
it's better to address this problem in the mmiowb core itself.

Fix mmiowb_set_pending() by using the raw_cpu_ptr() to get at the mmiowb
state and then only updating the 'mmiowb_pending' field if we are not
preemptible (i.e. we have a non-zero nesting count).

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

I can queue this in the arm64 tree as a fix, as I already have some other
fixes targetting -rc6.

 include/asm-generic/mmiowb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
index 9439ff037b2d..5698fca3bf56 100644
--- a/include/asm-generic/mmiowb.h
+++ b/include/asm-generic/mmiowb.h
@@ -27,7 +27,7 @@
 #include <asm/smp.h>
 
 DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
-#define __mmiowb_state()	this_cpu_ptr(&__mmiowb_state)
+#define __mmiowb_state()	raw_cpu_ptr(&__mmiowb_state)
 #else
 #define __mmiowb_state()	arch_mmiowb_state()
 #endif	/* arch_mmiowb_state */
@@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
 static inline void mmiowb_set_pending(void)
 {
 	struct mmiowb_state *ms = __mmiowb_state();
-	ms->mmiowb_pending = ms->nesting_count;
+
+	if (likely(ms->nesting_count))
+		ms->mmiowb_pending = ms->nesting_count;
 }
 
 static inline void mmiowb_spin_lock(void)
-- 
2.27.0.389.gc38d7665816-goog

