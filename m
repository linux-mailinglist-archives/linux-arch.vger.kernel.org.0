Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D681F0489
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jun 2020 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFFEDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Jun 2020 00:03:07 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53236 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgFFEDG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 6 Jun 2020 00:03:06 -0400
Received: from kvm-dev1.localdomain (unknown [10.2.5.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxJuppFdtebUs+AA--.1078S3;
        Sat, 06 Jun 2020 12:02:51 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] MIPS: Add writable-applies-readable policy with pgrot
Date:   Sat,  6 Jun 2020 12:02:49 +0800
Message-Id: <1591416169-26666-2-git-send-email-maobibo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
References: <1591416169-26666-1-git-send-email-maobibo@loongson.cn>
X-CM-TRANSID: AQAAf9AxJuppFdtebUs+AA--.1078S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fJryDXF1xAF4rGr45Wrg_yoW8Gw45pF
        9rA343JrWqgFy0yryUuFWrGayUGr4Dta47Jw17WF1xAws8Xw18KF93KF92qryruFsava10
        y3WxWr48JayxAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07jOrcfUUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Linux system, writable applies readable privilege in most
architectures, this patch adds this policy on MIPS platform
where hardware rixi is supported.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/mips/mm/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index f814e43..dae0617 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -160,7 +160,7 @@ static inline void setup_protection_map(void)
 	if (cpu_has_rixi) {
 		protection_map[0]  = __pgprot(__PC | __PP | __NX | __NR);
 		protection_map[1]  = __pgprot(__PC | __PP | __NX | ___R);
-		protection_map[2]  = __pgprot(__PC | __PP | __NX | __NR);
+		protection_map[2]  = __pgprot(__PC | __PP | __NX | ___R);
 		protection_map[3]  = __pgprot(__PC | __PP | __NX | ___R);
 		protection_map[4]  = __pgprot(__PC | __PP | ___R);
 		protection_map[5]  = __pgprot(__PC | __PP | ___R);
@@ -169,7 +169,7 @@ static inline void setup_protection_map(void)
 
 		protection_map[8]  = __pgprot(__PC | __PP | __NX | __NR);
 		protection_map[9]  = __pgprot(__PC | __PP | __NX | ___R);
-		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | __NR);
+		protection_map[10] = __pgprot(__PC | __PP | __NX | ___W | ___R);
 		protection_map[11] = __pgprot(__PC | __PP | __NX | ___W | ___R);
 		protection_map[12] = __pgprot(__PC | __PP | ___R);
 		protection_map[13] = __pgprot(__PC | __PP | ___R);
-- 
1.8.3.1

