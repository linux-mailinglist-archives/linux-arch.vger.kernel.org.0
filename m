Return-Path: <linux-arch+bounces-321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E37F2F15
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 14:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F6280F61
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A468537F6;
	Tue, 21 Nov 2023 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nqEI3WAY"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0C2116;
	Tue, 21 Nov 2023 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+z5XQz9hkPdS0YKuNfOGCu3IbWCtcbacoD2q0D9vrOw=; b=nqEI3WAYyZJxyF64IPxHkEcmAY
	0zHoBuLtkhuFbNVcphsa3DR1CeqPZB8OSJMxCewkeWa+3r2aRJsHBifLQNzcf7MdKmzS1irlVZkYc
	brexTxcjHljrYi9MqZlt5qPB0WZSIyTye8i3BP0Zsn2z3KX0mr0Gn5Tcy8sDo7ivRPUFHcyhdHmZI
	xY5m6A2RKQWhX7ADcpvQEAebkLT7S173hXa0lfCHHX101Jmg8lcPJghMpq/+37DDamUSLgZ0cIKEW
	orniAC8aOnbU5vGiNE6gevFXQqqcprYTUH/S//Uj72YUyJ3jSj49RkNbty3y/3+ePbiMNEMbtbVJ8
	YShdbryA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32984 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R49-0007BM-2B;
	Tue, 21 Nov 2023 13:45:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R4B-00Ct0G-Kk; Tue, 21 Nov 2023 13:45:27 +0000
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 19/21] LoongArch: convert to use arch_cpu_is_hotpluggable()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R4B-00Ct0G-Kk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:45:27 +0000

Convert loongarch to use the arch_cpu_is_hotpluggable() helper rather
than arch_register_cpu(). Also remove the export as nothing should be
using arch_register_cpu() outside of the core kernel/acpi code.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/loongarch/kernel/topology.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index 866c2c9ef6ab..75d5c51a7cd3 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -11,11 +11,8 @@
 #include <acpi/processor.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
-int arch_register_cpu(int cpu)
+bool arch_cpu_is_hotpluggable(int cpu)
 {
-	struct cpu *c = &per_cpu(cpu_devices, cpu);
-
-	c->hotpluggable = !io_master(cpu);
-	return register_cpu(c, cpu);
+	return !io_master(cpu);
 }
 #endif
-- 
2.30.2


