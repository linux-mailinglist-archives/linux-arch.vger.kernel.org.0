Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5E459D0F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 08:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhKWHxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 02:53:31 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52074 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234419AbhKWHxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 02:53:30 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxF+genZxh3IgAAA--.1089S3;
        Tue, 23 Nov 2021 15:50:00 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>, lkp@intel.com
Subject: [PATCH 1/6] hamradio: fix macro redefine warning
Date:   Tue, 23 Nov 2021 15:49:22 +0800
Message-Id: <20211123074927.12461-2-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211123074927.12461-1-huangpei@loongson.cn>
References: <20211123074927.12461-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxF+genZxh3IgAAA--.1089S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKryDAr15Jr13GryUXw13urg_yoW3Gwb_Cr
        1avr93Xr1DGw4jqr429r4rAa45Cw10gwn7uF9ag393Ww12yF47AFWkCrs7Jrs8CFW7ZFnx
        C34UCF18A3ySgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8ZXoUUUU
        U
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MIPS/IA64 define END as assembly function ending, which conflict
with END definition in mkiss.c, just undef it at first

Reported-by: lkp@intel.com
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 drivers/net/hamradio/mkiss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index e2b332b54f06..7da2bb8a443c 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -31,6 +31,8 @@
 
 #define AX_MTU		236
 
+/* some arch define END as assembly function ending, just undef it */
+#undef	END
 /* SLIP/KISS protocol characters. */
 #define END             0300		/* indicates end of frame	*/
 #define ESC             0333		/* indicates byte stuffing	*/
-- 
2.20.1

