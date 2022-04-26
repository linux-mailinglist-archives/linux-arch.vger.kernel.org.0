Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031FF510424
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353209AbiDZQtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353219AbiDZQsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:48:45 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BBF1C932
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:01 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so3906680edb.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eiEr+2P23HBOM4McbqvmLa2JAqZ5nkaX8a1H8WzeBdc=;
        b=AH6wl3/h3jZOQ/PP2XRz3H+6yTFTXd6FbVvqWs3dSD1VQoD7oZ4P8RfDCTZSOTbJuF
         Dea0WX2BnUSJqwq6L7bGv/kGkAoJpJXcX90MvZJCD8V3DLZNs48DS11HIb7sInlZfzue
         DMGpTwc5BhsC0Yj7lwGhp9whIz5ydF7WZDmw1yJ41rcNpl0D6aJSuZ/x8E6uGXhPjIWY
         MZ1Sk37oKsYl4w4mevm5K1deWm/GnWAIBSURersc8GWz4STFmSMBvkmT8PLUk5DY0bqQ
         4G5CpFQfFmOpU7OaJZK8mUaojJl5Tf4k8xlMFEdi9tJgBabQcMfO6BrSj4NGwPy+nPHk
         6HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eiEr+2P23HBOM4McbqvmLa2JAqZ5nkaX8a1H8WzeBdc=;
        b=MxLVN+FoGZElL+MsNNig+TjCTa8z77491HjKz0dTwlza5NEdQV61lqxkwVWCg8rsi2
         z7jRNmz2Wznqy85kKuQMW+5EGiMysIwJG0ymsj2H4Oj3Uo6jcrfL9q23VRBwAMB1Fnhd
         8thctBsXlmhfgC00G3h3anuT7NIOhRVqDEdBDS1CYzg5LIXcrJysOhHqW7PS+xoELDL1
         HOKLpuupacqCLNT95N76MB/nVhAOx72I0C6yO8BBKK/AyN2Cc9+WRPLpN2vPl4nsqWEW
         wC/0n0QIrTnXxBGYw/bfbW4lMfsvbTP7emxdUoIKSXY1C+Rt6K81ur7gEKKALgCM5OCA
         jCfw==
X-Gm-Message-State: AOAM5307/IS2fk/4hfHMCsFeIoUhOHD/xq56PWpiMHfD9b9c6axxd+fh
        2eUhKb/ZYNhvrZKbedb/7svZHygWDqw=
X-Google-Smtp-Source: ABdhPJxDSlpkDTmdkRbr1nbB7ZI7Yjkrt1D8Ci5Kh7HlHhT8mmXkAZD7Y6I7F3vOvJUv/S/j20xf/QcJdwc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:11cd:b0:425:ee49:58cb with SMTP id
 j13-20020a05640211cd00b00425ee4958cbmr10117861edw.157.1650991499654; Tue, 26
 Apr 2022 09:44:59 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:44 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-16-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 15/46] MAINTAINERS: add entry for KMSAN
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

Add entry for KMSAN maintainers/reviewers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e8c2f6117661..dc73b124971f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10937,6 +10937,18 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

