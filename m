Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8C5B3280
	for <lists+linux-arch@lfdr.de>; Fri,  9 Sep 2022 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIII65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Sep 2022 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIII6Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2022 04:58:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081B1365D7
        for <linux-arch@vger.kernel.org>; Fri,  9 Sep 2022 01:57:46 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3457bc84d53so11980877b3.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Sep 2022 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BA7v9By/PKm8Lb5EGh75hqx3B2NthlRyqEiydr+9MIw=;
        b=goGwbFEzBCu6ZReNVsQFXEaSFbARIBvytLuNW4v5IzfqaOxEddum2eMnFGd4n1giOm
         12yr+tkvZlEG8nCUA88s5hp100Jh85VNfSeMZi+Aq6wwHb9IOv/FFX1jCussxyGiaJ5U
         Nxmc1qPjqj8jpEfcvVPhcAgsqpQiA8h9e32psMV1REa/fw4xpH7NmtwCwq0Y3Dt9YILC
         176tLQDsChJoJCd8+GYPQmm5OjJtrlmbnNDXKD8AX6dyKzZgJPWyMxrYwLc7vOjaOYBI
         O9WJIH6/NkpPX9UbGKPOwAa8jlb13aKJ3GYGRyRTRCnNMOKLHvbAfbfKvl8FcfN+moBm
         H51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BA7v9By/PKm8Lb5EGh75hqx3B2NthlRyqEiydr+9MIw=;
        b=dDR0/UZxTUDr/yV5xIXj+8MeuV9hThi0+Y9rLLpUecSWuPnw8F/cDJxoNTws/bOr0e
         V6gdJcw5XqlLGOIt6yETUMdy/GMgz/CIkCaOuNKWY2eAtCgMn2yDL1ONnshE1h2m1FGC
         0JqlOpqH6hEpquOq3T8iZaP9Qy3bPeNlUFPrZXb5USyGErQq8NeOlsfoB059703fLnfW
         KOrIXxprLIWk/tm5Tx0GmHF0EWL1pYMp3u/sd1GKKHhniJ7JXhbOVnw1uF+7JwmUWTQK
         Kq4mvcaidpJOrD/oOzLxB9gRrnIqo6IMqQ8xAbAAG+FliV+xpKYh0eQdU1rhxtfqYIHE
         GUww==
X-Gm-Message-State: ACgBeo1asy6KvhKE35Lup5/O96hvfMIFWdUhUuxhZwY+cA9RcK5cUCsi
        Zw3fYafgXP4uW13gxLulxRoprunZ8lnfe1dBLo7Uzw==
X-Google-Smtp-Source: AA6agR6yLRVeEL7qXOrcf6i7wNdKQSe6OY+YRtuC5CLYDGWplZp6/6tDwb3XUHj4CjP4Gwj8mLOWHJSGHRh50UlvyRs=
X-Received: by 2002:a0d:c7c3:0:b0:31e:9622:c4f6 with SMTP id
 j186-20020a0dc7c3000000b0031e9622c4f6mr10866606ywd.144.1662713865771; Fri, 09
 Sep 2022 01:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com> <20220905122452.2258262-41-glider@google.com>
In-Reply-To: <20220905122452.2258262-41-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 9 Sep 2022 10:57:09 +0200
Message-ID: <CAG_fn=Wz1b5nKTACGa_oPBuxXcn4Hb7hDT-3Fcx5P3ODY+ivpA@mail.gmail.com>
Subject: Re: [PATCH v6 40/44] x86: kmsan: don't instrument stack walking functions
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 5, 2022 at 2:26 PM Alexander Potapenko <glider@google.com> wrote:
>
> Upon function exit, KMSAN marks local variables as uninitialized.
> Further function calls may result in the compiler creating the stack
> frame where these local variables resided. This results in frame
> pointers being marked as uninitialized data, which is normally correct,
> because they are not stack-allocated.
>
> However stack unwinding functions are supposed to read and dereference
> the frame pointers, in which case KMSAN might be reporting uses of
> uninitialized values.
>
> To work around that, we mark update_stack_state(), unwind_next_frame()
> and show_trace_log_lvl() with __no_kmsan_checks, preventing all KMSAN
> reports inside those functions and making them return initialized
> values.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Hi Andrew, Stephen,

I've noticed this particular patch is missing in -mm (and, as a
result, in linux-next), which results in tons of false positives at
boot time.
Could you please add it as well?
