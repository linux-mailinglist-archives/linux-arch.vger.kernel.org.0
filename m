Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9E663BF7
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 09:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjAJI43 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 03:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjAJIz7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 03:55:59 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D435B17D
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:53:11 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 203so11083651yby.10
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19QYjJTilGk/RhxRe6+HhMCtJmIsJ5ED63/iAKX6oJs=;
        b=lbCmyLed2VvMiWlAcFE73mcQDp5etVdnVHUJB0fOIywFthZ8lU7tD2PGNO2HC3zSAc
         dWKpNjNnenpRB/dYUu/Bi9UKnr53swijKGeB+DGMJw/CtYP9CyD/TXtTQ84qKtpOqa1B
         we5SLgjXbaeHfSmWsG3ddc7582JJaXXNPM0ZVcUZvBZvkBf1GjtFGD4jByY9MTuwdTZQ
         LqlMAkCjgFRNQ11MujIamnA4f5V112faxZSPfRUJ3D5SWQ8SxH5+y7WVLOCty9zTEV4H
         9x6AtFdn5fE2ZaudYTtWp4NSrDa4id6ZpWxndwXOdsPPP03SkrZFtgTmG+ErjTOg9i05
         S0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19QYjJTilGk/RhxRe6+HhMCtJmIsJ5ED63/iAKX6oJs=;
        b=GQ4GwmSoMM7CikL1SDqhBPwIUumPN6JMXBkM5IOBvP6guLYtxe9cTEOkMivU5R309O
         X2TguOhD9fOyaSO3O7UCSjriBF7O4yQuApMUhHPomZ2JmefMoOhMELquPLKZmU9TbadQ
         3xFm2w5zR+CQAoKBBeG9fEK0FR78zzMACG8bran3YPHrkRMC0lsfMDsM8MTPgJMhl+4b
         OZKKWCkpEfNmoWkG728nMJLK8KF3uEsOHjo/wRAWWEyP8OWIUmV8s5e3m3GJdPo86FRf
         dp96b7xF2e6E6t/6XFprWYruNPilW8/yaDyHBA5LVQNgTSmKn0aqKtAQYw8Od4VbFi/E
         i0Gw==
X-Gm-Message-State: AFqh2kqMPMcjGcJgvIHYIJTHtp6TbMMVnMdHlW4hYbJ3f5PR5m2XXwtg
        3JDVFls8IoTrq3nXp2wd93Wa8iAQG9wuw9pR6c9F+A==
X-Google-Smtp-Source: AMrXdXu1bywcmD2nBhn/vstGOcfd/CgtS7Mz2N+xJM/cbJTPId17VbthxQeFl64wwFgwjQNUfbOac2B/yqrJaq2AdY4=
X-Received: by 2002:a5b:b47:0:b0:6fe:1625:f1f5 with SMTP id
 b7-20020a5b0b47000000b006fe1625f1f5mr6647952ybr.549.1673340786873; Tue, 10
 Jan 2023 00:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
 <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7z99mf1M5edxV4A@kroah.com> <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=X9jBwAvz9gph-02WcLhv3MQkBpvkZAsZRMwEYyT8zVeQ@mail.gmail.com>
In-Reply-To: <CAG_fn=X9jBwAvz9gph-02WcLhv3MQkBpvkZAsZRMwEYyT8zVeQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Jan 2023 09:52:30 +0100
Message-ID: <CAG_fn=W4mX1WN0_24wpeNWynEUkApO2QzwavKqer3F3wttOndg@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

> > >
> > > >
> > > > -- >8 --
> > > > >From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 2001
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Date: Thu, 5 Jan 2023 13:27:34 -0800
> > > > Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
> > > >
> > > > Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> > > >
> > > > ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> > > > potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
> > > > doubles the amount of capacity stolen from user addressable capacity for
> > > > everyone, regardless of whether they are using the debug option. Revert
> > > > that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> > > > allow for debug scenarios to proceed with creating debug sized page maps
> > > > with a new 'libnvdimm.page_struct_override' module parameter.
> > > >
> > > > Note that this only applies to cases where the page map is permanent,
> > > > i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
> > > > create-namespace" terms). For the "--map=mem" case, since the allocation
> > > > is ephemeral for the lifespan of the namespace, there are no explicit
> > > > restriction. However, the implicit restriction, of having enough
> > > > available "System RAM" to store the page map for the typically large
> > > > pmem, still applies.
> > > >
> > > > Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Alexander Potapenko <glider@google.com>
> > > > Cc: Marco Elver <elver@google.com>
> > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > ---
> > > >  drivers/nvdimm/nd.h       |  2 +-
> > > >  drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++-------------
> > > >  2 files changed, 31 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > > > index 85ca5b4da3cf..ec5219680092 100644
> > > > --- a/drivers/nvdimm/nd.h
> > > > +++ b/drivers/nvdimm/nd.h
> > > > @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
> > > >             struct nd_namespace_common *ndns);
> > > >  #if IS_ENABLED(CONFIG_ND_CLAIM)
> > > >  /* max struct page size independent of kernel config */
> > > > -#define MAX_STRUCT_PAGE_SIZE 128
> > > > +#define MAX_STRUCT_PAGE_SIZE 64
> > > >  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
> > > >  #else
> > > >  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> > > > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > > > index 61af072ac98f..978d63559c0e 100644
> > > > --- a/drivers/nvdimm/pfn_devs.c
> > > > +++ b/drivers/nvdimm/pfn_devs.c
> > > > @@ -13,6 +13,11 @@
> > > >  #include "pfn.h"
> > > >  #include "nd.h"
> > > >
> > > > +static bool page_struct_override;
> > > > +module_param(page_struct_override, bool, 0644);
> > > > +MODULE_PARM_DESC(page_struct_override,
> > > > +            "Force namespace creation in the presence of mm-debug.");
> > >
> > > I can't figure out from this description what this is for so perhaps it
> > > should be either removed and made dynamic (if you know you want to debug
> > > the mm core, why not turn it on then?) or made more obvious what is
> > > happening?
> >
> > I'll kill it and update the KMSAN Documentation that KMSAN has
> > interactions with the NVDIMM subsystem that may cause some namespaces to
> > fail to enable. That Documentation needs to be a part of this patch
> > regardless as that would be the default behavior of this module
> > parameter.
> >
> > Unfortunately, it can not be dynamically enabled because the size of
> > 'struct page' is unfortunately recorded in the metadata of the device.
> > Recall this is for supporting platform configurations where the capacity
> > of the persistent memory exceeds or consumes too much of System RAM.
> > Consider 4TB of PMEM consumes 64GB of space just for 'struct page'. So,
> > NVDIMM subsystem has a mode to store that page array in a reservation on
> > the PMEM device itself.
>
> Sorry, I might be missing something, but why cannot we have
>
> #ifdef CONFIG_KMSAN
> #define MAX_STRUCT_PAGE_SIZE 128
By the way, KMSAN only adds 16 bytes to struct page - would it help to
reduce MAX_STRUCT_PAGE_SIZE to 80 bytes?
> #else
> #define MAX_STRUCT_PAGE_SIZE 64
> #endif
>
