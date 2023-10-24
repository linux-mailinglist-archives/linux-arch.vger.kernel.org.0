Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2947D566E
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjJXPaY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjJXP3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:29:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64241720;
        Tue, 24 Oct 2023 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wObq1ZtL38GoyXrpykUfQ+L3NY/VXeUmDZFIelovoYM=; b=FZDrLbP5QGr0Bfm6ivhiO1LbjQ
        Y4iafTUgbHLhkHP38WYvvVy6wgsx3XPMAkOraEF/gFnmpk/e9X8NZoY39Fs82GsEQOi/AN3hzJ2z/
        AKclEoxu7/BMPGlEBiHrVD+WGnT9K6F7yHYlIdOhSJ2tG/uPgN7TE9h8GpOG9WAE91evCIgpZBP3I
        fNhegreY0+W0QGkObxdbNBGb1DIqOBJzYV1rmlxYQLBApbk5ERid6ZuTH8skj0JKRp7i3gwXyHFeE
        sSLJw4ITb6s22exlxYg9WpCPCaWm2XP1LB3GblSxuM+VwsqI4Bu6lJ4uGAL4IC/+A7rVLNhjbUQUr
        pajifeoQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46028 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJBO-0004WC-2a;
        Tue, 24 Oct 2023 16:19:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJBQ-00AqS8-8B; Tue, 24 Oct 2023 16:19:04 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:19:04 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a CPU is marked as disabled, but online capable in the MADT, PSCI
applies some firmware policy to control when it can be brought online.
PSCI returns DENIED to a CPU_ON request if this is not currently
permitted. The OS can learn the current policy from the _STA enabled bit.

Handle the PSCI DENIED return code gracefully instead of printing an
error.

See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[ morse: Rewrote commit message ]
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2
 * Add specification reference
 * Use EPERM rather than EPROBE_DEFER
---
 arch/arm64/kernel/psci.c     | 2 +-
 arch/arm64/kernel/smp.c      | 3 ++-
 drivers/firmware/psci/psci.c | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 29a8e444db83..4fcc0cdd757b 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 {
 	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
-	if (err)
+	if (err && err != -EPROBE_DEFER)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
 	return err;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8c8f55721786..68ec7fbe166f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -124,7 +124,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Now bring the CPU into our world */
 	ret = boot_secondary(cpu, idle);
 	if (ret) {
-		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		if (ret != -EPERM)
+			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 		return ret;
 	}
 
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..ee82e7880d8c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -218,6 +218,8 @@ static int __psci_cpu_on(u32 fn, unsigned long cpuid, unsigned long entry_point)
 	int err;
 
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
+	if (err == PSCI_RET_DENIED)
+		return -EPERM;
 	return psci_to_linux_errno(err);
 }
 
-- 
2.30.2

