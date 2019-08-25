Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B179C37A
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfHYNXs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:23:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46743 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfHYNXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:23:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so8470835plz.13;
        Sun, 25 Aug 2019 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjceYrmvXTLazK4qmfRPF5eEKi6XicxtX5Qtj+7xm3s=;
        b=jg+bXQmHqguYB9XXKwWLY8S5g82O8eXWTKHot7+lb9IjZaGSkBlBPLnUdo1oyF4DWC
         +DdexSPWnfmPn/pjwb6jP0Yfdv5FR0UBZi9VDauS/w+ihe/2aNMciqIVwkxzlYGYe5a8
         whnexfx6Bn1mvw3pyH73xAJO8BkW2J6y02pohikwhCXA53I5KGWCniEe1L7TRdKxOdKx
         nAy3jtjyKE8zZZsiA+ld8V6Ch6cmHGuqzT16q55SFZn0W6Oi/GGl3mmaAIl00snA49X+
         mhhYG6kfWrjhVeK70PT+MPhkXvSoCWkVfxAaSWqBNnUGWhhrM4moWDgcJuGrn8wwpDUc
         YTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjceYrmvXTLazK4qmfRPF5eEKi6XicxtX5Qtj+7xm3s=;
        b=b0FHl/OfADEv3odIg5YidmrGB/3jpUGXWIx61OzNJ8SuzZyjjt1GYIBJr871wV61w0
         vqM7u7+zI1/zbBxj2UZqv+ix+67ShoqOTCRUjabMoJHy9sUisk6ORMMO3Jwpo9SG5h+U
         bPjCPxedm5Z3It7BkR8dVR/jTDLw3xewR3zwhFu0KXDmLnWDluqaVLTfglhtyq4/tBNc
         EJH33n41mygjlfbW7EMd2orVKYEqE2oj3FuFtdc+xTKihaI+NG4DRWyb+OOAPO8UM1rC
         NyKyWV9vxnM/QZ9FiwiE65zfO2JSpopKwX9sSmLV6NGij/91g1cGmrvcHBiLwVNsBZrz
         1Rwg==
X-Gm-Message-State: APjAAAV2Dlax2+Vs52EYqqgtUSSYkZVjkD4L0uF7KtNgFSNmA4KKJzQE
        aED5S4HlrsEqlE1rwiG3THo=
X-Google-Smtp-Source: APXvYqzYopH/Yp2whT8fTAbzmTdRsst0X9ruJcAY20hb68xqq8g6g2BcAOFEG34UycgCXdZZc5o+dA==
X-Received: by 2002:a17:902:100c:: with SMTP id b12mr14431985pla.40.1566739426477;
        Sun, 25 Aug 2019 06:23:46 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:23:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/11] ftrace: add support for recording function parameters and return value
Date:   Sun, 25 Aug 2019 21:23:19 +0800
Message-Id: <20190825132330.5015-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series introduces a new ftrace feature CONFIG_FTRACE_FUNC_PROTOTYPE to
record function parameters and return value. It can be enabled/disabled at
runtime by a new trace option "record-funcproto".

To achieve this, we need the function prototype infomation and the location of
parameters. A new tool scripts/ftrace/funcprototype is provided to collect such
necessary infomation and put them into kernel. It walks through the DWARF debug
sections in each object file and output assembly code which defines the function
prototype data. Then the assembly code is built into the original object file.

Here is an example of memremap() function:
            .section __funcprotostr, "a"
    .P_memremap_0:
            .string "offset"
    .P_memremap_1:
            .string "size"
    .P_memremap_2:
            .string "flags"
    
            .section __funcproto,  "a"
            .quad memremap
            .byte 0x8
            .byte 0x3
            .quad .P_memremap_0
            .byte 0x8
            .byte 0x55
            .byte 0x0
            .quad .P_memremap_1
            .byte 0x8
            .byte 0x54
            .byte 0x0
            .quad .P_memremap_2
            .byte 0x8
            .byte 0x51
            .byte 0x0

Note that currently funcprototype only support global functions. Local functions
can also be supported by using the idea described in recordmcount.pl - temporary
change local functions to global.

The C ABI is arch specific. For arch which supports this feature must
implement a new  arch-specific interface arch_fgraph_record_params() and
deliver the return value of function to ftrace core part.

This series only add support for x86_64 platform. Other platforms can be
supported in the future.

