Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7904C13058E
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jan 2020 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAECw0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Jan 2020 21:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAECw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 4 Jan 2020 21:52:26 -0500
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA31215A4;
        Sun,  5 Jan 2020 02:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578192746;
        bh=14ajwVbMlY0SfFFuMpMoc9Aw5UqL29m6fRijmZpEQCY=;
        h=From:To:Cc:Subject:Date:From;
        b=UYYAYWFGK/QyuziUyK+QU8wQ1n3K8ToZplVGhLa2n2Kc2aqyLcQp92Cheif2CajGy
         X7XGulwYMsGiiu7Z1JRaA8xujippXhXXxmeu3i4X73zfrZbMvFW/sUwwWdiKCr5RE0
         20JZhuQv664UIt1DPTDMGmiLsIwyCiZuOjuACS7M=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com,
        zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com,
        atish.patra@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/2] riscv: Fixup obvious bug for fp-regs reset
Date:   Sun,  5 Jan 2020 10:52:14 +0800
Message-Id: <20200105025215.2522-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

CSR_MISA is defined in Privileged Architectures' spec: 3.1.1 Machine
ISA Register misa. Every bit:1 indicate a feature, so we should beqz
reset_done when there is no F/D bit in csr_msia register.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 797802c73dee..2227db63f895 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -251,7 +251,7 @@ ENTRY(reset_regs)
 #ifdef CONFIG_FPU
 	csrr	t0, CSR_MISA
 	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
-	bnez	t0, .Lreset_regs_done
+	beqz	t0, .Lreset_regs_done
 
 	li	t1, SR_FS
 	csrs	CSR_STATUS, t1
-- 
2.17.0

