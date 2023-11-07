Return-Path: <linux-arch+bounces-49-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D897E398A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75AD28102B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21A28E28;
	Tue,  7 Nov 2023 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X5xIfco6"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6061A28A;
	Tue,  7 Nov 2023 10:31:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DE81FED;
	Tue,  7 Nov 2023 02:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l0bVO3Ofxt9I6VpXHzidso1VbLhWBJYttUHQB+3pVpM=; b=X5xIfco6mYR2jckL1Cjx6XpoY6
	F1j+OEIHu3sEhpzLOB+6C5P7A5s5MOemp9bper5vAt8AtlMODmCE1NmQF1xul0c7UFLIJWlbYhos3
	WVj5fDpIBk7p9pgPh6bnfgTw+atcLoD/d9QmrJIIluoISvDKmF+N3MZWxiKVhLsBiXVshQHbfpJqv
	e99I+AC3VrkDORY/ZprE1wCSOPIGGxAiesS/O18HG1utrXCksLOIlrC8VGe038QtNtNM2y70RLEva
	tpcXg87Q6zNr9aNTdc9DNqGIH8RSkaAYz0uSPevSMETjZ87SFXlrOTjwM0SXIqdowsEGbOS5u6Pi8
	KotwPOjA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34768 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r0JME-0000Jj-1K;
	Tue, 07 Nov 2023 10:30:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r0JMG-00CTyP-4X; Tue, 07 Nov 2023 10:30:56 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH RFC 19/22] LoongArch: Use the __weak version of
 arch_unregister_cpu()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JMG-00CTyP-4X@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Nov 2023 10:30:56 +0000

From: James Morse <james.morse@arm.com>

LoongArch provides its own arch_unregister_cpu(). This clears the
hotpluggable flag, then unregisters the CPU.

It isn't necessary to clear the hotpluggable flag when unregistering
a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
pointer, meaning cpu_is_hotpluggable() will return false, as
get_cpu_device() has returned NULL.

Remove arch_unregister_cpu() and use the __weak version.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v3:
 * Adapt for removal of EXPORT_SYMBOL()s
---
 arch/loongarch/kernel/topology.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index 7dfb46c68f58..866c2c9ef6ab 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -18,12 +18,4 @@ int arch_register_cpu(int cpu)
 	c->hotpluggable = !io_master(cpu);
 	return register_cpu(c, cpu);
 }
-
-void arch_unregister_cpu(int cpu)
-{
-	struct cpu *c = &per_cpu(cpu_devices, cpu);
-
-	c->hotpluggable = 0;
-	unregister_cpu(c);
-}
 #endif
-- 
2.30.2


