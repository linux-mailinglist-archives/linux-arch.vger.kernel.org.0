Return-Path: <linux-arch+bounces-172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA527E8EC4
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581B7280CFC
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29653A1;
	Sun, 12 Nov 2023 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbI2EEzZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23405386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DF4C433CA;
	Sun, 12 Nov 2023 06:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769947;
	bh=NRQ3+7zYtWxcLMyaVKQL6b/W2ki6kHtASjhWDkIuCOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbI2EEzZrCv1lHLtCSo4ml+lsXoi2BDR011BlUq9xT0ZNKfCfIJqP1pKQzJBh8N7g
	 kiMUAnJS6x4AZgmjx2yE/Ll/Yh2fkJYiBAoM1ZsZW9v4oJc0VHf32QSGCngpncB27v
	 LrJ7/m8DB/od4SkM4KJERf+onE6k2uJojjXohO3T1P7hGXPF9PwyWGjUI50nFnK721
	 NoXn00HX/mfQHlJg2099EljXDIxLj0RA4ke7+vHnDG/TY9K29A8ZFU5Obq3R9yBR2D
	 rgeYSxG2x8DJrDFwGs5DcDwJRy82wG1hlg4UfnC8H60hdWaKQfalzVHUZciXmdD3qd
	 MVlNJeiEpTn4w==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 36/38] irqchip: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
Date: Sun, 12 Nov 2023 01:15:12 -0500
Message-Id: <20231112061514.2306187-37-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When s64ilp32 enabled, CONFIG_32BIT=y but __riscv_xlen=64. So we
must use __riscv_xlen to detect real machine XLEN for CSR access.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/irqchip/irq-riscv-intc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..ee3514ef4326 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -22,10 +22,7 @@ static struct irq_domain *intc_domain;
 
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
-	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
-
-	if (unlikely(cause >= BITS_PER_LONG))
-		panic("unexpected interrupt cause");
+	xlen_t cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
 	generic_handle_domain_irq(intc_domain, cause);
 }
@@ -117,7 +114,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
+	intc_domain = irq_domain_create_linear(fn, __riscv_xlen,
 					       &riscv_intc_domain_ops, NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
@@ -132,7 +129,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped\n", __riscv_xlen);
 
 	return 0;
 }
-- 
2.36.1


