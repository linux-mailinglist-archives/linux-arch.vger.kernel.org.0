Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65864EAD63
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiC2MnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiC2Mmy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:54 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43558208321
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:03 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gv17-20020a1709072bd100b006dfcc7f7962so8125465ejc.5
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cXkdgZbGJwU6k8snEczoh0k/WkFNvdUgCw+ayF9WLuQ=;
        b=kJ3CEmpah2i9qEH7T+C5Ga2iXnj2Y+3RwMf8YqsmELN6LOISLHU5lU3es8dFXLXr4G
         RwvPPr+lXFQJJVB8eC5SfjBqsSq8LtpCHYf3AswzsXu/1NhBVq2D9gsP4OH2L4CTMT4M
         htWXUw29Be33vwaebXorL3fSnDwOI8IYefJyHWs3/4YxoYcA+PWRfpq7JHQ6XEzLzzbD
         FlQgRQzQ9K3/oO1RgYlOuEtyVvqXUpOZFhIl55G6hZ3TouP4qi7NusxxsF5cTKn2krfS
         X+VguAz0cQlQcgvkoFLT3U0fU9ShmiXto/lOzeXy+6A0JzZKD80LdngdHu/dWikUglw0
         6J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cXkdgZbGJwU6k8snEczoh0k/WkFNvdUgCw+ayF9WLuQ=;
        b=BsYICzaav+DTG90WRPZV+pyNtGam57K4b636gYL5Fy7wPqFuDzYbUnCiv275xjsUSY
         jkmMcNRvbe09rWXUC8z9uQ7auNrzBvUHQx9H52W1JBrje9Gi5PrDLR3qOSWJpAd1o6yx
         ruFIygwap3b8MT/IpTKyk0I9ljv8QUUbvyyERvOFMlPYyTyX1mywJCwrs/nnz/FiXw4Q
         cI+ZOnzfwsEJyrp1bBxngN6Akk+zktRxB4LGbnoct34I242N5laILZ1fTHiB8yYWPjbk
         Wy/M60LOqbHDPdKwoDnClzLY9zY0ZgVMIAtuKd98or6hWooehWi3BF+LTHUZWNET5+TC
         nIjw==
X-Gm-Message-State: AOAM533F/QaxLX3LSgaXn7QPZ+nZZXaY5OmKsqRT3K+epWlgGNT+SyhW
        UOIslO8zSDDsGWIJcLFFFAub+tG7y+0=
X-Google-Smtp-Source: ABdhPJywI+kpf/WbEulTkI+WWQEh96+s7tqreK3VONJIUmDgWPb5bSFILSkC6rnkhNtKnHdOQAMR0bfb/+4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:9743:b0:6d8:632a:a42d with SMTP id
 o3-20020a170906974300b006d8632aa42dmr34840939ejy.157.1648557662237; Tue, 29
 Mar 2022 05:41:02 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:41 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-13-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 12/48] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

kcov used to be broken prior to Clang 11, but right now that version is
already the minimum required to build with KCSAN, because no prior
compiler has "-tsan-distinguish-volatile=1".

Therefore KCSAN_KCOV_BROKEN is not needed anymore.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ida287421577f37de337139b5b5b9e977e4a6fee2
---
 lib/Kconfig.kcsan | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 63b70b8c55519..de022445fbba5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -10,21 +10,10 @@ config HAVE_KCSAN_COMPILER
 	  For the list of compilers that support KCSAN, please see
 	  <file:Documentation/dev-tools/kcsan.rst>.
 
-config KCSAN_KCOV_BROKEN
-	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
-	depends on CC_IS_CLANG
-	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
-	help
-	  Some versions of clang support either KCSAN and KCOV but not the
-	  combination of the two.
-	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
-	  in newer releases.
-
 menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
 	depends on DEBUG_KERNEL && !KASAN
-	depends on !KCSAN_KCOV_BROKEN
 	select STACKTRACE
 	help
 	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
-- 
2.35.1.1021.g381101b075-goog

