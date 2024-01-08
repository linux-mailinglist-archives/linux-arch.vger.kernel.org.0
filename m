Return-Path: <linux-arch+bounces-1306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FD827BBD
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50721F23E3D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6156767;
	Mon,  8 Jan 2024 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PTj6UMIl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E045645E
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20400d5b54eso1738647fac.1
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2024 15:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704758250; x=1705363050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjiIlU3g58hIFUKwUoiVaj6BvYCOkDOQIpxSoofLMPg=;
        b=PTj6UMIlaMGg0ub/zsIteAy5ItuTiN5v7mIhEWmcnZRnAhg9mzosQXm78Xs8MOfaXB
         W9GySp5WLf0LAXTMJuz8xnc8MJNAatXQENIQKhPpof6YKbjRBkIe+mjnvIdiAVZ8GMt5
         5FjNYFBzuJ4We6EwrasUlRVIoshqxXNRpc81/4K0VHUGsIBNT6ch8d3/hTLrbtMpoVZW
         7ai+T75vVeZAnDXBVKcxKZCELbAXCCtujw08GD2+pvj2DXK3JgUx0Aoj22XNgqR72giC
         UjOvoyb0nt5ifQxnzI0V6ms04qnz9N0uGSNunUCGsj8txq6sWr0k5cHULww7/yLa/rPK
         Ip+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758250; x=1705363050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjiIlU3g58hIFUKwUoiVaj6BvYCOkDOQIpxSoofLMPg=;
        b=NFbqumZGxefvs5IhxB3KaeY3VGq45CoNcdx8w2CHfBASS/RWwfYyuQ0lWDIvKoZXIm
         mDN8PSoNvUpsLPYFJ53q0vGJGSku/CRok+XsZ6nPT2vwsP3EIYY2RiRwKAOMQW2p9qb6
         WjCnBToxthwMsrGnqq3XIbVUfMZNZ0WG+drA/LEOjerIE09RwTboNmqzT9zgBGsTJS3K
         dZH7QVcivBxyS/bnRjl2l28hpCJ+1A+0v0gPsFDG73gnKqONEFP3DvsN0vhdqo36R+PZ
         wKZqPbULAlF0FDoyCdO/T8cwPnMYz4guCuUB/XpqrIMcxuGmmdbPvzPtzYKB5NyuWfiv
         9mzw==
X-Gm-Message-State: AOJu0Ywiw49vNj7ky1fJT5CagXHjms6rUODlsmIOSI9q7Y0V0OFvUso9
	+50am3TsXpTLW5HSs0wAv3vzmtDXsC/DZQ==
X-Google-Smtp-Source: AGHT+IFUZGGdDLQC9cX5fNhg+jYh8WmCCePQv1988nheWHfdZIW5kILBL7bdjKgDZdoAzGSjYv26zQ==
X-Received: by 2002:a05:6871:4d2:b0:1fb:75b:131e with SMTP id n18-20020a05687104d200b001fb075b131emr5963512oai.112.1704758250070;
        Mon, 08 Jan 2024 15:57:30 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ti5-20020a056871890500b002043b415eaasm206961oab.29.2024.01.08.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:57:29 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 08 Jan 2024 15:57:03 -0800
Subject: [PATCH v15 2/5] riscv: Add static key for misaligned accesses
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-optimize_checksum-v15-2-1c50de5f2167@rivosinc.com>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
In-Reply-To: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704758245; l=5351;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=8KBYgXHVWJbA5ZwBBOd3JMcReJGd2wOakcAaFByUquI=;
 b=bV66gCXlvdm2nItIplQ34m9bU1Txqz+B31KHO1dpux6boBZl96Sh7wpTptRGfxjlpIikdW4P3
 reSthiW79g7CfgE2jDl01ddjA6jiu4k8ztHlEa+JEg/aW7UgYUlMbQH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. At any point in time,
this static branch will only be enabled if all online CPUs are
considered "fast".

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 +
 arch/riscv/kernel/cpufeature.c      | 90 +++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 3 deletions(-)

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
index b3785ffc1570..b62baeb504d8 100644
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
 
@@ -655,13 +669,69 @@ static void check_unaligned_access_nonboot_cpu(void *param)
 		check_unaligned_access(pages[cpu]);
 }
 
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
+{
+	if (cpumask_weight(mask) == weight)
+		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+}
+
+static void set_unaligned_access_static_branches_except_cpu(int cpu)
+{
+	/*
+	 * Same as set_unaligned_access_static_branches, except excludes the
+	 * given CPU from the result. When a CPU is hotplugged into an offline
+	 * state, this function is called before the CPU is set to offline in
+	 * the cpumask, and thus the CPU needs to be explicitly excluded.
+	 */
+
+	cpumask_t fast_except_me;
+
+	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &fast_except_me);
+
+	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
+}
+
+static void set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all CPUs will be available.
+	 *
+	 * To avoid the number of online cpus changing between reading
+	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
+	 * held before calling this function.
+	 */
+
+	cpumask_t fast_and_online;
+
+	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
+
+	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
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
@@ -671,6 +741,17 @@ static int riscv_online_cpu(unsigned int cpu)
 
 	check_unaligned_access(buf);
 	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+
+exit:
+	set_unaligned_access_static_branches();
+
+	return 0;
+}
+
+static int riscv_offline_cpu(unsigned int cpu)
+{
+	set_unaligned_access_static_branches_except_cpu(cpu);
+
 	return 0;
 }
 
@@ -705,9 +786,12 @@ static int check_unaligned_access_all_cpus(void)
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


