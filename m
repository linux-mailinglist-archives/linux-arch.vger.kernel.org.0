Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3302AADB30
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2019 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfIIOay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Sep 2019 10:30:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34080 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfIIOay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Sep 2019 10:30:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so3642673qth.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Sep 2019 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CXfqRVCQFw7xqj7AICeJBWtrNhS6pGZdKh11BOOZ9lA=;
        b=gxEMwh/a/ND2u6HYSSw+CvoCqCBHgB9WAY3kEMDTKnHS721fCqfnpsUSXC2a0oOeGf
         hS6DIyV3UJqVsob9he/lOalVvuUnlHqXfyaB6/qIu5AZdsXVBD3H5UKaA89p9ehrqtw+
         HyVJbHyy0BC20nYdMA7IvWJsrq/du8PbBCqzLf/32PujYUN1YiLrJBu2apAoILgQ2QQM
         WXN1kirG4t98s2AA6PXav/e270xdKKCBwOxaaUgq+gIL67v8Nnc7hzablBWT5tXiqNyZ
         dztk4qQJT8T3WUmUbdwsE/SUovPAHV8+d9xftGR/FzO4FcQmWQWioLNX0jmu7RnXkbMR
         l9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CXfqRVCQFw7xqj7AICeJBWtrNhS6pGZdKh11BOOZ9lA=;
        b=Xo/PaqonZQ5TLXfwGJTG6sD7Ar75cY63otgDuO6fyO1Z8+kk1BhTylY5qRa4WepRLI
         7bTT/ewZ+GG7MT/KX5zEJKn6qn2XOwgLoLjvoKcrQ/13PRXwSFQnqBjOh+cbrTCPCBZX
         I3H81n9o4XtS5SiqQmAul9h4Wpe/dXVjbDp7naO5jgP6GidVqHNd03SCIkU9k1drjJjY
         12/8/wUiiiWIBSCP6y7SKQKwUgeMzFLC689trmasUYp4qJP14OGkG5oi3i9NV9mp6tg0
         LAUl9qtjWFk1SVvBQtO6EtbTuZa+TxpO7W/EUTOQfol8/jMhH50KriMdaJ4S1l8GVIby
         zufw==
X-Gm-Message-State: APjAAAVKDpmiZzyoov66FTVL4kMnlUDOqiafNBoJgwqj9DgYrTwQAL/o
        lXOSnmQmm1s2AkJhFx6vb7BMFw==
X-Google-Smtp-Source: APXvYqz3L3fSgl55DmtBbUTWQgR45D2JISFvfWDBJBH3PWAbVc68BgzFeZ6k0wq1m7D4qm15IYPnzA==
X-Received: by 2002:a0c:eda7:: with SMTP id h7mr14228023qvr.30.1568039452923;
        Mon, 09 Sep 2019 07:30:52 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w126sm6478943qkd.68.2019.09.09.07.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 07:30:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org,
        peterz@infradead.org, bvanassche@acm.org, arnd@arndb.de,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] powerpc/lockdep: fix a false positive warning
Date:   Mon,  9 Sep 2019 10:30:33 -0400
Message-Id: <1568039433-10176-1-git-send-email-cai@lca.pw>
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

v3: Change arch_is_bss_hole() to return a "bool".
    Rearrange variables in kvm.c a bit.
v2: No need to actually define arch_is_bss_hole() powerpc64 only.

 arch/powerpc/include/asm/sections.h | 11 +++++++++++
 arch/powerpc/kernel/kvm.c           |  8 +++++++-
 include/asm-generic/sections.h      |  7 +++++++
 kernel/locking/lockdep.c            |  3 +++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4a1664a8658d..6e9e39ebbb27 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,19 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_bss_hole arch_is_bss_hole
+
 #include <asm-generic/sections.h>
 
+extern void *bss_hole_start, *bss_hole_end;
+
+static inline bool arch_is_bss_hole(unsigned long addr)
+{
+	return addr >= (unsigned long)bss_hole_start &&
+	       addr < (unsigned long)bss_hole_end;
+}
+
 extern char __head_end[];
 
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index b7b3a5e4e224..e3c3b076ff07 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -64,9 +64,11 @@
 #define KVM_INST_MTSRIN		0x7c0001e4
 
 static bool kvm_patching_worked = true;
-char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
 
+char kvm_tmp[1024 * 1024];
+void *bss_hole_start, *bss_hole_end;
+
 static inline void kvm_patch_ins(u32 *inst, u32 new_inst)
 {
 	*inst = new_inst;
@@ -707,6 +709,10 @@ static __init void kvm_free_tmp(void)
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
index d1779d442aa5..28a7a56e7c8a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -91,6 +91,13 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 }
 #endif
 
+#ifndef arch_is_bss_hole
+static inline bool arch_is_bss_hole(unsigned long addr)
+{
+	return false;
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