Here is an example of the graph trace of function pick_next_task_fair().
Note that we only record the parameter and return value of global
functions.
    
     2)               |  pick_next_task_fair() {
     2)               |    update_blocked_averages() {
     2)   0.765 us    |      _raw_spin_lock_irqsave(lock=0xffff88807da2b100); /* ret=0x0000000000000082 */
     2)   0.944 us    |      update_rq_clock(rq=0xffff88807da2b100);
     2)   0.612 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff8880754f7488); /* ret=0 */
     2)   0.654 us    |      __update_load_avg_se(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180, se=0xffff88807be2e0d8); /* ret=0 */
     2)   0.206 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180); /* ret=0 */
     2)               |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff888079b5fb18) {
     2)   2.410 us    |        __accumulate_pelt_segments();
     2)   3.103 us    |      } /* ret=1 */
     2)   0.193 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180); /* ret=0 */
     2)               |      update_rt_rq_load_avg(now=0x000000251b8516ee, rq=0xffff88807da2b100, running=0) {
     2)   0.258 us    |        __accumulate_pelt_segments();
     2)   1.617 us    |      } /* ret=1 */
     2)               |      update_dl_rq_load_avg(now=0x000000251b8516ee, rq=0xffff88807da2b100, running=0) {
     2)   0.230 us    |        __accumulate_pelt_segments();
     2)   1.511 us    |      } /* ret=1 */
     2)   1.040 us    |      _raw_spin_unlock_irqrestore(lock=0xffff88807da2b100, flags=0x0000000000000082);
     2) + 14.739 us   |    }
     2)               |    load_balance() {
     2)               |      find_busiest_group() {
     2)   0.874 us    |        update_group_capacity(sd=0xffff88807c1d37d0, cpu=2);
     2)   1.761 us    |        idle_cpu();
     2)   0.262 us    |        idle_cpu();
     2)   0.217 us    |        idle_cpu();
     2)   6.338 us    |      }
     2)   8.442 us    |    }
     2)   1.823 us    |    __msecs_to_jiffies(m=0x00000006); /* ret=0x0000000000000002 */
     2)               |    load_balance() {
     2)               |      find_busiest_group() {
     2)   0.434 us    |        idle_cpu();
     2)   0.233 us    |        idle_cpu();
     2)   0.210 us    |        idle_cpu();
     2)   2.308 us    |      }
     2)   2.821 us    |    }
     2)   0.263 us    |    __msecs_to_jiffies(m=0x00000008); /* ret=0x0000000000000002 */
     2)   0.977 us    |    _raw_spin_lock(lock=0xffff88807da2b100);
     2) + 32.262 us   |  }
    
The printing rules of each value is:
   o For signed value, it is always printed as decimal number.
   o For unsigned value,
     - For value has size great than 8, it is printed as '{..}'.
     - For value has size of 1,2,4,8, it is printed as hexadecimal number.
     - If failed to record a parameter, it is printed as '?'.


Changbin Du (11):
  ftrace: move recordmcount tools to scripts/ftrace
  ftrace: introduce new building tool funcprototype
  asm-generic: add generic dwarf definition
  ftrace/hash: add private data field
  ftrace: create memcache for hash entries
  ftrace: process function prototype data in vmlinux and modules
  ftrace: prepare arch specific interfaces for function prototype
    feature
  ftrace: introduce core part of function prototype recording
  x86_64: add function prototype recording support
  ftrace: add doc for new option record-funcproto
  MAINTAINERS: make scripts/ftrace/ maintained

 Documentation/trace/ftrace.rst       |   6 +
 MAINTAINERS                          |   2 +
 arch/arm/kernel/ftrace.c             |   2 +-
 arch/arm64/kernel/ftrace.c           |   2 +-
 arch/csky/kernel/ftrace.c            |   2 +-
 arch/microblaze/kernel/ftrace.c      |   2 +-
 arch/mips/kernel/ftrace.c            |   2 +-
 arch/nds32/kernel/ftrace.c           |   5 +-
 arch/parisc/kernel/ftrace.c          |   2 +-
 arch/powerpc/kernel/trace/ftrace.c   |   2 +-
 arch/riscv/kernel/ftrace.c           |   2 +-
 arch/s390/kernel/ftrace.c            |   2 +-
 arch/sh/kernel/ftrace.c              |   2 +-
 arch/sparc/kernel/ftrace.c           |   2 +-
 arch/x86/Kconfig                     |   1 +
 arch/x86/kernel/ftrace.c             |  84 +++-
 arch/x86/kernel/ftrace_64.S          |   4 +-
 include/asm-generic/dwarf.h          | 199 +++++++++
 include/asm-generic/vmlinux.lds.h    |  18 +
 include/linux/ftrace.h               |  55 ++-
 include/linux/module.h               |   4 +
 kernel/module.c                      |  25 +-
 kernel/trace/Kconfig                 |  19 +
 kernel/trace/fgraph.c                |  26 +-
 kernel/trace/ftrace.c                | 164 +++++++-
 kernel/trace/trace.h                 |  20 +-
 kernel/trace/trace_entries.h         |  10 +
 kernel/trace/trace_functions_graph.c | 108 ++++-
 kernel/trace/trace_irqsoff.c         |   3 +-
 kernel/trace/trace_sched_wakeup.c    |   3 +-
 scripts/.gitignore                   |   1 -
 scripts/Makefile                     |   2 +-
 scripts/Makefile.build               |  28 +-
 scripts/ftrace/.gitignore            |   6 +
 scripts/ftrace/Makefile              |   9 +
 scripts/ftrace/funcprototype.c       | 576 +++++++++++++++++++++++++++
 scripts/{ => ftrace}/recordmcount.c  |   0
 scripts/{ => ftrace}/recordmcount.h  |   0
 scripts/{ => ftrace}/recordmcount.pl |   0
 39 files changed, 1340 insertions(+), 60 deletions(-)
 create mode 100644 include/asm-generic/dwarf.h
 create mode 100644 scripts/ftrace/.gitignore
 create mode 100644 scripts/ftrace/Makefile
 create mode 100644 scripts/ftrace/funcprototype.c
 rename scripts/{ => ftrace}/recordmcount.c (100%)
 rename scripts/{ => ftrace}/recordmcount.h (100%)
 rename scripts/{ => ftrace}/recordmcount.pl (100%)
 mode change 100755 => 100644

-- 
2.20.1

