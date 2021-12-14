Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A54747B7
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhLNQWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhLNQV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:21:57 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C525C06173E
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:21:57 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so11507054wma.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FXfeBchMfCdhuWi7P/c/cIQefpZCnVfOT656QFTkr+0=;
        b=rq4gED9OFGTopBP/h6U7GjMpe16CAVeGeHHMWF1VLMCL/cqIp/qiPpx4glUgvShgk1
         EkSX9gp/VQNQU3SylYvaqYyMvibQHhBg5sdPlaVPzR9GUxJfz4sDC+eO4p8B0yV/EnG5
         Q+LNLpcH58pH4zk/c181fED98u9j5txn3fFQrK5ARbC8kqPipeyptURB3RM/buoMHqua
         FrMvA+lEKucUHpWMNVWnqCh04HOhsUbN3S6yMJKEOl7kBKEyHO5xY3Q8cJtNiUGbu4X9
         A6IQPDzxqIHzfa4rqaT8/nrZwD0lbINSsPAPp21LEr6Mleh7u7KaI/iVQ1abzcblJfJ1
         2CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FXfeBchMfCdhuWi7P/c/cIQefpZCnVfOT656QFTkr+0=;
        b=hMAzpJucmcFek78NI80W05JW0QaPHLBIU/SbAWrRJmkjXX7O7pvYbYmiKrbPR3+P3x
         UJTRk5K9LXbrRfmOWLmnL1aUpLFy+zI+EjQb4sETzVN7PKTcaYDErneeBqphu0n1/+P7
         TtaaFMAjDJKh63cCHo/+pILkgDA3C/33WSTZ4znuHLt4JpMJMsUn5/Y6jqxstrd/bizQ
         uY00YA0nDju7yF86HuS6qZHjHuSYGrJbi6vNGGAYOxkyLHX4xH/imTDawjs66/iC2ZC6
         6G15cg6kMxQs4K9Mw9AACgqvdVAo7eqJjDtCNOE5DeWhrM0OfAbnS9vw5c7BRZpQWcFM
         q+YA==
X-Gm-Message-State: AOAM531O8OXeIlj9VMLr93uuqXH0xLdQR5+riU85HVmRogZfkV1jYUtm
        IOEVQaJlMYb9OkKINYzkoI+I4F6t8Yo=
X-Google-Smtp-Source: ABdhPJy4QNvRmDfM0eG011hD4RxNjSwaKd4qO7sKL/WYj9gWuHMNHmlS9FUP/lJt7VznT2PlfxW/ubfArUA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a1c:4c04:: with SMTP id z4mr8271378wmf.11.1639498915988;
 Tue, 14 Dec 2021 08:21:55 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:08 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-2-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 01/43] arch/x86: add missing include to sparsemem.h
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

From: Dmitry Vyukov <dvyukov@google.com>

Somehow all existing inclusions of sparsemem.h are preceded by inclusion
of <linux/types.h>, but KMSAN contains code that transitively includes
sparsemem.h without that header, resulting in a compilation error:

  sparsemem.h:34:32: error: unknown type name 'phys_addr_t'
  extern int phys_to_target_node(phys_addr_t start);
                                 ^
  sparsemem.h:36:39: error: unknown type name 'u64'
  extern int memory_add_physaddr_to_nid(u64 start);
                                        ^

Because sparsemem.h does actually use phys_addr_t and u64, include
types.h explicitly.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
Link: https://linux-review.googlesource.com/id/Ifae221ce85d870d8f8d17173bd44d5cf9be2950f
---
 arch/x86/include/asm/sparsemem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 6a9ccc1b2be5d..64df897c0ee30 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SPARSEMEM_H
 #define _ASM_X86_SPARSEMEM_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_SPARSEMEM
 /*
  * generic non-linear memory support:
-- 
2.34.1.173.g76aa8bc2d0-goog

