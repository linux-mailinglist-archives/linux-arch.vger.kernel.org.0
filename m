Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206436D0F7C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjC3T42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjC3T4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 15:56:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF710260;
        Thu, 30 Mar 2023 12:56:19 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 6F570733;
        Thu, 30 Mar 2023 19:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6F570733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680206179; bh=ZWpDe74U3Fhl0J6lbM9YoaPnOlXMk5FAqeyqi/rrhfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdbVMMR83re5DCZYqWJmSJHGinC4Ye2YiwRzKlmgP6MI1VGGCS3FgXllTOgTD+52X
         6PXnOW4TtfW41/bdiyzza8jy2e5QTLMjh8PaJ3tCQC35MJkBJTtfnL8BybQnvap26h
         gNwDWxdItfOe+337INrmPPk2Z6eRVYVB1JtWutEfP99aBeLZp3m2wJJDGa9SsGy49Q
         o0pHjdV5UXqmGIEmicgpR7xRGhAOouEBiLFF8KCKOxqjJxKw5CDeDWy3wQKhVTdlQu
         lHSkB+aBa66jDwlhn0cb1nH/XZ5+3nJmHqX77pm2z3OKLF2WTT5e3EhZEspNQU/NQp
         N05+1J1J9hR8Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/4] docs: move ia64 architecture docs under Documentation/arch/
Date:   Thu, 30 Mar 2023 13:56:02 -0600
Message-Id: <20230330195604.269346-3-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330195604.269346-1-corbet@lwn.net>
References: <20230330195604.269346-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.  Move
Documentation/ia64 into arch/ and fix all in-tree references.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/{ => arch}/ia64/aliasing.rst   | 0
 Documentation/{ => arch}/ia64/efirtc.rst     | 0
 Documentation/{ => arch}/ia64/err_inject.rst | 0
 Documentation/{ => arch}/ia64/features.rst   | 0
 Documentation/{ => arch}/ia64/fsys.rst       | 0
 Documentation/{ => arch}/ia64/ia64.rst       | 0
 Documentation/{ => arch}/ia64/index.rst      | 0
 Documentation/{ => arch}/ia64/irq-redir.rst  | 0
 Documentation/{ => arch}/ia64/mca.rst        | 0
 Documentation/{ => arch}/ia64/serial.rst     | 0
 Documentation/arch/index.rst                 | 2 +-
 MAINTAINERS                                  | 2 +-
 arch/ia64/kernel/efi.c                       | 2 +-
 arch/ia64/kernel/fsys.S                      | 2 +-
 arch/ia64/mm/ioremap.c                       | 2 +-
 arch/ia64/pci/pci.c                          | 2 +-
 16 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/{ => arch}/ia64/aliasing.rst (100%)
 rename Documentation/{ => arch}/ia64/efirtc.rst (100%)
 rename Documentation/{ => arch}/ia64/err_inject.rst (100%)
 rename Documentation/{ => arch}/ia64/features.rst (100%)
 rename Documentation/{ => arch}/ia64/fsys.rst (100%)
 rename Documentation/{ => arch}/ia64/ia64.rst (100%)
 rename Documentation/{ => arch}/ia64/index.rst (100%)
 rename Documentation/{ => arch}/ia64/irq-redir.rst (100%)
 rename Documentation/{ => arch}/ia64/mca.rst (100%)
 rename Documentation/{ => arch}/ia64/serial.rst (100%)

