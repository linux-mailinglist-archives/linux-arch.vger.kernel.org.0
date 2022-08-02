Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940758810B
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiHBR3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiHBR3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 13:29:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0A4AD4E
        for <linux-arch@vger.kernel.org>; Tue,  2 Aug 2022 10:29:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o15so24528689yba.10
        for <linux-arch@vger.kernel.org>; Tue, 02 Aug 2022 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MvRBkFzdQaYaXfpQTRaszNRJA99lxIjSlE2BIJqxf/w=;
        b=QRi9qghYw00C8ncMgz03GPp5X4XZwYBjLhTst+txxvrrxIKQSUmvN0iydfY7XxTRPZ
         FljvcSTp2ADimYd7Symv/nntq6KpZiWp6d//C2GypYu/OlpHeLOtYJAAvDcymW7JC3z0
         vFmHS4EctNa1FeEfaDLNxOsvpogUFSLuXoQkFy1gkjcrY42Fcsk3slvwkX0sSHWa2PA+
         tx4YnR0p+wucGibEbwhrHFYXYZI38NDi3qKYYQnitOrDk170nf3Jt8K81Ues6I017fas
         rtIy9n7wsldT5qtbZc3Up54mQyY1/O/xbkmoCTmJ7Qwc73uY29KBeFOWyQvihRzUNGNx
         LxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MvRBkFzdQaYaXfpQTRaszNRJA99lxIjSlE2BIJqxf/w=;
        b=ajCfnHJ20fL7lM369iB3MKAEqtmjDCJXewDZjebI1c6ObYl9VlYpelV03q95Ara5d1
         6Jca/FGQlEAFgxi6LnEvoUPAWd/3q1bOqZBUAumUJXhzkijxHzv3GflgmKZaHaQ25ysW
         H+kdweNdbfy6Bgb6yi3qqt0bGUP8g2SIfelio1bibxE8RVGiUhnwsQIgo0wvnhFSxZ5e
         nG+2uYZb7X/si92gHdiqpWHlEqcYgScGK7vSQE1TFP5KZQhqMLH93H8pA6RbyhEPIrn0
         P3FRrrqrX7DhCNVn+dmJ+lxHZomQ3TC2Tni4ULbwQSAggETZEgag687tBuiX37JykYec
         fP7w==
X-Gm-Message-State: ACgBeo1E6oubACgn6WB8e4ScRJ3HaM0NuWSTEYn8zTjVrs4XXHth5PVQ
        y4fW7MdBoq1UTyRnIdSVeYWegnlrEHXdxFRkAgZnqg==
X-Google-Smtp-Source: AA6agR7VtR+Gv6MIRMZVXbACWuJKrFK4u921sU30CJ51jY/b/Dg4+iYwU/syVU8A9VvADNQ3PrTrNZmZWMU0fOSHqlA=
X-Received: by 2002:a25:bc3:0:b0:673:bc78:c095 with SMTP id
 186-20020a250bc3000000b00673bc78c095mr15729538ybl.376.1659461379014; Tue, 02
 Aug 2022 10:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-26-glider@google.com>
 <CANpmjNPeW=pQ_rU5ACTpBX8W4TH4vdcDn=hqPhHGtYU96iHF0A@mail.gmail.com>
In-Reply-To: <CANpmjNPeW=pQ_rU5ACTpBX8W4TH4vdcDn=hqPhHGtYU96iHF0A@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Aug 2022 19:29:02 +0200
Message-ID: <CAG_fn=V343yojjvuU6zxHKm+SgFJ2jAb7G_aKEwaqLqtqSeiYQ@mail.gmail.com>
Subject: Re: [PATCH v4 25/45] kmsan: add tests for KMSAN
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

On Tue, Jul 12, 2022 at 4:17 PM Marco Elver <elver@google.com> wrote:
>

> > +static void test_params(struct kunit *test)
> > +{
> > +#ifdef CONFIG_KMSAN_CHECK_PARAM_RETVAL
>
> if (IS_ENABLED(...))
>
Not sure this is valid C, given that EXPECTATION_UNINIT_VALUE_FN
introduces a variable declaration.

> > +       if (vbuf)
> > +               vunmap(vbuf);
> > +       for (i = 0; i < npages; i++)
>
> add { }
>
Done.


> if (IS_ENABLED(CONFIG_KMSAN_CHECK_PARAM_RETVAL))
>
Same as above.

> > +static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
> > +{
> > +       if (!strcmp(tp->name, "console"))
> > +               tracepoint_probe_unregister(tp, probe_console, NULL);
> > +}
> > +
> > +/*
> > + * We only want to do tracepoints setup and teardown once, therefore we have to
> > + * customize the init and exit functions and cannot rely on kunit_test_suite().
> > + */
>
> This is no longer true. See a recent version of
> mm/kfence/kfence_test.c which uses the new suite_init/exit.

Done.

> > +late_initcall_sync(kmsan_test_init);
> > +module_exit(kmsan_test_exit);
> > +
> > +MODULE_LICENSE("GPL v2");
>
> A recent version of checkpatch should complain about this, wanting
> only "GPL" instead of "GPL v2".
>
Fixed.
