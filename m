Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3AD3DB7CB
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhG3LZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238697AbhG3LZs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D69761055;
        Fri, 30 Jul 2021 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644343;
        bh=VcjaQPzybbGlvtzMZMZPB8b5mPi8TxhDPTMLtmuqXPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPJLNBAq9EWh5Ch+oqsURAMrDIMMJZJ0bHbeueS0fIIKjv+VuBdXp9WWHI7r05VSp
         vNf+qMi0pfqDEm2XlU4JVuXCOMlFs+dj4a3tWWpHqVAnRxGMikDDAU9JLTMYRbtoZZ
         UEmFwv9nWdLdiDGQvIu1/zG+n3808lISU6eodl+5HgJTwWbOHHRomS1i7f5h+7dLNm
         asuerZzynWzfMk4HTtUlZ/eQyllQDEyoq1q75WdFinOfmIl9kGTp1XOFm9pp8rp4RV
         qXdCa3Ni0Yh/iVvc3FIpVjPNcacdGn7EvNV9uVHGuMSYMq9ds/DyR32apaIhgamfYX
         iojvukfFf37yQ==
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v11 13/16] arm64: Advertise CPUs capable of running 32-bit applications in sysfs
Date:   Fri, 30 Jul 2021 12:24:40 +0100
Message-Id: <20210730112443.23245-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730112443.23245-1-will@kernel.org>
References: <20210730112443.23245-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since 32-bit applications will be killed if they are caught trying to
execute on a 64-bit-only CPU in a mismatched system, advertise the set
of 32-bit capable CPUs to userspace in sysfs.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
 arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 160b10c029c0..69edbd99e0b7 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -494,6 +494,15 @@ Description:	AArch64 CPU registers
 		'identification' directory exposes the CPU ID registers for
 		identifying model and revision of the CPU.
 
+What:		/sys/devices/system/cpu/aarch32_el0
+Date:		May 2021
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
index d99a29f52aa1..7ee1095a4585 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -67,6 +67,7 @@
 #include <linux/crash_dump.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
@@ -1320,6 +1321,24 @@ const struct cpumask *system_32bit_el0_cpumask(void)
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
2.32.0.402.g57bb445576-goog

