Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2F399070
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhFBQuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 12:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhFBQuR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jun 2021 12:50:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9118261C1A;
        Wed,  2 Jun 2021 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622652514;
        bh=x0QP/3o6xRJ/gC/T6Aypyq2owsN7PsaVjL0+LhRfv9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBnfLC8lVlr7fHXCOk8mA0nAY/vKDSF+BFWsimunyPFQGA+5mKZ6F4dgWi7zGHvnu
         DwylaewYl9cAatwBF4rvFQ6I6/vN6gYXGkEqknGS+EYwAuluMHSb8HLzE2jJohIZnl
         0de3WtTvewghIQ+8CdgMRCEqPCLPQ/fM3iF3chVsCLr0Fox52NRahcu642ScVWWsBq
         0FQ6eHTSobS3Q3H+jYa5+mjBLGCi998N8MQSZYdb+V8CDWvE9WMRJM+cEfQiSEaTBE
         0gHV+Lb5RGqHOERkJNW1wmkmm3yssDuwrvtXJChDZhVQZDIL/HDe9QO1MNHtcJfi/a
         RNO7hNv6sIyPg==
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
        kernel-team@android.com
Subject: [PATCH v8 16/19] arm64: Advertise CPUs capable of running 32-bit applications in sysfs
Date:   Wed,  2 Jun 2021 17:47:16 +0100
Message-Id: <20210602164719.31777-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602164719.31777-1-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org>
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
index fe13baa53c59..899377b2715a 100644
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
index b31d7a1eaed6..72efdc611b14 100644
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
@@ -1297,6 +1298,24 @@ const struct cpumask *system_32bit_el0_cpumask(void)
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
2.32.0.rc0.204.g9fa02ecfa5-goog

