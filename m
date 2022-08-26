Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46AC5A2AD1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiHZPPA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiHZPNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:13:44 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F5D13FBC
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:54 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so1241933edb.22
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=TL1IO7xzXsHa87B/8VTzh6zaFcPyOOUQBNZupLxKBzY=;
        b=HmM0VO6gyAfILflJdnMgQCrJGnTi5XVkH3YSfQa6Ep7rg4UjuRksDwsSKfdFWywrKQ
         X82KrgKGqPOH7W1Y085jaYB8hH48o1UO09SOdX25urL9IS+XrJIM0Ssl/7EKgVgUGuxb
         suAFkuoPLhsCY3yiCTAbiGImLbwkQ5FdkgDFrYP2s7UE16Wpzs+b87M7ywZwNSRcm9YT
         cGnqAcNCOOLNxnkJmTHzwJPrKl7dQaDEoIofp21fLLf8UCuU8TSnY933jziAvQ7zwjo3
         /ax/hZi6c/lKBcQc7+qabk0byKdenq8IrwbzMmcRBwdyqFxWLtVcbbN3QqtnjPKNbk+n
         t0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TL1IO7xzXsHa87B/8VTzh6zaFcPyOOUQBNZupLxKBzY=;
        b=vxNgViKGg0yM8cjV70MvGwM9cWROSl/+Aop68wXyvHUFab3wZni/CnG+rNUaIlT0F6
         FqYN1q18FW89D/pgxfTFBpZpCVbFc7H/8zzff2HXKOmV8I41DJu2J++jsFuIxAhsFNmc
         D3tp2snznorfsiIETt3X47MG09ilWQ54SWsrrIR9fjkawLXYeCWcH3k7HZznAhH9akOv
         dtWH8mngeuDGYCinIfFaOC/t3XOCCgWntdefkehWgIWwOx0XJX4Pq0V0+WPdPnXa2+D/
         3v/K1pvk+COafuX8HWzMQbHeE24CdWc6FwCaReIeq9td5AmvWnDttVrEgXHzsdcI+SuR
         1DvQ==
X-Gm-Message-State: ACgBeo11JwcNTC8mq9RHk8xoWe5/ExZfgcmrjlqY9RJtkqpILcuhGk3h
        e5hs8nwmc+BYaeGbPoov0NuQCRIQdBg=
X-Google-Smtp-Source: AA6agR76x5AzTzEwn7EdrRuhdUjJW6rIUhqvD9uYbbBW+SigP/bQyvCEvWgW5kLb9e6YBzYDFPgy1GTjMDc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id
 d17-20020a50fe91000000b0043dc97d1b93mr7390732edt.67.1661526585272; Fri, 26
 Aug 2022 08:09:45 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:56 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-34-glider@google.com>
Subject: [PATCH v5 33/44] x86: kmsan: disable instrumentation of unsupported code
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instrumenting some files with KMSAN will result in kernel being unable
to link, boot or crashing at runtime for various reasons (e.g. infinite
recursion caused by instrumentation hooks calling instrumented code again).

Completely omit KMSAN instrumentation in the following places:
 - arch/x86/boot and arch/x86/realmode/rm, as KMSAN doesn't work for i386;
 - arch/x86/entry/vdso, which isn't linked with KMSAN runtime;
 - three files in arch/x86/kernel - boot problems;
 - arch/x86/mm/cpu_entry_area.c - recursion.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- moved the patch earlier in the series so that KMSAN can compile
 -- split off the non-x86 part into a separate patch

v3:
 -- added a comment to lib/Makefile

v5:
 -- removed a comment belonging to another patch

Link: https://linux-review.googlesource.com/id/Id5e5c4a9f9d53c24a35ebb633b814c414628d81b
---
 arch/x86/boot/Makefile            | 1 +
 arch/x86/boot/compressed/Makefile | 1 +
 arch/x86/entry/vdso/Makefile      | 3 +++
 arch/x86/kernel/Makefile          | 2 ++
 arch/x86/kernel/cpu/Makefile      | 1 +
 arch/x86/mm/Makefile              | 2 ++
 arch/x86/realmode/rm/Makefile     | 1 +
 7 files changed, 11 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index ffec8bb01ba8c..9860ca5979f8a 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -12,6 +12,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b7..3a261abb6d158 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -20,6 +20,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 12f6c4d714cd6..ce4eb7e44e5b8 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -11,6 +11,9 @@ include $(srctree)/lib/vdso/Makefile
 
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KMSAN_SANITIZE_vclock_gettime.o := n
+KMSAN_SANITIZE_vgetcpu.o	:= n
+
 UBSAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a20a5ebfacd73..ac564c5d7b1f0 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -33,6 +33,8 @@ KASAN_SANITIZE_sev.o					:= n
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
+KMSAN_SANITIZE_head$(BITS).o				:= n
+KMSAN_SANITIZE_nmi.o					:= n
 
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 9661e3e802be5..f10a921ee7565 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -12,6 +12,7 @@ endif
 # If these files are instrumented, boot hangs during the first second.
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
+KMSAN_SANITIZE_common.o := n
 
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index f8220fd2c169a..39c0700c9955c 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -12,6 +12,8 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
 # reference __initdata sections.
 KCSAN_SANITIZE := n
+# Avoid recursion by not calling KMSAN hooks for CEA code.
+KMSAN_SANITIZE_cpu_entry_area.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 83f1b6a56449f..f614009d3e4e2 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -10,6 +10,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
+KMSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
-- 
2.37.2.672.g94769d06f0-goog

