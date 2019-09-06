Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72334AC128
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 22:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391224AbfIFUBR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 16:01:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46174 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390981AbfIFUBR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 16:01:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id v11so8468580qto.13
        for <linux-arch@vger.kernel.org>; Fri, 06 Sep 2019 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XZg1AAkAQ3fXHA3yMI/fVv8b1scLlUoErbv2jydnHF0=;
        b=KarCypdbxHFg4D7ey/gZUnTb0EZNg7So6Lb194+ZAqwHgNt/6am9DAusFJNYw/oIUV
         W4IuvyMlguvZ0sDmlwLVK7x2UQX4pPrWLY2OjLKuRmBwom48z4Mn6JF/EwBZmWb88+lR
         qG3+xUdqDS7gF3pAXooFiVIca42lQ1ZBoeW3VS+8ba6h/nQetemyjqc0URio69HcU9ks
         +S52SEfh77jeI8RnMGit0O+YIzn9bQw1+KhIcK+T55fTJgM7yYucxjdk8NqnBripdy/3
         KEK45jw4NqzlO0/QX/Sy5t2NREzBKqvHNpL50kflus8wliNOXpbVvb1hXC6y+tdTvJrg
         O5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XZg1AAkAQ3fXHA3yMI/fVv8b1scLlUoErbv2jydnHF0=;
        b=t8spD2BbYvog8q/qz88WYmzbqJt9UMk1TggxzXVv3SKanMPE2Rr8ngv0uYGSAb+uPl
         HrnILX/CfnVIXEUAmbNmJ/cZOtxhSLuiK1ywocGLNUaq1AOuKXJBcs65l6Aaui649EOX
         H4Tiy2E5OUxY897SiDmkmBQ92/NkKbMStZtwqdcZOUZx8mcKPhP8RvTF/PNVkAzirREp
         /OKXvb6P/jtSs6cJnRvkv5PlMX+UYeY5Pvq4CJoSN9Qv1Tj7lV4iuIlctWOiwAM7Z2G6
         LbUMLK0bg5ZOwtJx8mVTVowyVR3Zr6nqkXdViAbzGLJMhaPUqCmZXJj6uv7fj/w85rN1
         Krjg==
X-Gm-Message-State: APjAAAXqFPGf6uQe/H+tgYiduMNeiMqgklNqFo6qCjheyXJJsGC8+rkO
        F4Y/l+f5cnKuhx5igw/0P+KLCA==
X-Google-Smtp-Source: APXvYqyAiyjvLcIHi9T1V0CgWAtxTzIeILZ4tYXpY7syCNFoM/o6mdeCaLs9QYnSdlVOPXj2yMsDPg==
X-Received: by 2002:ac8:7558:: with SMTP id b24mr11010769qtr.260.1567800075930;
        Fri, 06 Sep 2019 13:01:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x2sm2740340qkf.83.2019.09.06.13.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:01:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@kernel.org, mpe@ellerman.id.au
Cc:     bvanassche@acm.org, arnd@arndb.de, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/lockdep: fix a false positive warning
Date:   Fri,  6 Sep 2019 16:00:55 -0400
Message-Id: <1567800055-30309-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The commit 108c14858b9e ("locking/lockdep: Add support for dynamic
keys") introduced a boot warning on powerpc below, because since the
commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
kvm_tmp[] into the .bss section and then free the rest of unused spaces
back to the page allocator.

kernel_init
  kvm_guest_init
    kvm_free_tmp
      free_reserved_area
        free_unref_page
          free_unref_page_prepare

Later, alloc_workqueue() happens to allocate some pages from there and
trigger the warning at,

if (WARN_ON_ONCE(static_obj(key)))

Fix it by adding a generic helper arch_is_bss_hole() to skip those areas
in static_obj(). Since kvm_free_tmp() is only done early during the
boot, just go lockless to make the implementation simple for now.

WARNING: CPU: 0 PID: 13 at kernel/locking/lockdep.c:1120
Workqueue: events work_for_cpu_fn
Call Trace:
  lockdep_register_key+0x68/0x200
  wq_init_lockdep+0x40/0xc0
  trunc_msg+0x385f9/0x4c30f (unreliable)
  wq_init_lockdep+0x40/0xc0
  alloc_workqueue+0x1e0/0x620
  scsi_host_alloc+0x3d8/0x490
  ata_scsi_add_hosts+0xd0/0x220 [libata]
  ata_host_register+0x178/0x400 [libata]
  ata_host_activate+0x17c/0x210 [libata]
  ahci_host_activate+0x84/0x250 [libahci]
  ahci_init_one+0xc74/0xdc0 [ahci]
  local_pci_probe+0x78/0x100
  work_for_cpu_fn+0x40/0x70
  process_one_work+0x388/0x750
  process_scheduled_works+0x50/0x90
  worker_thread+0x3d0/0x570
  kthread+0x1b8/0x1e0
  ret_from_kernel_thread+0x5c/0x7c

Fixes: 108c14858b9e ("locking/lockdep: Add support for dynamic keys")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/include/asm/sections.h | 10 ++++++++++
 arch/powerpc/kernel/kvm.c           |  5 +++++
 include/asm-generic/sections.h      |  7 +++++++
 kernel/locking/lockdep.c            |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4a1664a8658d..abd08b3cb3f3 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,12 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_bss_hole arch_is_bss_hole
+
 #include <asm-generic/sections.h>
 
+extern void *bss_hole_start, *bss_hole_end;
 extern char __head_end[];
 
 #ifdef __powerpc64__
@@ -24,6 +28,12 @@
 extern char end_virt_trampolines[];
 #endif
 
+static inline int arch_is_bss_hole(unsigned long addr)
+{
+	return addr >= (unsigned long)bss_hole_start &&
+	       addr < (unsigned long)bss_hole_end;
+}
+
 static inline int in_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b7b3a5e4e224..89e0e522e125 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -66,6 +66,7 @@
 static bool kvm_patching_worked = true;
 char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
+void *bss_hole_start, *bss_hole_end;
 
 static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
 {
@@ -707,6 +708,10 @@ static __init void kvm_free_tmp(void)
 	 */
 	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
 			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
+
+	bss_hole_start = &kvm_tmp[kvm_tmp_index];
+	bss_hole_end = &kvm_tmp[ARRAY_SIZE(kvm_tmp)];
+
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d442aa5..4d8b1f2c5fd9 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -91,6 +91,13 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 }
 #endif
 
+#ifndef arch_is_bss_hole
+static inline int arch_is_bss_hole(unsigned long addr)
+{
+	return 0;
+}
+#endif
+
 /**
  * memory_contains - checks if an object is contained within a memory region
  * @begin: virtual address of the beginning of the memory region
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4861cf8e274b..cd75b51f15ce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -675,6 +675,9 @@ static int static_obj(const void *obj)
 	if (arch_is_kernel_initmem_freed(addr))
 		return 0;
 
+	if (arch_is_bss_hole(addr))
+		return 0;
+
 	/*
 	 * static variable?
 	 */
-- 
1.8.3.1

