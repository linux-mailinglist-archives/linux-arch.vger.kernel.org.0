Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABA5996C7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbiHSIOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbiHSIOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:14:23 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4226A5D108;
        Fri, 19 Aug 2022 01:14:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+BLRv9i9I0EAA--.22658S2;
        Fri, 19 Aug 2022 16:14:04 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 0/9] LoongArch: Add ftrace support
Date:   Fri, 19 Aug 2022 16:13:54 +0800
Message-Id: <20220819081403.7143-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+BLRv9i9I0EAA--.22658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyDuw4UKr1ruw17XF1UZFb_yoW5CF4Dpr
        ZxZrn3Gr48GFs3trnIg34rurn5Arn7Gryag3ZxAry8Cr42vF1UXr1kArykXa45t3yrGry0
        qF1rWw43KF4UZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUsF4iUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series to support basic and dynamic ftrace.

1) -pg
Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
Thus, it can be seen store RA and open stack before `call _mcount`.
Find `open stack` at first, and then find `store RA`.

2) -fpatchable-function-entry=2
The compiler has inserted 2 NOPs before the regular function prologue.
T series registers are available and safe because of LoongArch psABI.

At runtime, replace nop with bl to enable ftrace call and replace bl with
nop to disable ftrace call. The bl requires us to save the original RA value,
so here it saves RA at t0.
details are:

| Compiled   |       Disabled         |        Enabled         |
+------------+------------------------+------------------------+
| nop        | move     t0, ra        | move     t0, ra        |
| nop        | nop                    | bl      ftrace_caller  |
| func_body  | func_body              | func_body              |

The RA value will be recovered by ftrace_regs_entry, and restored into RA
before returning to the regular function prologue. When a function is not
being traced, the move t0, ra is not harmful.

performs a series of startup tests on ftrace and The test cases in selftests
has passed on LoongArch.

Qing Zhang (9):
  LoongArch/ftrace: Add basic support
  LoongArch/ftrace: Add recordmcount support
  LoongArch/ftrace: Add dynamic function tracer support
  Loongarch/ftrace: Add dynamic function graph tracer support
  Loongarch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
  LoongArch: modules/ftrace: Initialize PLT at load time
  Loongarch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
  LoongArch: ftrace: Add CALLER_ADDRx macros
  LoongArch: Enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS

 arch/loongarch/Kconfig                     |   6 +
 arch/loongarch/Makefile                    |   5 +
 arch/loongarch/configs/loongson3_defconfig |  60 ++---
 arch/loongarch/include/asm/ftrace.h        |  46 ++++
 arch/loongarch/include/asm/inst.h          |  35 +++
 arch/loongarch/include/asm/module.h        |  14 +-
 arch/loongarch/include/asm/module.lds.h    |   1 +
 arch/loongarch/include/asm/processor.h     |   2 -
 arch/loongarch/include/asm/unwind.h        |   1 +
 arch/loongarch/kernel/Makefile             |  17 +-
 arch/loongarch/kernel/entry_dyn.S          | 154 +++++++++++++
 arch/loongarch/kernel/ftrace.c             |  74 ++++++
 arch/loongarch/kernel/ftrace_dyn.c         | 252 +++++++++++++++++++++
 arch/loongarch/kernel/inst.c               | 129 +++++++++++
 arch/loongarch/kernel/mcount.S             |  94 ++++++++
 arch/loongarch/kernel/module-sections.c    |  11 +
 arch/loongarch/kernel/module.c             |  48 ++++
 arch/loongarch/kernel/return_address.c     |  45 ++++
 arch/loongarch/kernel/unwind_guess.c       |   4 +-
 arch/loongarch/kernel/unwind_prologue.c    |  10 +-
 scripts/recordmcount.c                     |  23 ++
 21 files changed, 973 insertions(+), 58 deletions(-)
 create mode 100644 arch/loongarch/include/asm/ftrace.h
 create mode 100644 arch/loongarch/kernel/entry_dyn.S
 create mode 100644 arch/loongarch/kernel/ftrace.c
 create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
 create mode 100644 arch/loongarch/kernel/mcount.S
 create mode 100644 arch/loongarch/kernel/return_address.c

-- 
2.36.1

