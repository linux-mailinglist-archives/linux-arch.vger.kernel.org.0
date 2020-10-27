Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54AA29CB86
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374487AbgJ0Vvh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgJ0Vvh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:37 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC1B20829;
        Tue, 27 Oct 2020 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835496;
        bh=7xtHpE+jN4KpE9aM9q3M6jMkm03ttdE7SBSV+UdhCUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/U0lij0fRys470mF3hwkMMbzObDJHRKi2dF5fW3IA/jbYB9alNaVzhhx/g/7o6cg
         bqIbnBe1A7JAGpgFfiIj6b5z/Kv+dMaHVEN4zTs8fceQxp4LBtoXHGGSPMr5p3qD9D
         f2ECqbFgp1/9T4F9tzZUUfDvDhUzvbLGLBgZ5fTY=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: [PATCH 5/6] arm64: Advertise CPUs capable of running 32-bit applcations in sysfs
Date:   Tue, 27 Oct 2020 21:51:17 +0000
Message-Id: <20201027215118.27003-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since 32-bit applications will be killed if they are caught trying to
execute on a 64-bit-only CPU in a mismatched system, advertise the set
of 32-bit capable CPUs to userspace in sysfs.

Signed-off-by: Will Deacon <will@kernel.org>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  8 ++++++++
 arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b555df825447..19893fb8e870 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -472,6 +472,14 @@ Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		 identifying model and revision of the CPU.
 
+What:		/sys/devices/system/cpu/aarch32_el0
+Date:		October 2020
+Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
+Description:	Identifies the subset of CPUs in the system that can execute
+		AArch32 (32-bit ARM) applications. If absent, then all or none
+		of the CPUs can execute AArch32 applications and execve() will
+		behave accordingly.
+
 What:		/sys/devices/system/cpu/cpu#/cpu_capacity
 Date:		December 2016
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2e2219cbd54c..9f29d4d1ef7e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -67,6 +67,7 @@
 #include <linux/crash_dump.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/cpu.h>
@@ -1236,6 +1237,24 @@ bool system_has_mismatched_32bit_el0(void)
 	return fld == ID_AA64PFR0_EL0_64BIT_ONLY;
 }
 
+static ssize_t aarch32_el0_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	const struct cpumask *mask = system_32bit_el0_cpumask();
+	return sprintf(buf, "%*pbl\n", cpumask_pr_args(mask));
+}
+static const struct kobj_attribute aarch32_el0_attr = __ATTR_RO(aarch32_el0);
+
+static int __init aarch32_el0_sysfs_init(void)
+{
+	if (!__allow_mismatched_32bit_el0)
+		return 0;
+
+	return sysfs_create_file(&cpu_subsys.dev_root->kobj,
+				 &aarch32_el0_attr.attr);
+}
+device_initcall(aarch32_el0_sysfs_init);
+
 static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	return has_cpuid_feature(entry, scope) || __allow_mismatched_32bit_el0;
-- 
2.29.0.rc2.309.g374f81d7ae-goog

