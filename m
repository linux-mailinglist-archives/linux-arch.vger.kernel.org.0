Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0196399053
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFBQt1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 12:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbhFBQt0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jun 2021 12:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909CB610A1;
        Wed,  2 Jun 2021 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622652463;
        bh=H0wBqILgyrPd1zjIVdrlTRAQC2o/Hx1img2NVyMOtVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyPpOwCoI+nVIafLI5WARH5Ut3hhgspJHbF6HX0icz9wN9zVwAZvb0eJzdU6T8Q/X
         BsEFaeYLehDd+j9kgkOYP+Gx/lJLfT/6F+TK//V8o5ccTbcT9fLGx02QxiqcBekpOt
         yMIxAaOCHUDgrkGMbqoWsuj6rqQLSwQgY/xXDuJstdrPhEb3kSI6po3uQmec/wJQ2t
         fYMl2DIwSr8fWU/peFG2/3qPS+aVfU4NR/h+Lbbd+cOyCO515Na6pViSePEVfKw/IA
         jJRrt/yBMXUfjrB6c9IaadsahFurEPx1yFGtGsiVWTQ1maa1CxijUHX1IsEuq1bZzK
         o1NiUnvqB6OUA==
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
Subject: [PATCH v8 03/19] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
Date:   Wed,  2 Jun 2021 17:47:03 +0100
Message-Id: <20210602164719.31777-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602164719.31777-1-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org>
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
2.32.0.rc0.204.g9fa02ecfa5-goog

