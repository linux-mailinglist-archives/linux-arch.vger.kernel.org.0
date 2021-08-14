Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3273EC555
	for <lists+linux-arch@lfdr.de>; Sat, 14 Aug 2021 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhHNVRw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Aug 2021 17:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHNVRv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 Aug 2021 17:17:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3AC061764;
        Sat, 14 Aug 2021 14:17:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so14296970pje.0;
        Sat, 14 Aug 2021 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGEOABaW+Jyt8FMHeH6RyQFPROFOcMHr8N2XiGjbDrs=;
        b=I3QzjE207ZflawaKKpji4QRm89bQ1A3Q0gksdRuOQxuvpaowiu8dTNx1fyzpGMInJP
         ostZMyu6ka1isxCZ2YdgM7NeOhV8ovPJrdzCtGB607Qi0ajFAbyVqtOwuvYCvF3lNl5W
         2gzsa842TdVlwdSe7T4KIqKD9LNPqlddUaVKx6tmwSfH05UlA02W4m7IIV1YRk95Vt7/
         B+MguM2AJJo1lsqhfq3XeoNBVO5ZxmRgFPIz1A88s+cbIlw3KZBk3kBqQGFN45XUNpkv
         cl4ltNivCmmDhh8lhk0f2qRHJ4CTsLmE9jDfvcKFo8yZXZnwPyeRjDP1uK4bgoKaEAsO
         sSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGEOABaW+Jyt8FMHeH6RyQFPROFOcMHr8N2XiGjbDrs=;
        b=e4+mD+1qyvbcGlrLTeb0QJSl6OcAAVWZWykPtWJXVBHKe7YN+QDqI46H8jLNURJaTE
         ZQcdNsd2CIBgntAhJGSD+qVpFW9+J/kUkkY0IGk8TP4PsI3lt0h9p13/52H1l+gJAGBs
         GLQ1R7mrQCgx5j4qb2p1FRPkVRd/F39ZwTa3xu0ilW3pYLx2jjnvJ6R3b/XTEwDLRMJE
         CSAbu0A0M86CvR3kJ2dOAAyJ/YMYlN9ZorHynfkUaxuUISywYDERwvQM2dlmBoZq2bRM
         DaY5meN9FX57qwN0Yxlz/BxMUEWvELY0bmuONweN/nDpTrIAZN69ka5onvDqt51I7hwd
         wAhA==
X-Gm-Message-State: AOAM533Q7JaXsKyUj+yc59nP193IskvwV6y997BsGQzU0fN3d7jQloEr
        Ydit5E6ED+cSYlrwtavLaao=
X-Google-Smtp-Source: ABdhPJwmFsyM66ivdWGbPvVG1tm5rS7lVzakmgwAMXc7eBgk/qC2GYFSWSHTH5GxrhsrKGfjp/usTw==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr8335224pgg.4.1628975841948;
        Sat, 14 Aug 2021 14:17:21 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id x4sm6454780pff.126.2021.08.14.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 14:17:21 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Joe Perches <joe@perches.com>, Jonas Bonn <jonas@southpole.se>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Sean Christopherson <seanjc@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH RESEND 00/17] Resend bitmap patches
Date:   Sat, 14 Aug 2021 14:16:56 -0700
Message-Id: <20210814211713.180533-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a resend of previously submitted series:
https://lore.kernel.org/patchwork/cover/1462071/
https://lore.kernel.org/patchwork/patch/1458703/
https://lore.kernel.org/lkml/YPG8SdsbQ+sxjk0w@yury-ThinkPad/T/
https://lore.kernel.org/lkml/YMVSHCY9yEocmfVD@yury-ThinkPad/T/

Most of the patches received testing and review. If I missed to
add someone's review tag putting all together - my kind apologise.
Please resend it here.

I believe I addessed all comments except Joe's one. In comment to patch 3,
Joe Perches suggested to rename include/linux/find.h, but didn't give a
new name, so I leave it as is. Since this header is not for direct
inclusion, I'm OK with any reasonable name, and we can change it later.

Andrew, can you please take this series in linux-next?

Andy Shevchenko (1):
  tools: Rename bitmap_alloc() to bitmap_zalloc()

