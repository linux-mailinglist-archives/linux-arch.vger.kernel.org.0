Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272C125D642
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgIDKbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgIDKbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:21 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C83208C7;
        Fri,  4 Sep 2020 10:31:09 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 16/29] arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
Date:   Fri,  4 Sep 2020 11:30:16 +0100
Message-Id: <20200904103029.32083-17-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make use of the newly introduced arch_validate_flags() hook to
sanity-check the PROT_MTE request passed to mmap() and mprotect(). If
the mapping does not support MTE, these syscalls will return -EINVAL.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index b01051be7750..e3e28f7daf62 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -49,8 +49,10 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
 	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
 	 * mmap() call since mprotect() does not accept MAP_* flags.
+	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
+	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
 	 */
-	if ((vm_flags & VM_MTE) && (vm_flags & VM_MTE_ALLOWED))
+	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
 	return __pgprot(prot);
@@ -72,4 +74,14 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
+static inline bool arch_validate_flags(unsigned long vm_flags)
+{
+	if (!system_supports_mte())
+		return true;
+
+	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
+	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
+}
+#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+
 #endif /* ! __ASM_MMAN_H__ */
