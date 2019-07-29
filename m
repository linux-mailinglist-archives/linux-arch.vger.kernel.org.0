Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8178C10
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2Mym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 08:54:42 -0400
Received: from foss.arm.com ([217.140.110.172]:43716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfG2Mym (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jul 2019 08:54:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86D1A28;
        Mon, 29 Jul 2019 05:54:41 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9656B3F71F;
        Mon, 29 Jul 2019 05:54:39 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, salyzyn@android.com, pcc@google.com,
        0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        Matteo Croce <mcroce@redhat.com>
Subject: [PATCH] arm64: vdso: Fix Makefile regression
Date:   Mon, 29 Jul 2019 13:54:21 +0100
Message-Id: <20190729125421.32482-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Using an old .config in combination with "make oldconfig" can cause
an incorrect detection of the compat compiler:

$ grep CROSS_COMPILE_COMPAT .config
CONFIG_CROSS_COMPILE_COMPAT_VDSO=""

$ make oldconfig && make
arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
Stop.

Accordingly to the section 7.2 of the GNU Make manual "Syntax of
Conditionals", "When the value results from complex expansions of
variables and functions, expansions you would consider empty may
actually contain whitespace characters and thus are not seen as
empty. However, you can use the strip function to avoid interpreting
whitespace as a non-empty value."

Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
evaluation.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index bb1f1dbb34e8..61de992bbea3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
 
   ifeq ($(CONFIG_CC_IS_CLANG), y)
     $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
-  else ifeq ($(CROSS_COMPILE_COMPAT),)
+  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
     $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
   else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
     $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
-- 
2.22.0

