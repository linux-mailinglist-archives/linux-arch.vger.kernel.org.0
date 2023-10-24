Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124197D558B
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjJXPTR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjJXPS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 11:18:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D2198E;
        Tue, 24 Oct 2023 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+gACgpTQj8OpvruPj/p3shExXAIg9qVB65uOYbGxgdU=; b=S+hMwPD1b9oQ/RqKbnhw1l9eHh
        B5f+XBLR8a9qXl8fH2rLn1s6mfbARa4b9U6prgqxT3kAF5/t7lW8FVuiVE0g4iWDxuaMel/MnTKcl
        cNt8zlbqh3Td1sLM/Qe/hT6rUp3qsPThS8Ffp1E9er9heuQqHfLJMZCIrdGWVrxXqLdTK8eG4GjBh
        fawV+SO4XGkk8Sw9U7RkxiPTsv8nmLQs7ydSMjvkhp1MYiTFVMRya3EPZdkR91BPLwRgyXw4H0dMy
        iDr8dmnkOcHbcaTVLbYtp0eQIcv7M4EvJ9RiSiidyLEzaFqHhqZmQNTh+700LPffqertf8Nz6fyaZ
        S6Yjv1xw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34484 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ9e-0004Ox-2H;
        Tue, 24 Oct 2023 16:17:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ9g-00AqQ5-5y; Tue, 24 Oct 2023 16:17:16 +0100
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 13/39] x86: intel_epb: Don't rely on link order
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ9g-00AqQ5-5y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:17:16 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: James Morse <james.morse@arm.com>

intel_epb_init() is called as a subsys_initcall() to register cpuhp
callbacks. The callbacks make use of get_cpu_device() which will return
NULL unless register_cpu() has been called. register_cpu() is called
from topology_init(), which is also a subsys_initcall().

This is fragile. Moving the register_cpu() to a different
subsys_initcall()  leads to a NULL dereference during boot.

Make intel_epb_init() a late_initcall(), user-space can't provide a
policy before this point anyway.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
subsys_initcall_sync() would be an option, but moving the register_cpu()
calls into ACPI also means adding a safety net for CPUs that are online
but not described properly by firmware. This lives in subsys_initcall_sync().
---
 arch/x86/kernel/cpu/intel_epb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba91321c..f18d35fe27a9 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -237,4 +237,4 @@ static __init int intel_epb_init(void)
 	cpuhp_remove_state(CPUHP_AP_X86_INTEL_EPB_ONLINE);
 	return ret;
 }
-subsys_initcall(intel_epb_init);
+late_initcall(intel_epb_init);
-- 
2.30.2

