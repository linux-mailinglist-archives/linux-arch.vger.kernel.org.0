Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15CA4F17B4
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiDDO7J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiDDO7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 10:59:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F11C10E
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 07:57:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w134so10249648ybe.10
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2022 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQXip11/mOq1QEIb7Uh7PfUGeTnBxSjdGMNgDU3H0ac=;
        b=sFPpy6/1ERVilOjkhoNtdU6pzyexFt9dvn8SKKMJfIG2Qtk3XLX6kW46rCfdemme06
         QLVikzfPklS+9789YRedbVZNG9vCKmAXYBqTm+oxmSoXtl7AEU9lAaUa5jWqs9UYE9sM
         yFECOLoBML1fKtj4hqurE1FBRLG7nsR1mpmLYtb5ijpgb6frVlG1HTH0L96Epwz/Kyz7
         /DjT9HpXAGnx+MUwOrA9zFVUEGhhPS2zohqq/7QJJDqEBtdzjIkyXPAaZ4+FGbv9CfFv
         fBMcu+KM0UNHhn7zzrqdnQFSR6CG0Sk216wg118fddoib1KIuZl5NG+K4xOVbSVAQT4D
         CY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQXip11/mOq1QEIb7Uh7PfUGeTnBxSjdGMNgDU3H0ac=;
        b=nhEKwU/rZJ35WSzqCHyrN9Z6xsr28Q129OyLBuX7PMVysNLLNEZaNe+toJClS+eAp/
         ZfAnw+SFW1hLV0uB+o5MUGgSfC0cb5emsMAhKQOutV3851Kr3UreyzlrC025AA7az6tZ
         ZortWMHQbxvhbQrtzQLYqwgPybeTzlSSX4VN6H1YnXKvNGa5J6dYmB3414OyD3kJCQIA
         qECaWz2U+JBeMwBeD85oaNVwaIFTbdvpPzC2TglcnB8v7dxOUuGtrDOW7f5ZD7Wl3c0f
         8ES/KftYWdKTNUy6Pb2hWWTtsvJRMsQBu+LMS4AaMBv/qlolqQ1nzkJylRX3zNqiIwvX
         n2iQ==
X-Gm-Message-State: AOAM531VLsNknN/GTPOUBEsgLq2FC19e5NzNg8lSO0XAD6HvpFwYce9S
        CBGxjLRftdWfADgnFzfQ7ebuUSeKkHSKYzMUvThj9w==
X-Google-Smtp-Source: ABdhPJzw1DgZAsjP77DWhNJHF9MxDZ8jfkBeWpV+GnWhN3Ppz05CKQlwJDA6qtB0VyPTIdnI6RaZeiSysOLf9uEgkgU=
X-Received: by 2002:a25:d897:0:b0:63d:af73:1115 with SMTP id
 p145-20020a25d897000000b0063daf731115mr185537ybg.274.1649084231809; Mon, 04
 Apr 2022 07:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220329124017.737571-1-glider@google.com> <20220329124017.737571-32-glider@google.com>
In-Reply-To: <20220329124017.737571-32-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Apr 2022 16:56:35 +0200
Message-ID: <CAG_fn=Xt6a0MS4EM33KbMDwqUem4_xnSfNFR6P7MHNgaC2wpPg@mail.gmail.com>
Subject: Re: [PATCH v2 31/48] kernel: kmsan: don't instrument stacktrace.c
To:     Alexander Potapenko <glider@google.com>
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
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 29, 2022 at 2:41 PM Alexander Potapenko <glider@google.com> wrote:
>
> When unwinding stack traces, the kernel may pick uninitialized data from
> the stack. To avoid false reports on that data, we do not instrument
> stacktrace.c

This patch is not needed anymore if we unpoison the stack traces
passed to __stack_depot_save() from KMSAN core.
