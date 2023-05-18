Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770A70827A
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjERNQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjERNQG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0E1FF7;
        Thu, 18 May 2023 06:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C2C64F56;
        Thu, 18 May 2023 13:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03258C433D2;
        Thu, 18 May 2023 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415663;
        bh=AwoQnmBHOr8wX0BVa478M177ccT62CL+qVUXJhTICuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGfQ4mTsDn9k0q6IINE7XDk0tKpDcaHJHIxootwL5i8ZJ0N7q3ng58l2ZjEY516m9
         FKQw5tQCYBZakdMpIBAXpl2tc5W2YLS5RMM1pzt/wdz6TubznYeCa/b00k6pTNsDmR
         sc6hIPHQvtW9muFdbki2SUqga9mE3IzTx9htIZf3NlWlEZ4PQum9xN95fiZrmzSEZ9
         7OkUxnDfttaUxZJhhF2ZPadDhwpxojueC1k4ARxqVNlNJGOAruHtt4FtqbP1fMei9I
         dF84cS/k70zpGSTYTyErDjUgaKm43y7gCp4bHwDDt79Ejta9aJeaugb8egsLEIIwzm
         CL8SNUms7jvfg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH 19/22] riscv: Cleanup rv32_defconfig
Date:   Thu, 18 May 2023 09:10:10 -0400
Message-Id: <20230518131013.3366406-20-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
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

Remove unnecessary configs to make rv32_defconfig have a minimal
difference from the defconfig. CONFIG_ARCH_RV32I selects the
CONFIG_32BIT, so putting it in the file is unnecessary. Also, there is
no need to comment on CONFIG_PORTABLE; it should come from carelessness.

Next rv64ilp32_defconfig would like:
  CONFIG_ARCH_RV64ILP32=y
  CONFIG_NONPORTABLE=y

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/32-bit.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/configs/32-bit.config b/arch/riscv/configs/32-bit.config
index f6af0f708df4..eb87885c8640 100644
--- a/arch/riscv/configs/32-bit.config
+++ b/arch/riscv/configs/32-bit.config
@@ -1,4 +1,2 @@
 CONFIG_ARCH_RV32I=y
-CONFIG_32BIT=y
-# CONFIG_PORTABLE is not set
 CONFIG_NONPORTABLE=y
-- 
2.36.1

