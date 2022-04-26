Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657951046E
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353413AbiDZQv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353353AbiDZQu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:59 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92C4832F
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:52 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id r26-20020a50aada000000b00425afa72622so7756345edc.19
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qfycs5WHoOJISCgVkz4aOXJI06Vi4G56am9I/vqcS5Q=;
        b=fRwDF91Cl56NtYnfVRrrwWq+ACk34XnpCPgWDJNhxkPf0+jyG4t7SUqyZkxziScoD6
         nlS+/T0kxR6PQ7wQlPhgkRdK+OAhXkwXjvWT5GdxHtziDcUCsqgfbLBiAQg7R4lxOA+S
         b1h3WJe9vuCUveQdnRjvIleLSdoXjd5T81AR3B/d6sysyhegK2IbBH7cJDKBoPbngE01
         jvw+rllOIeEdhzy+uxIADb7nx6kl7sAhRpV9EXPjMlnyR573JuNml4rWiL8PIe9a6qEW
         epw0ifH48szv7cq73qPvPsJ2sXpbRFaPAhln/IK2M8zSSWNmDvdbyCHkb2G+fh3x7wwt
         zbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qfycs5WHoOJISCgVkz4aOXJI06Vi4G56am9I/vqcS5Q=;
        b=WDhOctqzGkuNngUfa3nBynbQfUVmhoU7KnjsrMxqScpXmLJHX8fm9bzu6J9qHutmuf
         n87FqtI0JzKkEMjFHYzdOdy50hkCGA6cdEXvH4IdU432NIrvoW4eK7DgmhAlF4drAlWe
         vd6SajrezRqd5aq75aQshnzo2b96JRIJFPLNxXuQ5z/AyvyBEpgBxNPGziCEK0y90ddO
         Vfs8/0f1ueKpGIISgMDZWtQFhegbmkZRYU7fuVs23VzqbRnpLv783YUiEN47/XlW9ues
         hR/mja+ICwkddx9+wtiZjIXaF02A8jARCiXG5DuGQmIxkMBqc4YkuRDomqofvQa+lF6Z
         Pmgw==
X-Gm-Message-State: AOAM531TCqM5OJf1uVt0hY3TjrPVeaIw6x/ZwAb4yFMnNXafbfJjNKND
        9pC0lU28SZ9uaNbgWxH06YqvSf2L0II=
X-Google-Smtp-Source: ABdhPJyO5IzITq1Md/msOkFe5QpCMXnvVTw7Eg5gyXSwTxjpxMvbx88JMdeRNdS+uJ66Z5Deghmk2VEGLtk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:906:a08b:b0:6b9:2e20:f139 with SMTP id
 q11-20020a170906a08b00b006b92e20f139mr23252089ejy.463.1650991550999; Tue, 26
 Apr 2022 09:45:50 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:04 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-36-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 35/46] security: kmsan: fix interoperability with auto-initialization
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Heap and stack initialization is great, but not when we are trying
uses of uninitialized memory. When the kernel is built with KMSAN,
having kernel memory initialization enabled may introduce false
negatives.

We disable CONFIG_INIT_STACK_ALL_PATTERN and CONFIG_INIT_STACK_ALL_ZERO
under CONFIG_KMSAN, making it impossible to auto-initialize stack
variables in KMSAN builds. We also disable CONFIG_INIT_ON_ALLOC_DEFAULT_ON
and CONFIG_INIT_ON_FREE_DEFAULT_ON to prevent accidental use of heap
auto-initialization.

We however still let the users enable heap auto-initialization at
boot-time (by setting init_on_alloc=1 or init_on_free=1), in which case
a warning is printed.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I86608dd867018683a14ae1870f1928ad925f42e9
---
 mm/page_alloc.c            | 4 ++++
 security/Kconfig.hardening | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35b1fedb2f09c..4c89729cac7ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -849,6 +849,10 @@ void init_mem_debugging_and_hardening(void)
 	else
 		static_branch_disable(&init_on_free);
 
+	if (IS_ENABLED(CONFIG_KMSAN) &&
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index ded4d7c0d1322..d6cce64899d13 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -106,6 +106,7 @@ choice
 	config INIT_STACK_ALL_PATTERN
 		bool "pattern-init everything (strongest)"
 		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
+		depends on !KMSAN
 		help
 		  Initializes everything on the stack (including padding)
 		  with a specific debug value. This is intended to eliminate
@@ -124,6 +125,7 @@ choice
 	config INIT_STACK_ALL_ZERO
 		bool "zero-init everything (strongest and safest)"
 		depends on CC_HAS_AUTO_VAR_INIT_ZERO
+		depends on !KMSAN
 		help
 		  Initializes everything on the stack (including padding)
 		  with a zero value. This is intended to eliminate all
@@ -218,6 +220,7 @@ config STACKLEAK_RUNTIME_DISABLE
 
 config INIT_ON_ALLOC_DEFAULT_ON
 	bool "Enable heap memory zeroing on allocation by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_alloc=1" on the kernel
 	  command line. This can be disabled with "init_on_alloc=0".
@@ -230,6 +233,7 @@ config INIT_ON_ALLOC_DEFAULT_ON
 
 config INIT_ON_FREE_DEFAULT_ON
 	bool "Enable heap memory zeroing on free by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_free=1" on the kernel
 	  command line. This can be disabled with "init_on_free=0".
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

