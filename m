Return-Path: <linux-arch+bounces-3053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E968A885DB2
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 17:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6166BB21394
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2C12CD8B;
	Thu, 21 Mar 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/85ugjN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC029CEA
	for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039036; cv=none; b=WSy6AXdZyOSdxGpL1Us/jWbqdsA8JFZ1Q3ub1oARnjqTt8aimd+oi7bztzrFvrFl+cj+W9tyCglxMaG553bFSAsb96NTGc3Or/Is31brZxlRZJMJFY5HotQpCvwD91sizPHohzCNbyukROngeGyL0xV7BxmdTvowvGpR/R/9Hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039036; c=relaxed/simple;
	bh=Aur5JYEngJBQvIF+YjoMS+Q/1uNDQvUJSExZF5+wZkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eWFvWg0C8gsazx3Ld1Hhc8Ep+v4oHAPCooh80glgIcQAbGbBSW7x6JSJV8A6+doAl0Ez5VOQIZJrE6GdtJ6l9K6Yg0jTwFpzCqcupKQr2aIbyPLKCgPy4nQV6ZmYnjzuzJXpAvK1N1wW9pEpiAAeDMWl4ypNtBw87Tt7OOdWu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/85ugjN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a55cd262aso20231637b3.2
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039033; x=1711643833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvHQT84Vpgs1c9BTtx/ZOKdQLP9IYCyPDqaPAHjwGfE=;
        b=C/85ugjN98z+EAx7YXxI4PLffyEFsvP4N/TG4IcZrychCC7cQ9UfzYrUUXnKujLLWE
         jVSVhLhEf6qRtzqlMVi7mCh6aPIhIcjQ7LqpMF70/+N4dh3jSDd2fkmGxZsQsupBI82/
         fEc5HCB2MJViErJ+JqJ1VXWOZ48RsB1Zvp7sBJS4Q+bRjVnKudfoIUioe5QudCk48qiM
         eAB+9keogE6yyWzRBlFBmic5ZU14vPZ7AmmAemzje9Cpald3dMJYAPFuLAh0wtu+t0rS
         TNJE6QWNLmv/sQSi/+3qeJ8sFxBP0ThBNca6E0vuN3LpzwYwhdisR/JZwO+QAFcvBjAj
         4FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039033; x=1711643833;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvHQT84Vpgs1c9BTtx/ZOKdQLP9IYCyPDqaPAHjwGfE=;
        b=HxsANsMeOFNnaQeowDTyK8onlNqWv9nRrIQjPoaBopNyo8YrxOVR7/iBZdwE3Id4/Y
         //R7thAutdHoX4h0XTdvFcRgkcFcQcgWXb8Oehgd16NU0Sf/HLaTP+HsUrk5jho39QnH
         QXwlMs2ulNxq2zZNyWmSUyutGCOZVxEbxeYgn3nyOfkN4O469FHyuA9NkM5qL/FmeeFy
         qtnftwSZyxatx7/t+Dnm39fyjFylBRsEmBurJ0+VrSxz4nCl2kMU0o3hNKXvfJFwWmAI
         HwF1SD8uSXCSeWglwH1GXnvYg7HsYWvaElhPd2RB/7/qg77i70Qgg0cVayNi1aqM6R99
         PR/A==
X-Forwarded-Encrypted: i=1; AJvYcCVeCPGeKWN5TCumUeLZapWau9XsRk0x5XhwdZHZdRDIW9OG9QHx5xfIu+IRCGVnNMP0ubbGfQj0aiBKbi4Cdivs+fW7lXrIOU5VPg==
X-Gm-Message-State: AOJu0Yzb8LGDLFIxfFwM8nJfcOcUjriCfvmF2D/SObI2+KUnc+w2WGeH
	pFvTxUgdUPEKtg/9hczjwXJNuEXT9lafI5Tqumn05awGeErRBQxHYc1RlaGOi4/D6FYccZXguNU
	GtA==
X-Google-Smtp-Source: AGHT+IE0GrI48aMtLt86KJtvt2ABiO4vb9dUmX9df+RhMwB6AbI4ueJGxRCaSy1scrleMDbYTlfJxXp4A3s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:18d1:b0:dc7:42:ecd with SMTP id
 ck17-20020a05690218d100b00dc700420ecdmr2405851ybb.6.1711039032771; Thu, 21
 Mar 2024 09:37:12 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:23 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-2-surenb@google.com>
Subject: [PATCH v6 01/37] fix missing vmalloc.h includes
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Kent Overstreet <kent.overstreet@linux.dev>

