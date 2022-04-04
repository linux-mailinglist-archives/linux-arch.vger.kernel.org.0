Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2184F1765
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354324AbiDDOpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379350AbiDDOok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 10:44:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BD44A3D
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 07:40:09 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z33so13499387ybh.5
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2022 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pz3pYCujkv281hkCmxtkOvOxylf8pz3W8bcVxSFrQPo=;
        b=rp/qQxgcvWDdpmgA7fnhdYdZmKKGoA5Rh0NrghNK6QHGJaNrHNYoL1GD0Lo1sS0BUA
         Nby0xgsdoq1R6HeNh2u1Wkukpnqh5Ntkf5q76zL3bFMxJlmTeFTJnNsnhZRKvy55qwnZ
         slBewtIQuNbDNpCxmj1Fdp5nbCcMAsJsPryda6tMxoCyTky12lj33/ip4ciiZUz3koC/
         szf7VWLN8gWAJvRw9nJCWeTApXNEDA5qLIldc38tppkwV5o9VxDq6OSye/JUfjA+DBO8
         6/xeIsUOwgR8bNW/D7SxqiCFntXvCDnf4E8IDKNocpBYt9rOmdfd/xKobqm1+B6tbRe1
         GBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pz3pYCujkv281hkCmxtkOvOxylf8pz3W8bcVxSFrQPo=;
        b=jb0Z1lebfeJSi8mYTg3FW5KLdWkyaAj+KQJw7JScAlXZBC13C2vjIMI0cfhox2Cfcs
         s9uSRKD4jIQr9kYBNQDye0VjKVVezyJyeTCcBNsUGk/ACSmNn+9XJE/SLQZhBwH4MSL0
         gtwIxlM1jiC7X29Q3gG7KF0sh2gepSyi6K2yUBE2AJL7W3HHHFQT8NhLkEhklLU1b6BQ
         Uz6jaQCZdhgFetA23ZnDvKdyVGffgQVNhgRFuE3bKSc05c4iAZPoAcMW4mFWtEQ5ooXQ
         ylPq5V+CzQJQnnhJgclwQ0oumbwSoatDe2qwVDrwQh8TLfXWdBykU0//B+bNE6eBMCfo
         aiAg==
X-Gm-Message-State: AOAM530qgKremlkFh41MZCIGY60eYuVmwH4iEEoCJiwOa1/0NrF7RFDD
        0Bkc/H72+gk2mZZnaKtHso+clhZoftvMbmhudAAnDg==
X-Google-Smtp-Source: ABdhPJzn3nqxMsBH+7CEIPeIkwewLgc0IoSM83IwhtPQ5GBOQVPSfRg5TvY6utuFCSGhkNhPJBRtsnAq/8hPKoD3/xA=
X-Received: by 2002:a25:3750:0:b0:634:6b89:ca9f with SMTP id
 e77-20020a253750000000b006346b89ca9fmr78127yba.363.1649083208503; Mon, 04 Apr
 2022 07:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220329124017.737571-1-glider@google.com> <20220329124017.737571-14-glider@google.com>
In-Reply-To: <20220329124017.737571-14-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 4 Apr 2022 16:39:31 +0200
Message-ID: <CAG_fn=XvC7UPaBbcDM4-Rc_4RdWSceQK5jV9n6q7DtTeZbd0zw@mail.gmail.com>
Subject: Re: [PATCH v2 13/48] kmsan: add KMSAN runtime core
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

> +depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
> +                                                unsigned int extra)
> +{
> +       unsigned long entries[KMSAN_STACK_DEPTH];
> +       unsigned int nr_entries;
> +
> +       nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
> +       nr_entries = filter_irq_stacks(entries, nr_entries);

This is redundant, __stack_depot_save() below already calls filter_irq_stacks().

> +
> +       if (depth >= MAX_CHAIN_DEPTH) {
> +               static atomic_long_t kmsan_skipped_origins;
> +               long skipped = atomic_long_inc_return(&kmsan_skipped_origins);
> +
> +               if (skipped % NUM_SKIPPED_TO_WARN == 0) {
> +                       pr_warn("not chained %ld origins\n", skipped);
> +                       dump_stack();
> +                       kmsan_print_origin(id);
> +               }
> +               return id;
> +       }
> +       depth++;
> +       extra_bits = kmsan_extra_bits(depth, uaf);
> +
> +       entries[0] = KMSAN_CHAIN_MAGIC_ORIGIN;
> +       entries[1] = kmsan_save_stack_with_flags(GFP_ATOMIC, 0);
> +       entries[2] = id;
> +       return __stack_depot_save(entries, ARRAY_SIZE(entries), extra_bits,
> +                                 GFP_ATOMIC, true);

@entries is initialized in non-instrumented code, so passing it to
filter_irq_stacks() etc. will result in false positives, unless we
explicitly unpoison it.
(right now KMSAN does not instrument kernel/stacktrace.c, but it
probably should)
