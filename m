Return-Path: <linux-arch+bounces-7485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F69899EB
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 06:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835E228182C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE14F8BB;
	Mon, 30 Sep 2024 04:55:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605D1362;
	Mon, 30 Sep 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727672107; cv=none; b=DVcr+618jfMVcWrH81gN+ytdcM+Axw58vEJ/We6vaX3/m1P7fduluAOgujPTOmjkC3AHdzkNKFv5em6IGQyfdo3sHmkbjkYEPjxoGbYjEZV1IhMtXPaLfCUDgxV178ZtXpr7UXndmOA1wUftpmAk54wLx7JRXSyT2X6RA7uLVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727672107; c=relaxed/simple;
	bh=c4P6LyXludCiH+ABK2+yHmUzA/pGZ9E92BHafV+dQ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUOspA82J3D8QRpULh9hGDyc6WM9NRthalzYImxxYOgx81FYmeH1507IscCRL3Nr8sQ+74241ghLcUCUxeAeCko97smHXOVBVujLV/XoHq+OJW8hqcj+SUuymFjr+SN/pef+xQnFx+yqC6rAuLo7eQeXVo1BBtU8QOirTaXqelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612FFC4CECE;
	Mon, 30 Sep 2024 04:55:04 +0000 (UTC)
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
	Huacai Chen <chenhuacai@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH V2] LoongArch: Set correct size for VDSO code mapping
Date: Mon, 30 Sep 2024 12:54:52 +0800
Message-ID: <20240930045452.3946322-1-chenhuacai@loongson.cn>
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
Reviewed-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Allocate code pages dynamically.

 arch/loongarch/kernel/vdso.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index f6fcc52aefae..2c0d852ca536 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -34,7 +34,6 @@ static union {
 	struct loongarch_vdso_data vdata;
 } loongarch_vdso_data __page_aligned_data;
 
-static struct page *vdso_pages[] = { NULL };
 struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 struct vdso_rng_data *vdso_rng_data = &loongarch_vdso_data.vdata.rng_data;
@@ -85,10 +84,8 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
-	.size = PAGE_SIZE,
 	.code_mapping = {
 		.name = "[vdso]",
-		.pages = vdso_pages,
 		.mremap = vdso_mremap,
 	},
 	.data_mapping = {
@@ -103,11 +100,14 @@ static int __init init_vdso(void)
 	unsigned long i, cpu, pfn;
 
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
-	BUG_ON(!PAGE_ALIGNED(vdso_info.size));
 
 	for_each_possible_cpu(cpu)
 		vdso_pdata[cpu].node = cpu_to_node(cpu);
 
+	vdso_info.size = PAGE_ALIGN(vdso_end - vdso_start);
+	vdso_info.code_mapping.pages =
+		kcalloc(vdso_info.size / PAGE_SIZE, sizeof(struct page *), GFP_KERNEL);
+
 	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
 	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
 		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
-- 
2.43.5


