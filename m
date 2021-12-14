Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978504747CD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhLNQXo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhLNQXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:23:32 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040FC061761
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:11 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p17-20020adff211000000b0017b902a7701so4853733wro.19
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x5YBqNptwlSdtxXj6Mpbhns9uYlzM7sKdh+OiWmHV8E=;
        b=Eq16fqo7/umIC+mRw+0mkHSO2SVMHikYc1m6jSZV8W6hhVaM9NMvFdQfrWKGA3yg/i
         7vUEVTKL+jqzhdEkXU9xVd75uPZ4Rmx4C1qHm0ZEuH7q6SV7Qvuyq3wzniVYxjvJom4F
         4OBdWZpawHisawFRRG9ZiNgKyC5uZphoOmN+OvbQMyHKkPhl4uA1SbeivqjtkKXkYXvj
         ayyTsXbSYK8GBBsDpjliMHxRjjyXaQDfpdlmy8yxUniRXrvUu+NwM9AzRrogCDV9SX9P
         LlNfxBQ96uMgIvTX+ftvkx34ETbts7JwLHCgfgsywDgA/Qo2UWkAtoDM5JW5QNO9UuHJ
         Hb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x5YBqNptwlSdtxXj6Mpbhns9uYlzM7sKdh+OiWmHV8E=;
        b=jl3rAUnz9hfQ/5egbunW5GjMm5M7SOK85YTa7e9iwnDZ3qAZD35/0YxAJjmXoY/qn0
         +ZNt+fdnDL/Ep0GetW/xG9kyj8oABX1T3OG/sT8DLFut7pbqsYAyb+jnptPoe1NBbkFO
         1k9A1yl8Zb7vEg3wvzY3Nxb7j68sD3zrhPEdh35rQ4aXWjdzW4uUDe2ccVSaewkMObFC
         hl/uBeGw4z62WebfyMFVVW+xw9F16T690PEBkd2F/6/5Fs+0GXXHf5AJwdR1pqt+o38N
         t/DyprBP2LiMtMKKLEospY2H3900OrvzPy+sLTcgPiV3vxwhe1LFI77SNiNQMA9YOFtn
         7ZWg==
X-Gm-Message-State: AOAM532ycl+mtGXdMiq0imDDKir7NMJuVp9uJBsIIhnbbh0GN7K8ITGN
        wXxqpU52Key+fTH0gGwxD3e1oRZQuSA=
X-Google-Smtp-Source: ABdhPJz2ZQuIEn5ZmHrH4VnKPAPp72t+EVJM3lTIPSyuDMPR4kQmFKNO01R60JjhCJQ/Lb82u7miTPMRVUQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:adf:ed52:: with SMTP id u18mr6938942wro.609.1639498989844;
 Tue, 14 Dec 2021 08:23:09 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:35 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-29-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 28/43] kmsan: dma: unpoison DMA mappings
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

KMSAN doesn't know about DMA memory writes performed by devices.
We unpoison such memory when it's mapped to avoid false positive
reports.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ia162dc4c5a92e74d4686c1be32a4dfeffc5c32cd
---
 kernel/dma/mapping.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9478eccd1c8e6..0560080813761 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -156,6 +156,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	kmsan_handle_dma(page, offset, size, dir);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
@@ -194,11 +195,13 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 
-	if (ents > 0)
+	if (ents > 0) {
+		kmsan_handle_dma_sg(sg, nents, dir);
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
-	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
+				ents != -EIO)) {
 		return -EIO;
+	}
 
 	return ents;
 }
-- 
2.34.1.173.g76aa8bc2d0-goog

