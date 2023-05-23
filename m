Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5370E358
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbjEWRGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjEWRGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 13:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635BABF;
        Tue, 23 May 2023 10:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA8C6222F;
        Tue, 23 May 2023 17:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7886FC4339B;
        Tue, 23 May 2023 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861578;
        bh=S1v3epwjKPZhhmwrrwdqziIQP7+cuuUHEgza9tY/ky4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VroAEK5OljQLhXtHf6feHA8/FP9OXYl6sjuMlhJsY8l8KPby6JgzKKo6wcnYW31kk
         7699dMhJ4mj/3Sez4d4jeyXrd9ERwFEGrqRI4zLewef48JVaieRPxC68pFZq3gnrG0
         QwLsevTvH5HQg2BMVx3o/K6NDABDbh/+eAmtHw4GRUCBfZkUonc6oKYSTltVEvG2ei
         wGp8bjpvxifPQIq+Vr3n/eYYBZuKYC77OR2xuYa91Vrd6O0cZDX3KKmKqEfPF3jLBK
         OXdEs3T9UefBk5W3LeStb3eKkp+/XzUWYJ/awKpJCTvSoEsiEa17E2YSrtqZ4j32yM
         2VuLUKy8tPE7Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/4] riscv: vmlinux-xip.lds.S: remove .alternative section
Date:   Wed, 24 May 2023 00:55:00 +0800
Message-Id: <20230523165502.2592-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523165502.2592-1-jszhang@kernel.org>
References: <20230523165502.2592-1-jszhang@kernel.org>
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

ALTERNATIVE mechanism can't work on XIP, and this is also reflected by
below Kconfig dependency:

RISCV_ALTERNATIVE
	...
	depends on !XIP_KERNEL
	...

So there's no .alternative section at all for XIP case, remove it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/vmlinux-xip.lds.S |   6 ------
 1 files changed, 6 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index eab9edc3b631..50767647fbc6 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -98,12 +98,6 @@ SECTIONS
 		__soc_builtin_dtb_table_end = .;
 	}
 
-	. = ALIGN(8);
-	.alternative : {
-		__alt_start = .;
-		*(.alternative)
-		__alt_end = .;
-	}
 	__init_end = .;
 
 	. = ALIGN(16);
-- 
2.40.1

