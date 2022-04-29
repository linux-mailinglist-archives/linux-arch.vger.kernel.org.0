Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8012F5145BC
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356737AbiD2Jsd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356678AbiD2Jsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342117E2C;
        Fri, 29 Apr 2022 02:45:12 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqSJK1TPqzhYs7;
        Fri, 29 Apr 2022 17:44:49 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:10 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:10 +0800
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
Subject: [RFC PATCH v4 06/37] objtool: arm64: Decode jump and call related instructions
Date:   Fri, 29 Apr 2022 17:43:24 +0800
Message-ID: <20220429094355.122389-7-chenzhongjin@huawei.com>
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

Decode branch, branch and link (aarch64's call) and return instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 84daec62006a..351f8b1bbd6d 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -219,6 +219,27 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			}
 		}
 		break;
+	case AARCH64_INSN_CLS_BR_SYS:
+		if (aarch64_insn_is_ret(insn) &&
+		    aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn)
+			== AARCH64_INSN_REG_LR) {
+			*type = INSN_RETURN;
+		} else if (aarch64_insn_is_bl(insn)) {
+			*type = INSN_CALL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_blr(insn)) {
+			*type = INSN_CALL_DYNAMIC;
+		} else if (aarch64_insn_is_b(insn)) {
+			*type = INSN_JUMP_UNCONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_br(insn)) {
+			*type = INSN_JUMP_DYNAMIC;
+		} else if (aarch64_insn_is_branch_imm(insn)) {
+			/* Remaining branch opcodes are conditional */
+			*type = INSN_JUMP_CONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

