Return-Path: <linux-arch+bounces-34-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9B7E3936
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 11:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEBD280FAD
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFB10951;
	Tue,  7 Nov 2023 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bavolUUV"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598314F7A;
	Tue,  7 Nov 2023 10:30:00 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39E9E;
	Tue,  7 Nov 2023 02:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k001Y0HNcuzUMO9PpBpBC5MY+V+GfJ89AzcoCw+2U8g=; b=bavolUUVWJJ+JrwViNlWUJGFZG
	yEG3eu5aiS/5IAtLJ2AF1IrIbMgWCIxn4s58cABXCaYHrTOxE4oFQpnCSyhBaDL1Aub3ieslIfQlr
	WmburAj8ubzr205HsDIViyzzg4MBsdkx+sdlfKyik70SxJWXfCTQnRjFGnEYKjrIORI+fm9GdapWT
	hK0sajp/QbZeWswzEMXM0fObTVsth74LYNseX9zPgh6iK5/ffLBaIZM1pdtmqrPSVk4jJX62//gvA
	+moKoyUd5ZdbAcEMRPF2jlcxzOkrBuL9i8E6fp9M2e5N6eAQ8+kExMpXyOr/XOj/A67g5XqPMSWby
	ownOkLlA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49884 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r0JKz-0000EI-0j;
	Tue, 07 Nov 2023 10:29:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r0JL0-00CTwm-VX; Tue, 07 Nov 2023 10:29:39 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
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
Subject: [PATCH RFC 04/22] Loongarch: remove arch_*register_cpu() exports
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JL0-00CTwm-VX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Nov 2023 10:29:38 +0000

arch_register_cpu() and arch_unregister_cpu() are not used by anything
that can be a module - they are used by drivers/base/cpu.c and
drivers/acpi/acpi_processor.c, neither of which can be a module.

Remove the exports.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/loongarch/kernel/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index 3fd166006698..ae860fe81536 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -25,7 +25,6 @@ int arch_register_cpu(int cpu)
 
 	return ret;
 }
-EXPORT_SYMBOL(arch_register_cpu);
 
 void arch_unregister_cpu(int cpu)
 {
@@ -34,7 +33,6 @@ void arch_unregister_cpu(int cpu)
 	c->hotpluggable = 0;
 	unregister_cpu(c);
 }
-EXPORT_SYMBOL(arch_unregister_cpu);
 #endif
 
 static int __init topology_init(void)
-- 
2.30.2


