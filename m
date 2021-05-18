Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B6387584
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbhERJtN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348090AbhERJtN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7460E613C8;
        Tue, 18 May 2021 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331275;
        bh=k5KbCUN0F2YlNMUf2xfvaa60/l+3klPfLthUfAzmzGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUh4fN2yCR5HduaVygauxlNzp5jizxbUnEaUdzEo1k9g8pVcD0mg1gChO3grPPfS3
         7xyJoUy1xX6PebVXgM4JgUFgWwbAR+anDJagqO2iXeGou2OKQ5kR87kAzk4O8PuuAt
         iDTmVXug7o5AbFjurqVgN3ohJ8Zr1Eyre91fQHrLA8dLl/l0kNlqHoZlIOQphMyojX
         6YfAah9AqPPsc/KPZmu+UrPAfhXnHaWaYnTp7GApF6LJ3UxUTqiFzEstcqv5njR41E
         91bMYM2M/OxQGfy3u6X12L7dw65enYb7fICh1NpBrx9wUnZQAk3rEenjtS1sS9vdOH
         2vQ19b/57LRfQ==
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 05/21] arm64: Advertise CPUs capable of running 32-bit applications in sysfs
Date:   Tue, 18 May 2021 10:47:09 +0100
Message-Id: <20210518094725.7701-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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
index 4194a47de62d..959442f76ed7 100644
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
2.31.1.751.gd2f1c929bd-goog

