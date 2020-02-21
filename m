Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCE16863F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 19:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgBUSTE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 13:19:04 -0500
Received: from foss.arm.com ([217.140.110.172]:45354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgBUSTD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A300FEC;
        Fri, 21 Feb 2020 10:19:03 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068653F6CF;
        Fri, 21 Feb 2020 10:19:01 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH v2 2/3] arm64: clocksource: Add VDSO default clockmode
Date:   Fri, 21 Feb 2020 18:18:48 +0000
Message-Id: <20200221181849.40351-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define VDSO_CLOCKMODE_ARCH_DEFAULT to represent the default vDSO
clockmode for arm_arch_timer.

The change to arm_arch_timer will be in the next patch of this
series.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/clocksource.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
index eb82e9d95c5d..36a2cca213ae 100644
--- a/arch/arm64/include/asm/clocksource.h
+++ b/arch/arm64/include/asm/clocksource.h
@@ -4,5 +4,6 @@
 
 #define VDSO_ARCH_CLOCKMODES	\
 	VDSO_CLOCKMODE_ARCHTIMER
+#define VDSO_CLOCKMODE_ARCH_DEFAULT	VDSO_CLOCKMODE_ARCHTIMER
 
 #endif
-- 
2.25.0

