Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081A2294B68
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392101AbgJUKqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 06:46:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390103AbgJUKqg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 06:46:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F6AD6E;
        Wed, 21 Oct 2020 03:46:35 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2BD3F66E;
        Wed, 21 Oct 2020 03:46:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/4] arm64: kvm: Handle Asymmetric AArch32 systems
Date:   Wed, 21 Oct 2020 11:46:08 +0100
Message-Id: <20201021104611.2744565-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021104611.2744565-1-qais.yousef@arm.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a system without uniform support for AArch32 at EL0, it is possible
for the guest to force run AArch32 at EL0 and potentially cause an
illegal exception if running on the wrong core.

Add an extra check to catch if the guest ever does that and prevent it
from running again by resetting vcpu->arch.target and return
ARM_EXCEPTION_IL.

We try to catch this misbehavior as early as possible and not rely on
PSTATE.IL to occur.

Tested on Juno by instrumenting the host to:

	* Fake asym aarch32.
	* Instrument KVM to make the asymmetry visible to the guest.

Any attempt to run 32bit app in the guest will produce such error on
qemu:

	# ./test
	error: kvm run failed Invalid argument
	 PC=ffff800010945080 X00=ffff800016a45014 X01=ffff800010945058
	X02=ffff800016917190 X03=0000000000000000 X04=0000000000000000
	X05=00000000fffffffb X06=0000000000000000 X07=ffff80001000bab0
	X08=0000000000000000 X09=0000000092ec5193 X10=0000000000000000
	X11=ffff80001608ff40 X12=ffff000075fcde86 X13=ffff000075fcde88
	X14=ffffffffffffffff X15=ffff00007b2105a8 X16=ffff00007b006d50
	X17=0000000000000000 X18=0000000000000000 X19=ffff00007a82b000
	X20=0000000000000000 X21=ffff800015ccd158 X22=ffff00007a82b040
	X23=ffff00007a82b008 X24=0000000000000000 X25=ffff800015d169b0
	X26=ffff8000126d05bc X27=0000000000000000 X28=0000000000000000
	X29=ffff80001000ba90 X30=ffff80001093f3dc  SP=ffff80001000ba90
	PSTATE=60000005 -ZC- EL1h
	qemu-system-aarch64: Failed to get KVM_REG_ARM_TIMER_CNT
	Aborted

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 arch/arm64/kvm/arm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b588c3b5c2f0..c2fa57f56a94 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -804,6 +804,19 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		preempt_enable();
 
+		/*
+		 * The ARMv8 architecture doesn't give the hypervisor
+		 * a mechanism to prevent a guest from dropping to AArch32 EL0
+		 * if implemented by the CPU. If we spot the guest in such
+		 * state and that we decided it wasn't supposed to do so (like
+		 * with the asymmetric AArch32 case), return to userspace with
+		 * a fatal error.
+		 */
+		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+			vcpu->arch.target = -1;
+			ret = ARM_EXCEPTION_IL;
+		}
+
 		ret = handle_exit(vcpu, ret);
 	}
 
-- 
2.25.1

