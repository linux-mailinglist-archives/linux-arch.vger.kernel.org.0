Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8B3A4EDA
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFLMjn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 08:39:43 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41512 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhFLMjn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 08:39:43 -0400
Received: by mail-qk1-f174.google.com with SMTP id c124so33891944qkd.8;
        Sat, 12 Jun 2021 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2AOegu4kmOp+uckc/oXupIgYX7RqKTst12dJ0Jl2c8=;
        b=gGYPLwX8NizCoZ3oxegKQzTBS2jNEpXBnjUHrJ5FTstg/L8Gc77Z82pivLGNvAmkSP
         nYlCTx+f1XGarsSh9o4c5ii1UpouOIgd5w6uLmiVElEYZiHObF9cm9fN9NMcvye3bFoL
         Ho1zcoYeoB2R2fs/S9PDxeW7pfMhN9L5XMhAXxJhGypH0Xy0phj+EYp2bWyn+BKzvSwZ
         0t0Af4pKkKTtKFJLiEhhp9/mrpvrnyfcnB6n5aP7Sooi53zGA52ofOw7PLUSwlTOO238
         tf1ZZ7wXhzGqpNx45/bYE0yeP2jNWx9b0s/JXf6PV7bDjv59ydof29L6MEpsloUtDMgp
         Bikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2AOegu4kmOp+uckc/oXupIgYX7RqKTst12dJ0Jl2c8=;
        b=ZMP8zo33qv995ZmwS41bwKXJzZRAmtO3e5ZWLPRZnm45dMNtH+NefnluoGnpY2PSG2
         bgimhuFcm/6v6Kqqwr4RrVix5vXr3PhsPqh8z6lxO1Z8ZHNPN+Et32pL5OvhfaQhimgL
         EMkIin/cthEq9proBLslBRpH8rBCpea6sMz1gcDXgF6z52+DcDMtydTpQ51JTW0D5K7F
         vprdqxzRgHiQ3sN7rQx8qzOXGFTadbI2ECJC01nsslF80p+NAozUsQjwF4R6SI5a/O84
         cN6dT7plUosVSY+n15cy0JOlyJAMLICnopKzcQftGjDPYsbR+ghDw8Ys4+IgKI/dad2R
         vpIQ==
X-Gm-Message-State: AOAM532uyX6GZGxF/MAzMi+hHOwsJGGIAjGuTv9Uxn3KKYCce2msbMAc
        wrNTSPjERXDUe1swmqWuMH02JvyafzqeFA==
X-Google-Smtp-Source: ABdhPJw94DZ1WW/KEGRHhbhUFOJ07uSJUlekmAzQWmw5V+sL7Hz9S6Nqwb3kJhCZpFu1tjCKozKq0A==
X-Received: by 2002:a37:2cc3:: with SMTP id s186mr8266165qkh.330.1623501403378;
        Sat, 12 Jun 2021 05:36:43 -0700 (PDT)
Received: from localhost ([70.127.84.75])
        by smtp.gmail.com with ESMTPSA id g2sm6098525qtb.63.2021.06.12.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:36:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/8] all: use find_next_*_bit() instead of find_first_*_bit() where possible
Date:   Sat, 12 Jun 2021 05:36:31 -0700
Message-Id: <20210612123639.329047-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_first_*_bit() is simpler and faster than 'next' version [1], and they
work identically if start == 0. But in many cases kernel code uses the
'next' version where 'first' can be used. This series addresses this issue.

Patches 1-3 move find.h under include/linux as it simplifies development.
Patches 4-8 switch the kernel and tools to find_first_*_bit() implementation
where appropriate. 

