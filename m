Return-Path: <linux-arch+bounces-318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D627F7F2F03
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE9281189
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0551C5F;
	Tue, 21 Nov 2023 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MG0g9GvH"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABF1FD4;
	Tue, 21 Nov 2023 05:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gaUuxoRP2iSef3HGwjZTXVv7sp9dUHlrSN6JEtACmSA=; b=MG0g9GvHPLNzYgIMRjPbdF3Zjd
	MWnJjqRCsvPoH2okKjYX6iX5oYgvzh3unPGb8gsRm+/0j2HuiWbN6KE8oLw8a3H8OBvWDIK4b5xb9
	pcwSRY5fwtLgbO0/b+4UsGX5H+lmgyNpOkleh7Dln/pOGLyFrOXauYKhTJHi0n39uEvWNKXJlgL6B
	0+9jSY0gyVtms+qjjQL3QEscua+BVqfwHHHbHN1UZn2eGo1LBUJmJQaLwVp7JWkncmAqRmf2/VQSR
	UUmskRxCB1+woeIzyUCnH+nIHcRzvF0H+A7OqbPFL8fvBG+8ufHTL/uPDPApx6U5O1Hl6GIAmg4EO
	XYJxioMQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52668 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R3u-0007AY-0r;
	Tue, 21 Nov 2023 13:45:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R3w-00Cszy-6k; Tue, 21 Nov 2023 13:45:12 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 16/21] x86/topology: convert to use arch_cpu_is_hotpluggable()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3w-00Cszy-6k@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:45:12 +0000

Convert x86 to use the arch_cpu_is_hotpluggable() helper rather than
arch_register_cpu().

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/x86/kernel/topology.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 211863cb5b81..d42c28b8bfd8 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -36,11 +36,8 @@
 #include <asm/cpu.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
-int arch_register_cpu(int cpu)
+bool arch_cpu_is_hotpluggable(int cpu)
 {
-	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
-
-	c->hotpluggable = cpu > 0;
-	return register_cpu(c, cpu);
+	return cpu > 0;
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
2.30.2


