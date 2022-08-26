Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AEE5A2ADD
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbiHZPQF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiHZPOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:14:39 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC275CD9
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:02 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso722482ejc.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=03rMp3Lo5JUXz6YDRuTXWFQl7G4ZPrO7G1beymmSRqE=;
        b=sAVtSR5T+WmzYcO0y/rL5vqCNNkvHaCr2ijspx7pp0tTQssYQZLgmJ9706bnECI/Pi
         YvE0hXaOB/bpoPUuj28jQP33PpftgYXVTG+qpwIi3L5mxwe+6kaftp5iFooMAa5EApv+
         4Xho0ql82BCrzE6U0OTZGJ/taBfHGO1y8osby63H8xs97a7h4A461xjeIy2Zy7keH0xZ
         +t+I84JRMBYSgKA0pc92tEXu95OISOZBUXZ056nBZFYe+Q+0daqg0RU0hYyWf00i7zRH
         6jRE7es/OUAGkP/ew2ox8ehfjiFp5faSOGaeaVZskTV8TnVAMbg5VUMNyZ3ZbwBFqN1c
         qKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=03rMp3Lo5JUXz6YDRuTXWFQl7G4ZPrO7G1beymmSRqE=;
        b=WbRnTg1KJdJGaiqNGdssfafmUmMH4NuDF4qXMEs94HWhzR5MFYyv+3RTPzseXAZ7av
         7km0aijCOKwLTmzXf0ShB6wNG7aphCoarCKDGVAiEkadr8erq+AMcX86fdJAUauZxZP+
         OGD9ZwZ5+dnnHVS9B7QXtE4kiGM0ygy4H8GCdTe2QGg/oQWkqv+Ps96l1q2Gr/RNpKfO
         7+qc982gF/LrEOwtXkTwMzMdJKc+KoM2cfMB70uF6Sx0JKR9xes478kAf9EbQtrviM5k
         AlddZtH1TfgETqhVjmmSwJBKVz3vikzIunUtW/e+OM87GZbMysJZoq8jFSgEvQftKBSH
         NNXg==
X-Gm-Message-State: ACgBeo0gTsPcLIUAYa0GlPiaygF8Z8OjpsQfyZy5o6Mjk4CfrDj/lpdR
        OHjXBWekv6Ww/JM7/pQkVnjvZRSxjuU=
X-Google-Smtp-Source: AA6agR5sfXXazfCHPhI3z6MZ77T83FgZy9TTJ1m+QzHsaIqLLsWY/SYhrcqQDvh5VnxcE117PZ//mWwCuBo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:26c6:b0:446:b4aa:5d00 with SMTP id
 x6-20020a05640226c600b00446b4aa5d00mr7346330edd.63.1661526597110; Fri, 26 Aug
 2022 08:09:57 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:00 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-38-glider@google.com>
Subject: [PATCH v5 37/44] x86: kmsan: sync metadata pages on page fault
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
2.37.2.672.g94769d06f0-goog

