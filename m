Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D545250787
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHXS2h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHXS2f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:35 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D098206BE;
        Mon, 24 Aug 2020 18:28:33 +0000 (UTC)
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
Subject: [PATCH v8 14/28] mm: Introduce arch_validate_flags()
Date:   Mon, 24 Aug 2020 19:27:44 +0100
Message-Id: <20200824182758.27267-15-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to arch_validate_prot() called from do_mprotect_pkey(), an
architecture may need to sanity-check the new vm_flags.

Define a dummy function always returning true. In addition to
do_mprotect_pkey(), also invoke it from mmap_region() prior to updating
vma->vm_page_prot to allow the architecture code to veto potentially
inconsistent vm_flags.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    v2:
    - Some comments updated.

 include/linux/mman.h | 13 +++++++++++++
 mm/mmap.c            |  9 +++++++++
 mm/mprotect.c        |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 6fa15c9b12af..629cefc4ecba 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -108,6 +108,19 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 #define arch_validate_prot arch_validate_prot
 #endif
 
+#ifndef arch_validate_flags
+/*
+ * This is called from mmap() and mprotect() with the updated vma->vm_flags.
+ *
+ * Returns true if the VM_* flags are valid.
+ */
+static inline bool arch_validate_flags(unsigned long flags)
+{
+	return true;
+}
+#define arch_validate_flags arch_validate_flags
+#endif
+
 /*
  * Optimisation macro.  It is equivalent to:
  *      (x & bit1) ? bit2 : 0
diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..eed30b096667 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1812,6 +1812,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error = -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..56c02beb6041 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -603,6 +603,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			goto out;
 		}
 
+		/* Allow architectures to sanity-check the new flags */
+		if (!arch_validate_flags(newflags)) {
+			error = -EINVAL;
+			goto out;
+		}
+
 		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
 			goto out;
