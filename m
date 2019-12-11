Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A862B11BBE4
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKSkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:40:42 -0500
Received: from foss.arm.com ([217.140.110.172]:43022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfLKSkl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091551045;
        Wed, 11 Dec 2019 10:40:41 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4461F3F6CF;
        Wed, 11 Dec 2019 10:40:39 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 02/22] kbuild: Add support for 'as-instr' to be used in Kconfig files
Date:   Wed, 11 Dec 2019 18:40:07 +0000
Message-Id: <20191211184027.20130-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similar to 'cc-option' or 'ld-option', it is occasionally necessary to
check whether the assembler supports certain ISA extensions. In the
arm64 code we currently do this in Makefile with an additional define:

lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)

Add the 'as-instr' option so that it can be used in Kconfig directly:

	def_bool $(as-instr,.arch_extension lse)

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 scripts/Kconfig.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index d4adfbe42690..9d07e59cbdf7 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -31,6 +31,10 @@ cc-option = $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/null -o /de
 # Return y if the linker supports <flag>, n otherwise
 ld-option = $(success,$(LD) -v $(1))
 
+# $(as-instr,<instr>)
+# Return y if the assembler supports <instr>, n otherwise
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) $(CLANG_FLAGS) -c -x assembler -o /dev/null -)
+
 # check if $(CC) and $(LD) exist
 $(error-if,$(failure,command -v $(CC)),compiler '$(CC)' not found)
 $(error-if,$(failure,command -v $(LD)),linker '$(LD)' not found)
