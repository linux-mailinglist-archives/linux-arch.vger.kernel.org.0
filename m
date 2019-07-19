Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC186E1E8
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2019 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfGSHq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jul 2019 03:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfGSHq3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jul 2019 03:46:29 -0400
Received: from guoren-Inspiron-7460.lan (unknown [115.193.173.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B0F2084C;
        Fri, 19 Jul 2019 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563522388;
        bh=iS5Gcs9pag52S8jnb0L9hoE1awodLzeCGsoHidwBNP4=;
        h=From:To:Cc:Subject:Date:From;
        b=AITcbkVffd4Xb0QO7pN7uPS0Qge7mdnc9O7a15SKfHBYo6sucawk2elfYZ41NBzgf
         gIMe3wpftynxWVZKGnique4Qv6MyYsiKCgmWfNbbGvuCVDCyItCMrjR6GpsYV266AB
         uBxNDycvLO8MLXGbM4wEVf8aUpbTPq9sExVyDoic=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v5.3-rc1
Date:   Fri, 19 Jul 2019 15:46:20 +0800
Message-Id: <1563522380-9180-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.3-rc1

for you to fetch changes up to bdfeb0ccea1a12b58299b95eb0f28e2aa26de4c2:

  csky: Fixup abiv1 memset error (2019-07-19 14:21:36 +0800)

----------------------------------------------------------------
arch/csky patches for 5.3-rc1

This round of csky subsystem gives two features (ASID algorithm update,
Perf pmu record support) and some fixups.

Feature:
 - csky: Revert mmu ASID mechanism
 - csky: Add new asid lib code from arm
 - csky: Use generic asid algorithm to implement switch_mm
 - csky: Improve tlb operation with help of asid

 - csky: Init pmu as a device
 - csky: Add count-width property for csky pmu
 - csky: Add pmu interrupt support
 - csky: Fix perf record in kernel/user space
 - dt-bindings: csky: Add csky PMU bindings

Fixup:
 - csky: Fixup no panic in kernel for some traps
 - csky: Fixup some error count in 810 & 860.
 - csky: Fixup abiv1 memset error

CI-Tested: https://gitlab.com/c-sky/buildroot/pipelines/68656845

----------------------------------------------------------------
Guo Ren (9):
      csky: Select intc & timer drivers
      csky: Fixup no panic in kernel for some traps
      csky: Fixup some error count in 810 & 860.
      dt-bindings: interrupt-controller: Update csky mpintc
      csky: Revert mmu ASID mechanism
      csky: Add new asid lib code from arm
      csky: Use generic asid algorithm to implement switch_mm
      csky: Improve tlb operation with help of asid
      csky: Fixup abiv1 memset error

Mao Han (5):
      csky: Init pmu as a device
      csky: Add count-width property for csky pmu
      csky: Add pmu interrupt support
      csky: Fix perf record in kernel/user space
      dt-bindings: csky: Add csky PMU bindings

 Documentation/devicetree/bindings/csky/pmu.txt     |  38 ++
 .../bindings/interrupt-controller/csky,mpintc.txt  |  20 +-
 arch/csky/Kconfig                                  |   4 +
 arch/csky/abiv1/Makefile                           |   1 -
 arch/csky/abiv1/inc/abi/ckmmu.h                    |   6 +
 arch/csky/abiv1/inc/abi/string.h                   |   3 -
 arch/csky/abiv1/memset.c                           |  37 --
 arch/csky/abiv1/strksyms.c                         |   1 -
 arch/csky/abiv2/inc/abi/ckmmu.h                    |  10 +
 arch/csky/include/asm/asid.h                       |  78 ++++
 arch/csky/include/asm/mmu.h                        |   2 +-
 arch/csky/include/asm/mmu_context.h                | 114 +-----
 arch/csky/include/asm/pgtable.h                    |   2 -
 arch/csky/kernel/perf_event.c                      | 410 +++++++++++++++++++--
 arch/csky/kernel/smp.c                             |   2 -
 arch/csky/kernel/traps.c                           |   5 +
 arch/csky/mm/Makefile                              |   2 +
 arch/csky/mm/asid.c                                | 189 ++++++++++
 arch/csky/mm/context.c                             |  46 +++
 arch/csky/mm/init.c                                |   2 -
 arch/csky/mm/tlb.c                                 | 238 +++++-------
 21 files changed, 877 insertions(+), 333 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt
 delete mode 100644 arch/csky/abiv1/memset.c
 create mode 100644 arch/csky/include/asm/asid.h
 create mode 100644 arch/csky/mm/asid.c
 create mode 100644 arch/csky/mm/context.c
