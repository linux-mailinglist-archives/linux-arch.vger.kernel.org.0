Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1A1EF3C5
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgFEJL1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 05:11:27 -0400
Received: from mail.loongson.cn ([114.242.206.163]:51160 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbgFEJLZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jun 2020 05:11:25 -0400
Received: from kvm-dev1.localdomain (unknown [10.2.5.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxXesqDNpeHOw9AA--.611S3;
        Fri, 05 Jun 2020 17:11:07 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] MIPS: Add writable-applies-readable policy with pgrot
Date:   Fri,  5 Jun 2020 17:11:06 +0800
Message-Id: <1591348266-28392-2-git-send-email-maobibo@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
X-CM-TRANSID: AQAAf9DxXesqDNpeHOw9AA--.611S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fJryDXF1xAF4rGr45Wrg_yoW8Gw45pF
        9rA343JrWqgFy0yryUuFWrGayUGr4Dta47Jw17WF1xAws8Xw18KF93KF92qryruFsava10
        y3WxWr48JayxAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Q_-PUUUUU==
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

