Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6942D4FB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJNIeo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhJNIen (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 04:34:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC674C06174E;
        Thu, 14 Oct 2021 01:32:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x4so3656390pln.5;
        Thu, 14 Oct 2021 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtXP/wOKWq7Usqz2ehAroKotGw87XTAZSrJ6cI/Q9Co=;
        b=bjB6MzPAMQigG2THA7VBKzUogqYmCXIzvzSFELasrOqmNWo6SKEkvp5acAzXnSOLfm
         ovmm93zumEEi+FCGzHkaBbTEXrgF7042ZTShxdxXXgws9s5mL18S9FILAyyLoAnLM0Dx
         MMXhhU0ufBmfrDoF6j+Hsr72NMdKgKdvK7TrvDl1PVzqfoKW5zjRy0QQpdZaw05tQExU
         svdu4qEgBu0kxuyhGfLBE4ySL8TTRYKv8ZHO5InbPCDBMFn5imy8b+nLCnsiBUnfA6mn
         28mu/2XA10+PFxQA9mzkCLfDQ5GPiAvBzoZgVBfBEEpegE/h31j/7cF8/Tte2KoCrqHz
         U4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AtXP/wOKWq7Usqz2ehAroKotGw87XTAZSrJ6cI/Q9Co=;
        b=GIhE87YIIz2f67VurEFgoHcKoNKjckgXVAFyZrqOvbNDffQw5dyBTKfRaX4XTlQ+BK
         ERda9ZeIrIHU3vOPYf16tH0vLqdFfB8aLQSof+Ehgpbf9txnc5IrjHAWgTr7vIDRx8mb
         TbfLPWPBQbAZw6RqgsFAlYogy/0zMRUvnUKllZ/xk4GmhKRrVF8or91WWvNWJbfTDJTs
         YQ8Wmd9ZfBoFqQ4fbuaRCOOvBB0bOEx1K4OhQPm64EudVerzvblGiJJp6Cr6IxByT3OK
         +HdWCYXZFDp3qiga3/4cdJPNSWNOvbpzQ+zk1djvehvqN7PXkabqmUnz60Pp6K81NtrT
         Pmkg==
X-Gm-Message-State: AOAM530N1KkdaomfEYyRiRfcpJwTU8VCPYWzO7y3ntlqjsAAiLjKgDau
        1pu73ed6oQgKn+N0b2Pejl8=
X-Google-Smtp-Source: ABdhPJxChR2MQ1rbev0p1qxy8sWeQ/2svjhZCpQMO2XOjcPQoVnNXQ7+FaDD3XPz/QC3Dk5gs0CzCQ==
X-Received: by 2002:a17:90b:1a91:: with SMTP id ng17mr4731230pjb.61.1634200358396;
        Thu, 14 Oct 2021 01:32:38 -0700 (PDT)
Received: from archlinux.localdomain (61-218-132-193.hinet-ip.hinet.net. [61.218.132.193])
        by smtp.gmail.com with ESMTPSA id z23sm1802004pgv.45.2021.10.14.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 01:32:38 -0700 (PDT)
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
X-Google-Original-From: Feiyang Chen <chenfeiyang@loongson.cn>
To:     tsbogend@alpha.franken.de, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, zhouyu@wanyeetech.com, hns@goldelico.com,
        chris.chenfeiyang@gmail.com
Subject: [PATCH v3 0/2] MIPS: convert to generic entry
Date:   Thu, 14 Oct 2021 16:32:52 +0800
Message-Id: <cover.1634177547.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Convert MIPS to use the generic entry infrastructure from
kernel/entry/*.

v2: Use regs->regs[27] to mark whether to restore all registers in
handle_sys and enable IRQ stack.
v3: Do not do syscall restart in *_sigreturn().
Fix missing "goto out" in do_ade().

Feiyang Chen (2):
  MIPS: convert syscall to generic entry
  MIPS: convert irq to generic entry

 arch/mips/Kconfig                         |   1 +
 arch/mips/include/asm/entry-common.h      |  13 ++
 arch/mips/include/asm/irqflags.h          |  42 ----
 arch/mips/include/asm/ptrace.h            |   8 +-
 arch/mips/include/asm/sim.h               |  70 -------
 arch/mips/include/asm/stackframe.h        |   8 +
 arch/mips/include/asm/syscall.h           |   5 +
 arch/mips/include/asm/thread_info.h       |  17 +-
 arch/mips/include/uapi/asm/ptrace.h       |   7 +-
 arch/mips/kernel/Makefile                 |  14 +-
 arch/mips/kernel/entry.S                  | 143 +-------------
 arch/mips/kernel/genex.S                  | 150 +++------------
 arch/mips/kernel/head.S                   |   1 -
 arch/mips/kernel/linux32.c                |   1 -
 arch/mips/kernel/ptrace.c                 |  78 --------
 arch/mips/kernel/r4k-bugs64.c             |  14 +-
 arch/mips/kernel/scall.S                  | 136 +++++++++++++
 arch/mips/kernel/scall32-o32.S            | 223 ---------------------
 arch/mips/kernel/scall64-n32.S            | 107 ----------
 arch/mips/kernel/scall64-n64.S            | 116 -----------
 arch/mips/kernel/scall64-o32.S            | 221 ---------------------
 arch/mips/kernel/signal.c                 |  59 ++----
 arch/mips/kernel/signal_n32.c             |  16 +-
 arch/mips/kernel/signal_o32.c             |  31 +--
 arch/mips/kernel/syscall.c                | 148 +++++++++++---
 arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
 arch/mips/kernel/traps.c                  | 225 ++++++++++++++++------
 arch/mips/kernel/unaligned.c              |  21 +-
 arch/mips/mm/c-octeon.c                   |  15 ++
 arch/mips/mm/cex-oct.S                    |   8 +-
 arch/mips/mm/fault.c                      |  12 +-
 arch/mips/mm/tlbex-fault.S                |   7 +-
 34 files changed, 602 insertions(+), 1339 deletions(-)
 create mode 100644 arch/mips/include/asm/entry-common.h
 delete mode 100644 arch/mips/include/asm/sim.h
 create mode 100644 arch/mips/kernel/scall.S
 delete mode 100644 arch/mips/kernel/scall32-o32.S
 delete mode 100644 arch/mips/kernel/scall64-n32.S
 delete mode 100644 arch/mips/kernel/scall64-n64.S
 delete mode 100644 arch/mips/kernel/scall64-o32.S

-- 
2.27.0

