Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F855AD2FC
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiIEM0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiIEM0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:26:40 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560348EB2
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:25:33 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso5758817eda.17
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=TshE4y0aie2V6V2+uLUqxx2CJ+sNpnEg6whn5GrSFP8=;
        b=KmmCnyB09bJUZHQjwO3kUqnRIzGi9Y6VrKDAE64MFeu4Hil7cpdZ1q8lGli5tvlBil
         Cf5P4IYHvBxUmSdTUn2Gs0hAszt3eHWuDQRa1N/xxYxOEV1PWqlg6iRMSOV+PpAy2o+2
         1lURM4Q8xxd5V55Pvmx9SoQvzLhysQwJIvhnUwhfV8lbB1JRyFpg50YsIYISy2l27np8
         0AeS93YWxdbLmnWpRfAjWXYqBq/UDffiGW4SJHduO9ItYKsRWLYVVh9lruPFOY9Obx9o
         q9QkK6qz/sMihjClMDGyBIEwP/q80o0fvL3OXcdVsGXHZs3uyfuziK6LVf7bejqyI7za
         kefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=TshE4y0aie2V6V2+uLUqxx2CJ+sNpnEg6whn5GrSFP8=;
        b=BwpVQBXKAYFu8UUW3sI4lsZhTDUzuVNCvbVHK8loCrbna5rr5Od98rqeG6p9XfeilT
         iTYu8jKHCN2DBubVmlobFYHh/WeHGKy535ZIydN2YVoVneZVwwgSXiIqFT8Ga2o13eUW
         LSqPhLdnBF/L/keQTKLIL/DzeNy7xbETsSPk4cMDlmE5+H6ivwt4lHCh6sNN9EsRxjtn
         HhyEt7tX+PqJvAmE+ezH0/V/JQjtg9svfROawv/nyCTzjh2L1PhozoDuoH0Uvux2ORXA
         jlREeAONQ/k/tGvitR1r3hEnQr1BAxQWYDLu2WYSOmDy9rejeiBjiNkpxKAhYknphZfV
         ZVqA==
X-Gm-Message-State: ACgBeo1wo+QEJWS8mn3sgB2qoUoYNFPrx46N4s9PWnFEHWWuZQzue4w/
        3GObEuhgoJEulqXIBsRPc9uqNQEkbjA=
X-Google-Smtp-Source: AA6agR4Xve7I8LLlB44NFT0vCYfBwPcSCu1DsccfnrCnOEmeaOisZ/pABs8s7TnNbobeUn78bMXZn8M1y9E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:aa7:d0c7:0:b0:44d:f0ed:75b8 with SMTP id
 u7-20020aa7d0c7000000b0044df0ed75b8mr6971238edo.50.1662380733016; Mon, 05 Sep
 2022 05:25:33 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:21 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-14-glider@google.com>
Subject: [PATCH v6 13/44] MAINTAINERS: add entry for KMSAN
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add entry for KMSAN maintainers/reviewers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---

v5:
 -- add arch/*/include/asm/kmsan.h

Link: https://linux-review.googlesource.com/id/Ic5836c2bceb6b63f71a60d3327d18af3aa3dab77
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd39..9332b99371c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11373,6 +11373,19 @@ F:	kernel/kmod.c
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KMSAN
+M:	Alexander Potapenko <glider@google.com>
+R:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kmsan.rst
+F:	arch/*/include/asm/kmsan.h
+F:	include/linux/kmsan*.h
+F:	lib/Kconfig.kmsan
+F:	mm/kmsan/
+F:	scripts/Makefile.kmsan
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.37.2.789.g6183377224-goog

