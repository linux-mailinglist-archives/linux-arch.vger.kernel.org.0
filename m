Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66C4170702
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 19:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgBZSF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 13:05:58 -0500
Received: from foss.arm.com ([217.140.110.172]:40214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgBZSF6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D0394B2;
        Wed, 26 Feb 2020 10:05:58 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A721E3F881;
        Wed, 26 Feb 2020 10:05:56 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 13/19] mm: Introduce arch_validate_flags()
Date:   Wed, 26 Feb 2020 18:05:20 +0000
Message-Id: <20200226180526.3272848-14-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
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
---

Notes:
    v2:
    - Some comments updated.

 include/linux/mman.h | 13 +++++++++++++
 mm/mmap.c            |  9 +++++++++
 mm/mprotect.c        |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 15c1162b9d65..09dd414b81b6 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -103,6 +103,19 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
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
index 6756b8bb0033..e52e433849c3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1794,6 +1794,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
index 7a8e84f86831..1c760058ace3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -543,6 +543,12 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
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
