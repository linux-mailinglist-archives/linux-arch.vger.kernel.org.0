Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420981B2977
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDUO0c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 10:26:32 -0400
Received: from foss.arm.com ([217.140.110.172]:35992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbgDUO0c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:26:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1DE31B;
        Tue, 21 Apr 2020 07:26:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4DEE3F68F;
        Tue, 21 Apr 2020 07:26:29 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Kevin Brodsky <Kevin.Brodsky@arm.com>
Subject: [PATCH v3 11/23] mm: Introduce arch_calc_vm_flag_bits()
Date:   Tue, 21 Apr 2020 15:25:51 +0100
Message-Id: <20200421142603.3894-12-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142603.3894-1-catalin.marinas@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
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
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v2:
    - Updated the comment above arch_calc_vm_prot_bits().
    - Changed author since this patch had already been posted (internally).

 include/linux/mman.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c9c538..15c1162b9d65 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -74,13 +74,17 @@ static inline void vm_unacct_memory(long pages)
 }
 
 /*
- * Allow architectures to handle additional protection bits
+ * Allow architectures to handle additional protection and flag bits
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
@@ -131,7 +135,8 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
-	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
+	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       arch_calc_vm_flag_bits(flags);
 }
 
 unsigned long vm_commit_limit(void);
