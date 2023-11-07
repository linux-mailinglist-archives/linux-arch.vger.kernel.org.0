Return-Path: <linux-arch+bounces-41-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FDD7E3957
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 11:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68601C20B6E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390E614AAC;
	Tue,  7 Nov 2023 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dqcnH4JH"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD4107A9;
	Tue,  7 Nov 2023 10:30:27 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C110CF;
	Tue,  7 Nov 2023 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B2mYLeaTLi2RKWi068dxPknxY80IYTqbrhnkvkRDiuE=; b=dqcnH4JHbhq+YyuErnnwbDz8AN
	0aZHSKx0GUxYcKgXYu+ufg2cb8kYEmwx+9kFA1w4O4SyrvG+1OUdeuxsMHh2eLeLdkByAWX4X3oAz
	2NO1ccm9fwHvFF2bXexmTLIQFvhf3Qz/DmRmQrmP+rcr76RnT2KsoSlxcfXP+7GCe+AP8as7RQRsh
	PmNfmj8Cg3tcxdNxPxdJVtZXPcRFD/Kr+zcnE867HVQbpMciT0HRPaxiHcaaDbAvZ36cCRU1uznTv
	t2z4hpxFimnFtmEAgZQioZfNIPtAqdcKWzGgkyzsh3sSohV2F7UJLYN38lWTMr+ZWxB3YwUcNX/qc
	768F37qQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42208 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r0JLd-0000Gy-1D;
	Tue, 07 Nov 2023 10:30:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r0JLa-00CTxY-Uv; Tue, 07 Nov 2023 10:30:15 +0000
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC 11/22] drivers: base: remove unnecessary call to
 register_cpu_under_node()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Nov 2023 10:30:14 +0000

Since "drivers: base: Move cpu_dev_init() after node_dev_init()", we
can remove some redundant code.

node_dev_init() will walk through the nodes calling register_one_node()
on each. This will trickle down to __register_one_node() which walks
all present CPUs, calling register_cpu_under_node() on each.

register_cpu_under_node() will call get_cpu_device(cpu) for each, which
will return NULL until the CPU is registered using register_cpu(). This
now happens _after_ node_dev_init().

Therefore, calling register_cpu_under_node() from __register_one_node()
becomes a no-op, and can be removed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/base/node.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..4d5ac7cf8757 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -867,7 +867,6 @@ void register_memory_blocks_under_node(int nid, unsigned long start_pfn,
 int __register_one_node(int nid)
 {
 	int error;
-	int cpu;
 
 	node_devices[nid] = kzalloc(sizeof(struct node), GFP_KERNEL);
 	if (!node_devices[nid])
@@ -875,12 +874,6 @@ int __register_one_node(int nid)
 
 	error = register_node(node_devices[nid], nid);
 
-	/* link cpu under this node */
-	for_each_present_cpu(cpu) {
-		if (cpu_to_node(cpu) == nid)
-			register_cpu_under_node(cpu, nid);
-	}
-
 	INIT_LIST_HEAD(&node_devices[nid]->access_list);
 	node_init_caches(nid);
 
-- 
2.30.2