Yury Norov (16):
  bitops: protect find_first_{,zero}_bit properly
  bitops: move find_bit_*_le functions from le.h to find.h
  include: move find.h from asm_generic to linux
  arch: remove GENERIC_FIND_FIRST_BIT entirely
  lib: add find_first_and_bit()
  cpumask: use find_first_and_bit()
  all: replace find_next{,_zero}_bit with find_first{,_zero}_bit where
    appropriate
  tools: sync tools/bitmap with mother linux
  cpumask: replace cpumask_next_* with cpumask_first_* where appropriate
  include/linux: move for_each_bit() macros from bitops.h to find.h
  find: micro-optimize for_each_{set,clear}_bit()
  Replace for_each_*_bit_from() with for_each_*_bit() where appropriate
  mm/percpu: micro-optimize pcpu_is_populated()
  bitmap: unify find_bit operations
  lib: bitmap: add performance test for bitmap_print_to_pagebuf
  vsprintf: rework bitmap_list_string

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
 arch/powerpc/include/asm/cputhreads.h         |   2 +-
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
 arch/x86/kernel/apic/vector.c                 |   4 +-
 arch/x86/um/Kconfig                           |   1 -
 arch/xtensa/include/asm/bitops.h              |   1 -
 block/blk-mq.c                                |   2 +-
 drivers/block/rnbd/rnbd-clt.c                 |   2 +-
 drivers/dma/ti/edma.c                         |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   4 +-
 drivers/hwmon/ltc2992.c                       |   3 +-
 drivers/iio/adc/ad7124.c                      |   2 +-
 drivers/infiniband/hw/irdma/hw.c              |  16 +-
 drivers/media/cec/core/cec-core.c             |   2 +-
 drivers/media/mc/mc-devnode.c                 |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
 drivers/net/virtio_net.c                      |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                  |  10 +-
 drivers/soc/fsl/qbman/bman_portal.c           |   2 +-
 drivers/soc/fsl/qbman/qman_portal.c           |   2 +-
 drivers/soc/ti/k3-ringacc.c                   |   4 +-
 drivers/tty/n_tty.c                           |   2 +-
 drivers/virt/acrn/ioreq.c                     |   3 +-
 fs/f2fs/segment.c                             |   8 +-
 fs/ocfs2/cluster/heartbeat.c                  |   2 +-
 fs/ocfs2/dlm/dlmdomain.c                      |   4 +-
 fs/ocfs2/dlm/dlmmaster.c                      |  18 +-
 fs/ocfs2/dlm/dlmrecovery.c                    |   2 +-
 fs/ocfs2/dlm/dlmthread.c                      |   2 +-
 include/asm-generic/bitops.h                  |   1 -
 include/asm-generic/bitops/le.h               |  64 ---
 include/linux/bitmap.h                        |  34 +-
 include/linux/bitops.h                        |  34 --
 include/linux/cpumask.h                       |  46 ++-
 include/linux/find.h                          | 372 ++++++++++++++++++
 kernel/time/clocksource.c                     |   4 +-
 lib/Kconfig                                   |   3 -
 lib/find_bit.c                                |  21 +
 lib/find_bit_benchmark.c                      |  21 +
 lib/genalloc.c                                |   2 +-
 lib/test_bitmap.c                             |  37 ++
 lib/vsprintf.c                                |  24 +-
 mm/percpu.c                                   |  35 +-
 net/ncsi/ncsi-manage.c                        |   4 +-
 tools/include/asm-generic/bitops.h            |   1 -
 tools/include/asm-generic/bitops/find.h       | 145 -------
 tools/include/linux/bitmap.h                  |  11 +-
 .../bitops => tools/include/linux}/find.h     |  54 ++-
 tools/lib/find_bit.c                          |  20 +
 tools/perf/bench/find-bit-bench.c             |   2 +-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/tests/bitmap.c                     |   2 +-
 tools/perf/tests/mem2node.c                   |   2 +-
 tools/perf/util/affinity.c                    |   4 +-
 tools/perf/util/header.c                      |   4 +-
 tools/perf/util/metricgroup.c                 |   2 +-
 tools/perf/util/mmap.c                        |   4 +-
 .../selftests/kvm/dirty_log_perf_test.c       |   2 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |   4 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |   2 +-
 87 files changed, 657 insertions(+), 461 deletions(-)
 create mode 100644 include/linux/find.h
 delete mode 100644 tools/include/asm-generic/bitops/find.h
 rename {include/asm-generic/bitops => tools/include/linux}/find.h (83%)

-- 
2.30.2

