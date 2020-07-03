Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88278213CC4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGCPhw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 11:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 11:37:52 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EECA21534;
        Fri,  3 Jul 2020 15:37:49 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>
Subject: [PATCH v6 12/26] mm: Introduce arch_calc_vm_flag_bits()
Date:   Fri,  3 Jul 2020 16:37:04 +0100
Message-Id: <20200703153718.16973-13-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703153718.16973-1-catalin.marinas@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kevin Brodsky <Kevin.Brodsky@arm.com>

Similarly to arch_calc_vm_prot_bits(), introduce a dummy
arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
can be overridden by architectures to insert specific VM_* flags derived
from the mmap() MAP_* flags.

Signed-off-by: Kevin Brodsky <Kevin.Brodsky@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    v6:
    - Added comment on where the arch code should define overriding arch_*
      macros (asm/mman.h).
    
    v2:
    - Updated the comment above arch_calc_vm_prot_bits().
    - Changed author since this patch had already been posted (internally).

 include/linux/mman.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c9c538..9ea3f95faa90 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -74,13 +74,18 @@ static inline void vm_unacct_memory(long pages)
 }
 
 /*
- * Allow architectures to handle additional protection bits
+ * Allow architectures to handle additional protection and flag bits. The
+ * overriding macros must be defined in the arch-specific asm/mman.h file.
  */
 
 #ifndef arch_calc_vm_prot_bits
 #define arch_calc_vm_prot_bits(prot, pkey) 0
 #endif
 
+#ifndef arch_calc_vm_flag_bits
+#define arch_calc_vm_flag_bits(flags) 0
+#endif
+
 #ifndef arch_vm_get_page_prot
 #define arch_vm_get_page_prot(vm_flags) __pgprot(0)
 #endif
@@ -131,7 +136,8 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
-	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
+	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       arch_calc_vm_flag_bits(flags);
 }
 
 unsigned long vm_commit_limit(void);
