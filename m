Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421475BF4F5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 05:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiIUDtj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 23:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIUDte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 23:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CFB21;
        Tue, 20 Sep 2022 20:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AA9627FB;
        Wed, 21 Sep 2022 03:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE07BC43470;
        Wed, 21 Sep 2022 03:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663732169;
        bh=XwVzwKWzSSnE5M8iQ5zKiH/uEZOA/qYNZrttzn2FPsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evMc6D5WdMFtNWHCWKTz6YKkVvfMfxzJr5PLOr8HVtcfVLSVGBMF+MZOilQrDAp/F
         QiEtDFUB4A10NFY/1eUChpXaNrY02KAuSHEkhfC5uJzyLQ5zIDgHMwJT3tRTXZHsxo
         oxCVrESLGPkfr+P55gY+71+ILubAtjpYbcgih0Srn3l8tJfz6W0gorxsxzdqUvNwZW
         mS208jHLqw3na33EBCEOnYAR904QYqH1QAzaJdJaygb2h05Lg/ZPHFLfR9uLpnZ/m7
         PBYzptMQt1k3Ketlv9IgpPn6HuPpX+KCQ6Nj+L2D/0LCRY41piSM+0/8PcDzW9iy+c
         8dMibz1MwLlng==
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        andy.chiu@sifive.com, greentime.hu@sifive.com, zong.li@sifive.com,
        jrtc27@jrtc27.com, mingo@redhat.com, palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/3] riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
Date:   Tue, 20 Sep 2022 23:49:09 -0400
Message-Id: <20220921034910.3142465-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220921034910.3142465-1-guoren@kernel.org>
References: <20220921034910.3142465-1-guoren@kernel.org>
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

