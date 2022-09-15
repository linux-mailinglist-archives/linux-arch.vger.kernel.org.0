Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801145B9E6A
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIOPLE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiIOPJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:09:50 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015C9C1EB
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:19 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id d25-20020adf9b99000000b0022adb03aee6so69390wrc.6
        for <linux-arch@vger.kernel.org>; Thu, 15 Sep 2022 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=y4+04AEFcGK6lJisKBf+d7wj7/tgJIfosEPW0CJiM4s=;
        b=TY9zj9hsonLfxsKiJ/Nk2jseei3hK6yzpjZdnJr1tEyHclD4r1lmduXOFaXWThcHMB
         DJaob/V+m/PRO6csCY9Qz7+UxT/duZ0JLxrjFhCX78YuVaTTZumMHyb2TWgLeR3UbElB
         7X4tMiqGIMatHsfHnsy6juWEIz1QNOu/tb14hyG2cs2B6k04dPWvwNIFfjy6W/oOeaN0
         QrnIqe66ITykN//4B+h/MckE3RzTc0/Lsnyh0ahzj+igL5hjBzIYjNA8Ky1MP7CzfGn4
         gexfdk9N6b5itmc9hr0TODSZeATm0DUea9IoCzI93/y47kt1AL6SpSZT+FyLO6lv3DEl
         7UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=y4+04AEFcGK6lJisKBf+d7wj7/tgJIfosEPW0CJiM4s=;
        b=MUIn17Sn5QPgNCtTk87t9WlQOtKX9+RcddgNo9cnGOJ4sf6Sph4eUd5Pb5cU5PiD11
         2fhkmjxqT1W/QATWnwQMVjUjaao0CXlZ2Y6WJtaYaTTp3x5PvRFT8q14gFqp90dKfCWh
         Sq3EkNjlElzd9kanhrMRtL+fdUW8Gr6CRta/mUe5M8nz5HHVqDbhEcclsMHRHofQdu1T
         H75BvOHfDbwU9s0GYrSJw08twZF+tiwEuGfkHYUYYFXFymD4cuQHM3oB4BB9Hg8mklmB
         AwcjvEKhfTP9E2nOr76BKAQhzxUPJIdcYfNidNOIluZfHMuNc6CrvHnjyNUN0sTe2ReJ
         PWvA==
X-Gm-Message-State: ACrzQf1vT0VPd1c+PIPQw3jSSDpwawZpLVrmsOYGZ2rs3znAEY1Sckye
        kkwb1CYRBWIMVhyYAKy5cYe9/rPv5EY=
X-Google-Smtp-Source: AMsMyM7TO7pwHZKC5FCuc6aosYGc8fP10GsQWeB+vHWTvsz1rJA3jVBR26bmI08PTxhgRL6r8YIYohpf0Dw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:a05:6000:68c:b0:22a:bde3:f8cc with SMTP id
 bo12-20020a056000068c00b0022abde3f8ccmr71217wrb.556.1663254376855; Thu, 15
 Sep 2022 08:06:16 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:10 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-37-glider@google.com>
Subject: [PATCH v7 36/43] x86: kmsan: sync metadata pages on page fault
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

KMSAN assumes shadow and origin pages for every allocated page are
accessible. For pages between [VMALLOC_START, VMALLOC_END] those metadata
pages start at KMSAN_VMALLOC_SHADOW_START and
KMSAN_VMALLOC_ORIGIN_START, therefore we must sync a bigger memory
region.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

v2:
 -- addressed reports from kernel test robot <lkp@intel.com>

Link: https://linux-review.googlesource.com/id/Ia5bd541e54f1ecc11b86666c3ec87c62ac0bdfb8
---
 arch/x86/mm/fault.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fa71a5d12e872..d728791be8ace 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -260,7 +260,7 @@ static noinline int vmalloc_fault(unsigned long address)
 }
 NOKPROBE_SYMBOL(vmalloc_fault);
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+static void __arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
@@ -284,6 +284,27 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	__arch_sync_kernel_mappings(start, end);
+#ifdef CONFIG_KMSAN
+	/*
+	 * KMSAN maintains two additional metadata page mappings for the
+	 * [VMALLOC_START, VMALLOC_END) range. These mappings start at
+	 * KMSAN_VMALLOC_SHADOW_START and KMSAN_VMALLOC_ORIGIN_START and
+	 * have to be synced together with the vmalloc memory mapping.
+	 */
+	if (start >= VMALLOC_START && end < VMALLOC_END) {
+		__arch_sync_kernel_mappings(
+			start - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START,
+			end - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START);
+		__arch_sync_kernel_mappings(
+			start - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START,
+			end - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START);
+	}
+#endif
+}
+
 static bool low_pfn(unsigned long pfn)
 {
 	return pfn < max_low_pfn;
-- 
2.37.2.789.g6183377224-goog

