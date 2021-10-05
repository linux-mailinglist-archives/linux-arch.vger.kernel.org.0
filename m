Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0C421E0A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 07:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJEFmr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEFmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 01:42:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA5C061745;
        Mon,  4 Oct 2021 22:40:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b22so1532583pls.1;
        Mon, 04 Oct 2021 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av2xBHrLGpKKZFp0hKB8ZbiiBN2E9k8Q3N8s6NRbFdw=;
        b=PKuJVAQDnM7o1A1xpeF9VLcI17Tqus9XxFzhAFuALd4R+DXgKacNKpcN4FRR5jgShX
         0UBK5eiN6fVVUtxRfpi88bjCdDPrJuc5Dn1Af826bcu4uksV/iFiCPl2pWonOLzVlBR/
         0KCtgKab/npd30UZLa5Aoka8viu0QbsVH2Ngcxp9cExcUTfUPsA20If8PgSMlp0y3ErD
         z7rQDCQkAAczGP5c9hqIIwOORhPeEF6XVN9fMG+XWt7PjZA/pdSBQFZMmiqNX2HefQV4
         YAPjieQrGgSghN3pjiWlHzLfAYELhqIizkpXRwvoBwysp++4UikVvpezIYL/senmkl2I
         hJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=av2xBHrLGpKKZFp0hKB8ZbiiBN2E9k8Q3N8s6NRbFdw=;
        b=JdPvgt1V5qrXvy0IDTwmtRQbt/z+uN84FbZa+3peb//X3fZHTUND1oPXM2Nfn+YYn8
         +pE+IPnSy7pHs5nUDKO1IegIQ6qyZV/EQOOnntujSt05bjra79rh/fE201X5b4raAlDi
         TQ3GfuNmCcr7uB90cmeuRBnbxVaWg/Lf3C86JL6lgZhy7OkfEUI6EvnGlzY7tK3dQLPc
         n7M+0ML2w19owsPxfVaDgQLgUSHj/mxpkbSW2Nv42WumaYEzNQbTcERwoipRsyIqeFgV
         3zqvmDyv+IMH2H0ejkuAGxeawiJABAwTB95yDB3XLsGMhnEmO7Qa8MzpAIKHQSD2Mf+E
         3Rqw==
X-Gm-Message-State: AOAM531TphuW2GP4ASeJiOFXT1+Pa/YcwkYpO5JYMkJPujLPpDTAOrqr
        Svy1ds6KZqXkX+VaITGtyHg=
X-Google-Smtp-Source: ABdhPJwO5flC4hUMWWj7yG3YyGmvMkMYfWlRb1NWlMcNKI//7aKBUf5dAIWmvjHk9EHwFLu2wf1g3Q==
X-Received: by 2002:a17:90a:4b4d:: with SMTP id o13mr1510046pjl.236.1633412456736;
        Mon, 04 Oct 2021 22:40:56 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x21sm16155237pfa.186.2021.10.04.22.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 22:40:56 -0700 (PDT)
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
Subject: [PATCH RESEND 3 00/16] Bitmap patches for 5.15
Date:   Mon,  4 Oct 2021 22:40:43 -0700
Message-Id: <20211005054059.475634-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stephen,

Please pull this bitmap series. The git tree is here:
        https://github.com/norov/linux/tree/bitmap-master-5.15

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

