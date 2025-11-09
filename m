Return-Path: <linux-arch+bounces-14591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717EC43725
	for <lists+linux-arch@lfdr.de>; Sun, 09 Nov 2025 03:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0D4E0281
	for <lists+linux-arch@lfdr.de>; Sun,  9 Nov 2025 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1F1A4F3C;
	Sun,  9 Nov 2025 02:18:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421BE33E7;
	Sun,  9 Nov 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762654723; cv=none; b=ZVe1iWld1/zYEVVAIyareKbx5wbUCw7iWe7xn+WuDvszoXFeSSe0pWkqpg/aoK+00rJQqxOonB6E8HSUcVKQ5gLje6QlvXosvyyIWNnXtI0JrdJ+T/ncDc/ySV1/r3s0NcxpGyYkNpCsBupA7z1B5RYxkJ8npPQhPzyFTRO8vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762654723; c=relaxed/simple;
	bh=YXne9CGsS3sZ43i27BTisLoANgIP5WrJgw/qYkxKOrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yx5FhcM2paV530yD431y6NMcaTC3Rpx6lV1m9Zyxsh42QlWVC/XqxviMufpuB5yKJTlZgp0J2qU890ZONsIoPvhXeDaBX4yrSv7kZ5+MjfJTpsRfPILNETYuL0TW6tlCUoJOnd9bOpXsj7R1mScwB60UDU0aPwGyOas8NmFdnjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.45])
	by gateway (Coremail) with SMTP id _____8CxrtP2+Q9phdcgAA--.1106S3;
	Sun, 09 Nov 2025 10:18:30 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.45])
	by front1 (Coremail) with SMTP id qMiowJBx38Py+Q9p8C0sAQ--.3584S2;
	Sun, 09 Nov 2025 10:18:29 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Vishal Moola <vishal.moola@gmail.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] mm: Remove unnecessary __GFP_HIGHMEM in __p*d_alloc_one_*()
Date: Sun,  9 Nov 2025 10:18:17 +0800
Message-ID: <20251109021817.346181-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx38Py+Q9p8C0sAQ--.3584S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1fGryUXF4rKr1xAr43urX_yoW8Cry8pF
	s7C3y8X398GFyfWa10yan7Cr17tw45GFW2yF42gFy5Z3W3tw1xGFyDtrW7ZFZrZFZ5ZFW5
	Wrsxta9xAF1avrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

__{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
as follows:

 #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)

There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
explicitly.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Change the subject line as Vishal suggested.

 include/asm-generic/pgalloc.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..706e87b43b19 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,8 +18,7 @@
  */
 static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
 {
-	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
-			~__GFP_HIGHMEM, 0);
+	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
 
 	if (!ptdesc)
 		return NULL;
@@ -172,7 +171,6 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	gfp &= ~__GFP_HIGHMEM;
 
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)
@@ -226,7 +224,6 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	gfp &= ~__GFP_HIGHMEM;
 
 	ptdesc = pagetable_alloc_noprof(gfp, 0);
 	if (!ptdesc)
@@ -270,7 +267,6 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	gfp &= ~__GFP_HIGHMEM;
 
 	ptdesc = pagetable_alloc_noprof(gfp, order);
 	if (!ptdesc)
-- 
2.47.3


