Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA950740CF2
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjF1J1e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjF1JMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 05:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E25C1FED;
        Wed, 28 Jun 2023 02:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDBEC61272;
        Wed, 28 Jun 2023 09:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CBDC433C0;
        Wed, 28 Jun 2023 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687943540;
        bh=4+LWuCHhCgLBPx3TQt9FM+S9EBnOCqZEpjrJRHY4slg=;
        h=From:To:Cc:Subject:Date:From;
        b=tEFODtSPH9PwiiyWel/MqR3Vzv7WJ+Q5hdPMZOE5rk7JHo0dmjMiWCJ3fD/rindP7
         laSw4+QNVvtyArW+7XMcYXsP4eeI0/NYxQQMseeQxRlgpWARua881xj65+f/uJbjhz
         45w9SypuKhJeEqOKycFqmczZbUVGO8x+mkK21HQZqmX1xHxnIzOWwiw9EFoUwveugr
         o3HyCoZOCFma5KOz2/g7d6kxzG8ptoXNAGbMStOCprEngfPpRxhUIM5hnvc6/w6Ao2
         dPDZsqtsuAo75kd9lMATaxw9CsHPsy9aB2yrXu8MF5ncYvJDC8NvYuHG46blzHg7DH
         SP/E+6MYRdudQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: sigcontext: Correct the comment of sigreturn
Date:   Wed, 28 Jun 2023 05:12:13 -0400
Message-Id: <20230628091213.2908149-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The real-time signals enlarged the sigset_t type, and most architectures
have changed to using rt_sigreturn as the only way. The riscv is one of
them, and there is no sys_sigreturn in it. Only some old architecture
preserved sys_sigreturn as part of the historical burden.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/uapi/asm/sigcontext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index 8b8a8541673a..ca5b5c8391a0 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -23,7 +23,7 @@ struct __sc_riscv_v_state {
  * Signal context structure
  *
  * This contains the context saved before a signal handler is invoked;
- * it is restored by sys_sigreturn / sys_rt_sigreturn.
+ * it is restored by sys_rt_sigreturn.
  */
 struct sigcontext {
 	struct user_regs_struct sc_regs;
-- 
2.36.1