Yury Norov (8):
  bitops: protect find_first_{,zero}_bit properly
  bitops: move find_bit_*_le functions from le.h to find.h
  include: move find.h from asm_generic to linux
  arch: remove GENERIC_FIND_FIRST_BIT entirely
  lib: add find_first_and_bit()
  cpumask: use find_first_and_bit()
  all: replace find_next{,_zero}_bit with find_first{,_zero}_bit where
    appropriate
  tools: sync tools/bitmap with mother linux

 MAINTAINERS                                   |   4 +-
 arch/alpha/include/asm/bitops.h               |   2 -
 arch/arc/Kconfig                              |   1 -
 arch/arc/include/asm/bitops.h                 |   1 -
 arch/arm/include/asm/bitops.h                 |   1 -
 arch/arm64/Kconfig                            |   1 -
 arch/arm64/include/asm/bitops.h               |   1 -
 arch/csky/include/asm/bitops.h                |   1 -
 arch/h8300/include/asm/bitops.h               |   1 -
 arch/hexagon/include/asm/bitops.h             |   1 -
 arch/ia64/include/asm/bitops.h                |   2 -
 arch/m68k/include/asm/bitops.h                |   2 -
 arch/mips/Kconfig                             |   1 -
 arch/mips/include/asm/bitops.h                |   1 -
 arch/openrisc/include/asm/bitops.h            |   1 -
 arch/parisc/include/asm/bitops.h              |   2 -
 arch/powerpc/include/asm/bitops.h             |   2 -
 arch/powerpc/platforms/pasemi/dma_lib.c       |   4 +-
 arch/riscv/include/asm/bitops.h               |   1 -
 arch/s390/Kconfig                             |   1 -
 arch/s390/include/asm/bitops.h                |   1 -
 arch/s390/kvm/kvm-s390.c                      |   2 +-
 arch/sh/include/asm/bitops.h                  |   1 -
 arch/sparc/include/asm/bitops_32.h            |   1 -
 arch/sparc/include/asm/bitops_64.h            |   2 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/bitops.h                 |   2 -
 arch/x86/um/Kconfig                           |   1 -
 arch/xtensa/include/asm/bitops.h              |   1 -
 drivers/block/rnbd/rnbd-clt.c                 |   2 +-
 drivers/dma/ti/edma.c                         |   2 +-
 drivers/iio/adc/ad7124.c                      |   2 +-
 drivers/infiniband/hw/irdma/hw.c              |  16 +-
 drivers/media/cec/core/cec-core.c             |   2 +-
 drivers/media/mc/mc-devnode.c                 |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                  |  10 +-
 drivers/soc/ti/k3-ringacc.c                   |   4 +-
 drivers/tty/n_tty.c                           |   2 +-
 drivers/virt/acrn/ioreq.c                     |   3 +-
 fs/f2fs/segment.c                             |   8 +-
 fs/ocfs2/cluster/heartbeat.c                  |   2 +-
 fs/ocfs2/dlm/dlmdomain.c                      |   4 +-
 fs/ocfs2/dlm/dlmmaster.c                      |  18 +--
 fs/ocfs2/dlm/dlmrecovery.c                    |   2 +-
 fs/ocfs2/dlm/dlmthread.c                      |   2 +-
 include/asm-generic/bitops.h                  |   1 -
 include/asm-generic/bitops/le.h               |  64 --------
 include/linux/bitmap.h                        |   1 +
 include/linux/cpumask.h                       |  30 ++--
 .../bitops => include/linux}/find.h           | 149 +++++++++++++++++-
 lib/Kconfig                                   |   3 -
 lib/find_bit.c                                |  21 +++
 lib/find_bit_benchmark.c                      |  21 +++
 lib/genalloc.c                                |   2 +-
 net/ncsi/ncsi-manage.c                        |   4 +-
 tools/include/asm-generic/bitops.h            |   1 -
 tools/include/linux/bitmap.h                  |   7 +-
 .../bitops => tools/include/linux}/find.h     |  54 +++++--
 tools/lib/find_bit.c                          |  20 +++
 60 files changed, 319 insertions(+), 185 deletions(-)
 rename {tools/include/asm-generic/bitops => include/linux}/find.h (50%)
 rename {include/asm-generic/bitops => tools/include/linux}/find.h (83%)

-- 
2.30.2

