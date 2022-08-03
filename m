Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D59E589216
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiHCSPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiHCSPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 14:15:10 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8044E60F
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 11:15:09 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 21so6932631ybf.4
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y92UH4xk+JPW8aVK6dnuw9Im2HL19mMdvEh4kg2bK0g=;
        b=sRaUcFSt01Ks/YKwz49XSN4/OQvEBUtHn7sYd8Oa0W+RPqKMQsv/ah+4XJrjoNKK3V
         4j2I7Tajo+oVO9Q5WTtI1QuoXeODixWCLa23b1InrLOJyPU02L4/Yr/tENmLzArPe26j
         DK/m40vsysHm36fjz9hf0ijAdwjkgSVHSYPSPrwNgUOUiUdSCi/oAaZBdDTnc3g9xuGq
         839WQoZ4HI7Kmwe7vY647SSHzsYhD5fTboEBRfpWYIj7aavapmuws2kEMYFnX6Lr5mN0
         kUnF3AqZajcHFLMKTBSEskpbdf3rLx6io9gRFy6nwuHCHATyl7jADUHe9UMBgC+VpADx
         mzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y92UH4xk+JPW8aVK6dnuw9Im2HL19mMdvEh4kg2bK0g=;
        b=kX8WZpMzSlX8f9p+iOBqjAdePunayl22xgwWfnwPU5aPZNT4jaBLMnjoFNwDgLyc7L
         DJXKFJuRGRHZwhoUh0sZu6zCxUpCpQJAFVvuSA9E1/Vai5JkBZmGltUZ67S7z1STqKUs
         8B6aWgSPFWjRdBbtKt2kVbywv/P3uMktcvcc1jYqTKKVrYcp5W3gB0NB5BeOuz09F5l6
         o6WZ1M2zZGOujrkXdpwBalRDdLWnqyIfEZMOvW5qoPeXcwc8EjkVs1UXI5wYNuiMmXqH
         o7SzBLi0ENNF0PtuFNSTi2LqhVbyWry3EwJ6gkKZfxsTupxrNr8f4xFy8MJX8fIVlVND
         DL4Q==
X-Gm-Message-State: ACgBeo3yvripGoh1o8G7yqttpWa3AXSqLO/lCgj+MB1ivdz1uiXOfV/X
        mc9gShlCSZCAUh9GHlKt1oL0qpC5kfi4ax/c7iAVNA==
X-Google-Smtp-Source: AA6agR7w1Awhe+owXzXOZf/Iib4idl+Q2nTlhXV4EvXq+vsWRav1PlQBwpamgAi8i+PhP+JOsEl+kLahLKT5WDsOYvk=
X-Received: by 2002:a5b:982:0:b0:63e:7d7e:e2f2 with SMTP id
 c2-20020a5b0982000000b0063e7d7ee2f2mr20837859ybq.549.1659550508989; Wed, 03
 Aug 2022 11:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-12-glider@google.com>
 <CANpmjNMrEdNdsz6rxkrpiJNREB+GSkx4B=LwPLWYmwVhdjVA4g@mail.gmail.com>
In-Reply-To: <CANpmjNMrEdNdsz6rxkrpiJNREB+GSkx4B=LwPLWYmwVhdjVA4g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 20:14:31 +0200
Message-ID: <CAG_fn=UZ9MLLu9zos2Daba+DB__HidgYRT-27CxB2PwV_t=KnQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/45] kmsan: add KMSAN runtime core
To:     Marco Elver <elver@google.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"
> > +struct page;
>
> Either I'm not looking hard enough, but I can't see where this is used
> in this file.

You are right, this declaration should belong to "init: kmsan: call
KMSAN initialization routines". I'll move it accordingly.
