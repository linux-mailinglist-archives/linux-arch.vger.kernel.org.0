Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79D4A2D82
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 05:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfH3DoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 23:44:12 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:45744 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfH3DoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 23:44:12 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x7U3hATq026091;
        Fri, 30 Aug 2019 12:43:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x7U3hATq026091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567136590;
        bh=n/FaYt9S0oYy3OrU7uUSdznL2hSFziWcD6C9H/gFJSY=;
        h=From:To:Cc:Subject:Date:From;
        b=uf7EcFZazsGLGvFsS19t8IFTDuhERUXvBjI3JrKxn3IC1YmROZFTmWfAdaSZhGwYU
         dIXgxjLkRU4ztzVqfzWxYmhqhqoypqqcwqotFg8pWNo5fUbXwr+E+p43Low8y8WZvD
         nS6ez0U5nPVXKIBmTUHlI84Y9ELgdEg5iGrKZns6Ae4vYKXKyU3gY0IUPJdOffg2I6
         Pyuv0OQ4Awc0ARp0K3y8QcPSSzKZ9KDXoVGNNdkg+3nrh+7RZEnKg6b65CQSu9T7iq
         CDzgWBcyeQTIkuTT0pyNylGLlTCYCUrME8ZwicpZSzws+5LCMjxO8IpkzJ1g3KVMk5
         vFmFF+KTSulcw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Date:   Fri, 30 Aug 2019 12:43:04 +0900
Message-Id: <20190830034304.24259-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 9012d011660e ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
this option. A couple of build errors were reported by randconfig,
but all of them have been ironed out.

Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
(and it will simplify the 'inline' macro in compiler_types.h),
this commit changes it to always-on option. Going forward, the
compiler will always be allowed to not inline functions marked
'inline'.

This is not a problem for x86 since it has been long used by
arch/x86/configs/{x86_64,i386}_defconfig.

I am keeping the config option just in case any problem crops up for
other architectures.

The code clean-up will be done after confirming this is solid.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/Kconfig.debug | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..e25493811df8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -327,7 +327,7 @@ config HEADERS_CHECK
 	  relevant for userspace, say 'Y'.
 
 config OPTIMIZE_INLINING
-	bool "Allow compiler to uninline functions marked 'inline'"
+	def_bool y
 	help
 	  This option determines if the kernel forces gcc to inline the functions
 	  developers have marked 'inline'. Doing so takes away freedom from gcc to
@@ -338,8 +338,6 @@ config OPTIMIZE_INLINING
 	  decision will become the default in the future. Until then this option
 	  is there to test gcc for this.
 
-	  If unsure, say N.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1

