Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE43459D0D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 08:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhKWHxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 02:53:30 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52076 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234417AbhKWHxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 02:53:30 -0500
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxF+genZxh3IgAAA--.1089S4;
        Tue, 23 Nov 2021 15:50:03 +0800 (CST)
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
Subject: [PATCH 2/6] slip: fix macro redefine warning
Date:   Tue, 23 Nov 2021 15:49:23 +0800
Message-Id: <20211123074927.12461-3-huangpei@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211123074927.12461-1-huangpei@loongson.cn>
References: <20211123074927.12461-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxF+genZxh3IgAAA--.1089S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKryDAr15tF43tw4rWw1Dtrb_yoW3WFg_Kw
        13Zr93XF1YkFnYqrW3Kr4rAFWYkw1UXwn7Wwnag343Xw1j9w48AFWkCa18Jr9xCr4vvFnx
        C3yYkry0y343KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOJPEUUUU
        U
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MIPS/IA64 define END as assembly function ending, which conflict
with END definition in slip.h, just undef it at first

Reported-by: lkp@intel.com
Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 drivers/net/slip/slip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/slip/slip.h b/drivers/net/slip/slip.h
index c420e5948522..3d7f88b330c1 100644
--- a/drivers/net/slip/slip.h
+++ b/drivers/net/slip/slip.h
@@ -40,6 +40,8 @@
 					   insmod -oslip_maxdev=nnn	*/
 #define SL_MTU		296		/* 296; I am used to 600- FvK	*/
 
+/* some arch define END as assembly function ending, just undef it */
+#undef	END
 /* SLIP protocol characters. */
 #define END             0300		/* indicates end of frame	*/
 #define ESC             0333		/* indicates byte stuffing	*/
-- 
2.20.1

