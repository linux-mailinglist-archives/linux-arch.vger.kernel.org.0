Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B475BABC4
	for <lists+linux-arch@lfdr.de>; Fri, 16 Sep 2022 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIPKyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Sep 2022 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiIPKyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 06:54:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A9B0888;
        Fri, 16 Sep 2022 03:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC7FDB825ED;
        Fri, 16 Sep 2022 10:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF95C433D7;
        Fri, 16 Sep 2022 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663324724;
        bh=XwVzwKWzSSnE5M8iQ5zKiH/uEZOA/qYNZrttzn2FPsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTADtsZQRqUgZ8Fu8jhyGQlwDX+YFuhK7dKHvbytFm1kbh7Bz5o0AYIRQ1CKHpLaD
         dL+k/Zc4OXvMjhj3lrcRpHsA8JgicJFnT+sr/Z23qpp+sQgb9hbS3zcVk/AoFIT1RA
         scCeGOk6tHEeRUmM72HNnP7IZJscZ7b2CQyBxXGZsffoIHv/EOZExfNHRJFOcp0pVs
         EFr61FAgMYwXPS4pfEwiZoK8yuUpunq3JbepWzlKJi0RIDBWDIW4R1NLqO28p3vff2
         x0/jz9yfNRaW6gOQd60rLeUXWGqFPbnrDUJ7DGGwJNfL/8iglchb7FccXYNG07aox9
         FTAtQQ/lhxQBg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        rostedt@goodmis.org, andy.chiu@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, jrtc27@jrtc27.com, mingo@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
Date:   Fri, 16 Sep 2022 06:38:16 -0400
Message-Id: <20220916103817.9490-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220916103817.9490-1-guoren@kernel.org>
References: <20220916103817.9490-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_RISCV_ISA_C=n, -fpatchable-function-entry=8 would generate
more nops than we expect. Because it treat nop opcode as 0x00000013
instead of 0x0001.

Dump of assembler code for function dw_pcie_free_msi:
   0xffffffff806fce94 <+0>:     sd      ra,-8(sp)
   0xffffffff806fce98 <+4>:     auipc   ra,0xff90f
   0xffffffff806fce9c <+8>:     jalr    -684(ra) # 0xffffffff8000bbec
<ftrace_caller>
   0xffffffff806fcea0 <+12>:    ld      ra,-8(sp)
   0xffffffff806fcea4 <+16>:    nop /* wasted */
   0xffffffff806fcea8 <+20>:    nop /* wasted */
   0xffffffff806fceac <+24>:    nop /* wasted */
   0xffffffff806fceb0 <+28>:    nop /* wasted */
   0xffffffff806fceb4 <+0>:     addi    sp,sp,-48
   0xffffffff806fceb8 <+4>:     sd      s0,32(sp)
   0xffffffff806fcebc <+8>:     sd      s1,24(sp)
   0xffffffff806fcec0 <+12>:    sd      s2,16(sp)
   0xffffffff806fcec4 <+16>:    sd      s3,8(sp)
   0xffffffff806fcec8 <+20>:    sd      ra,40(sp)
   0xffffffff806fcecc <+24>:    addi    s0,sp,48

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3fa8ef336822..f32844f545d6 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -11,7 +11,11 @@ LDFLAGS_vmlinux :=
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux := --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+ifeq ($(CONFIG_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=8
+else
+	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+endif
 endif
 
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
-- 
2.36.1

