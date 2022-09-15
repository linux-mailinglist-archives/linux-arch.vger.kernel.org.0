Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD465B9E57
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIOPJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIOPHh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:07:37 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C097EF3
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:48 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so13151382edc.13
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PRETZsLeKtd8er/vGZIvwJ67UbRQnpYPS7VnNd6iitc=;
        b=IWkX75T/Q/431JKoP2sw1gGv+TRTk4KNLPsHPqPmF3DWGGkurKMl+8ONAEiBTDmheE
         /bRfKFH3UY7lflgk+tGWw2/6W93k+canHKGQEEM6HO9CEQKXMkCUdWv2f4MdMGWOzrIJ
         G1jDnp7yxG83XTB77HooBd8pj1DXFnHlOsQNax7eY08XATzldTmtPTs26zPGXzgiy0Mz
         qNMjVTPKt1EwXBmVdFMqJwU0Hi3WzmYliSNKgIFTflzD9qXlcsCQbN9DI90LX0j/d90o
         XtOjNQuQkTbxe0CH70hTFyO24aVCsu/CiMUIXLlZA1dstaOwJf3am2bgGgOOrjIMUJcm
         Q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PRETZsLeKtd8er/vGZIvwJ67UbRQnpYPS7VnNd6iitc=;
        b=G2J4yJKptS5lkPGSRfj7jIwd4u7IZYMVIiQl/rqDhjRr9tHr3QMiZpy4TBsVVMVDEE
         JVV+k+gxaOTPn5TbTju9afd4C7srQEt2chNTbcdcwXWpWQ5QcumxeC2vmfhAnvBYjISG
         W9FwGi5G7hMA5N50EZ5y63vGXeQ0ZYL8/9YrjJfL56S0lMMrOaiivvrqQmbSUmREFsXl
         HDemNsiN0QbNaT40hFhhr8rMBLDHhJLpKaz9Dtws+0Uc7iMVhCOgESmpVJQUT0tK531u
         Mdggt/6Daq1dIcASea//+7n3SRMJtxzUOxBkIJWrnUG0TYlqUP/NYzWLC1ugg0nYrPys
         3LJQ==
X-Gm-Message-State: ACrzQf3wzHCj9Dco4yhaaWBQW4I2xcIIBjPcPOROtyL++bPP2KSu5pLj
        D1QbKI4xhg80OzG5j3jX2NUdhwAYhDc=
X-Google-Smtp-Source: AMsMyM6VUn1IGxuterUYBQnBqfqJp+t0ecAEWvO8gXW0QL3/We8FwA+dhbmbRRZVNw5aXpi14wf65X3+jsg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a17:906:cc59:b0:779:f094:af3d with SMTP id
 mm25-20020a170906cc5900b00779f094af3dmr278250ejb.239.1663254346675; Thu, 15
 Sep 2022 08:05:46 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:03:59 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-26-glider@google.com>
Subject: [PATCH v7 25/43] kmsan: disable strscpy() optimization under KMSAN
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
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
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

Disable the efficient 8-byte reading under KMSAN to avoid false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Iffd8336965e88fce915db2e6a9d6524422975f69
---
 lib/string.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index 6f334420f6871..3371d26a0e390 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -197,6 +197,14 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 		max = 0;
 #endif
 
+	/*
+	 * read_word_at_a_time() below may read uninitialized bytes after the
+	 * trailing zero and use them in comparisons. Disable this optimization
+	 * under KMSAN to prevent false positive reports.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN))
+		max = 0;
+
 	while (max >= sizeof(unsigned long)) {
 		unsigned long c, data;
 
-- 
2.37.2.789.g6183377224-goog

