Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B815AD2D9
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiIEMeE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiIEMc0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:32:26 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D85A61727
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:54 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r11-20020a05640251cb00b004484ec7e3a4so5725778edd.8
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=63Lbiss0mCSaP/JatuEwb7Qda7JVHXONR7b7gS/f0zw=;
        b=UDsvJYgtTXPZF5a9agPh2mXyrYJrhXMTAzXPZNghSJw5ee3mNMwXIwpKa+RKY0zuMd
         0oketLAQ8tAqBq9H1OztfYXsFZLC3/GjPvaRGV4Tf5cx5pY09RUcAdfIPub4N1YomTRe
         qN17vYLlykWW3fcYQY5yUk9fGBNhlorODfdAFeJeB/phj1xFUAdvMGDkePvsaAAnNZDZ
         QNcHmgGjaBYlCKkJsPpqD7vIZwk92kcg49ObV7TTQ+SLXpAZ9pO/JJZcCHGzK92euOmB
         wKHTk01woRx7PzSGgjyowKFGJYseYwyRla1r4RWjs1ovT7LskcrPtqUZWACg7jNiOAET
         dJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=63Lbiss0mCSaP/JatuEwb7Qda7JVHXONR7b7gS/f0zw=;
        b=c8tVpJvnOWe44AXlDfOyYnrzcuJv787EvugyfEbMXDVYvHwJ1WYbbMMwpaHrXvYJqX
         6sii3H5t9W1RMbg6nnRsZaOC+vvMVW0bjSjF5NM9qpmJIjlL1ZaEzQ2O4uHJdAx56WgW
         vr3/8FiBWiZ1Lj+ZybxEdjn95n7tjP0xqElfr8RYuv8qowbUeHagbrjKjt/E7DXKvLV6
         FZnM+K2ulNvC779ehJpXLLQuz08LzhSjLYjmuhiD8YvdGmjuFw67Tp7zgLY/KJICkG+k
         r8FNjYLh8EkHIPZevckvvOgaf0teIFDv4UqX5+VGSbe61pQYZQyZD4HaN7QE3meEktsa
         yxXA==
X-Gm-Message-State: ACgBeo2BXfspig/e9Iml3tzGYLgh4wNxeYCNVYnDXKva3Ryu9PZ4xC0s
        wuVULbybbgPq7sFytxERjOwUtDgRbqA=
X-Google-Smtp-Source: AA6agR5LBRpdlR606D8rNDqY5QJ3OBC/wbbIgC3X8Ct4s02WNlqHsbJo9IxNX+CTnN40NsuDZAMm2jER36E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:2c41:b0:741:4906:482b with SMTP id
 hf1-20020a1709072c4100b007414906482bmr28414813ejc.239.1662380813588; Mon, 05
 Sep 2022 05:26:53 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:50 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-43-glider@google.com>
Subject: [PATCH v6 42/44] bpf: kmsan: initialize BPF registers with zeroes
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

When executing BPF programs, certain registers may get passed
uninitialized to helper functions. E.g. when performing a JMP_CALL,
registers BPF_R1-BPF_R5 are always passed to the helper, no matter how
many of them are actually used.

Passing uninitialized values as function parameters is technically
undefined behavior, so we work around it by always initializing the
registers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I8ef9dbe94724cee5ad1e3a162f2b805345bc0586
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3d9eb3ae334ce..21c74fac5131c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2002,7 +2002,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_EXT_REG]; \
+	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
-- 
2.37.2.789.g6183377224-goog

