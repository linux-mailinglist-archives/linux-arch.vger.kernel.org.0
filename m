Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE86FF3FB
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjEKOXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbjEKOXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 10:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBA5FD2;
        Thu, 11 May 2023 07:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4B6A614F5;
        Thu, 11 May 2023 14:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3FC4339B;
        Thu, 11 May 2023 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814998;
        bh=ttH63jm3oRXZocNrzbxAhA7UBN+8YVEox9ekGGVcYR4=;
        h=From:To:Cc:Subject:Date:From;
        b=jcQ8/lb8jG/eXSbSQ+XOukeP6fiMjxMNAHRGswnfJWJSA8ZN9cYOCk8QF4TgIHCyK
         CVaTJdz6iQhaAR8iGuUbjl9RB8PGFnAI2K/gHl1dpN8NzcGq/3Elxa5NKBdh0tvhlu
         yHxluj4e9zLA5rMniU07TSvx8XWgFBdCzzIPzqX9w9U02uEyY0uZCHGK5G+I1chxw0
         /UET0S2RPJisdLI94Q9oZFTkqO9dd6bCDMJqGhZHirBWBIrnQ/tqCW+XPfI1brvo2i
         VyqAon31aX+YIDTDFwKxoffiHCWUPF82DmlXhbULi2SE2onh3N++hf6CCaGQ1Mc7yD
         Yx+aWDbkTfHIw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Date:   Thu, 11 May 2023 22:12:07 +0800
Message-Id: <20230511141211.2418-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
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

When trying to run linux with various opensource riscv core on
resource limited FPGA platforms, for example, those FPGAs with less
than 16MB SDRAM, I want to save mem as much as possible. One of the
major technologies is kernel size optimizations, I found that riscv
does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
--gc-sections flag to the linker.

This not only benefits my case on FPGA but also benefits defconfigs.
Here are some notable improvements from enabling this with defconfigs:

nommu_k210_defconfig:
   text    data     bss     dec     hex
1112009  410288   59837 1582134  182436     before
 962838  376656   51285 1390779  1538bb     after

rv32_defconfig:
   text    data     bss     dec     hex
8804455 2816544  290577 11911576 b5c198     before
8692295 2779872  288977 11761144 b375f8     after

defconfig:
   text    data     bss     dec     hex
9438267 3391332  485333 13314932 cb2b74     before
9285914 3350052  483349 13119315 c82f53     after

patch1 and patch2 are clean ups.
patch3 fixes a typo.
patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.

Jisheng Zhang (4):
  riscv: vmlinux-xip.lds.S: remove .alternative section
  riscv: move HAVE_RETHOOK to keep entries sorted
  riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
  vmlinux.lds.h: use correct .init.data.* section name

 arch/riscv/Kconfig                  | 3 ++-
 arch/riscv/kernel/vmlinux-xip.lds.S | 6 ------
 arch/riscv/kernel/vmlinux.lds.S     | 6 +++---
 include/asm-generic/vmlinux.lds.h   | 2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.40.1

