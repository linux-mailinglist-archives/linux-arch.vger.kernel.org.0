Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B772A1706F2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 19:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBZSFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 13:05:38 -0500
Received: from foss.arm.com ([217.140.110.172]:40068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgBZSFi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C290031B;
        Wed, 26 Feb 2020 10:05:37 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 596F53F881;
        Wed, 26 Feb 2020 10:05:36 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 01/19] arm64: alternative: Allow alternative_insn to always issue the first instruction
Date:   Wed, 26 Feb 2020 18:05:08 +0000
Message-Id: <20200226180526.3272848-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are situations where we do not want to disable the whole block
based on a config option, only the alternative part while keeping the
first instruction. Improve the alternative_insn assembler macro to take
a 'first_insn' argument, default 0 to preserve the current behaviour.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/alternative.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 324e7d5ab37e..44083424d7aa 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -111,7 +111,11 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.byte \alt_len
 .endm
 
-.macro alternative_insn insn1, insn2, cap, enable = 1
+/*
+ * Disable the whole block if enable == 0, unless first_insn == 1 in which
+ * case insn1 will always be issued but without an alternative insn2.
+ */
+.macro alternative_insn insn1, insn2, cap, enable = 1, first_insn = 0
 	.if \enable
 661:	\insn1
 662:	.pushsection .altinstructions, "a"
@@ -122,6 +126,8 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 664:	.popsection
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
+	.elseif \first_insn
+	\insn1
 	.endif
 .endm
 
