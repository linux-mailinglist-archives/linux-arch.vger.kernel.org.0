Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAC9A770
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfHWGQI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 02:16:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34193 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390037AbfHWGQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 02:16:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07521714|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.525283-0.101757-0.37296;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FGwcr64_1566540964;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FGwcr64_1566540964)
          by smtp.aliyun-inc.com(10.147.41.158);
          Fri, 23 Aug 2019 14:16:04 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>
Subject: [PATCH V5 0/3] riscv: Add perf callchain support
Date:   Fri, 23 Aug 2019 14:15:57 +0800
Message-Id: <cover.1566540652.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set add perf callchain(FP/DWARF) support for RISC-V.
It comes from the csky version callchain support with some
slight modifications. The patchset base on Linux 5.3.

Changes since v4:
  - Add missing PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
    verified with extra CFLAGS(-Wall -Werror)

Changes since v3:
  - Add more strict check for unwind_frame_kernel
  - update for kernel 5.3

Changes since v2:
  - fix inconsistent comment
  - force to build kernel with -fno-omit-frame-pointer if perf
    event is enabled

Changes since v1:
  - simplify implementation and code convention


Mao Han (3):
  riscv: Add perf callchain support
  riscv: Add support for perf registers sampling
  riscv: Add support for libdw

 arch/riscv/Kconfig                            |   2 +
 arch/riscv/Makefile                           |   3 +
 arch/riscv/include/uapi/asm/perf_regs.h       |  42 ++++++++++
 arch/riscv/kernel/Makefile                    |   4 +-
 arch/riscv/kernel/perf_callchain.c            | 115 ++++++++++++++++++++++++++
 arch/riscv/kernel/perf_regs.c                 |  44 ++++++++++
 tools/arch/riscv/include/uapi/asm/perf_regs.h |  42 ++++++++++
 tools/perf/Makefile.config                    |   6 +-
 tools/perf/arch/riscv/Build                   |   1 +
 tools/perf/arch/riscv/Makefile                |   4 +
 tools/perf/arch/riscv/include/perf_regs.h     |  96 +++++++++++++++++++++
 tools/perf/arch/riscv/util/Build              |   2 +
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ++++++++++++++++
 tools/perf/arch/riscv/util/unwind-libdw.c     |  57 +++++++++++++
 14 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_callchain.c
 create mode 100644 arch/riscv/kernel/perf_regs.c
 create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/Build
 create mode 100644 tools/perf/arch/riscv/Makefile
 create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/util/Build
 create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c

-- 
2.7.4

