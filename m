Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE24747A8
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhLNQWf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhLNQW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:29 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC4C06173E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:28 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso4896707wrw.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=16fifb7fJzYqUAIiYSNBFHwRb1cbOSZox8dTCQyam0A=;
        b=FYoyQuklP2kR/YlG5VwN0TkoQqWmp2nR4oXvp2JqUrE3xG1lS0l6ESiSBW7nqYN4Lh
         hCEaEHi5xKaCvQ3l+uXlIighB9wYaF+K90XykbBeii6vP3VeU7xol/8hbMgw2agx8E0h
         YR3PvWGRaMrv63N+yw0UQ/mh2+UFeqZzCyTuPIBCNoBZRGL5UBnDci/f3GAeh7c6jwFF
         /Z2s5WvhBSufD+VRiWkfEtXPAntkmqf9R/r5u9AqMI9WKRfMGFScQtZMTgIISrPLfWFD
         2n9AKqYILeSb1EsYLyOBOV/4doaFkcoWd7POKw5aiv076jLR9bhgNJlmUv5qhO2YZrEO
         TFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=16fifb7fJzYqUAIiYSNBFHwRb1cbOSZox8dTCQyam0A=;
        b=hEVVTi2vBeMN7N57uhxPhrQmZ1yQB/7LRH7pYxoZZlnbhY/I5yvYgZzfOLZrKZi4Uj
         yQGkmeazS3nW4oPDQRHg7MQ2hunbnTM9H+Lrq7ZBfxza3tRAd4/84ODm0yRZ4w24jb7c
         LFM3/qVNFlghC4Zoe5rmjsPHmMVTcaq7kyGElVqho038cVf5ipOoP5z4D9kBWd7ant0u
         b7ntyf8jbpAU4kvohXqOc4rO94M3lm5uDYElfNW05DHOVNlGuIhdnoq4soOnembOZMAb
         8JUYPvgBFKJYswgSPgBruH3DnYUwpyboLYGhSESBufCJGB+w0K/Y1pkZAq3yOa25uB9E
         HR5Q==
X-Gm-Message-State: AOAM53301dc/uzHgvyiJippkaFxJoRH0ukSETFCY6WnZu5IsY9u54k2s
        Qq6wYb0lQw4gPq4LM58WUUixi8SVyXY=
X-Google-Smtp-Source: ABdhPJwGJ87yZ0c0920vo+MGB3z979iOfpbYK0oGnlTVO8FYOEYPR7anYWpNFEcFdlEd0o9ummCDC9H5Y1g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1c8d:: with SMTP id
 k13mr2668278wms.0.1639498945977; Tue, 14 Dec 2021 08:22:25 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:19 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-13-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kcov used to be broken prior to Clang 11, but right now that version is
already the minimum required to build with KCSAN, that is why we don't
need KCSAN_KCOV_BROKEN anymore.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ida287421577f37de337139b5b5b9e977e4a6fee2
---
 lib/Kconfig.kcsan | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index e0a93ffdef30e..b81454b2a0d09 100644
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
2.34.1.173.g76aa8bc2d0-goog

