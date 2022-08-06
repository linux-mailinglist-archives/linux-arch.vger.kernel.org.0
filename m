Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A082158B478
	for <lists+linux-arch@lfdr.de>; Sat,  6 Aug 2022 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiHFIKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Aug 2022 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHFIKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2022 04:10:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C86F5FD1;
        Sat,  6 Aug 2022 01:10:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxbyPdIe5ixooIAA--.1165S2;
        Sat, 06 Aug 2022 16:10:06 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>, hejinyang@loongson.cn,
        tangyouling@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v4 0/4] Add unwinder support
Date:   Sat,  6 Aug 2022 16:10:01 +0800
Message-Id: <20220806081005.332-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxbyPdIe5ixooIAA--.1165S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UJFWkCw4rZw1DWrWUXFb_yoW5XryrpF
        ZrCrnxGr4DGrySvFnxtw18urn5Jr4kGrW2qa9FyryrCF4aqa47ZrnYvF1DZ3WDJ3yrJry0
        qFn5G3s0ga1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUP-B_UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series in order to add stacktrace support, Some upcoming features require
these changes, like trace, divide unwinder into guess unwinder and prologue
unwinder is to add new unwinders in the future.
eg:unwinder_frame, unwinder_orc .etc.

Three stages when we do unwind,
  1) unwind_start(), the prapare of unwinding, fill unwind_state.
  2) unwind_done(), judge whether the unwind process is finished or not.
  3) unwind_next_frame(), unwind the next frame.

you can test them by:
  1) echo t > /proc/sysrq-trigger
  2) cat /proc/*/stack
  3) ftrace: function graph
  4) uprobe: echo 1 > ./options/userstacktrace

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

Changes from v3 to v4:

- Add get wchan implement. (Suggested by Huacai).

Qing Zhang (4):
  LoongArch: Add guess unwinder support
  LoongArch: Add prologue unwinder support
  LoongArch: Add stacktrace and get_wchan support
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
 arch/loongarch/kernel/process.c         |  91 ++++++++++++-
 arch/loongarch/kernel/stacktrace.c      |  78 +++++++++++
 arch/loongarch/kernel/switch.S          |   2 +
 arch/loongarch/kernel/traps.c           |  24 ++--
 arch/loongarch/kernel/unwind_guess.c    |  67 +++++++++
 arch/loongarch/kernel/unwind_prologue.c | 173 ++++++++++++++++++++++++
 15 files changed, 602 insertions(+), 17 deletions(-)
 create mode 100644 arch/loongarch/include/asm/unwind.h
 create mode 100644 arch/loongarch/kernel/stacktrace.c
 create mode 100644 arch/loongarch/kernel/unwind_guess.c
 create mode 100644 arch/loongarch/kernel/unwind_prologue.c

-- 
2.20.1

