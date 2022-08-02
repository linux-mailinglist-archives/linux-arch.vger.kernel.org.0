Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF25876CD
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 07:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiHBFic (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 01:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbiHBFia (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 01:38:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D05343313;
        Mon,  1 Aug 2022 22:38:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxoM5KuOhiZCABAA--.2520S2;
        Tue, 02 Aug 2022 13:38:19 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v3 0/4] Add unwinder support
Date:   Tue,  2 Aug 2022 13:38:14 +0800
Message-Id: <20220802053818.18051-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxoM5KuOhiZCABAA--.2520S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UJFWkZryxtw13Aw4ktFb_yoW5GF1rpF
        ZrurnxGF4DGrySvrnxtw18urn5Jw4kG3y2qa9FyryrCF4aqF17ZrnYvF9rZ3WDt395Jry0
        qFn5G3s0ga1jqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjWxRDUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series in order to add stacktrace support, Some upcoming features require
these changes, like trace, divide unwinder into guess unwinder and prologue
unwinder is to add new unwinders in the future, eg:unwind_frame, unwind_orc .etc.
Three stages when we do unwind,
  1) unwind_start(), the prapare of unwinding, fill unwind_state.
  2) unwind_done(), judge whether the unwind process is finished or not.
  3) unwind_next_frame(), unwind the next frame.

you can test them by:
  1) echo t > /proc/sysrq-trigger
  2) cat /proc/*/stack
  4) ftrace: function graph
  5) uprobe: echo 1 > ./options/userstacktrace

Changes from v1 to v2:

- Add the judgment of the offset value of ra in the prologue.
  (Suggested by Youling).
- Create an inline function to check the sign bit, which is convenient
  for extending other types of immediates.  (Suggested by Jinyang).
- Fix sparse warning :
    arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect
    type in argument 2 (different address spaces) @@     expected void const
    *from @@     got void const [noderef] __user *from @@
- Add USER_STACKTRACE support as a series.

Changes from v2 to v3:

- Move unwind_start definition and use location, remove #ifdef in unwind_state
  and use type instead of enable. (Suggested by Huacai).
- Separated fixes for uaccess.h. (Suggested by Huacai).

Qing Zhang (4):
  LoongArch: Add guess unwinder support
  LoongArch: Add prologue unwinder support
  LoongArch: Add stacktrace support
  LoongArch: Add USER_STACKTRACE support

 arch/loongarch/Kconfig                  |   6 +
 arch/loongarch/Kconfig.debug            |  28 ++++
 arch/loongarch/include/asm/inst.h       |  52 +++++++
 arch/loongarch/include/asm/processor.h  |   9 ++
 arch/loongarch/include/asm/stacktrace.h |  22 +++
 arch/loongarch/include/asm/switch_to.h  |  14 +-
 arch/loongarch/include/asm/unwind.h     |  47 +++++++
 arch/loongarch/kernel/Makefile          |   4 +
 arch/loongarch/kernel/asm-offsets.c     |   2 +
 arch/loongarch/kernel/process.c         |  64 +++++++++
 arch/loongarch/kernel/stacktrace.c      |  78 +++++++++++
 arch/loongarch/kernel/switch.S          |   2 +
 arch/loongarch/kernel/traps.c           |  24 ++--
 arch/loongarch/kernel/unwind_guess.c    |  65 +++++++++
 arch/loongarch/kernel/unwind_prologue.c | 172 ++++++++++++++++++++++++
 15 files changed, 573 insertions(+), 16 deletions(-)
 create mode 100644 arch/loongarch/include/asm/unwind.h
 create mode 100644 arch/loongarch/kernel/stacktrace.c
 create mode 100644 arch/loongarch/kernel/unwind_guess.c
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c

-- 
2.20.1

