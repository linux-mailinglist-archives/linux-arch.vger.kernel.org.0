Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C93904E2
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhEYPRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231890AbhEYPRB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C40876142E;
        Tue, 25 May 2021 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955731;
        bh=iCW9NKyrbGkMxHcLgSLRB5Nf72sT8+JudVFeMeF95HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyBLnhcA8wo1hU2DqGOjfq0QJmNvr/isoo7LCQdyT3+fvqpDiKV0CynUr0L52SDsI
         1xtfrE9AaE+vfZzJMEw0BGAaIgiLUW/xXg7ls7DG6VLhbY2tiihgWMcrS8DYusUEYv
         mO5WivCKYFBniNAE0BmZCtuo5xu+QuMB6fnim/ktxeHZaBmnpC5qmkxKi0TYTV6vUa
         GTOGs1mRQug8rupVTmbchSmrWltfufcqsJGC3vVbtvIoWWh9Ft41UNxIOwwXcbGQnV
         vtnfAkldabJW483EXJpHFEzT4br15Pb2hNMGT65ApBrbJMIyoZ07Jg4+b95ngGQgSJ
         uoc2TMNNF7adA==
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
        kernel-team@android.com
Subject: [PATCH v7 04/22] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
Date:   Tue, 25 May 2021 16:14:14 +0100
Message-Id: <20210525151432.16875-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If a vCPU is caught running 32-bit code on a system with mismatched
support at EL0, then we should kill it.

Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1cb39c0803a4..5bdba97a7654 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -692,6 +692,15 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
+{
+	if (likely(!vcpu_mode_is_32bit(vcpu)))
+		return false;
+
+	return !system_supports_32bit_el0() ||
+		static_branch_unlikely(&arm64_mismatched_32bit_el0);
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -875,7 +884,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * with the asymmetric AArch32 case), return to userspace with
 		 * a fatal error.
 		 */
-		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu_mode_is_bad_32bit(vcpu)) {
 			/*
 			 * As we have caught the guest red-handed, decide that
 			 * it isn't fit for purpose anymore by making the vcpu
-- 
2.31.1.818.g46aad6cb9e-goog

