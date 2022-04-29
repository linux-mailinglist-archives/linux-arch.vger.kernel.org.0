Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC585145A2
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356754AbiD2Jsf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356740AbiD2Jsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16381DA5B;
        Fri, 29 Apr 2022 02:45:14 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqSCV2ZSrzCsSq;
        Fri, 29 Apr 2022 17:40:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:13 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:12 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [RFC PATCH v4 19/37] arm64: irq-gic: Replace unreachable() with -EINVAL
Date:   Fri, 29 Apr 2022 17:43:37 +0800
Message-ID: <20220429094355.122389-20-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429094355.122389-1-chenzhongjin@huawei.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Using unreachable() at end of function generates an extra NOP for
.unreachable section. It can confuse objtool to warn this NOP as
fall through instruction.

Considering that these branches are actually unreachable, replace
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

