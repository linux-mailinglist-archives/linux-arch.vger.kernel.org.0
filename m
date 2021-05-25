Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E996439050A
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhEYPSk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhEYPSB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:18:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E906141D;
        Tue, 25 May 2021 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955790;
        bh=+/Imnr+Lo2MHpB6ujnUBakmFLkmdTTKNQf8pvMFeGqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMsDJnKhwUnXSsyJXLrzpp4HjoVRD3S63OQWe/qSC1xxp0FfgSlshU7VAV4lB9tlt
         a2vKC55LaHtqUTG6HPX6i/f5m0GoX3SN0/oQLTYycrccS+Fupt6spRFqHE+Pt2EbjX
         FJq2oAMDuRRmqfNNAVfjZQ3z3HbiBJvKzlYQByFCIufApdE3+dSHaEGEfhZ9Fs4rvL
         uQCF2tZy0dn4c8gKG04jjh1j0A/J4NEjcGRrqVTBdO8zPVKJY72c55iJLAlH+ItyGp
         mbJFmQPr363ErKG6rJp88QUrdbCb+P7oZvK5ih329JPQZLYse5jjOQk5mcQyB2Kf1s
         KpMZm+8xwHQkA==
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
        kernel-team@android.com
Subject: [PATCH v7 20/22] arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
Date:   Tue, 25 May 2021 16:14:30 +0100
Message-Id: <20210525151432.16875-21-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow systems with mismatched 32-bit support at EL0 to run 32-bit
applications based on a new kernel parameter.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 arch/arm64/kernel/cpufeature.c                  | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..a2e453919bb6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -287,6 +287,14 @@
 			do not want to use tracing_snapshot_alloc() as it needs
 			to be done where GFP_KERNEL allocations are allowed.
 
+	allow_mismatched_32bit_el0 [ARM64]
+			Allow execve() of 32-bit applications and setting of the
+			PER_LINUX32 personality on systems where only a strict
+			subset of the CPUs support 32-bit EL0. When this
+			parameter is present, the set of CPUs supporting 32-bit
+			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0
+			and hot-unplug operations may be restricted.
+
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 72efdc611b14..f2c97baa050f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1298,6 +1298,13 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 	return cpu_possible_mask;
 }
 
+static int __init parse_32bit_el0_param(char *str)
+{
+	allow_mismatched_32bit_el0 = true;
+	return 0;
+}
+early_param("allow_mismatched_32bit_el0", parse_32bit_el0_param);
+
 static ssize_t aarch32_el0_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-- 
2.31.1.818.g46aad6cb9e-goog

