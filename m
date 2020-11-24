Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078312C2BDA
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbgKXPvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389441AbgKXPvJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:09 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADF12086A;
        Tue, 24 Nov 2020 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233068;
        bh=X2W8sDs5r9Smn/YgyXcOa5uzquvNXtff5TMj5lfN6Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD6/cOcDs5PRSyZ/2pO6HDF2UO3HVp2mHKoB+cAx0Oil2tKnXeHjptHw4q04/jPeC
         l6G85u8tK1+JK3C5s+uRRPZYhS5Zh9H9qUe6ep+KxKVGS3l8pDHkwegOEJ1rs6TKNp
         lk0NYC3sp0mRdZT1PnO43fNKkHeOluT4pDMqWgoU=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 05/14] arm64: Advertise CPUs capable of running 32-bit applications in sysfs
Date:   Tue, 24 Nov 2020 15:50:30 +0000
Message-Id: <20201124155039.13804-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since 32-bit applications will be killed if they are caught trying to
execute on a 64-bit-only CPU in a mismatched system, advertise the set
of 32-bit capable CPUs to userspace in sysfs.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
 arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1a04ca8162ad..8a2e377b0dde 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -493,6 +493,15 @@ Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		identifying model and revision of the CPU.
 
+What:		/sys/devices/system/cpu/aarch32_el0
+Date:		November 2020
+Contact:	Linux ARM Kernel Mailing list <linux-arm-kernel@lists.infradead.org>
+Description:	Identifies the subset of CPUs in the system that can execute
+		AArch32 (32-bit ARM) applications. If present, the same format as
+		/sys/devices/system/cpu/{offline,online,possible,present} is used.
+		If absent, then all or none of the CPUs can execute AArch32
+		applications and execve() will behave accordingly.
+
 What:		/sys/devices/system/cpu/cpu#/cpu_capacity
 Date:		December 2016
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bc71a51f1b9c..534f80edb594 100644
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
@@ -1272,6 +1273,24 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 	return cpu_possible_mask;
 }
 
+static ssize_t aarch32_el0_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	const struct cpumask *mask = system_32bit_el0_cpumask();
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
+}
+static const DEVICE_ATTR_RO(aarch32_el0);
+
+static int __init aarch32_el0_sysfs_init(void)
+{
+	if (!allow_mismatched_32bit_el0)
+		return 0;
+
+	return device_create_file(cpu_subsys.dev_root, &dev_attr_aarch32_el0);
+}
+device_initcall(aarch32_el0_sysfs_init);
+
 static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	if (!has_cpuid_feature(entry, scope))
-- 
2.29.2.454.gaff20da3a2-goog

