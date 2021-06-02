Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E816339904D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFBQtO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 12:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFBQtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jun 2021 12:49:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D76B860FEE;
        Wed,  2 Jun 2021 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622652451;
        bh=mHZIffR0DdrLEhnAmRnaMyrF2+gcxZ3dunFWbH0rWDA=;
        h=From:To:Cc:Subject:Date:From;
        b=X8O9G15WXlPUIbsCT12lVtm4RjLJ4zKx9HySsNAGCx6+dztpHWyFTf/EZyKPUT9jW
         K90QcC5TS/hhmiLFDbOJWHiGfdP9LVfnIXh8ziBf1Av26VhRnvfxuUM06+uv0ieNJr
         /WemsMqoaEOhMwMwj9CAcjAXMi0vLjNAJnvl3JM12+T9U7ID41hxxmKjI5ikT/tzWU
         g1mUG0tVkszEO0DHYLJC81eCOAoXQLmnGFZZUhqSGbaETa0WZ1SUwvOWPnTHUF5Ctp
         po8TcQcjPb2FtI/eieTLbrNVfcRJMfPoFDpxUd2FDKMdHny3KKiJef0ehjy9VzpcBk
         qNbIRY+j3Jg8g==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v8 00/19] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Wed,  2 Jun 2021 17:47:00 +0100
Message-Id: <20210602164719.31777-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi again folks,

Here is v8 of the asymmetric 32-bit support patches that I previously
posted here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
  v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org
  v7: https://lore.kernel.org/r/20210525151432.16875-1-will@kernel.org

There was also a nice LWN writeup in case you've forgotten what this is
about:

	https://lwn.net/Articles/838339/

Changes since v7 include:

  * Dropped the scheduler migration fix, as Valentin has kindly fixed
    this separately in -tip:

    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=475ea6c60279e9f2ddf7e4cf2648cd8ae0608361

  * Dropped the freezer/ttwu changes, as Peter is rewriting that:

    https://lore.kernel.org/r/YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net

  * Reworded documentation wrt KVM behaviour [maz]

  * Tidied up control flow in cpuset_cpus_allowed_fallback() [peterz]

  * Fixed interaction with migrate_disable() [peterz]

  * Don't ignore allocation failure in restrict_cpus_allowed_ptr() [peterz]

  * Reordered the patches to put arm64 prep work first

  * Added some more acks/reviewed-by tags

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: kernel-team@android.com

--->8

Will Deacon (19):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  sched: Introduce task_cpu_possible_mask() to limit fallback rq
    selection
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
  sched: Reject CPU affinity changes based on task_cpu_possible_mask()
  sched: Introduce task_struct::user_cpus_ptr to track requested
    affinity
  sched: Split the guts of sched_setaffinity() into a helper function
  sched: Allow task CPU affinity to be restricted on asymmetric systems
  sched: Introduce task_cpus_dl_admissible() to check proposed affinity
  arm64: Implement task_cpu_possible_mask()
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
  Documentation: arm64: describe asymmetric 32-bit support

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |  11 +
 Documentation/arm64/asymmetric-32bit.rst      | 155 ++++++++
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/include/asm/cpu.h                  |  44 +--
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/elf.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                | 227 +++++++++---
 arch/arm64/kernel/cpuinfo.c                   |  53 +--
 arch/arm64/kernel/process.c                   |  44 ++-
 arch/arm64/kvm/arm.c                          |  11 +-
 arch/arm64/tools/cpucaps                      |   3 +-
 include/linux/cpuset.h                        |   3 +-
 include/linux/mmu_context.h                   |  11 +
 include/linux/sched.h                         |  21 ++
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  49 ++-
 kernel/fork.c                                 |   2 +
 kernel/sched/core.c                           | 334 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 21 files changed, 819 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

