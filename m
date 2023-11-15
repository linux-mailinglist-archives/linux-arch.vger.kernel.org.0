Return-Path: <linux-arch+bounces-228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C97EC4E4
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCD11F272DC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A128DB9;
	Wed, 15 Nov 2023 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F8286B5;
	Wed, 15 Nov 2023 14:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D367FC433C7;
	Wed, 15 Nov 2023 14:15:48 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Silence the boot warning about 'nokaslr'
Date: Wed, 15 Nov 2023 22:15:30 +0800
Message-Id: <20231115141530.2534778-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel parameter 'nokaslr' is handled before start_kernel(), so we
don't need early_param() to mark it technically. But it can cause a boot
warning as follows:

Unknown kernel command line parameters "nokaslr", will be passed to user space.

When we use 'init=/bin/bash', 'nokaslr' which passed to user space will
even cause a kernel panic. So we use early_param() to mark 'nokaslr',
simply print a notice and silence the boot warning (also fix a potential
panic). This logic is similar to RISC-V.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/relocate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 6c3eff9af9fb..c2f5c2bdeb7f 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -102,6 +102,14 @@ static inline __init unsigned long get_random_boot(void)
 	return hash;
 }
 
+static int __init nokaslr(char *p)
+{
+	pr_info("KASLR is disabled.\n");
+
+	return 0; /* Print a notice and silence the boot warning */
+}
+early_param("nokaslr", nokaslr);
+
 static inline __init bool kaslr_disabled(void)
 {
 	char *str;
-- 
2.39.3


