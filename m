Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AB7D55C8
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjJXPVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjJXPT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:19:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537910E3;
        Tue, 24 Oct 2023 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X5Z3Nkf5E4AARS+LHoFvElPsf0E44YGYiNzXX8jAQTI=; b=KMVeJnaKKwNEXhfQUmDrES4Snp
        XVvjqbxfqo6dLoYwamROVwhdcf+ZovVQJI7nDYDGQtcNIXjfIT8e7KsFeto4CPCANkXvu4t9K4Y+g
        8EGsTU5QpumHaaHipUSZyR13cFFVehwjO/0SFEc+a9oyQs8c2MGh5V3uwAXUPf7q0fXPquP3hLEJy
        Yzqs5yQ5uo1f5zI1l2MQZ9XL7/fXlSAGmRdqC0+pVYMp1Z9i9VoONTVYY/uld4OO+hy99c97jEcyL
        Hniy37vHKdoNG4BwZgaojb/AMgXRdKgZ2qQQjWXVjYQP8wKJN0AeDHybJXL9JPfGFMLw+qJ5Nr0tt
        HjcFxc7g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57434 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJAU-0004SZ-0c;
        Tue, 24 Oct 2023 16:18:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJAV-00AqR4-LS; Tue, 24 Oct 2023 16:18:07 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 23/39] drivers: base: Implement weak arch_unregister_cpu()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJAV-00AqR4-LS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:18:07 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

Add arch_unregister_cpu() to allow the ACPI machinery to call
unregister_cpu(). This is enough for arm64, riscv and loongarch, but
needs to be overridden by x86 and ia64 who need to do more work.

CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
Changes since RFC v2:
 * Move earlier in the series
---
 drivers/base/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6c70a004c198..2b9cb2667654 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -531,7 +531,14 @@ int __weak arch_register_cpu(int cpu)
 {
 	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
 }
-#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+void __weak arch_unregister_cpu(int num)
+{
+	unregister_cpu(&per_cpu(cpu_devices, num));
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_GENERIC_CPU_DEVICES */
 
 static void __init cpu_dev_register_generic(void)
 {
-- 
2.30.2

