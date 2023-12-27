Return-Path: <linux-arch+bounces-1176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458681F0F3
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 18:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC922844C8
	for <lists+linux-arch@lfdr.de>; Wed, 27 Dec 2023 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E504655F;
	Wed, 27 Dec 2023 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CS1jGi83"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF546522
	for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204a16df055so1762336fac.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Dec 2023 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703698698; x=1704303498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMlsfn7czPVsXwrmU+kv95pA8qnyqJLx1nukNUHIJyw=;
        b=CS1jGi83E7VPxvt/zfcdFd8WqYW7kOSdswTvvWDV7hbCYmRqSlz0MjKR+JKaoi1c1b
         MtP79vlajSqHWDpZz0SG/HTWUMCQwWPcVEThieDhCWD9+Gro7Ukp3iwJoM6mdQ7Hz2r1
         gELZI0svWI/5vscAJTp2+p7ZECYBaq6EWjxXOs1c4090eXCHoADYJ2tWajnJrm5UueH2
         l8sD3ZUmsWWSxUjUr3SLStwOWFeaUTUbDnRGeeZShJx91fpkVi4EFkPkZ58eU1e1DH4Q
         a7qeLnCDFpsWLL6S/xCeFTpl1ySl7G68usW7eLdVgXiPryltzSRyImYGsreWnCEr4Gx/
         qPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703698698; x=1704303498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMlsfn7czPVsXwrmU+kv95pA8qnyqJLx1nukNUHIJyw=;
        b=H6oMkaShCyjX13wMFqYW4v6hxBUGnCk4LZ6XpzSIeT6oeAAeqAt/Q2L83i6/Ti06iT
         6FMtHjQsfALiEsMv2ZpJzfBmh9KHxspIyJz1JBtQpvuBy9erTcma3ZkmhTFvOrnWgVO2
         vbfdgdCDfOdwqvTMNS1QhKJII8PvtD9NJUuJWDU0V6JFDI2RALptDUw2d1paOZKpVOzI
         jnrdis78iU5Ns1yJTQ2mKQUNY4xprZCeHVUfFym802O5/9uNNb3fLxBRkfevfS839ICQ
         rvRSX0M3kwEEDDZl3XBYZZR6T5Gta31xrynCCqt7yzGOvxT27zhqT8uxo5sSMIiDPGS1
         KH5Q==
X-Gm-Message-State: AOJu0Yzc99o0evQ9tqr7qpy7jTqNOSe2y2GoQtKGAkW4OkpEw6LCVhrI
	+H+S6F7k0/7xnLj2ECNAB7Lg9UvI/i4y5w==
X-Google-Smtp-Source: AGHT+IEIrmTuGZOJNDeXOpI5DFGqZulKKWwLyazfrOgAYCgNMHfgJ1Ew2aY/lLJoiaXBaUHq2w/fMw==
X-Received: by 2002:a05:6871:724:b0:204:302f:74cb with SMTP id f36-20020a056871072400b00204302f74cbmr11492877oap.24.1703698698069;
        Wed, 27 Dec 2023 09:38:18 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id rl15-20020a056871650f00b002049c207104sm1337173oab.27.2023.12.27.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:38:17 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 27 Dec 2023 09:38:01 -0800
Subject: [PATCH v14 2/5] riscv: Add static key for misaligned accesses
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-optimize_checksum-v14-2-ddfd48016566@rivosinc.com>
References: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
In-Reply-To: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703698692; l=5478;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=D4IKaaj3vE+b0K5XN8QdVSXmK3dl6XnNZpqh6Lepfss=;
 b=wW1oSltYcPLm6WjHMbTJUzZDxQi942rfKCi7R0Jd24cRe7PpnWNp2kkXzDGS2uPhT+MHc6RqD
 cYQbMZT28P7Bxk85HOSEujEx+JNt2ZYDyHx8MaBRhCDsRybFl1WXekw
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. All online cpus must
be considered "fast" for this static branch to be flipped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 +
 arch/riscv/kernel/cpufeature.c      | 89 +++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index a418c3112cd6..7b129e5e2f07 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..dfd716b93565 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,8 +8,10 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -44,6 +46,8 @@ struct riscv_isainfo hart_isa[NR_CPUS];
 /* Performance information */
 DEFINE_PER_CPU(long, misaligned_access_speed);
 
+static cpumask_t fast_misaligned_access;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -643,6 +647,16 @@ static int check_unaligned_access(void *param)
 		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
 
 	per_cpu(misaligned_access_speed, cpu) = speed;
+
+	/*
+	 * Set the value of fast_misaligned_access of a CPU. These operations
+	 * are atomic to avoid race conditions.
+	 */
+	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
+		cpumask_set_cpu(cpu, &fast_misaligned_access);
+	else
+		cpumask_clear_cpu(cpu, &fast_misaligned_access);
+
 	return 0;
 }
 
@@ -655,13 +669,70 @@ static void check_unaligned_access_nonboot_cpu(void *param)
 		check_unaligned_access(pages[cpu]);
 }
 
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static int exclude_set_unaligned_access_static_branches(int cpu)
+{
+	/*
+	 * Same as set_unaligned_access_static_branches, except excludes the
+	 * given CPU from the result. When a CPU is hotplugged into an offline
+	 * state, this function is called before the CPU is set to offline in
+	 * the cpumask, and thus the CPU needs to be explicitly excluded.
+	 */
+
+	cpumask_t online_fast_misaligned_access;
+
+	cpumask_and(&online_fast_misaligned_access, &fast_misaligned_access, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &online_fast_misaligned_access);
+
+	if (cpumask_weight(&online_fast_misaligned_access) == (num_online_cpus() - 1))
+		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+
+	return 0;
+}
+
+static int set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all CPUs will be available.
+	 *
+	 * To avoid the number of online cpus changing between reading
+	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
+	 * held before calling this function.
+	 */
+	cpumask_t online_fast_misaligned_access;
+
+	cpumask_and(&online_fast_misaligned_access, &fast_misaligned_access, cpu_online_mask);
+
+	if (cpumask_weight(&online_fast_misaligned_access) == num_online_cpus())
+		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+
+	return 0;
+}
+
+static int lock_and_set_unaligned_access_static_branch(void)
+{
+	cpus_read_lock();
+	set_unaligned_access_static_branches();
+	cpus_read_unlock();
+
+	return 0;
+}
+
+arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
+
 static int riscv_online_cpu(unsigned int cpu)
 {
 	static struct page *buf;
 
 	/* We are already set since the last check */
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		return 0;
+		goto exit;
 
 	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
 	if (!buf) {
@@ -671,7 +742,14 @@ static int riscv_online_cpu(unsigned int cpu)
 
 	check_unaligned_access(buf);
 	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
-	return 0;
+
+exit:
+	return set_unaligned_access_static_branches();
+}
+
+static int riscv_offline_cpu(unsigned int cpu)
+{
+	return exclude_set_unaligned_access_static_branches(cpu);
 }
 
 /* Measure unaligned access on all CPUs present at boot in parallel. */
@@ -705,9 +783,12 @@ static int check_unaligned_access_all_cpus(void)
 	/* Check core 0. */
 	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
 
-	/* Setup hotplug callback for any new CPUs that come online. */
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, NULL);
+				  riscv_online_cpu, riscv_offline_cpu);
 
 out:
 	unaligned_emulation_finish();

-- 
2.43.0


