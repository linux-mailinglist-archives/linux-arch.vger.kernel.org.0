Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61A31395C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhBHQ1I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 11:27:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:40894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhBHQ03 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 11:26:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC98CAD6A;
        Mon,  8 Feb 2021 16:25:46 +0000 (UTC)
Date:   Mon, 8 Feb 2021 17:25:43 +0100
From:   Borislav Petkov <bp@suse.de>
To:     AC <achirvasub@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, jpoimboe@redhat.com, nborisov@suse.com,
        seth.forshee@canonical.com, yamada.masahiro@socionext.com
Subject: [PATCH] x86/build: Disable CET instrumentation in the kernel for
 32-bit too
Message-ID: <20210208162543.GH17908@zn.tnic>
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain>
 <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
 <YCCIgMHkzh/xT4ex@arch-chirva.localdomain>
 <20210208121227.GD17908@zn.tnic>
 <82FA27E6-A46F-41E2-B7D3-2FEBEA8A4D70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82FA27E6-A46F-41E2-B7D3-2FEBEA8A4D70@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 08, 2021 at 10:19:33AM -0500, AC wrote:
> That did fix it, thank you!

Thanks!

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 8 Feb 2021 16:43:30 +0100
Subject: [PATCH] x86/build: Disable CET instrumentation in the kernel for 32-bit too

Commit

  20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")

disabled CET instrumentation which gets added by default by the Ubuntu
gcc9 and 10 by default, but did that only for 64-bit builds. It would
still fail when building a 32-bit target. So disable CET for all x86
builds.

Fixes: 20bf2b378729 ("x86/build: Disable CET instrumentation in the kernel")
Reported-by: AC <achirvasub@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: AC <achirvasub@gmail.com>
Link: https://lkml.kernel.org/r/YCCIgMHkzh/xT4ex@arch-chirva.localdomain
---
 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 109c7f86483c..b9f58b8993b3 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -50,6 +50,9 @@ export BITS
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
 KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
 
+# Intel CET isn't enabled in the kernel
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
@@ -120,9 +123,6 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-
-	# Intel CET isn't enabled in the kernel
-	KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
 ifdef CONFIG_X86_X32
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
