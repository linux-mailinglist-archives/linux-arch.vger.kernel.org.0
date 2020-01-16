Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226EE13DD6C
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgAPObH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 09:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAPObH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 09:31:07 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4158F214AF;
        Thu, 16 Jan 2020 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185066;
        bh=RjL5HdLG7civsy73fTv4k4f+R0TSQwtrPFMWF4g32q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qjn8wqBWj2L6b2sJheZhnC5CIgvBnl8BKi3UBDtiDWXt1ZfPJq/gsR7DeCyZ41tZ1
         qEqyZ5PuGI/IESC/3866525qRDmmGtmlCHjc8WaEs66TO48o3kqgACx93evEYrRcOG
         o4UhLhz0YM/1cx77nxX25GSN3PoAOgYyidbM0oMA=
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com,
        zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com,
        atish.patra@wdc.com, schwab@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 2/4] riscv: Rename __switch_to_aux -> fpu
Date:   Thu, 16 Jan 2020 22:30:27 +0800
Message-Id: <20200116143029.31441-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200116143029.31441-1-guoren@kernel.org>
References: <20200116143029.31441-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Anup Patel <Anup.Patel@wdc.com>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 407bcc96a710..b9234e7178d0 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -60,7 +60,7 @@ extern bool has_fpu;
 #define has_fpu false
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -71,7 +71,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu)					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.17.0

