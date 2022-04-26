Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2C510450
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353447AbiDZQve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353271AbiDZQvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:51:01 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18030483A5
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:11 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id dn26-20020a05640222fa00b00425e4b8efa9so3783011edb.1
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SGOwGjYq/2PwacKh0/9At0yFevcHrzg9FDlShmi+vnk=;
        b=fSZ4zfvDJJmqaIzU1XL0WfStwXr6OPa8V+ga0qTz0UlsIHyG9I6Fr6ZEbs9vmLiuhO
         ClbMCWmC+tznTOah7YoL3txE0BplWerCcj5Pt/KeycPvVB+sF+pTOE13LG7aV8CaSZd6
         CtB276fuSEgHwCIg/10uWG7rSCD98aAcUKoO+LU4U8ks8bUI5/GdxxpoNac4ZhTkb0E1
         grtFS0KyEl74V0H8NCr4jzX10gmxpamQ+wZyHKObaL9HWxab3p+XWx1x2TN57EUQX6a4
         MV6fXbcDTcGpFO2Dt7YM5K3PDMZSDsLSt5fDbOOZGvHfv6pU1T6bZgqLE57A40M5bQwM
         0uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SGOwGjYq/2PwacKh0/9At0yFevcHrzg9FDlShmi+vnk=;
        b=1AUVFAIQxFy1598NewQMdKs13sPbf7+P6gUwNUX+wHaaorfJ9aE7H5VQh2FtSLs9f4
         QGnj+ciC8UUcwh+u0bAf2k9ifOz8EQDICGGHJjRQBkfwXVSPplpoQ7nRSbIyFqrwJCo1
         AsR5+4rKipculjT0WbJzc+veqmE8QgT7+subzANLsqS0p85yrJHF0Houb5MQ/Pemr2wq
         EyzHYMZSE3nF8zR0P1tdP/Qd9pJv6fMWEWrANQ5seOtdNbB4XwrAIkt8gnFNMSfqNXyb
         RUYWGy7LYowGViJQwgRjo248RW/bAonCwje66FjItowFrZtg/aXNzZBV80TWMBe8puYn
         M/Yw==
X-Gm-Message-State: AOAM532hNpeswDC8JyD72fQ5jKSWc/JG5P82iPiYlTucm1wa2/eW3Dcn
        etk+pDs5FlDc3dP6EOJtZpZ0eUWkWcc=
X-Google-Smtp-Source: ABdhPJw9NptsR6xC76SX+4t0lKzp8AK1gzotC/X9LsmKWQ/MoVeg5tjW3Iafs+1NkdThy9tu1emAPZFww8w=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id
 b10-20020a056402084a00b00423fe998c53mr25385277edz.195.1650991569448; Tue, 26
 Apr 2022 09:46:09 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:11 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-43-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 42/46] x86: kmsan: sync metadata pages on page fault
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
index d0074c6ed31a3..f2250a32a10ca 100644
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
2.36.0.rc2.479.g8af0fa9b8e-goog

