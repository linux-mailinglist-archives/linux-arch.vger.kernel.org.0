Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD84EAD95
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiC2Mts (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiC2MsF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:48:05 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949325CB97
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:19 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso10943085edt.20
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eekKcS683P9sWiTSuhgkvdPXp9EdJwN5ZjFsPJMzm7E=;
        b=nThiYlFFBsJrC6J4CsRmdsKff+pDAxmWAIIBI48Vo80VmKhgV7dastoHrc6SVW9X6d
         jx/eMpAi1+TKGKqks/kz1GydwiVFtB3s4/Iqslz0Sb0I1p4yER6QQnh5/UL9bNG2RLeo
         C5XtiIVh5zpbhTTlL5airTyDdq93mQxCRjBtLqk2mbuMHgpMJxTKy/8BxllO8FXvoXri
         ekBImg/blQGPTzvxUnzHyySXJs6MIGJ9C3qLF6RA9zgxjyAbLcaI48UrWAydgcCoo14J
         kueGk3ukqrtHmHCvYLUUERRZzvhgDhUfNxGvcRCiVUwTYx9WsgjVrySPvU/5ycGH8wZP
         hUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eekKcS683P9sWiTSuhgkvdPXp9EdJwN5ZjFsPJMzm7E=;
        b=44mGJphwglphwRYSWB09LQWbZ0urY7+n35PmcPzLdnTcTpSXG68eB605SFL46FfNpC
         cSqphKkv7nPRh+9JTD3z1cEAm0Yf4LWwxH7M8JS6thoAbpoYgwAwUroiVfwNYg0Nb9u9
         S/kVgJd59OyfsB59xJ3sYuwL2umjvQ7HX+ybhuMx55WX2QA3mNlrGM9RuG4qlaA7jdIw
         arvvLwjBzqY1MoDMnNgcCKG733N0CSyKLJFWEFeyg9BcvISnaCDlnR94dgs4WLulByxq
         ZaP2rwUuBqHQWvCSm7NMrPhzNdjZbCqvPBWzwrQA1s5WSgmzTiroiw0hKxmNGsj0XqtF
         h24g==
X-Gm-Message-State: AOAM533ubC5qfKLk+sfHRf8bbPdr2Haq7vwXidQ1BaNNgCrifWPAOF5f
        ytZpT8She4HVjElewlKiAHfh3zQi9Dk=
X-Google-Smtp-Source: ABdhPJzQ+mzPatwMfV3rPhv+G2Q81dnqKFY/srjOhBDb0t1yefVaA5tyYkGIYP5vkw1Slryk14/AH+9Tlek=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a50:c010:0:b0:418:d53c:24ec with SMTP id
 r16-20020a50c010000000b00418d53c24ecmr4358428edb.17.1648557738276; Tue, 29
 Mar 2022 05:42:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:10 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-42-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 41/48] x86: kmsan: skip shadow checks in __switch_to()
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

When instrumenting functions, KMSAN obtains the per-task state (mostly
pointers to metadata for function arguments and return values) once per
function at its beginning, using the `current` pointer.

Every time the instrumented function calls another function, this state
(`struct kmsan_context_state`) is updated with shadow/origin data of the
passed and returned values.

When `current` changes in the low-level arch code, instrumented code can
not notice that, and will still refer to the old state, possibly corrupting
it or using stale data. This may result in false positive reports.

To deal with that, we need to apply __no_kmsan_checks to the functions
performing context switching - this will result in skipping all KMSAN
shadow checks and marking newly created values as initialized,
preventing all false positive reports in those functions. False negatives
are still possible, but we expect them to be rare and impersistent.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- This patch was previously called "kmsan: skip shadow checks in files
    doing context switches". Per Mark Rutland's suggestion, we now only
    skip checks in low-level arch-specific code, as context switches in
    common code should be invisible to KMSAN. We also apply the checks
    to precisely the functions performing the context switch instead of
    the whole file.

Link: https://linux-review.googlesource.com/id/I45e3ed9c5f66ee79b0409d1673d66ae419029bcb
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402edec236c4..838b1e9808d6f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -553,6 +553,7 @@ void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
  * Kprobes not supported here. Set the probe on schedule instead.
  * Function graph tracer not supported too.
  */
+__no_kmsan_checks
 __visible __notrace_funcgraph struct task_struct *
 __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
-- 
2.35.1.1021.g381101b075-goog

