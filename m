Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB815A2AAE
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiHZPKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHZPJK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:09:10 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D1DC5E3
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:37 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sd6-20020a1709076e0600b0073315809fb5so720117ejc.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=TLtEZ0bDABRCjn67uEnKqh55BiGh6mAGtPfpqU3Dom0=;
        b=XhlU5hNd0e3S9HPBMmJkefc8yx08LwmA0SrbD/8z4iCrhfOsJcZduc1PlOL9efVBc+
         RqztXd6/u4p+K40pJYJ4MKo6W7YSwm2TGNfQJRg+spj7KYsPClZuKVg0K7kt5K6whqKk
         q+NjffiftBk+4Wc6g4Tz0BBUvyrlit9JdAIemyH8qENuefh4JnuhzYQuq/s4MXy2lHoL
         NjoHCmqDqQlUi8tcUV7ZMIQKkT1OxE2DmCvSQcE4JHvpg4oQKQDno1JEzzGIKstmVxfI
         M0cRhGmxUmpadUGkfzrVjEWgWPnBig+aEKw2Ua3xaSSd45CO/SHC+zQxCgI2IVeAmV7R
         JiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TLtEZ0bDABRCjn67uEnKqh55BiGh6mAGtPfpqU3Dom0=;
        b=zEtahhasgcUK2wefvj3kvfR4s5a8kou09TXNFJ9lus870wQv2dgkt6S6XDEEPjcM/S
         OSld9ncBz2hbrE+GI/MiWgA4dtDQsCWO5KYP/8yo6ROECLOUiyQRFtofjXbsYP0663np
         +nxkVzXiemHRZzg3IG0cU9I0kgdeM8L/rHX9kWOfDIRgDBOoLbAifHhb7HXsTZZK4nD0
         8BZLdyptNf9gxDQiPJoY+u0qYKR4yN6X4Skmsb9bfERWCoxInDGV4G58nFCzpESm8cV0
         2XiktyEhswfdgOXynrhWPQ1bgBpXvPpPISCT+YALsLSkWWKRPonjkthDdYeHYSiAUKHW
         h7MQ==
X-Gm-Message-State: ACgBeo2TwhcVJC6Le2HMf1/LbMtxVuFZ0oP2VCc4YXTODqsDaZXeWS2n
        I/6zdNOHUQgqHpXoXf0/BGUKjFvsg9I=
X-Google-Smtp-Source: AA6agR6QdK8Prck1Efax3JC3LSwW7ZoPOT0nuqvyH6CShWmZZX9DGTqKWmC6+Ghh+6F66GZY1zvqUreveU8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a17:906:9752:b0:738:364a:4ac with SMTP id
 o18-20020a170906975200b00738364a04acmr5783646ejy.759.1661526515449; Fri, 26
 Aug 2022 08:08:35 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:31 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-9-glider@google.com>
Subject: [PATCH v5 08/44] kmsan: mark noinstr as __no_sanitize_memory
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

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>

---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a3..015207a6e2bf5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -229,7 +229,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.37.2.672.g94769d06f0-goog

