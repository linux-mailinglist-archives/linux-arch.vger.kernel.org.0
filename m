Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA864747B3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhLNQWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbhLNQWp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:45 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B77C061748
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:44 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so11493368wmb.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e8wDcDLgqLYcyyBsUvkh60ghxris53AouQaXxm5r3VY=;
        b=bwbWTEarveUVX+itJ0fuWYEkY+Ic1ruhFCrxUeHNnxH5C8YooQA7cUsnyl8QWo37I6
         qTSM1De/qqc5mhyJtWkyChUpcc1nvO5H+mOj9FiHjcds3GvwduBveBltJ+MOJP/LyV7c
         K/DQVpI3lfpjDdqbPpWHBynUKrxIhmcfVj1tonRgeT8hXBQQWaaChDGRY91NmnLmrBd8
         qK7LRFOohNDU/Dbk3RB2WOgoN4+ftz4obf+oEFc+u9s1lPaqCHjHqdN5zv3+L7i8La57
         4WiPTF5fv5H95tgHlFg9ybWEeaQttWWACxX/wPbwtcvTtH5Nq8FL5fccCq06rND3IElh
         TzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e8wDcDLgqLYcyyBsUvkh60ghxris53AouQaXxm5r3VY=;
        b=09brc7LEHyiHyr3cEdStV0QVydDfIXPv/gtaaTu2tDq3cukHHqQs2zFOl9Uj3n4wLs
         4NMt0xPHVqZrtew8v7R4jqT9W8TE3DG3lKyeV1KibscN/arW5jMiNDkqpEA9HJmkgcZw
         H4DuMW3OJpnbSUQ9kD7febhLJ2RNl1dewxUMk5FSp8+1sTJ2Osxez2rd2RUOa7KNzAwe
         OqmRL6QZJQSZaX1MZabZWSxDxV7TAvsdeJP2roj7WTqT29Qt8EdI0ajraIrt9gOE4jDb
         Fe7xjKa6uPDsBzLgaUwgbxS/uqqXEz7zKEnbSkGaxlYMX/4VBhbXWNrQ55kMVZalGq8q
         BH9w==
X-Gm-Message-State: AOAM532rzGXPK+aArCLETpfxWmhWgC9WfmOWfh9Zf0U2JLG8D3CZEGPu
        59czuREOWcjVx2utwio9zpAkhd73AFk=
X-Google-Smtp-Source: ABdhPJzoy7nwddl4O5eQjXMqW0hLllhbb9+Sf9gHpEsPLwPy4hBpBZLzkiU1SPitQ3yLHKKXprNAepEWH4s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:4646:: with SMTP id j6mr1679288wrs.485.1639498962614;
 Tue, 14 Dec 2021 08:22:42 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:25 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-19-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 18/43] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
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

This is a hack to reduce stackdepot pressure.

struct mmu_gather contains 7 1-bit fields packed into a 32-bit unsigned
int value. The remaining 25 bits remain uninitialized and are never used,
but KMSAN updates the origin for them in zap_pXX_range() in mm/memory.c,
thus creating very long origin chains. This is technically correct, but
consumes too much memory.

Unpoisoning the whole structure will prevent creating such chains.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I76abee411b8323acfdbc29bc3a60dca8cff2de77
---
 mm/mmu_gather.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9c..72e4c4ca01d27 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,6 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/pagemap.h>
@@ -252,6 +253,15 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
+	/*
+	 * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
+	 * unsigned int value. The remaining 25 bits remain uninitialized
+	 * and are never used, but KMSAN updates the origin for them in
+	 * zap_pXX_range() in mm/memory.c, thus creating very long origin
+	 * chains. This is technically correct, but consumes too much memory.
+	 * Unpoisoning the whole structure will prevent creating such chains.
+	 */
+	kmsan_unpoison_memory(tlb, sizeof(*tlb));
 	tlb->mm = mm;
 	tlb->fullmm = fullmm;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