The next patch drops vmalloc.h from a system header in order to fix
a circular dependency; this adds it to all the files that were pulling
it in implicitly.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/alpha/lib/checksum.c                                 | 1 +
 arch/alpha/lib/fpreg.c                                    | 1 +
 arch/alpha/lib/memcpy.c                                   | 1 +
 arch/arm/kernel/irq.c                                     | 1 +
 arch/arm/kernel/traps.c                                   | 1 +
 arch/arm64/kernel/efi.c                                   | 1 +
 arch/loongarch/include/asm/kfence.h                       | 1 +
 arch/powerpc/kernel/iommu.c                               | 1 +
 arch/powerpc/mm/mem.c                                     | 1 +
 arch/riscv/kernel/elf_kexec.c                             | 1 +
 arch/riscv/kernel/probes/kprobes.c                        | 1 +
 arch/s390/kernel/cert_store.c                             | 1 +
 arch/s390/kernel/ipl.c                                    | 1 +
 arch/x86/include/asm/io.h                                 | 1 +
 arch/x86/kernel/cpu/sgx/main.c                            | 1 +
 arch/x86/kernel/irq_64.c                                  | 1 +
 arch/x86/mm/fault.c                                       | 1 +
 drivers/accel/ivpu/ivpu_mmu_context.c                     | 1 +
 drivers/gpu/drm/gma500/mmu.c                              | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c                 | 1 +
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c          | 1 +
 drivers/gpu/drm/i915/gt/shmem_utils.c                     | 1 +
 drivers/gpu/drm/i915/gvt/firmware.c                       | 1 +
 drivers/gpu/drm/i915/gvt/gtt.c                            | 1 +
 drivers/gpu/drm/i915/gvt/handlers.c                       | 1 +
 drivers/gpu/drm/i915/gvt/mmio.c                           | 1 +
 drivers/gpu/drm/i915/gvt/vgpu.c                           | 1 +
 drivers/gpu/drm/i915/intel_gvt.c                          | 1 +
 drivers/gpu/drm/imagination/pvr_vm_mips.c                 | 1 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                    | 1 +
 drivers/gpu/drm/omapdrm/omap_gem.c                        | 1 +
 drivers/gpu/drm/v3d/v3d_bo.c                              | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c                   | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c                       | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c                   | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                       | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                   | 1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c                     | 1 +
 drivers/gpu/drm/xen/xen_drm_front_gem.c                   | 1 +
 drivers/hwtracing/coresight/coresight-trbe.c              | 1 +
 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c  | 1 +
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c | 1 +
 drivers/net/ethernet/microsoft/mana/hw_channel.c          | 1 +
 drivers/platform/x86/uv_sysfs.c                           | 1 +
 drivers/scsi/mpi3mr/mpi3mr_transport.c                    | 2 ++
 drivers/vfio/pci/pds/dirty.c                              | 1 +
 drivers/virt/acrn/mm.c                                    | 1 +
 drivers/virtio/virtio_mem.c                               | 1 +
 include/linux/pds/pds_common.h                            | 2 ++
 include/rdma/rdmavt_qp.h                                  | 1 +
 mm/debug_vm_pgtable.c                                     | 1 +
 sound/pci/hda/cs35l41_hda.c                               | 1 +
 52 files changed, 54 insertions(+)

diff --git a/arch/alpha/lib/checksum.c b/arch/alpha/lib/checksum.c
index 3f35c3ed6948..c29b98ef9c82 100644
--- a/arch/alpha/lib/checksum.c
+++ b/arch/alpha/lib/checksum.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
=20
 #include <asm/byteorder.h>
