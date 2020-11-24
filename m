Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805992C2BD0
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbgKXPuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389441AbgKXPuu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:50:50 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4FD206F7;
        Tue, 24 Nov 2020 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233049;
        bh=yoeRj4z5iLRdLbFu53ck1gIL1842BAqIhWtAD0VR2Tk=;
        h=From:To:Cc:Subject:Date:From;
        b=sFK2P+nvwsOkOCUTTAQWExKGMp1llBY1idSsHQR3G8+ZfsmDfDOydQWVQwNjODzpb
         xA1+lEG4+iwF3Q3WJGQNW5xFPiDEAMzNJyFHnT/Ruv5t1qU+YcEdJZlaaUKTOFRHZa
         B2BNV2WJReTFe0YYSyXcDYrPQhYSAWXgbPogpm8g=
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
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 00/14] An alternative series for asymmetric AArch32 systems
Date:   Tue, 24 Nov 2020 15:50:25 +0000
Message-Id: <20201124155039.13804-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello folks,

Here's version four of the wonderful patches I previously posted here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org

and which started life as a reimplementation of some patches from Qais:

  https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com

The aim of this series is to allow 32-bit ARM applications to run on
arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
Unfortunately, such SoCs are real and will continue to be productised
over the next few years at least.

Changes in v4 include:

  * Take into account the cpuset 'allowed' mask on exec
  * Print a warning if we forcefully override the affinity, like we do
    in select_fallback_rq()
  * Rename arch_cpu_allowed_mask() to arch_task_cpu_possible_mask()
  * Added a comment to adjust_compat_task_affinity()

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
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: kernel-team@android.com

--->8

Will Deacon (14):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU
    affinity
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  sched: Introduce arch_task_cpu_possible_mask() to limit fallback rq
    selection
  sched: Reject CPU affinity changes based on
    arch_task_cpu_possible_mask()
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Implement arch_task_cpu_possible_mask()
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/arm64/include/asm/cpu.h                  |  44 ++--
 arch/arm64/include/asm/cpucaps.h              |   2 +-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/mmu_context.h          |  13 ++
 arch/arm64/kernel/cpufeature.c                | 219 ++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                   |  53 +++--
 arch/arm64/kernel/process.c                   |  47 +++-
 arch/arm64/kvm/arm.c                          |  11 +-
 include/linux/sched.h                         |   1 +
 kernel/cgroup/cpuset.c                        |   6 +-
 kernel/sched/core.c                           |  90 +++++--
 13 files changed, 401 insertions(+), 109 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

