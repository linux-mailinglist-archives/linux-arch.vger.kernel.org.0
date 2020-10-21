Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1972294B67
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392083AbgJUKqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 06:46:34 -0400
Received: from foss.arm.com ([217.140.110.172]:33432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390103AbgJUKqe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 06:46:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C4D71FB;
        Wed, 21 Oct 2020 03:46:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0F6E3F66E;
        Wed, 21 Oct 2020 03:46:31 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Date:   Wed, 21 Oct 2020 11:46:07 +0100
Message-Id: <20201021104611.2744565-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds basic support for Asymmetric AArch32 systems. Full rationale
is in v1's cover letter.

	https://lore.kernel.org/linux-arch/20201008181641.32767-1-qais.yousef@arm.com/

Changes in v2:

	* We now reset vcpu->arch.target to force re-initialized for KVM patch.
	  (Marc)

	* Fix a bug where this_cpu_has_cap() must be called with preemption
	  disabled in check_aarch32_cpumask().

	* Add new sysctl.enable_asym_32bit. (Catalin)

	* Export id_aar64fpr0 register in sysfs which allows user space to
	  discover which cpus support 32bit@EL0. The sysctl must be enabled for
	  the user space to discover the asymmetry. (Will/Catalin)

	* Fixing up affinity in the kernel approach was dropped. The support
	  assumes the user space that wants to enable this support knows how to
	  guarantee correct affinities for 32bit apps by using cpusets.

Open questions:

	* Should there be any extra handling at execve() time? At the moment we
	  allow the app to start and only SIGKILL it after it has moved to the
	  'wrong' cpu. We could be stricter and do the check earlier when the
	  elf is loaded.

Thanks

--
Qais Yousef


Qais Yousef (4):
  arm64: kvm: Handle Asymmetric AArch32 systems
  arm64: Add support for asymmetric AArch32 EL0 configurations
  arm64: export emulate_sys_reg()
  arm64: Export id_aar64fpr0 via sysfs

 Documentation/arm64/cpu-feature-registers.rst |   2 +-
 arch/arm64/include/asm/cpu.h                  |   1 +
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |  22 +++-
 arch/arm64/include/asm/thread_info.h          |   5 +-
 arch/arm64/kernel/cpufeature.c                |  72 ++++++-----
 arch/arm64/kernel/cpuinfo.c                   | 116 +++++++++++++-----
 arch/arm64/kernel/process.c                   |  17 +++
 arch/arm64/kernel/signal.c                    |  24 ++++
 arch/arm64/kvm/arm.c                          |  14 +++
 arch/arm64/kvm/guest.c                        |   2 +-
 arch/arm64/kvm/sys_regs.c                     |   8 +-
 kernel/sysctl.c                               |  11 ++
 13 files changed, 226 insertions(+), 71 deletions(-)

-- 
2.25.1

