Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61EA5145AE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356756AbiD2Jsh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356733AbiD2Jsc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FD1A808;
        Fri, 29 Apr 2022 02:45:13 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqSFj0wwvzGpTv;
        Fri, 29 Apr 2022 17:42:33 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:11 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:11 +0800
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
Subject: [RFC PATCH v4 11/37] objtool: arm64: Handle supported relocations in alternatives
Date:   Fri, 29 Apr 2022 17:43:29 +0800
Message-ID: <20220429094355.122389-12-chenzhongjin@huawei.com>
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

From: Julien Thierry <jthierry@redhat.com>

Based on get_alt_insn() in arch/arm64/kernel/alternative.c, arm64
alternative code adapts offsets for static branches and adrp
instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index 45f283283091..a70b91e8bd7d 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -10,7 +10,11 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc)
 {
-	return false;
+	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
+
+	return aarch64_insn_is_branch_imm(opcode) ||
+	       aarch64_insn_is_adrp(opcode) ||
+	       !aarch64_insn_uses_literal(opcode);
 }
 
 
-- 
2.17.1

