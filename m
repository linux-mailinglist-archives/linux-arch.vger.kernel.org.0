Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928036A0B23
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjBWNsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 08:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjBWNsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 08:48:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CD1EBDC;
        Thu, 23 Feb 2023 05:47:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 669341EC06C0;
        Thu, 23 Feb 2023 14:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677160075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hO7XAwGHrh7jFk3tHCK0hu6b1iYy4OafzVQ/2u7pgt0=;
        b=XfrOb7PSES+S6B9eQEkNsjlZRHVF4TWjOqGoeG4O4dPJLEYmxc8q1Ehl5tvde40+rpKH68
        3wN/883J0piBys3sMxNwuV9jX8TKi5vKKbjvvJPUrReZ+bzfj4BeS2P9fQiRfrIHpbz3Bl
        1WIZQ+6CUY+TxMk/R6vjW/NeYUVVxE8=
Date:   Thu, 23 Feb 2023 14:47:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Message-ID: <Y/duhySUieqUWoGX@zn.tnic>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-38-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-38-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:29PM -0800, Rick Edgecombe wrote:
> Since this test exercises a recently added syscall manually, it needs
> to find the automatically created __NR_foo defines. Per the selftest
> documentation, KHDR_INCLUDES can be used to help the selftest Makefile's

Well, why don't you make it easier for the user of this to not have to
jump through hoops to get the test built?

IOW, something like the below ontop.

It works if I do

$ make -j<num> test_shadow_stack_64

It would only need to be fixed to work when you do

$ make -j<num>

without arguments as then make does a parallel build.

I guess something like

ifneq ($(filter test_shadow_stack_64, $(MAKECMDGOALS)),)
.NOTPARALLEL:
endif

needs to happen but I'm not sure...

Thx.

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index a5c5ee73052a..9287dc7c0263 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -14,6 +14,10 @@ top_srcdir ?= ../../..
 abs_srctree := $(shell cd $(top_srcdir) && pwd)
 KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
 
+test_shadow_stack_64: test_shadow_stack.c helpers.h
+	cd $(top_srcdir) && $(MAKE) headers
+	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $^ -lrt -ldl
+
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
@@ -22,7 +26,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx test_shadow_stack
+			corrupt_xstate_header amx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -38,7 +42,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
