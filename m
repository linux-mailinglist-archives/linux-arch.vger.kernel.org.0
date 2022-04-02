Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96F4F03A0
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355977AbiDBN5S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Apr 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355943AbiDBN4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2022 09:56:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84841C12F;
        Sat,  2 Apr 2022 06:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 815EEB80885;
        Sat,  2 Apr 2022 13:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9502FC36AE5;
        Sat,  2 Apr 2022 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648907654;
        bh=kPBdsSZwAFo7vna7h4jVnZjxy4XlzYkfwZ49VTpvuBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjjXIQ4SZPksqZUberIl3l2bEnDD/L+MKfjyo66BL4yl4580WMCd9UHw2FQCXFMHZ
         YwzDuMKWeHsWOsmB4suIO6KxK0C63csPUGzuJnVC7ljrKET8hyz3WzB+UZ2/u/tGXI
         QiAje/bzwM2QslVpXWNdrHsx631xvK/IPNmYqw5gKpkE4vA6WCRr9h7g/J64ZDHx6o
         eYsIhr8c56FJLsynyelcNS9uixhRvE5IVBbxeoZDe9WUJ79beVS/Fa0uawkb5jTB1p
         V2b2P8cHmr5icIpmyThplg7IHuXyGxMOL5sTOJv0sigfgrWaybO7YQykLWhDTPMRKa
         6SXnCBf2oldYQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V11 12/20] riscv: compat: syscall: Add entry.S implementation
Date:   Sat,  2 Apr 2022 21:52:48 +0800
Message-Id: <20220402135256.2691868-13-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402135256.2691868-1-guoren@kernel.org>
References: <20220402135256.2691868-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement the entry of compat_sys_call_table[] in asm. Ref to
riscv-privileged spec 4.1.1 Supervisor Status Register (sstatus):

 BIT[32:33] = UXL[1:0]:
 - 1:32
 - 2:64
 - 3:128

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/csr.h |  7 +++++++
 arch/riscv/kernel/entry.S    | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index ae711692eec9..7f05c65654c8 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -36,6 +36,13 @@
 #define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
 #endif
 
+#ifdef CONFIG_64BIT
+#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+#define SR_UXL_SHIFT	32
+#endif
+
 /* SATP flags */
 #ifndef CONFIG_64BIT
 #define SATP_PPN	_AC(0x003FFFFF, UL)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index d6a46ed0bf05..d4a1ad4edbc6 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -207,13 +207,27 @@ check_syscall_nr:
 	 * Syscall number held in a7.
 	 * If syscall number is above allowed value, redirect to ni_syscall.
 	 */
-	bgeu a7, t0, 1f
+	bgeu a7, t0, 3f
+#ifdef CONFIG_COMPAT
+	REG_L s0, PT_STATUS(sp)
+	srli s0, s0, SR_UXL_SHIFT
+	andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
+	li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
+	sub t0, s0, t0
+	bnez t0, 1f
+
+	/* Call compat_syscall */
+	la s0, compat_sys_call_table
+	j 2f
+1:
+#endif
 	/* Call syscall */
 	la s0, sys_call_table
+2:
 	slli t0, a7, RISCV_LGPTR
 	add s0, s0, t0
 	REG_L s0, 0(s0)
-1:
+3:
 	jalr s0
 
 ret_from_syscall:
-- 
2.25.1

