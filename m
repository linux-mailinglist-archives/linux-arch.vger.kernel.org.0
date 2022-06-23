Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2B55708E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbiFWBxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377637AbiFWBwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:52:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4843EC5;
        Wed, 22 Jun 2022 18:51:54 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LT37J1xxkzShCC;
        Thu, 23 Jun 2022 09:48:28 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:53 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:52 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
Subject: [PATCH v6 32/33] arm64: irq-gic: Replace unreachable() with -EINVAL
Date:   Thu, 23 Jun 2022 09:49:16 +0800
Message-ID: <20220623014917.199563-33-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220623014917.199563-1-chenzhongjin@huawei.com>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Using unreachable() at default of switch generates an extra branch at
end of the function, and compiler won't generate a ret to close this
branch because it knows it's unreachable.

If there's no instruction in this branch, compiler will generate a NOP,
And it will confuse objtool to warn this NOP as a fall through branch.

In fact these branches are actually unreachable, so we can replace
unreachable() with returning a -EINVAL value.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 7 +++----
 drivers/irqchip/irq-gic-v3.c    | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
index 4fb419f7b8b6..f3cee92c3038 100644
--- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
@@ -6,7 +6,6 @@
 
 #include <hyp/adjust_pc.h>
 
-#include <linux/compiler.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/kvm_host.h>
 
@@ -55,7 +54,7 @@ static u64 __gic_v3_get_lr(unsigned int lr)
 		return read_gicreg(ICH_LR15_EL2);
 	}
 
-	unreachable();
+	return -EINVAL;
 }
 
 static void __gic_v3_set_lr(u64 val, int lr)
@@ -166,7 +165,7 @@ static u32 __vgic_v3_read_ap0rn(int n)
 		val = read_gicreg(ICH_AP0R3_EL2);
 		break;
 	default:
-		unreachable();
+		val = -EINVAL;
 	}
 
 	return val;
@@ -190,7 +189,7 @@ static u32 __vgic_v3_read_ap1rn(int n)
 		val = read_gicreg(ICH_AP1R3_EL2);
 		break;
 	default:
-		unreachable();
+		val = -EINVAL;
 	}
 
 	return val;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b252d5534547..2ef98e32d257 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -475,7 +475,7 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 	case EPPI_RANGE:
 		return hwirq - EPPI_BASE_INTID + 16;
 	default:
-		unreachable();
+		return -EINVAL;
 	}
 }
 
-- 
2.17.1

