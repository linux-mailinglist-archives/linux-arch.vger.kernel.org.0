Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE0A347018
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 04:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhCXDZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 23:25:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37088 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234999AbhCXDZN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Mar 2021 23:25:13 -0400
Received: from localhost.localdomain (unknown [182.149.161.110])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxqckDsVpgywsAAA--.7S2;
        Wed, 24 Mar 2021 11:24:56 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] MIPS: loongson64: fix bug when PAGE_SIZE > 16KB
Date:   Wed, 24 Mar 2021 11:24:51 +0800
Message-Id: <20210324032451.27569-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: AQAAf9CxqckDsVpgywsAAA--.7S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4xKr4ruF43XFWUZr15XFb_yoWkGFgEgF
        W7tw4IgryFkrn7Ca47XrW7WF4a9a48GF4fuFyUJr9ag3sYvFnxJF4rurWjk3W3XrnYvryr
        Gw4rKry0yw1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjQBMtUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When page size larger than 16KB, arguments "vaddr + size(16KB)" in
"ioremap_page_range(vaddr, vaddr + size,...)" called by
"add_legacy_isa_io" is not page-aligned.

As loongson64 needs at least page size 16KB to get rid of cache alias,
and "vaddr" is 64KB-aligned, and 64KB is largest page size supported,
rounding "size" up to PAGE_SIZE is enough for all page size supported.

Fixes: 6d0068ad15e4 ("MIPS: Loongson64: Process ISA Node in DeviceTree")
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/loongson64/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index ed75f7971261..052cce6a8a99 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -82,7 +82,7 @@ static int __init add_legacy_isa_io(struct fwnode_handle *fwnode, resource_size_
 		return -ENOMEM;
 
 	range->fwnode = fwnode;
-	range->size = size;
+	range->size = size = round_up(size, PAGE_SIZE);
 	range->hw_start = hw_start;
 	range->flags = LOGIC_PIO_CPU_MMIO;
 
-- 
2.17.1