+#include <asm/checksum.h>
=20
 static inline unsigned short from64to16(unsigned long x)
 {
diff --git a/arch/alpha/lib/fpreg.c b/arch/alpha/lib/fpreg.c
index 7c08b225261c..3d32165043f8 100644
--- a/arch/alpha/lib/fpreg.c
+++ b/arch/alpha/lib/fpreg.c
@@ -8,6 +8,7 @@
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/preempt.h>
+#include <asm/fpu.h>
 #include <asm/thread_info.h>
=20
 #if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
diff --git a/arch/alpha/lib/memcpy.c b/arch/alpha/lib/memcpy.c
index cbac3dc6d963..0e536a1a39ff 100644
--- a/arch/alpha/lib/memcpy.c
+++ b/arch/alpha/lib/memcpy.c
@@ -18,6 +18,7 @@
=20
 #include <linux/types.h>
 #include <linux/export.h>
+#include <linux/string.h>
=20
 /*
  * This should be done in one go with ldq_u*2/mask/stq_u. Do it
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index fe28fc1f759d..dab42d066d06 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -32,6 +32,7 @@
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
 #include <linux/export.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/cache-uniphier.h>
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3bad79db5d6e..27addbf0f98c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
+#include <linux/vmalloc.h>
=20
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 9afcc690fe73..4a92096db34e 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/screen_info.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/efi.h>
 #include <asm/stacktrace.h>
diff --git a/arch/loongarch/include/asm/kfence.h b/arch/loongarch/include/a=
sm/kfence.h
index 6c82aea1c993..54062656dc7b 100644
--- a/arch/loongarch/include/asm/kfence.h
+++ b/arch/loongarch/include/asm/kfence.h
@@ -10,6 +10,7 @@
 #define _ASM_LOONGARCH_KFENCE_H
=20
 #include <linux/kfence.h>
+#include <linux/vmalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
=20
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 1185efebf032..65468d0829e1 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -26,6 +26,7 @@
 #include <linux/iommu.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/iommu.h>
 #include <asm/pci-bridge.h>
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3a440004b97d..a197d4c2244b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -16,6 +16,7 @@
 #include <linux/highmem.h>
 #include <linux/suspend.h>
 #include <linux/dma-direct.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/swiotlb.h>
 #include <asm/machdep.h>
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 54260c16f991..11c0d2e0becf 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -19,6 +19,7 @@
 #include <linux/libfdt.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
+#include <linux/vmalloc.h>
 #include <asm/setup.h>
=20
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/=
kprobes.c
index 2f08c14a933d..71a8b8945b26 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -6,6 +6,7 @@
 #include <linux/extable.h>
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
+#include <linux/vmalloc.h>
 #include <asm/ptrace.h>
 #include <linux/uaccess.h>
 #include <asm/sections.h>
diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 554447768bdd..bf983513dd33 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/vmalloc.h>
 #include <crypto/sha2.h>
 #include <keys/user-type.h>
 #include <asm/debug.h>
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 1486350a4177..5d6d381aa0be 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/crash_dump.h>
 #include <linux/debug_locks.h>
+#include <linux/vmalloc.h>
 #include <asm/asm-extable.h>
 #include <asm/diag.h>
 #include <asm/ipl.h>
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 294cd2a40818..7452fc193b4f 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -42,6 +42,7 @@
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
 #include <asm/shared/io.h>
+#include <asm/special_insns.h>
=20
 #define build_mmio_read(name, size, type, reg, barrier) \
 static inline type name(const volatile void __iomem *addr) \
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.=
c
index 166692f2d501..27892e57c4ef 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -13,6 +13,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/vmalloc.h>
 #include <asm/sgx.h>
 #include "driver.h"
 #include "encl.h"
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index fe0c859873d1..ade0043ce56e 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/smp.h>
 #include <linux/sched/task_stack.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/cpu_entry_area.h>
 #include <asm/softirq_stack.h>
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 622d12ec7f08..a4cc20d0036d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
+#include <linux/vmalloc.h>
=20
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
diff --git a/drivers/accel/ivpu/ivpu_mmu_context.c b/drivers/accel/ivpu/ivp=
u_mmu_context.c
index fe6161299236..128aef8e5a19 100644
--- a/drivers/accel/ivpu/ivpu_mmu_context.c
+++ b/drivers/accel/ivpu/ivpu_mmu_context.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/highmem.h>
 #include <linux/set_memory.h>
+#include <linux/vmalloc.h>
=20
 #include <drm/drm_cache.h>
=20
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index a70b01ccdf70..4d78b33eaa82 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -5,6 +5,7 @@
  *************************************************************************=
*/
=20
 #include <linux/highmem.h>
+#include <linux/vmalloc.h>
=20
 #include "mmu.h"
 #include "psb_drv.h"
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i9=
15/gem/i915_gem_pages.c
index 0ba955611dfb..8780aa243105 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -5,6 +5,7 @@
  */
=20
 #include <drm/drm_cache.h>
+#include <linux/vmalloc.h>
=20
 #include "gt/intel_gt.h"
 #include "gt/intel_tlb.h"
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu=
/drm/i915/gem/selftests/mock_dmabuf.c
index b2a5882b8f81..075657018739 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -4,6 +4,7 @@
  * Copyright =C2=A9 2016 Intel Corporation
  */
=20
+#include <linux/vmalloc.h>
 #include "mock_dmabuf.h"
=20
 static struct sg_table *mock_map_dma_buf(struct dma_buf_attachment *attach=
ment,
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/g=
t/shmem_utils.c
index bccc3a1200bc..1fb6ff77fd89 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/shmem_fs.h>
+#include <linux/vmalloc.h>
=20
 #include "i915_drv.h"
 #include "gem/i915_gem_object.h"
diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt=
/firmware.c
index 4dd52ac2043e..d800d267f0e9 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -30,6 +30,7 @@
=20
 #include <linux/firmware.h>
 #include <linux/crc32.h>
+#include <linux/vmalloc.h>
=20
 #include "i915_drv.h"
 #include "gvt.h"
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.=
c
index 094fca9b0e73..58cca4906f41 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -39,6 +39,7 @@
 #include "trace.h"
=20
 #include "gt/intel_gt_regs.h"
+#include <linux/vmalloc.h>
=20
 #if defined(VERBOSE_DEBUG)
 #define gvt_vdbg_mm(fmt, args...) gvt_dbg_mm(fmt, ##args)
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt=
/handlers.c
index efcb00472be2..ea9c30092767 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -52,6 +52,7 @@
 #include "display/skl_watermark_regs.h"
 #include "display/vlv_dsi_pll_regs.h"
 #include "gt/intel_gt_regs.h"
+#include <linux/vmalloc.h>
=20
 /* XXX FIXME i915 has changed PP_XXX definition */
 #define PCH_PP_STATUS  _MMIO(0xc7200)
diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/mmi=
o.c
index 5b5def6ddef7..780762f28aa4 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.c
+++ b/drivers/gpu/drm/i915/gvt/mmio.c
@@ -33,6 +33,7 @@
  *
  */
=20
+#include <linux/vmalloc.h>
 #include "i915_drv.h"
 #include "i915_reg.h"
 #include "gvt.h"
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgp=
u.c
index 08ad1bd651f1..63c751ca4119 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -34,6 +34,7 @@
 #include "i915_drv.h"
 #include "gvt.h"
 #include "i915_pvinfo.h"
+#include <linux/vmalloc.h>
=20
 void populate_pvinfo_page(struct intel_vgpu *vgpu)
 {
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_=
gvt.c
index 9b6d87c8b583..5a01d60e5186 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -28,6 +28,7 @@
 #include "gt/intel_context.h"
 #include "gt/intel_ring.h"
 #include "gt/shmem_utils.h"
+#include <linux/vmalloc.h>
=20
 /**
  * DOC: Intel GVT-g host support
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/im=
agination/pvr_vm_mips.c
index b7fef3c797e6..6563dcde109c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
=20
 /**
  * pvr_vm_mips_init() - Initialise MIPS FW pagetable
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/media=
tek/mtk_drm_gem.c
index 4f2e3feabc0f..3e519869b632 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/dma-buf.h>
+#include <linux/vmalloc.h>
=20
 #include <drm/drm.h>
 #include <drm/drm_device.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/o=
map_gem.c
index 3421e8389222..9ea0c64c26b5 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -9,6 +9,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pfn_t.h>
+#include <linux/vmalloc.h>
=20
 #include <drm/drm_prime.h>
 #include <drm/drm_vma_manager.h>
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a07ede668cc1..a165cbcdd27b 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -21,6 +21,7 @@
=20
 #include <linux/dma-buf.h>
 #include <linux/pfn_t.h>
+#include <linux/vmalloc.h>
=20
 #include "v3d_drv.h"
 #include "uapi/drm/v3d_drm.h"
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_binding.c
index ae2de914eb89..2731f6ded1c2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
@@ -54,6 +54,7 @@
 #include "vmwgfx_drv.h"
 #include "vmwgfx_binding.h"
 #include "device_include/svga3d_reg.h"
+#include <linux/vmalloc.h>
=20
 #define VMW_BINDING_RT_BIT     0
 #define VMW_BINDING_PS_BIT     1
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/v=
mwgfx_cmd.c
index 195ff8792e5a..dd4ca6a9c690 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -31,6 +31,7 @@
 #include <drm/ttm/ttm_placement.h>
=20
 #include <linux/sched/signal.h>
+#include <linux/vmalloc.h>
=20
 bool vmw_supports_3d(struct vmw_private *dev_priv)
 {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_devcaps.c
index 829df395c2ed..6e6beff9e262 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_devcaps.c
@@ -25,6 +25,7 @@
  *
  *************************************************************************=
*/
=20
+#include <linux/vmalloc.h>
 #include "vmwgfx_devcaps.h"
=20
 #include "vmwgfx_drv.h"
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/v=
mwgfx_drv.c
index d3e308fdfd5b..7a451410ad77 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/version.h>
+#include <linux/vmalloc.h>
=20
 #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics devices"
=20
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_execbuf.c
index cc3086e649eb..2e52d73eba48 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -35,6 +35,7 @@
=20
 #include <linux/sync_file.h>
 #include <linux/hashtable.h>
+#include <linux/vmalloc.h>
=20
 /*
  * Helper macro to get dx_ctx_node if available otherwise print an error
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_ioctl.c
index a1da5678c731..835d1eed8dd9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c
@@ -31,6 +31,7 @@
=20
 #include <drm/vmwgfx_drm.h>
 #include <linux/pci.h>
+#include <linux/vmalloc.h>
=20
 int vmw_getparam_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file_priv)
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/=
xen_drm_front_gem.c
index 3ad2b4cfd1f0..63112ed975c4 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -11,6 +11,7 @@
 #include <linux/dma-buf.h>
 #include <linux/scatterlist.h>
 #include <linux/shmem_fs.h>
+#include <linux/vmalloc.h>
=20
 #include <drm/drm_gem.h>
 #include <drm/drm_prime.h>
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtraci=
ng/coresight/coresight-trbe.c
index 6136776482e6..96a32b213669 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -17,6 +17,7 @@
=20
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <linux/vmalloc.h>
=20
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/dri=
vers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
index 2e2c3be8a0b4..e6eb98d70f3c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/etherdevice.h>
+#include <linux/vmalloc.h>
=20
 #include "octep_config.h"
 #include "octep_main.h"
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c b/dr=
ivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
index 2eab21e43048..445b626efe11 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
+#include <linux/vmalloc.h>
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
=20
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net=
/ethernet/microsoft/mana/hw_channel.c
index 2729a2c5acf9..11021c34e47e 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -3,6 +3,7 @@
=20
 #include <net/mana/gdma.h>
 #include <net/mana/hw_channel.h>
+#include <linux/vmalloc.h>
=20
 static int mana_hwc_get_msg_index(struct hw_channel_context *hwc, u16 *msg=
_id)
 {
diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysf=
s.c
index 38d1b692d3c0..40e010877189 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/kobject.h>
+#include <linux/vmalloc.h>
 #include <asm/uv/bios.h>
 #include <asm/uv/uv.h>
 #include <asm/uv/uv_hub.h>
diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/m=
pi3mr_transport.c
index d32ad46318cb..dabb91f0f75d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -7,6 +7,8 @@
  *
  */
=20
+#include <linux/vmalloc.h>
+
 #include "mpi3mr.h"
=20
 /**
diff --git a/drivers/vfio/pci/pds/dirty.c b/drivers/vfio/pci/pds/dirty.c
index 68e8f006dfdb..c51f5e4c3dd6 100644
--- a/drivers/vfio/pci/pds/dirty.c
+++ b/drivers/vfio/pci/pds/dirty.c
@@ -3,6 +3,7 @@
=20
 #include <linux/interval_tree.h>
 #include <linux/vfio.h>
+#include <linux/vmalloc.h>
=20
 #include <linux/pds/pds_common.h>
 #include <linux/pds/pds_core_if.h>
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index fa5d9ca6be57..c088ee1f1180 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
=20
 #include "acrn_drv.h"
=20
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8e3223294442..e8355f55a8f7 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -21,6 +21,7 @@
 #include <linux/bitmap.h>
 #include <linux/lockdep.h>
 #include <linux/log2.h>
+#include <linux/vmalloc.h>
=20
 #include <acpi/acpi_numa.h>
=20
diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.=
h
index 30581e2e04cc..5802e1deef24 100644
--- a/include/linux/pds/pds_common.h
+++ b/include/linux/pds/pds_common.h
@@ -4,6 +4,8 @@
 #ifndef _PDS_COMMON_H_
 #define _PDS_COMMON_H_
=20
+#include <linux/notifier.h>
+
 #define PDS_CORE_DRV_NAME			"pds_core"
=20
 /* the device's internal addressing uses up to 52 bits */
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 2e58d5e6ac0e..d67892944193 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -11,6 +11,7 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/rdmavt_cq.h>
 #include <rdma/rvt-abi.h>
+#include <linux/vmalloc.h>
 /*
  * Atomic bit definitions for r_aflags.
  */
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 65c19025da3d..f1c9a2c5abc0 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -30,6 +30,7 @@
 #include <linux/start_kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/io.h>
+#include <linux/vmalloc.h>
=20
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d3fa6e136744..990b5bd717a1 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -13,6 +13,7 @@
 #include <sound/soc.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/vmalloc.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
--=20
2.44.0.291.gc1ea87d7ee-goog


