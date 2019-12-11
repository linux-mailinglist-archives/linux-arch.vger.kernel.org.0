Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA711BBE2
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfLKSkj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:40:39 -0500
Received: from foss.arm.com ([217.140.110.172]:43006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKSkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 104B7328;
        Wed, 11 Dec 2019 10:40:39 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 662103F6CF;
        Wed, 11 Dec 2019 10:40:37 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/22] mm: Reserve asm-generic prot flags 0x10 and 0x20 for arch use
Date:   Wed, 11 Dec 2019 18:40:06 +0000
Message-Id: <20191211184027.20130-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

The asm-generic/mman.h definitions are used by a few architectures that
also define arch-specific PROT flags with value 0x10 and 0x20. This
currently applies to sparc and powerpc for 0x10, while arm64 will soon
join with 0x10 and 0x20.

To help future maintainers, document the use of this flag in the
asm-generic header too.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
[catalin.marinas@arm.com: reserve 0x20 as well]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/uapi/asm-generic/mman-common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index c160a5354eb6..f94f65d429be 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -11,6 +11,8 @@
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
 #define PROT_SEM	0x8		/* page may be used for atomic ops */
+/*			0x10		   reserved for arch-specific use */
+/*			0x20		   reserved for arch-specific use */
 #define PROT_NONE	0x0		/* page can not be accessed */
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
