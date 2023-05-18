Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE7708267
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjERNOb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjERNNz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915A1BF2;
        Thu, 18 May 2023 06:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C94A64F5F;
        Thu, 18 May 2023 13:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57254C433A8;
        Thu, 18 May 2023 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415586;
        bh=bke8fOXFDjV1zILAGkdyjNPTOfL1ZR2nFogEIcEnLNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAMuo5pzwMOpvpmRdsBO4B//KtrUXd+imzrD5Mh3DDlBHufx0EB8V67w+qPAZFV1z
         dsqcutlrg70o3jltbUb8FdXkMkK0WOJiUziB5H/f9M6hsBAsHfvZAoRpxHo/Hnk2D8
         OMPuo3LdhV3xqOxptOa0dkbeZEbo4AKYiMSGU5osum00FOUUMxAffoFb8mVcVMhH8J
         XeXitd2dU/FrKFfnDAI3T+wzVF1rTw/2U5SFNj5R+JMAsFe0U4ohwdoDLHRxLQ1L/i
         uM55dAsOlzVyslN7sFhhHr/n12ybWoBzk/8MLAWevVB0GKpEtGKqK+xTAD0/MU2Z6q
         0jXdFydmOx8Sg==
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
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kerenl.org>
Subject: [RFC PATCH 12/22] riscv: s64ilp32: Add ELF32 support
Date:   Thu, 18 May 2023 09:10:03 -0400
Message-Id: <20230518131013.3366406-13-guoren@kernel.org>
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

Use abi_len to distinct ELF32 and ELF64 because s64ilp32 is xlen=64 and
abi_len=32 (__SIZEOF_POINTER__=4). And s64ilp32 is an ELF32 based the
same as s32ilp32.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kerenl.org>
---
 arch/riscv/include/uapi/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..962e8ec8fe05 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -24,7 +24,7 @@ typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
 
-#if __riscv_xlen == 64
+#if __SIZEOF_POINTER__ == 8
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
 #define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
 #else
-- 
2.36.1

