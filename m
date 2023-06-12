Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F472C2A6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbjFLLNg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 07:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbjFLLNP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 07:13:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18163769E;
        Mon, 12 Jun 2023 04:02:10 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxEekW+4ZkDLYDAA--.6063S3;
        Mon, 12 Jun 2023 19:01:42 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxfcoQ+4Zk19QVAA--.54161S4;
        Mon, 12 Jun 2023 19:01:41 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1 2/2] tools arch: Remove uapi bitsperlong.h of hexagon and microblaze
Date:   Mon, 12 Jun 2023 19:01:34 +0800
Message-Id: <1686567694-20099-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1686567694-20099-1-git-send-email-yangtiezhu@loongson.cn>
References: <1686567694-20099-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxfcoQ+4Zk19QVAA--.54161S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1DAFWUWFykKr4UGFWxuFX_yoW5Jr1UpF
        95XwsrWF48CryjkrWFkF1jqrW3A39rGF4jga1xWry8ZrWxJF18Ar4S9FsFya47JayIqa1r
        uF93WryUKa1kKagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ApnDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After the following two commits:

  commit 872e24d5c698 ("hexagon: remove asm/bitsperlong.h")
  commit 83f0124ad81e ("microblaze: remove asm-generic wrapper headers")

the arch-specific headers of hexagon and microblaze have been removed,
the tools arch uapi headers are useless too, remove them.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/hexagon/include/uapi/asm/bitsperlong.h  | 27 ----------------------
 .../arch/microblaze/include/uapi/asm/bitsperlong.h |  2 --
 2 files changed, 29 deletions(-)
 delete mode 100644 tools/arch/hexagon/include/uapi/asm/bitsperlong.h
 delete mode 100644 tools/arch/microblaze/include/uapi/asm/bitsperlong.h

diff --git a/tools/arch/hexagon/include/uapi/asm/bitsperlong.h b/tools/arch/hexagon/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 5adca0d..0000000
--- a/tools/arch/hexagon/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef __ASM_HEXAGON_BITSPERLONG_H
-#define __ASM_HEXAGON_BITSPERLONG_H
-
-#define __BITS_PER_LONG 32
-
-#include <asm-generic/bitsperlong.h>
-
-#endif
diff --git a/tools/arch/microblaze/include/uapi/asm/bitsperlong.h b/tools/arch/microblaze/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 76da34b..0000000
--- a/tools/arch/microblaze/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/bitsperlong.h>
-- 
2.1.0

