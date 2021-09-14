Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150E40A2D5
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhINBvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 21:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhINBvi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2021 21:51:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04453C061574;
        Mon, 13 Sep 2021 18:50:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso1504217pjq.4;
        Mon, 13 Sep 2021 18:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3naW5TXsWlp8ZEyLyI0wcDHDao98aEjVNbwqPnQq+T4=;
        b=fyhq/QiRynPRs4qMAQGraVpkXSCWvB/yhvDeSp7zevZLHNlczgYcYD9bm/rRwHL1Os
         wf1uzyJ+v7izSCotYfIZnrhdGojY7KjuwGCcvNc8dcROm/A7oyFk3LG5gYIz/mcHHTvR
         RCS3EL/UP6gOIP/0HwwkrCQeZzDEDn01/ZhaLgX4tex4h2Fq42pghCcgTGpbA/NHTBNG
         dop89oQDJsDT78UqWbkRLJVXveI24+OoCNs4Nj3TpmjzMJdUrJHcRsroseEUcWKryEXB
         8UPdTi4V8MK7DFdqvTh9MPRR6uHCMhOarwAX5tjRFoZqk4BDNFY+CnB4WSykUdeK6EZe
         9BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3naW5TXsWlp8ZEyLyI0wcDHDao98aEjVNbwqPnQq+T4=;
        b=0TjSHJqEjdTJMZvHo/5xNOYK1HSiqDbhioGrWqcQGO/+58Yd3vj/ajStg0hQwggEbQ
         ka/cL/HkN5/n+w39E/qRXgBEEtd9BmBMKt021MKVjJkFYHgb5LdxN6Hz3sin+TQxb1Ql
         C47P2/XxlsLJzztC2NHNgxcgT4YkCkOyaPOfhinEAXHhX2vii8VCqLyxKbhzU+LtVioG
         HqbOpMs4v4nMkp9mvpBqajjHbvXoOUmbeAKF9u4tloXMG4U5YjEPCosyQB2G1XNPae1K
         hOQlADnKgB3+zEveBi2eIof4AHueiZU+5HHlmzekpSbHcAxmyWuqASWM+mS4YS2uwkEI
         Lbkg==
X-Gm-Message-State: AOAM530iUgRpeWQOUicyNoq2m9GxLUkyOFnn2fRh6RDIZ69a2xhH8ynd
        vcmbZrUy4IJtQ2L7V4Nf9YE=
X-Google-Smtp-Source: ABdhPJz/FIyO2VHYIc2/eF5EuCzABzksSdVAndHqxt39gn3KASXL0MR7z42b2owkg0LWDIYYCD2yag==
X-Received: by 2002:a17:90a:8b8e:: with SMTP id z14mr2690143pjn.127.1631584221500;
        Mon, 13 Sep 2021 18:50:21 -0700 (PDT)
Received: from archlinux.localdomain ([104.227.23.10])
        by smtp.gmail.com with ESMTPSA id o2sm9320010pgc.47.2021.09.13.18.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:50:21 -0700 (PDT)
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
X-Google-Original-From: Feiyang Chen <chenfeiyang@loongson.cn>
To:     tsbogend@alpha.franken.de, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, zhouyu@wanyeetech.com, hns@goldelico.com,
        chris.chenfeiyang@gmail.com
Subject: [PATCH v2 0/2] MIPS: convert to generic entry
Date:   Tue, 14 Sep 2021 09:50:07 +0800
Message-Id: <cover.1631583258.git.chenfeiyang@loongson.cn>
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
 arch/mips/kernel/signal.c                 |  59 +-----
 arch/mips/kernel/signal_n32.c             |  15 +-
 arch/mips/kernel/signal_o32.c             |  29 +--
 arch/mips/kernel/syscall.c                | 148 +++++++++++---
 arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
 arch/mips/kernel/traps.c                  | 225 ++++++++++++++++------
 arch/mips/kernel/unaligned.c              |  19 +-
 arch/mips/mm/c-octeon.c                   |  15 ++
 arch/mips/mm/cex-oct.S                    |   8 +-
 arch/mips/mm/fault.c                      |  12 +-
 arch/mips/mm/tlbex-fault.S                |   7 +-
 34 files changed, 594 insertions(+), 1342 deletions(-)
 create mode 100644 arch/mips/include/asm/entry-common.h
 delete mode 100644 arch/mips/include/asm/sim.h
 create mode 100644 arch/mips/kernel/scall.S
 delete mode 100644 arch/mips/kernel/scall32-o32.S
 delete mode 100644 arch/mips/kernel/scall64-n32.S
 delete mode 100644 arch/mips/kernel/scall64-n64.S
 delete mode 100644 arch/mips/kernel/scall64-o32.S

-- 
2.27.0

