Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8994A9E900
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH0NTC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 09:19:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbfH0NSo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0FEB15BF;
        Tue, 27 Aug 2019 06:18:43 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B40083F246;
        Tue, 27 Aug 2019 06:18:42 -0700 (PDT)
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6/6] arm64: kvm: Replace hardcoded '1' with SYS_PAR_EL1_F
Date:   Tue, 27 Aug 2019 14:18:18 +0100
Message-Id: <20190827131818.14724-7-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that we have a definition for the 'F' field of PAR_EL1, use that
instead of coding the immediate directly.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index adaf266d8de8..bd978ad71936 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -264,7 +264,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	tmp = read_sysreg(par_el1);
 	write_sysreg(par, par_el1);
 
-	if (unlikely(tmp & 1))
+	if (unlikely(tmp & SYS_PAR_EL1_F))
 		return false; /* Translation failed, back to guest */
 
 	/* Convert PAR to HPFAR format */
-- 
2.11.0

