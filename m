Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CC1706FB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 19:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBZSFw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 13:05:52 -0500
Received: from foss.arm.com ([217.140.110.172]:40160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZSFw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C56C30E;
        Wed, 26 Feb 2020 10:05:51 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B27883F881;
        Wed, 26 Feb 2020 10:05:49 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
Date:   Wed, 26 Feb 2020 18:05:16 +0000
Message-Id: <20200226180526.3272848-10-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Add MTE-specific SIGSEGV codes to siginfo.h.

Note that the for MTE we are reusing the same SPARC ADI codes because
the two functionalities are similar and they cannot coexist on the same
system.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
[catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
[catalin.marinas@arm.com: dropped #ifdef __aarch64__, renumbered]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Notes:
    v2:
    - Dropped the #ifdef __aarch64__.
    - Renumbered the SEGV_MTE* values to avoid clash with ADI.

 include/uapi/asm-generic/siginfo.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..7aacf9389010 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,9 @@ typedef struct siginfo {
 #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
 #define SEGV_ADIDERR	6	/* Disrupting MCD error */
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
-#define NSIGSEGV	7
+#define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
+#define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
+#define NSIGSEGV	9
 
 /*
  * SIGBUS si_codes
