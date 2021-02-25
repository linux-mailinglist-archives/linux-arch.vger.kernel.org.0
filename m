Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26863324BC2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 09:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhBYIIi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 03:08:38 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40263 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhBYII1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 03:08:27 -0500
X-Originating-IP: 81.185.161.35
Received: from localhost.localdomain (35.161.185.81.rev.sfr.net [81.185.161.35])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8DAD41C0006;
        Thu, 25 Feb 2021 08:07:26 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 2/3] Documentation: riscv: Add documentation that describes the VM layout
Date:   Thu, 25 Feb 2021 03:04:52 -0500
Message-Id: <20210225080453.1314-3-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210225080453.1314-1-alex@ghiti.fr>
References: <20210225080453.1314-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This new document presents the RISC-V virtual memory layout and is based
one the x86 one: it describes the different limits of the different regions
of the virtual address space.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 Documentation/riscv/index.rst     |  1 +
 Documentation/riscv/vm-layout.rst | 61 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/riscv/vm-layout.rst

diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index 6e6e39482502..ea915c196048 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -6,6 +6,7 @@ RISC-V architecture
     :maxdepth: 1
 
     boot-image-header
+    vm-layout
     pmu
     patch-acceptance
 
diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
new file mode 100644
index 000000000000..e8e569e2686a
--- /dev/null
+++ b/Documentation/riscv/vm-layout.rst
@@ -0,0 +1,61 @@
+=====================================
+Virtual Memory Layout on RISC-V Linux
+=====================================
+
+:Author: Alexandre Ghiti <alex@ghiti.fr>
+:Date: 12 February 2021
+
+This document describes the virtual memory layout used by the RISC-V Linux
+Kernel.
+
+RISC-V Linux Kernel 32bit
+=========================
+
+RISC-V Linux Kernel SV32
+------------------------
+
+TODO
+
+RISC-V Linux Kernel 64bit
+=========================
+
+The RISC-V privileged architecture document states that the 64bit addresses
+"must have bits 63–48 all equal to bit 47, or else a page-fault exception will
+occur.": that splits the virtual address space into 2 halves separated by a very
+big hole, the lower half is where the userspace resides, the upper half is where
+the RISC-V Linux Kernel resides.
+
+RISC-V Linux Kernel SV39
+------------------------
+
+::
+
+  ========================================================================================================================
+      Start addr    |   Offset   |     End addr     |  Size   | VM area description
+  ========================================================================================================================
+                    |            |                  |         |
+   0000000000000000 |    0       | 0000003fffffffff |  256 GB | user-space virtual memory, different per mm
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   0000004000000000 | +256    GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -256 GB
+                    |            |                  |         |     starting offset of kernel mappings.
+  __________________|____________|__________________|_________|___________________________________________________________
+                                                              |
+                                                              | Kernel-space virtual memory, shared between all processes:
+  ____________________________________________________________|___________________________________________________________
+                    |            |                  |         |
+   ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
+   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
+   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
+   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
+   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB | vmalloc/ioremap space
+   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB | direct mapping of all physical memory
+  __________________|____________|__________________|_________|____________________________________________________________
+                                                              |
+                                                              |
+  ____________________________________________________________|____________________________________________________________
+                    |            |                  |         |
+   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules
+   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel, BPF
+  __________________|____________|__________________|_________|____________________________________________________________
-- 
2.20.1

