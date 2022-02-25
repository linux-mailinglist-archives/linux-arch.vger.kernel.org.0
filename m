Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A744C40E0
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 10:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiBYJDc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 04:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiBYJDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 04:03:30 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3A98F6E;
        Fri, 25 Feb 2022 01:02:58 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id i27so4830248vsr.10;
        Fri, 25 Feb 2022 01:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2yPQQkyfifzSb4UKUP/UBnBQil6yFEzzS1VsqjkII0=;
        b=7CrXJFRlHRE/QUMhax14jMyBVNdI0Vydx1IslgVMcPGgFUD0Mh++dfYBqTHQGwFwo4
         PZoXJsmWO1yNqLkpeq27aPH0zUJcvPf1HtKBppdskBAPCbfcXlcqGkUEs9gtptvQIZXV
         z3ALSrHz+2aJgVYyrtGOKwQ0ZELtzN6mUDAOA5ZajVAzKt8qTrwwGVqB0hzKB77b43RR
         A5NcD3tQAJD8WZG2mVTxKXAWysTZVNgUp8eeORFPK0d1t0QsvL1lT9oWRxSfJUuTpWU3
         zIDTs5qiJlbQO7lW9K65rxumJ0krp8n4Xz0AYPC9XPTLLH1PZDxRR4OzEjF16jgxNRec
         v39w==
X-Gm-Message-State: AOAM5334RLoPHZvgnzBykQL3I0+RztUZXJyYRC8VrEV9IZkm7oAX9B2O
        m17PFSOZpD6u6hDuJpMXC7S9UD1mWIqEFQ==
X-Google-Smtp-Source: ABdhPJxG5HoVXg1eE1vd/0Mx1PYq9jTqf9BaehELgXLjH5lBh5GvBNt2mAuZ8lt1LPVSQDsBqGxABg==
X-Received: by 2002:a67:ef98:0:b0:31b:fdff:f374 with SMTP id r24-20020a67ef98000000b0031bfdfff374mr3078941vsp.56.1645779777081;
        Fri, 25 Feb 2022 01:02:57 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id q6-20020a1fd906000000b003319bbeabd3sm297348vkg.18.2022.02.25.01.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:02:56 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id e26so4870184vso.3;
        Fri, 25 Feb 2022 01:02:56 -0800 (PST)
X-Received: by 2002:a67:e113:0:b0:30e:303d:d1d6 with SMTP id
 d19-20020a67e113000000b0030e303dd1d6mr2782888vsl.38.1645779776278; Fri, 25
 Feb 2022 01:02:56 -0800 (PST)
MIME-Version: 1.0
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com> <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Feb 2022 10:02:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRO5dph1m21=V3bVyniVvKfhDLbMoEHQzwPgvSesXj6A@mail.gmail.com>
Message-ID: <CAMuHMdXRO5dph1m21=V3bVyniVvKfhDLbMoEHQzwPgvSesXj6A@mail.gmail.com>
Subject: Re: [PATCH V2 08/30] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman, Andrew,

On Mon, Feb 21, 2022 at 12:54 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Feb 21, 2022 at 9:45 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > This defines and exports a platform specific custom vm_get_page_prot() via
> > subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> > macros can be dropped which are no longer needed.
> >
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: linux-m68k@lists.linux-m68k.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Thanks for your patch!
>
> > --- a/arch/m68k/mm/init.c
> > +++ b/arch/m68k/mm/init.c
> > @@ -128,3 +128,107 @@ void __init mem_init(void)
> >         memblock_free_all();
> >         init_pointer_tables();
> >  }
> > +
> > +#ifdef CONFIG_COLDFIRE
> > +/*
> > + * Page protections for initialising protection_map. See mm/mmap.c
> > + * for use. In general, the bit positions are xwr, and P-items are
> > + * private, the S-items are shared.
> > + */
> > +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>
> Wouldn't it make more sense to add this to arch/m68k/mm/mcfmmu.c?

It's not just about sense, but also about correctness.
The CF_PAGE_* definitions below exist only if CONFIG_MMU=y,
thus causing breakage for cfnommu in today's linux-next.
http://kisskb.ellerman.id.au/kisskb/buildresult/14701640/

>
> > +{
> > +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> > +       case VM_NONE:
> > +               return PAGE_NONE;
> > +       case VM_READ:
> > +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> > +                               CF_PAGE_READABLE);

> > +               BUILD_BUG();
> > +       }
> > +}
> > +#endif
> > +EXPORT_SYMBOL(vm_get_page_prot);

Having this outside the #ifdef means we now get ...

> > --- a/arch/m68k/mm/motorola.c
> > +++ b/arch/m68k/mm/motorola.c

> > +}
> > +EXPORT_SYMBOL(vm_get_page_prot);

... two of them in normal m68k builds.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
