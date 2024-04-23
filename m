Return-Path: <linux-arch+bounces-3906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF208ADE6D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 09:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2506E1C219D1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A29C47796;
	Tue, 23 Apr 2024 07:43:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977746557;
	Tue, 23 Apr 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858199; cv=none; b=nctynLfKy5pypBRFAyegfYYgw77w7RI3PjTdlB2WsfqGDV5ghESNCdovB9YHIgExdXwkUsjE6+pq+devrUQPrAwgO8pW6P9VqSfk3YSixPvJ7Ek8odqz+91X+x/RrLAajSTPCAWv7qosjS3aKq8GkBgP6Eau+QEKDbATJjJccjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858199; c=relaxed/simple;
	bh=NoS4itDaBOpjGmCNi4CVA0MJJnPxZXKEwsnZaFEDMQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMIN5gQTsuw64NTFn4PldljR9tKsggGPN/vu9vjtjj3mB5fF63E3ijiCgpYK4Oq1FaGVcq5E1VGJpueX94L7IZ90Tr8myEm/LBAaQW5LSwrO7m496lu0JiiplK0+RUfL5AyhmGQMlXPPyEPIZp4NKRKCzvINhzRMYaAzXc5+LpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF89C116B1;
	Tue, 23 Apr 2024 07:43:15 +0000 (UTC)
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
	Jiantao Shan <shanjiantao@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Fix access error when read fault on a write-only VMA
Date: Tue, 23 Apr 2024 15:42:57 +0800
Message-ID: <20240423074257.2480274-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiantao Shan <shanjiantao@loongson.cn>

As with most architectures, allow handling of read faults in VMAs that
have VM_WRITE but without VM_READ (WRITE implies READ).

Otherwise, reading before writing a write-only memory will error while
reading after writing everything is fine.

BTW, move the VM_EXEC judgement before VM_READ/VM_WRITE to make logic a
little clearer.

Signed-off-by: Jiantao Shan <shanjiantao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 1fc2f6813ea0..97b40defde06 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -202,10 +202,10 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & VM_READ) && address != exception_era(regs))
-			goto bad_area;
 		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs))
 			goto bad_area;
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address != exception_era(regs))
+			goto bad_area;
 	}
 
 	/*
-- 
2.43.0


