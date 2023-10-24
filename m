Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F637D5512
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJXPQZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjJXPQY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:16:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40CDE;
        Tue, 24 Oct 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lY8MAhZ9Z+rtoj2wYABQB+N0CKSqFLYW9u3X+b/CjEk=; b=MIuYVLL/ss5nnQ4+gplZqkXCRX
        /MNdqQD/kryr4L2BxVRmfVOR58iw9MZRAu7mb2BCNGmTN1dK7FEdQWftEa+sicdcBpQVsB35lO3+q
        loolpA9iU7Nq0WKV7S80BBm1kkkp3/Hqzxn2bhcPWBtllfuHD46+oW1MfiXWY4skJ8cNz6Fbxa5Q4
        BWHxYre5Zagm7L3Z/H5OVTAuVERhN8hxTx0akFq2Pp+ZMOft8NXNMMc/MRtlyagRrCGlVHUQunuWP
        CmhzqTPGGVUkyPEeeIwTclwblDOGmJVvUf+3/BRntJEDqLntj6Yxkh+eI2Dm/dz4qRwlNo/k7whLQ
        Md+spz1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60856 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ8e-0004LL-36;
        Tue, 24 Oct 2023 16:16:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ8g-00AqOs-E9; Tue, 24 Oct 2023 16:16:14 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 01/39] parisc: simplify smp_prepare_boot_cpu()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ8g-00AqOs-E9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:16:14 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

smp_prepare_boot_cpu() reads the cpuid of the first CPU, printing a
message to state which processor booted, and setting it online and
present.

This cpuid is retrieved from per_cpu(cpu_data, 0).cpuid, which is
initialised in arch/parisc/kernel/processor.c:processor_probe() thusly:

	p = &per_cpu(cpu_data, cpuid);
...
	p->cpuid = cpuid;	/* save CPU id */

Consequently, the cpuid retrieved seems to be guaranteed to also be
zero, meaning that the message printed in this boils down to:

	pr_info("SMP: bootstrap CPU ID is 0\n");

Moreover, since kernel/cpu.c::boot_cpu_init() already sets CPU 0 to
be present and online, there is no need to do this again in
smp_prepare_boot_cpu().

Remove this code, and simplify the printk().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/parisc/kernel/smp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 2019c1f04bd0..444154271f23 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -404,13 +404,7 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
 
 void __init smp_prepare_boot_cpu(void)
 {
-	int bootstrap_processor = per_cpu(cpu_data, 0).cpuid;
-
-	/* Setup BSP mappings */
-	printk(KERN_INFO "SMP: bootstrap CPU ID is %d\n", bootstrap_processor);
-
-	set_cpu_online(bootstrap_processor, true);
-	set_cpu_present(bootstrap_processor, true);
+	pr_info("SMP: bootstrap CPU ID is 0\n");
 }
 
 
-- 
2.30.2

