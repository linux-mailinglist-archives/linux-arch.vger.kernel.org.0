Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200941F468
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355586AbhJASON (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhJASOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:14:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277CBC061775;
        Fri,  1 Oct 2021 11:12:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r7so7084989pjo.3;
        Fri, 01 Oct 2021 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1V9qLdJ7N9KO3G5HusJFlDeTFePzR9GzlCEJBTXj3U=;
        b=iqFo/EBaTQNoe4x5hYB05wov6we850SStXP27FhStUkPDi9Lr9CWiQLcFcDIALBm8E
         4aWBViejYhUjMssufYOySZ9pWWpO2RVKv96lA4BCEqUabGROHoYIsK7l2LPjzPfy8g4o
         yM28Gfs3u3n3VBCSmWyCeyHJFQKECIVQbY/T4OtYNF2j/i333wL67XIOvBtOW4nEUZoc
         2iBZ8+/5EXoI/tbZTf3Rh/pXmHKcwjnUE4HbtlNfQRdFGXdV5wKHTKbSoErpkWxddN0t
         MstNBNLID4V2yUaye9E18Ok1dmajJWaN13VXKpYkEY6DmB5XlIwx4Dn7ZseK4WcTqmeg
         7nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1V9qLdJ7N9KO3G5HusJFlDeTFePzR9GzlCEJBTXj3U=;
        b=p29H3V2HLsNE65vewlUzvAGk1IjZp6wLYiv9MGSEzC2MDSPpeKvbEupxIKi6f4fWMz
         ZbSPD9HflyvnSGVUHVTRnScR9RpGQ8A7NJW4dT5uIK3x9Yswa/GiYiSdbni8DVLu868a
         scnnrzjkRMXRS+mv9dwsi0LHitwPiKs57PtkyD5la7BEoJfnFpZL+h3FEoxH0sO8caMX
         l1XkAP5WJvWXINvfRl4HyAvrlcR0AdRPJnwZZG8FzPCkA4fkXpZZiVGRHDVaxJlRqVNi
         A41YDx1pTrTvf+iVBp++4gKNRIXklVs1QvY9yaVZpkD6bXCBB7PJfb30xboQUVxWegMc
         FkOQ==
X-Gm-Message-State: AOAM533rgdp7QD3RijKxiDUOakiI8Qmizzds77Z4lxIih8s8iAxNeWi3
        db+RTx+y/VUOG8k1uhvqWpSlgKqoVwc=
X-Google-Smtp-Source: ABdhPJyfvygyojPKT3w4OvBrSy5IcoV7PC60DzY5WgZ5LojtQSC6JOTGKIKAg7rflEge8lah9V8Bew==
X-Received: by 2002:a17:90a:1942:: with SMTP id 2mr21445882pjh.195.1633111946990;
        Fri, 01 Oct 2021 11:12:26 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m10sm8294682pjs.21.2021.10.01.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:12:26 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH RESEND 2 00/16] Resend bitmap patches
Date:   Fri,  1 Oct 2021 11:12:10 -0700
Message-Id: <20211001181226.228340-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stephen,

Can you please take this series into the next tree? It has been already
in next-tree for 5.14:

https://lore.kernel.org/linux-mmc/YSeduU41Ef568xhS@alley/T/

But it was damaged and we decided to merge it in 5.15 cycle. No changes
comparing to 5.14, except for Andy's patch that was already upstreamed
and therefore removed from here.

The git tree is here:
	https://github.com/norov/linux/tree/bitmap-20210929

Thanks,
Yury

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
 tools/include/linux/bitmap.h                  |   7 +-
 .../bitops => tools/include/linux}/find.h     |  54 ++-
 tools/lib/find_bit.c                          |  20 +
 75 files changed, 637 insertions(+), 441 deletions(-)
 create mode 100644 include/linux/find.h
 delete mode 100644 tools/include/asm-generic/bitops/find.h
 rename {include/asm-generic/bitops => tools/include/linux}/find.h (83%)

-- 
2.30.2

