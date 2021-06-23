Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347E13B1FA8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWRlO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhFWRlO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:41:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 463D2611C1;
        Wed, 23 Jun 2021 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624469936;
        bh=LsdX3KU6rHhhTz7HcyPQTUF5UxnkSQL1LjLhYoWKqFw=;
        h=From:To:Cc:Subject:Date:From;
        b=Qw84XRhtkeGB7JM3QxZ6t9f0/y8C2OM14C+Bej0Njst+XSnFPogJJDTB0SwOAD0fq
         zgNR3QhWbBbZ0H0ofOHJ4JW2xmsN2anfZ4uBn8VHF/JLhzdDgG5LfcjRVauu0T9cgO
         i28MInicDQWrUidbSEzCzmh2xUD6b3J5TsGjE01Z2PfDcPm3KPqTh2t3uqXz/NI5rw
         XCZODsHsekMNB2s5wQNADJiM5Fjqxop8rwRaoowNNKUx3lRUcRKXZdM7T2x/az0XMd
         cMfgQCMh8MPGJYMVHwSiRAf+ZSzcv5VXcTrsj2suYKooryKDm6S95Ylrm9FDkO14xh
         +7EL8lvueSlTw==
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
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v10 00/16] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Wed, 23 Jun 2021 18:38:32 +0100
Message-Id: <20210623173848.318-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi again all,

This is version TEN of the patches previously circulated at:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
  v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org
  v7: https://lore.kernel.org/r/20210525151432.16875-1-will@kernel.org
  v8: https://lore.kernel.org/r/20210602164719.31777-1-will@kernel.org
  v9: https://lore.kernel.org/r/20210608180313.11502-1-will@kernel.org

There was also a nice LWN writeup in case you've forgotten what this is
about:

	https://lwn.net/Articles/838339/

The only changes since v9 are that I've added some Reviewed-by tags from
Valentin and rebased the series onto the stable arm64/for-next/cpufeature
branch, where I have queued some of the arm64 prerequisites [1].

Cheers,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/cpufeature

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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kernel-team@android.com

--->8

Will Deacon (16):
  sched: Introduce task_cpu_possible_mask() to limit fallback rq
    selection
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
  cpuset: Cleanup cpuset_cpus_allowed_fallback() use in
    select_fallback_rq()
  sched: Reject CPU affinity changes based on task_cpu_possible_mask()
  sched: Introduce task_struct::user_cpus_ptr to track requested
    affinity
  sched: Split the guts of sched_setaffinity() into a helper function
  sched: Allow task CPU affinity to be restricted on asymmetric systems
  sched: Introduce dl_task_check_affinity() to check proposed affinity
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
 arch/arm64/include/asm/elf.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                |  51 ++-
 arch/arm64/kernel/process.c                   |  47 ++-
 arch/arm64/kernel/signal.c                    |  26 --
 include/linux/cpuset.h                        |   8 +-
 include/linux/mmu_context.h                   |  14 +
 include/linux/sched.h                         |  21 ++
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  59 +--
 kernel/fork.c                                 |   2 +
 kernel/sched/core.c                           | 340 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 17 files changed, 627 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.32.0.93.g670b81a890-goog

