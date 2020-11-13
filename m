Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F22B1867
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKMJiI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgKMJh7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:37:59 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004842224D;
        Fri, 13 Nov 2020 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260278;
        bh=pyZT5qD+AOrZwx9wlgWYY4ZAqPT58rRrfL1buWsPYnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8ja5dEDu9Kq7iP/mbreuLWq0Wx/NeTfzBLjKvZ38pEgbJ7azo8Y+RJkmt4SAONGk
         wHrU3XGPofiwF3qgrGDYRLz7pTvW7ZFSfVTswv9J1ewexzAlE2e+JxrwoO32YOo2Mc
         eltkDvXDQalZXOCA1/o3/Z2bnrV7Yqmqdj35zPm4=
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
Subject: [PATCH v3 06/14] arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
Date:   Fri, 13 Nov 2020 09:37:11 +0000
Message-Id: <20201113093720.21106-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
References: <20201113093720.21106-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow systems with mismatched 32-bit support at EL0 to run 32-bit
applications based on a new kernel parameter.

Signed-off-by: Will Deacon <will@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 arch/arm64/kernel/cpufeature.c                  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..f20188c44d83 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -289,6 +289,13 @@
 			do not want to use tracing_snapshot_alloc() as it needs
 			to be done where GFP_KERNEL allocations are allowed.
 
+	allow_mismatched_32bit_el0 [ARM64]
+			Allow execve() of 32-bit applications and setting of the
+			PER_LINUX32 personality on systems where only a strict
+			subset of the CPUs support 32-bit EL0. When this
+			parameter is present, the set of CPUs supporting 32-bit
+			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0.
+
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a7a9b7bffc49..dfded018af44 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1273,6 +1273,13 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 	return cpu_present_mask;
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
2.29.2.299.gdc1121823c-goog

