Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955A7D55FC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjJXPWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjJXPVc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:21:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B861FDC;
        Tue, 24 Oct 2023 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OJBhmyu/vU7K1KRJlvc2+ydilRGhWCEq5NT0Tp7+EuE=; b=iG1/WzYfoNKMjG2yRgqZ7a5B0t
        WY8q8c75UjwIZGLwimqMAq+a5yTVtFo/3pMzO+5/QGwrpwXMxCov9HkQ7Dn1xzchPFUFPSzJImOvY
        DwcMTnTgwJ0oSlPsItxxXEpaLM88bE1KJtLbUXsD+yhx9bjRTTSJSjIdQD9BjWYWTn5Y2oTZPOUU2
        qJuUrhkO/SLTo/YujC5eGYjr4v+HOW00S+A21rFPqgc/w/RF2BqHzD7Gcm58inz/AwZgGKsjT4p10
        6jybcpzSBfl4agcBvOuVM5jZrOfrhlUS7+RyIeP+amro9BXC+vhzHxrJ0TC39ACMtD5qSZOF60yB0
        DuAqUghg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47588 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJAz-0004Uh-0A;
        Tue, 24 Oct 2023 16:18:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJB0-00AqRe-H9; Tue, 24 Oct 2023 16:18:38 +0100
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
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 29/39] LoongArch: Use the __weak version of
 arch_unregister_cpu()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJB0-00AqRe-H9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:18:38 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

LoongArch provides its own arch_unregister_cpu(). This clears the
hotpluggable flag, then unregisters the CPU.

It isn't necessary to clear the hotpluggable flag when unregistering
a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
pointer, meaning cpu_is_hotpluggable() will return false, as
get_cpu_device() has returned NULL.

Remove arch_unregister_cpu() and use the __weak version.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/loongarch/kernel/topology.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index bf58351beac1..b595edbfdbcd 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -19,13 +19,4 @@ int arch_register_cpu(int cpu)
 	return register_cpu(c, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
-
-void arch_unregister_cpu(int cpu)
-{
-	struct cpu *c = &per_cpu(cpu_devices, cpu);
-
-	c->hotpluggable = 0;
-	unregister_cpu(c);
-}
-EXPORT_SYMBOL(arch_unregister_cpu);
 #endif
-- 
2.30.2

