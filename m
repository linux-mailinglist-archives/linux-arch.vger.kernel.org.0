Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925664194C
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLCVzm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Dec 2022 16:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCVzl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Dec 2022 16:55:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AC193DD
        for <linux-arch@vger.kernel.org>; Sat,  3 Dec 2022 13:55:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so12748765lfc.8
        for <linux-arch@vger.kernel.org>; Sat, 03 Dec 2022 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBzpomWVWALPSSYS1RI2q0Xof2MmYb8r6/1awBZblis=;
        b=KwKvGAk0wRHzL5h7bNhfgxUQzqsGEcKquPPWmoqmlJweWxb0A5RV/WR8qW7TSW5p3p
         43WLq5/gJgcXfjzyuAU/WaeFM0jWpxnf8gnzBJSqC8QdGMh4Xx7rHq0T2OAaI634esOA
         OshKkliXcvgUeHD8C+DVrAhOXVj8bvetOlSRJQaWbqlAm72HYsDXts/YBrD8BEYUfZmX
         UpL6iYExLkdmpto5M0nbODUBm3midZuqKa1Bg6pn97Y+lQzHVQyY3BcQtYPT4kDQOPys
         VY4sFHRNDr1JXSx5eF7THOJhHD85gIfAUn/NMqcU0otVxeVb1XfsuGG9x5zrVKa6U64n
         0blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBzpomWVWALPSSYS1RI2q0Xof2MmYb8r6/1awBZblis=;
        b=faPFP8vXfq/KpYgrsbAY5J58Fu8UOdKf/Ajjj15yjhsDHA6wXjYvC8D95fv4RgXhzT
         njoe7D6akf5zznQBwfFylUysm3bOrMDoGhf7y3rajT2yovearKeOZiWc7/wRzcyCUuUa
         +ttBPqVWq8+aF0iaj2PPgatABV9Aa911SD6F0kVHQ66lj+MRjq60DyytjbH9yJNQWwWh
         qW/tCygsR6osD8DSUs0TI8i0PH70FFhc4yOQWHI1IT+2H81CZnbVU3vueFQgR+Qyb0zl
         SnzxGzkx4wKEw1nSmIdpSPGMPX5c2PSTSZZQM3ofpDKKUjaAA4f3vLZFJk04PoIHSYl3
         92Eg==
X-Gm-Message-State: ANoB5pmTt8ne5g9Q6MA08wQXL+kLdgAFn+9haJdm3iBp7s+4RyvyifVG
        qIXA4wKWiSB7eOYGQ01D2U4=
X-Google-Smtp-Source: AA0mqf7h7Z7If5YkOiTtcojtYDphsgE3DB/LCi60IoM3HSxp9T/aHMi1P5dlOGLb9IAC9rIaMb7Umg==
X-Received: by 2002:a05:6512:2212:b0:4b5:acf:8789 with SMTP id h18-20020a056512221200b004b50acf8789mr11483823lfu.549.1670104538313;
        Sat, 03 Dec 2022 13:55:38 -0800 (PST)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id j2-20020a056512344200b004b4f2a30e6csm1537002lfr.0.2022.12.03.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 13:55:37 -0800 (PST)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH RFC v2 0/3] riscv: support for hardware breakpoints/watchpoints
Date:   Sun,  4 Dec 2022 00:55:32 +0300
Message-Id: <20221203215535.208948-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RISC-V Debug specification includes Sdtrig ISA extension. This extension
describes Trigger Module. Triggers can cause a breakpoint exception,
entry into Debug Mode, or a trace action without having to execute a
special instruction. For native debugging triggers can be used to
implement hardware breakpoints and watchpoints.

Software support for triggers consists of the following
major components:
 - U-mode: gdb support for hw breakpoints/watchpoints
 - S-mode: hardware breakpoints framework in Linux kernel
 - M-mode: SBI firmware code to handle triggers

SBI Debug Trigger extension proposal has been posted by Anup Patel
to lists.riscv.org tech-debug mailing list, see:
https://lists.riscv.org/g/tech-debug/topic/92375492

This patch provides initial Linux support for RISC-V hardware breakpoints
and watchpoints based on the proposed SBI Debug Trigger extension. The
accompanying OpenSBI and GDB changes has also been posted for review:

- https://patchwork.ozlabs.org/project/opensbi/patch/20221203213929.206429-3-geomatsi@gmail.com/
- https://patchwork.sourceware.org/project/gdb/patch/20221130182605.1905317-1-yuly.tarasov@syntacore.com/

Current revision has the following limitations:
- two trigger types are supported: mcontrol, mcontrol6
- no support for chained triggers
- no support for virtualization
- only build test for RV32

The functionality has been tested on QEMU together with the mentioned
opensbi and gdb patches, including both target gdb and remote debug
using gdbserver. Hardware breakpoints work just fine on upstream QEMU.
However this is not the case for watchpoints since there is no way to
figure out which watchpoint triggered. IIUC there are two possible
options for doing this: using 'hit' bit in tdata1 or reading faulting
virtual address from STVAL. QEMU implements neither of them. Current
implementation opts for STVAL. The following experimental QEMU patch
is required to make hw-watchpoints work:

: diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
: index 278d163803..8858be7411 100644
: --- a/target/riscv/cpu_helper.c
: +++ b/target/riscv/cpu_helper.c
: @@ -1639,6 +1639,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
:          case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
:              tval = env->bins;
:              break;
: +        case RISCV_EXCP_BREAKPOINT:
: +            tval = env->badaddr;
: +            env->badaddr = 0x0;
: +            break;
:          default:
:              break;
:          }
: diff --git a/target/riscv/debug.c b/target/riscv/debug.c
: index 26ea764407..b4d1d566ab 100644
: --- a/target/riscv/debug.c
: +++ b/target/riscv/debug.c
: @@ -560,6 +560,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
:
:      if (cs->watchpoint_hit) {
:          if (cs->watchpoint_hit->flags & BP_CPU) {
: +            env->badaddr = cs->watchpoint_hit->hitaddr;
:              cs->watchpoint_hit = NULL;
:              do_trigger_action(env, DBG_ACTION_BP);


Changes v1 -> v2:
- switched to per-cpu buffers to exchange data with SBI firmware
- added support for type 2 (mcounter) triggers
- added ptrace interface to expose hw-breakpoints to debuggers


Sergey Matyukevich (3):
  riscv: add support for hardware breakpoints/watchpoints
  riscv: ptrace: expose hardware breakpoints to debuggers
  riscv: hw-breakpoints: add more trigger controls

 arch/riscv/Kconfig                     |   2 +
 arch/riscv/include/asm/hw_breakpoint.h | 172 ++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/processor.h     |   5 +
 arch/riscv/include/asm/sbi.h           |  24 ++
 arch/riscv/include/uapi/asm/ptrace.h   |   9 +
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 540 +++++++++++++++++++++++++
 arch/riscv/kernel/process.c            |   3 +
 arch/riscv/kernel/ptrace.c             | 188 +++++++++
 arch/riscv/kernel/traps.c              |   5 +
 11 files changed, 951 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

-- 
2.38.1

