Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB651040F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbiDZQs1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353127AbiDZQrx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:53 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA61906BA
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:45 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id v11-20020a2e9f4b000000b0024f195a39a0so1006239ljk.1
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ednioRVQi+463GyxSxojLtYXRmMb4k6reZrR8s7PDTk=;
        b=s7nDKeE2uO8tPBSHXhKtgeVd4KJBULrFKzji5KxbrLSqAsd9qwd5XqsiW4sxXc2Zuj
         /LDHzi6oYDxLjayBmNbbHHd8x60Z1q11m24TiSwhP8RYbreiv3W6YuCWDnMHnOA40Zg6
         2XAh/SQC3o2WwNcd888BCR1ayDkPme9nLNf+yFJmAhhH+5m2makPEnGrUgDcpKDvSpAx
         uZ/EMSRFu7oZ7g4w8LFxCUmwK7SAeXqsUvws74aRat1Udaq+/e8oYjQBcJ/MQ0phtMYp
         ItWJ4UPus1+bGv6Mz6YHzcXh/jQw/SqfpbBVzObyfR2JQ5g2erl9ttRuMQ0dfEHG3Yf8
         GoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ednioRVQi+463GyxSxojLtYXRmMb4k6reZrR8s7PDTk=;
        b=igq1giKFoPOyervgD0Sgn0HV6G2XR5o5IbRq0xH8N/qE4KkT8i1kgDGFikhwgpU800
         ukfFFkhBCZBIdIn3+umwywF6RaBjQr7HTlm9TLGmsG2KV/xYnEeLS7g4JLnGQpnxEZP4
         mxKr7xomsp/oVI8IGo7OVip2vqiFoyAbhdQ+sgn2nZugwdEgRTiMCbvU101E50kkvIxZ
         din6DDViVIo+EKDy4ZaHxxKeENgJBpb70yQ8S+U5lxgnHYkRCLWRZHWGwIViLh7CRRYd
         Yli8giD1Ie7VIBuXasrgGPewgvUxt57kRCytIbPG08L1yBDCpbl9efFG9MUNbOSqOoxI
         oSCw==
X-Gm-Message-State: AOAM532b0PGD+h5UKTJgJTvLhJaC1YjzJnMkflmZeY3DMkkDfOQzcK3i
        Wp5ObB3DqCyQyyX6VGfHwAQ34KunnXc=
X-Google-Smtp-Source: ABdhPJxHrJcKOCcTiJCxWbbHxqyDNc8yKbgnQVG+zhnL2F1NE0oryK8Ze862y3s98aS3FdAQ1AuU/NMiTCE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6512:114f:b0:471:b097:4a29 with SMTP id
 m15-20020a056512114f00b00471b0974a29mr17572189lfg.93.1650991483323; Tue, 26
 Apr 2022 09:44:43 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:38 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-10-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 09/46] kmsan: mark noinstr as __no_sanitize_memory
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37d..a9ba5edd8208b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -227,7 +227,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

