Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160154747A6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhLNQWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhLNQWZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:25 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2DC061748
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:25 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso17456919eds.12
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eUjwzrCoKbUh6R4rs1WIx34anW4MjQQumSQfrOhNX/M=;
        b=A+mk+fmu1YbqofexadpLTYy3cf/NtdeJeyWT6xHGBf9oiljC4Sn+IROP4d2ppCx8c+
         KFpuvuJ6otYQZ4VP0KeILi504/gfqUhG9yg8vqhWullvaKggE7IHyx+rAZWaicoeV+oc
         L33wkJWvTbKwNbw/qiUrh6n4BMMGbz0sW1vJlDBy2QRt1+wG4/+RQoRIXAGtBN1m49x5
         vdnHPrDaGi86YfsJ8RISvJcoAFwbSMZ0jM2I1xxcraggn+SuSJ6K29uQIzzUy2pnTCrz
         5yNiGmVqiImv547jU5KnPombPq8Oh4FN8J64WuratTrkPgZkCl22mUeIeOymjZYY88/J
         S5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eUjwzrCoKbUh6R4rs1WIx34anW4MjQQumSQfrOhNX/M=;
        b=3nvTrVfYSba1GJCI/61PA36ofiPXEuCE1v05ENuLrVIFtNNtd1DQS30f5xTqAjiC61
         93S4cf+bcIWO0aIT2mbqIIDejYGVrHKqk3fFvEyCjU2XqE1WOFers0OfNgOLNsGxGhmz
         CyA9KB+kl3kC8Pvppy4RduBASrrCmH6nbDQiLX+T6sYzY8WPyP91KXWmgR8wB4nQM2Ja
         /2H6/rQfk4+8eeLD0bQFQAnvGbjcUOvt/MbBMcfO0Rv+cPeZrRDMFkbSkt6vpRCzqy4H
         dpqbeY0xMvt+H+q6TBgLjmmArfu+H2Roz019bbkpjwuyjdjllEgYXTgFVpGHc+gBgfEI
         LJqQ==
X-Gm-Message-State: AOAM533WWlNUnPXiGxwCKdr0MCJTcE1kEmshcsPOgUGTacOSRxmH9Dxn
        16FPeTUraNkKvsyO3lj1aiDh4tJ07ME=
X-Google-Smtp-Source: ABdhPJzLaORHTQ4qmDAWFyBr9kup6IJB7Qe+p4FZHaadADZeiQuoAqGrx6VJ6ldvWuPpnMogRhonYMzcup0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a17:907:7e8e:: with SMTP id
 qb14mr6877453ejc.562.1639498943380; Tue, 14 Dec 2021 08:22:23 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:18 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-12-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 11/43] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
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

KMSAN adds extra metadata fields to struct page, so it does not fit into
64 bytes anymore.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342aa1b63e616fc614f1
---
 drivers/nvdimm/nd.h       | 2 +-
 drivers/nvdimm/pfn_devs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 6f8ce114032d0..b50aecd1dd423 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -663,7 +663,7 @@ void devm_namespace_disable(struct device *dev,
 		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 /* max struct page size independent of kernel config */
-#define MAX_STRUCT_PAGE_SIZE 64
+#define MAX_STRUCT_PAGE_SIZE 128
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 58eda16f5c534..07a539195cc8b 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -785,7 +785,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 64. We
+		 * Also make sure size of struct page is less than 128. We
 		 * want to make sure we use large enough size here so that
 		 * we don't have a dynamic reserve space depending on
 		 * struct page size. But we also want to make sure we notice
-- 
2.34.1.173.g76aa8bc2d0-goog

