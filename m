Return-Path: <linux-arch+bounces-7481-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC95989392
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28221C20A46
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB97E583;
	Sun, 29 Sep 2024 07:50:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41D18641;
	Sun, 29 Sep 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596204; cv=none; b=qJM9W/1dBaHqXa1/JxUAbILWFYCzggAKKTs/2QFq7m/c1nnI/KychEhSuOljKt1ojQpsJ3OIeh/VX1lGj0VhBHuVrNk5supreWQrKg5l+rfPgu6hpR87XO86U8tqrM4nRXkr46VfZc78kI0U1WRpDflwh5axyELQ+VGEX/mCckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596204; c=relaxed/simple;
	bh=fQjZbCs7b9iz8SZA/Ixj59N7GOi1PjKi0funL5JIrrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJYfUedktwmAx0YC+n2SMSs5Tzri1Ym+UQ41YlPE2kJrPDwH74C70dyGPiiMTE/w8B3I/Vb0/ZXHnE4BAbcTk8DSl4nrVSYLcF7v/fsHKZHdniLTWl4YLLZ3gYIMkls1AXfP8LyC+D24nnDOANckR382NjhTX8sS+entFxzuzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB79BC4CEC5;
	Sun, 29 Sep 2024 07:50:01 +0000 (UTC)
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
Subject: [PATCH] LoongArch: Set correct size for VDSO code mapping
Date: Sun, 29 Sep 2024 15:49:44 +0800
Message-ID: <20240929074944.3540514-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current size of VDSO code mapping is hardcoded to PAGE_SIZE. This
cannot work for 4KB page size after commit 18efd0b10e0fd77 ("LoongArch:
vDSO: Wire up getrandom() vDSO implementation") because the code size
increases to 8KB. Thus set the code mapping size to its real size, i.e.
PAGE_ALIGN(vdso_end - vdso_start).

Fixes: 18efd0b10e0fd77 ("LoongArch: vDSO: Wire up getrandom() vDSO implementation")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/vdso.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index f6fcc52aefae..7e0cc7f5e1ed 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -85,7 +85,6 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
-	.size = PAGE_SIZE,
 	.code_mapping = {
 		.name = "[vdso]",
 		.pages = vdso_pages,
@@ -103,7 +102,7 @@ static int __init init_vdso(void)
 	unsigned long i, cpu, pfn;
 
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
-	BUG_ON(!PAGE_ALIGNED(vdso_info.size));
+	vdso_info.size = PAGE_ALIGN(vdso_end - vdso_start);
 
 	for_each_possible_cpu(cpu)
 		vdso_pdata[cpu].node = cpu_to_node(cpu);
-- 
2.43.5