diff --git a/Documentation/ia64/aliasing.rst b/Documentation/arch/ia64/aliasing.rst
similarity index 100%
rename from Documentation/ia64/aliasing.rst
rename to Documentation/arch/ia64/aliasing.rst
diff --git a/Documentation/ia64/efirtc.rst b/Documentation/arch/ia64/efirtc.rst
similarity index 100%
rename from Documentation/ia64/efirtc.rst
rename to Documentation/arch/ia64/efirtc.rst
diff --git a/Documentation/ia64/err_inject.rst b/Documentation/arch/ia64/err_inject.rst
similarity index 100%
rename from Documentation/ia64/err_inject.rst
rename to Documentation/arch/ia64/err_inject.rst
diff --git a/Documentation/ia64/features.rst b/Documentation/arch/ia64/features.rst
similarity index 100%
rename from Documentation/ia64/features.rst
rename to Documentation/arch/ia64/features.rst
diff --git a/Documentation/ia64/fsys.rst b/Documentation/arch/ia64/fsys.rst
similarity index 100%
rename from Documentation/ia64/fsys.rst
rename to Documentation/arch/ia64/fsys.rst
diff --git a/Documentation/ia64/ia64.rst b/Documentation/arch/ia64/ia64.rst
similarity index 100%
rename from Documentation/ia64/ia64.rst
rename to Documentation/arch/ia64/ia64.rst
diff --git a/Documentation/ia64/index.rst b/Documentation/arch/ia64/index.rst
similarity index 100%
rename from Documentation/ia64/index.rst
rename to Documentation/arch/ia64/index.rst
diff --git a/Documentation/ia64/irq-redir.rst b/Documentation/arch/ia64/irq-redir.rst
similarity index 100%
rename from Documentation/ia64/irq-redir.rst
rename to Documentation/arch/ia64/irq-redir.rst
diff --git a/Documentation/ia64/mca.rst b/Documentation/arch/ia64/mca.rst
similarity index 100%
rename from Documentation/ia64/mca.rst
rename to Documentation/arch/ia64/mca.rst
diff --git a/Documentation/ia64/serial.rst b/Documentation/arch/ia64/serial.rst
similarity index 100%
rename from Documentation/ia64/serial.rst
rename to Documentation/arch/ia64/serial.rst
diff --git a/Documentation/arch/index.rst b/Documentation/arch/index.rst
index 2aeff47a0014..77e287c3eeb9 100644
--- a/Documentation/arch/index.rst
+++ b/Documentation/arch/index.rst
@@ -12,7 +12,7 @@ implementation.
    arc/index
    ../arm/index
    ../arm64/index
-   ../ia64/index
+   ia64/index
    ../loongarch/index
    ../m68k/index
    ../mips/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 78ff43f63753..c515abc269f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9724,7 +9724,7 @@ F:	include/linux/i3c/
 IA64 (Itanium) PLATFORM
 L:	linux-ia64@vger.kernel.org
 S:	Orphan
-F:	Documentation/ia64/
+F:	Documentation/arch/ia64/
 F:	arch/ia64/
 
 IBM Operation Panel Input Driver
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 21dfa4aa35bb..033f5aead88a 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -853,7 +853,7 @@ valid_phys_addr_range (phys_addr_t phys_addr, unsigned long size)
 	 * /dev/mem reads and writes use copy_to_user(), which implicitly
 	 * uses a granule-sized kernel identity mapping.  It's really
 	 * only safe to do this for regions in kern_memmap.  For more
-	 * details, see Documentation/ia64/aliasing.rst.
+	 * details, see Documentation/arch/ia64/aliasing.rst.
 	 */
 	attr = kern_mem_attribute(phys_addr, size);
 	if (attr & EFI_MEMORY_WB || attr & EFI_MEMORY_UC)
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index 2094f3249019..cc4733e9990a 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -28,7 +28,7 @@
 #include <asm/native/inst.h>
 
 /*
- * See Documentation/ia64/fsys.rst for details on fsyscalls.
+ * See Documentation/arch/ia64/fsys.rst for details on fsyscalls.
  *
  * On entry to an fsyscall handler:
  *   r10	= 0 (i.e., defaults to "successful syscall return")
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..92b81bc91397 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -43,7 +43,7 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	/*
 	 * For things in kern_memmap, we must use the same attribute
 	 * as the rest of the kernel.  For more details, see
-	 * Documentation/ia64/aliasing.rst.
+	 * Documentation/arch/ia64/aliasing.rst.
 	 */
 	attr = kern_mem_attribute(phys_addr, size);
 	if (attr & EFI_MEMORY_WB)
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 211757e34198..0a0328e61bef 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -448,7 +448,7 @@ pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 		return -ENOSYS;
 
 	/*
-	 * Avoid attribute aliasing.  See Documentation/ia64/aliasing.rst
+	 * Avoid attribute aliasing.  See Documentation/arch/ia64/aliasing.rst
 	 * for more details.
 	 */
 	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
-- 
2.39.2

