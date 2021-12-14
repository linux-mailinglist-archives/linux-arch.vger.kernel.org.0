Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6824747DF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhLNQYX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbhLNQXq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:46 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5228BC061751
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:33 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so17384560edq.16
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AQV6gal7xcYqVzVr1Fdti0Xi6wxVWlKKmnc0dLEZLM8=;
        b=b3jhMZ+gtnb0jZdcbymOiOH3N4uF7ztLrqbNz30Lv2gY/fV9Ysm768H49DQ8/xsqDs
         3IWlVkODvwaD+EJvZuTNbktU0WaOOSZHUsqp8QqkiwCjohzFOu6txRL7zkE4px1LcdIk
         vxd5HuCl389N3V8vVv47QaEENGeKSAVUqrG28FVdb0SAZssc5+xj0XeyIIN9bKbyM+on
         Am44ePDuKhmUb7BWyplo6vc0OeMhMfMyxIOC81WBZkpDw1pLZir5v7e7d0vLqnwzMew6
         hA5cisSZnjkJnZUIjDxzZR8BgPbTDD1a4PpQeqFA5R4A95BYLgdHW8cBeaznDvAgDZQB
         ASxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AQV6gal7xcYqVzVr1Fdti0Xi6wxVWlKKmnc0dLEZLM8=;
        b=yp7+DE0M9Bbs6pw+MzSp5Fv7sr9grhAPEB+m7s5Il8IDq4jt+QVlvrFtoRB9XkvHES
         l3edrS8gKXv4eFZQvZZpyUNBtMgLGlrFDCG13aWBqcaX2GwKmKFEOHEQs142YukHA9Lf
         o66QFgbx1wzPdsW9MeaIFucNisZlshPIejUe/ayZVl3U86hJl8c6s9IEBvipnQQ8eMBI
         Cub1y4ZiGlzKBMyJug7Tx1p+/s/SjksUXT2+OAH4nvynfidbzVZ8dEg53gh2lq7XoLBE
         Mxtk17zuA8r9EIVDayuXPoIEMlgVcybUiKl2tO0VdSyTZ2LT5DFm7FnVjqIBNZNlZ24H
         nIoQ==
X-Gm-Message-State: AOAM532miDP6rEGOT/tSAu8xRJOg4RCH5+mFG/128ZOLSjmUoIzvXSPx
        1Opd4PacdVK1MsG50IgnYvYt1c97Aso=
X-Google-Smtp-Source: ABdhPJwLPasgbm+76JeLxEcgZP9XNbaJpFUP/XX1HfS3uh/8mkJSzHomfuQTgR60DvU3f9qWQoPIPwmcbts=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:906:cd17:: with SMTP id
 oz23mr866387ejb.415.1639499011704; Tue, 14 Dec 2021 08:23:31 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:43 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-37-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 36/43] x86: kmsan: sync metadata pages on page fault
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

KMSAN assumes shadow and origin pages for every allocated page are
accessible. For pages between [VMALLOC_START, VMALLOC_END] those metadata
pages start at KMSAN_VMALLOC_SHADOW_START and
KMSAN_VMALLOC_ORIGIN_START, therefore we must sync a bigger memory
region.

Signed-off-by: Alexander Potapenko <glider@google.com>

---

Link: https://linux-review.googlesource.com/id/Ia5bd541e54f1ecc11b86666c3ec87c62ac0bdfb8
---
 arch/x86/mm/fault.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4bfed53e210ec..abed0aedf00d2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -260,7 +260,7 @@ static noinline int vmalloc_fault(unsigned long address)
 }
 NOKPROBE_SYMBOL(vmalloc_fault);
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+void __arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
@@ -284,6 +284,26 @@ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 	}
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	__arch_sync_kernel_mappings(start, end);
+	/*
+	 * KMSAN maintains two additional metadata page mappings for the
+	 * [VMALLOC_START, VMALLOC_END) range. These mappings start at
+	 * KMSAN_VMALLOC_SHADOW_START and KMSAN_VMALLOC_ORIGIN_START and
+	 * have to be synced together with the vmalloc memory mapping.
+	 */
+	if (IS_ENABLED(CONFIG_KMSAN) &&
+	    start >= VMALLOC_START && end < VMALLOC_END) {
+		__arch_sync_kernel_mappings(
+			start - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START,
+			end - VMALLOC_START + KMSAN_VMALLOC_SHADOW_START);
+		__arch_sync_kernel_mappings(
+			start - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START,
+			end - VMALLOC_START + KMSAN_VMALLOC_ORIGIN_START);
+	}
+}
+
 static bool low_pfn(unsigned long pfn)
 {
 	return pfn < max_low_pfn;
-- 
2.34.1.173.g76aa8bc2d0-goog

