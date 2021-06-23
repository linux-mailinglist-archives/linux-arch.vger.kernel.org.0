Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAE3B1FC4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFWRmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFWRmL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:42:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6147761358;
        Wed, 23 Jun 2021 17:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624469993;
        bh=Ay5njwJtQ49gtfXuMnHuSoPfWpf15KymMwIsFOkGhog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIpqYeFqvkY/q85XPiP/eC1HD62BWtPK9gOydf1pWlqHKJI9+GvtKntYxIcBU8zFE
         Hg/BRN32ILW+OhkoIQODezWCr9CJ6p2xDm6Py+pq9A5COL818Khi27Q1155jb1zIAI
         FPdmyxQeSQKO9mrLgiMTnPfBMKMnYzNaw0il+Y8plFpg3u2IFR7PYFa8ktzkJ6LW3C
         RxIST8Au+iBgQDLaFjCNLfzc/twGXSELc2+omJjdqNC8he4AuYtItCXMr1jt7mvdm2
         ESufuI/gEz8TCEMr8MysE0JgBIWeECno9tvHEEI6znVbGNP3/omK+MrkdYSmIkAS6b
         vtoGs15eQrDgg==
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
Subject: [PATCH v10 14/16] arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
Date:   Wed, 23 Jun 2021 18:38:46 +0100
Message-Id: <20210623173848.318-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623173848.318-1-will@kernel.org>
References: <20210623173848.318-1-will@kernel.org>
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
index 23eaa7f06f76..8c9f9a57626a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1320,6 +1320,13 @@ const struct cpumask *system_32bit_el0_cpumask(void)
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
2.32.0.93.g670b81a890-goog

