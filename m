Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB011AAECA
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410492AbgDOQw7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 12:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410484AbgDOQwv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:52:51 -0400
Received: from localhost.localdomain (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DABAC208FE;
        Wed, 15 Apr 2020 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969571;
        bh=Fl4LMr8tfhnu5I5/m4JsWq9kVGAsJCZEwYG3/7yjBSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTxe5nW1LeD77zlUfP+9luRCQxFWUlOaAVLtZGWWqYFy/PWSNFw1GAjaVghaa6iWP
         Kd6pnTiHfK3q6clheUTPN1AqMfxMCEi1LgwKYMigxiUla/83wxyVC8uogCffafC24o
         0J2f4RyJnvmSX3Vn/1MLbw71j95IpyvYe6zk6nLE=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 01/12] compiler/gcc: Emit build-time warning for GCC prior to version 4.8
Date:   Wed, 15 Apr 2020 17:52:07 +0100
Message-Id: <20200415165218.20251-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
discarding the 'volatile' qualifier:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

We've been working around this using some nasty hacks which make
READ_ONCE() both horribly complicated and also prevent us from enforcing
that it is only used on scalar types. Since GCC 4.8 is pretty old for
kernel builds now, emit a warning if we detect it during the build.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 init/Kconfig            | 4 ++--
 scripts/Kconfig.include | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..816b8b4a5e9e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -9,11 +9,11 @@ config DEFCONFIG_LIST
 	default "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)"
 
 config CC_IS_GCC
-	def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
+	def_bool $(cc-is-gcc)
 
 config GCC_VERSION
 	int
-	default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
+	default $(gcc-version) if CC_IS_GCC
 	default 0
 
 config LD_VERSION
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index c264da2b9b30..5261e9d6b50b 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -54,3 +54,12 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
 cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
 m32-flag := $(cc-option-bit,-m32)
 m64-flag := $(cc-option-bit,-m64)
+
+# gcc version including patch level
+gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
+
+# Return y if the compiler is GCC, n otherwise
+cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
+
+# Warn if the compiler is GCC prior to 4.8
+$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")
-- 
2.26.0.110.g2183baf09c-goog

