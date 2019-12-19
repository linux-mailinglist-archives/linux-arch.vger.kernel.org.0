Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7922E1261E9
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2019 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSMTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Dec 2019 07:19:43 -0500
Received: from foss.arm.com ([217.140.110.172]:37946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfLSMTm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Dec 2019 07:19:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 966C231B;
        Thu, 19 Dec 2019 04:19:41 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BE753F719;
        Thu, 19 Dec 2019 04:19:39 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com,
        linux@armlinux.org.uk, davem@davemloft.net,
        sparclinux@vger.kernel.org, hch@infradead.org
Subject: [RFC PATCH v3 07/12] arm64: smp: add arch specific cpu parking helper
Date:   Thu, 19 Dec 2019 12:19:00 +0000
Message-Id: <20191219121905.26905-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219121905.26905-1-cristian.marussi@arm.com>
References: <20191219121905.26905-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add an arm64 specific helper which parks the cpu in a more architecture
efficient way.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm64/kernel/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edb2de85507a..3f108be544f8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -952,6 +952,12 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
+void arch_smp_cpu_park(void)
+{
+	while (1)
+		cpu_park_loop();
+}
+
 void arch_smp_cpus_stop_complete(void)
 {
 	sdei_mask_local_cpu();
-- 
2.17.1

