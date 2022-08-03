Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA5588AA3
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 12:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiHCKdL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbiHCKb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 06:31:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1185732D9A
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 03:30:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 204so26503636yba.1
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BnCISkt/rTW8As5S0Z1/CmUKmWtp6KufxVc54xAHFLs=;
        b=bTMMrVHLEXsaZsPJ4ir9RlmOn/kRdosyeadx3rkmGXU4lflYbV46JM5DZksUMtzIVN
         U/XEZSrcnqjbOBxVyOOXZVWlx0hp9Fu5nKxWv12BNG1XktevXZFB3m/Y6U7AR+1tVcE2
         moSCPz5d5L9dbdRbJMQnG2/CX8KHw3/wr6ghKVtubKYXwknqG+9T92FwxaKne2npOKfO
         fDB0cU62aoS1208GpKYOLg5LwYk5buP/sgF+RjfJpmGKtXJeAinS5Jzr3wLXQdoHpwkg
         lGa+9i5+l/igcHME3dLynxA3WXk5TN5TBIaxPE4oeCTUDNBsXUUsFu1mf5QJV6HhkRE8
         9BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BnCISkt/rTW8As5S0Z1/CmUKmWtp6KufxVc54xAHFLs=;
        b=p7czOAIBoEqaD1069aV0cdd40f0NARkmKLiBcVtwHlgkCgmn6t7EEkYS83bfhvHjSU
         2eN0l7gzfYQEDhIk0b3IZ5nrEuHP3eLh2Y6eBAU8/jilOlEafoIPvK0htAGFSg93ZJ6Y
         u/sY3pkUtMDzj47yjT5aaz0suTALgBHWFexsgJri32vIWkC7kIQ4PqV74EsFm/8GN07W
         w6RMQL/qNMgf3icuHYfKfeCKbJk4qJlOFX31vilGEXm7Caa0NKL224v+55kdIZpuHQ9p
         h658GVWt0fCgO7LfvXfe6m1mB26+rxs20Xx28dZVvfQhEMU54+9Hij8XeNxbMIbWSK5i
         gL7Q==
X-Gm-Message-State: ACgBeo385A5pLEXebpqqAN9CP0GYv7uA/ZnA+dQI6gFg0WHVvJALcxWq
        O8+7tOTGWmdGIGktcjxwuM6FrHy/nj1H2YTBTYblfw==
X-Google-Smtp-Source: AA6agR7fdKTqJ79i3lBMbE47XG4iizoPXTEVMh+XjGTeEPP0Bf+PZ8XOj+9lhkdsDhh+hXPLRsJykxdjz32sjCymNEA=
X-Received: by 2002:a05:6902:1348:b0:671:78a4:471f with SMTP id
 g8-20020a056902134800b0067178a4471fmr19280596ybu.242.1659522658125; Wed, 03
 Aug 2022 03:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-15-glider@google.com>
 <CANpmjNP8kmZYRsdpHCni33W-Yjgy-ajCAuTE94zwUniyYt7WQw@mail.gmail.com>
In-Reply-To: <CANpmjNP8kmZYRsdpHCni33W-Yjgy-ajCAuTE94zwUniyYt7WQw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 12:30:21 +0200
Message-ID: <CAG_fn=X8zV2j9aPviz23UH8tsbRTqefGoZOCRgJeVtcivdhKVA@mail.gmail.com>
Subject: Re: [PATCH v4 14/45] mm: kmsan: maintain KMSAN metadata for page operations
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 12, 2022 at 2:21 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrot=
e:
> >
> > Insert KMSAN hooks that make the necessary bookkeeping changes:
> >  - poison page shadow and origins in alloc_pages()/free_page();
> >  - clear page shadow and origins in clear_page(), copy_user_highpage();
> >  - copy page metadata in copy_highpage(), wp_page_copy();
> >  - handle vmap()/vunmap()/iounmap();
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> > v2:
> >  -- move page metadata hooks implementation here
> >  -- remove call to kmsan_memblock_free_pages()
> >
> > v3:
> >  -- use PAGE_SHIFT in kmsan_ioremap_page_range()
> >
> > v4:
> >  -- change sizeof(type) to sizeof(*ptr)
> >  -- replace occurrences of |var| with @var
> >  -- swap mm: and kmsan: in the subject
> >  -- drop __no_sanitize_memory from clear_page()
> >
> > Link: https://linux-review.googlesource.com/id/I6d4f53a0e7eab46fa29f034=
8f3095d9f2e326850
> > ---
> >  arch/x86/include/asm/page_64.h |  12 ++++
> >  arch/x86/mm/ioremap.c          |   3 +
> >  include/linux/highmem.h        |   3 +
> >  include/linux/kmsan.h          | 123 +++++++++++++++++++++++++++++++++
> >  mm/internal.h                  |   6 ++
> >  mm/kmsan/hooks.c               |  87 +++++++++++++++++++++++
> >  mm/kmsan/shadow.c              | 114 ++++++++++++++++++++++++++++++
> >  mm/memory.c                    |   2 +
> >  mm/page_alloc.c                |  11 +++
> >  mm/vmalloc.c                   |  20 +++++-
> >  10 files changed, 379 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page=
_64.h
> > index baa70451b8df5..227dd33eb4efb 100644
> > --- a/arch/x86/include/asm/page_64.h
> > +++ b/arch/x86/include/asm/page_64.h
> > @@ -45,14 +45,26 @@ void clear_page_orig(void *page);
> >  void clear_page_rep(void *page);
> >  void clear_page_erms(void *page);
> >
> > +/* This is an assembly header, avoid including too much of kmsan.h */
>
> All of this code is under an "#ifndef __ASSEMBLY__" guard, does it matter=
?
Actually, the comment is a bit outdated. kmsan-checks.h doesn't
introduce any unnecessary declarations and can be used here.

> > +#ifdef CONFIG_KMSAN
> > +void kmsan_unpoison_memory(const void *addr, size_t size);
> > +#endif
> >  static inline void clear_page(void *page)
> >  {
> > +#ifdef CONFIG_KMSAN
> > +       /* alternative_call_2() changes @page. */
> > +       void *page_copy =3D page;
> > +#endif
> >         alternative_call_2(clear_page_orig,
> >                            clear_page_rep, X86_FEATURE_REP_GOOD,
> >                            clear_page_erms, X86_FEATURE_ERMS,
> >                            "=3DD" (page),
> >                            "0" (page)
> >                            : "cc", "memory", "rax", "rcx");
> > +#ifdef CONFIG_KMSAN
> > +       /* Clear KMSAN shadow for the pages that have it. */
> > +       kmsan_unpoison_memory(page_copy, PAGE_SIZE);
>
> What happens if this is called before the alternative-call? Could this
> (in the interest of simplicity) be moved above it? And if you used the
> kmsan-checks.h header, it also doesn't need any "ifdef CONFIG_KMSAN"
> anymore.

Good idea, that'll work.

> > +#endif
> >  }



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
