Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ABD663BF9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbjAJI5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbjAJI5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 03:57:19 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BC61457
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:54:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c82so3850060ybf.6
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C0wBQv8YQpv5VyQcb9pxfBorQ6HWujhHG8utDOoc3g=;
        b=k/TJCMVazo2Ao0kE+x2EGjqiAUdh/vQUU+S59SKjenc4ATfvF/01aNwmb5zF4zsVhV
         Mw+h/alUHbLpzpKhyLxepQhBFesKrScRexoaNvh2n1xAQ3effegffupppIVZS+P9ux68
         F+vBcEAZy6Eg3SkD2nFxnBEYh2BYCGU+l4ob4+TIOfWS00QlElIBoIlzUnSRf4wIMj1W
         j+2ZN3u9vavPyZb7RbeWQrze1LvP6rHtjf5doqLgP8LwLMxW2qRiyFujMMnoxaZya+oM
         v8j1pIRfD5Yd7wqV/8UxhNlkfjh9jhKihqOVEtAzCZ9gnyOtiYDApzmiEug126+e0VH8
         ZodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C0wBQv8YQpv5VyQcb9pxfBorQ6HWujhHG8utDOoc3g=;
        b=qsPIw5udBhrjCnkB3TuBhOcni7+Y00gh6ytmcjFW/7h4CroGz7g2yUnuYRODUoIhS6
         QytXcN1RFRZOzopx3C2qbJLDC2SIHIH/fJDKZmeUjrFWXeMYjEz+/VmT05fTBc7I8WbJ
         Td8pEZdzs/vdiQ56vJHTVWzOxkq78tO7Ox0DhQt5YKS2NE+onNFWgvylL5XyEmzyG6Hj
         78ZKQlsufSX0/t5OZkaJ11fOudGnvkRrOD5jlzSYnWYb6wtuzEqhX7chSY7RD8n7+bvV
         spgzx9RfziNZJg5cJ4PUAYsTkMvcBjiLW+VqazQes+wP3BLj/0L99O8yuvO/LOnIcOZm
         y6NQ==
X-Gm-Message-State: AFqh2kqdDqWNf2+hljw7lseOL7AjAyHlrmWemqvmcA5jwzQWTY85R/Wa
        SfB9iJql0/+rvbXfu/nKk1hVXfop9n9uGoQj6Hnl1A==
X-Google-Smtp-Source: AMrXdXtKhtXOE2xgEXY/ov80TE4K3T+jDV2nf2aqdglGgFRha0dNuDyTVEgpeiWyu4k6qMeiqlaR3nuIpnPNWEL87RE=
X-Received: by 2002:a25:3f06:0:b0:769:e5aa:4ac9 with SMTP id
 m6-20020a253f06000000b00769e5aa4ac9mr6208999yba.598.1673340839748; Tue, 10
 Jan 2023 00:53:59 -0800 (PST)
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
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 10 Jan 2023 09:53:48 +0100
Message-ID: <CANn89iJRXSb-xK_VxkHqm8NLGhfH1Q_HW_p=ygAH7QocyVh+DQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Alexander Potapenko <glider@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Jan 10, 2023 at 9:49 AM Alexander Potapenko <glider@google.com> wro=
te:
>
> On Tue, Jan 10, 2023 at 7:55 AM Dan Williams <dan.j.williams@intel.com> w=
rote:
> >
> > Greg Kroah-Hartman wrote:
> > > On Mon, Jan 09, 2023 at 02:06:36PM -0800, Dan Williams wrote:
> > > > Alexander Potapenko wrote:
> > > > > On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@inte=
l.com> wrote:
> > > > > >
> > > > > > Alexander Potapenko wrote:
> > > > > > > (+ Dan Williams)
> > > > > > > (resending with patch context included)
> > > > > > >
> > > > > > > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com=
> wrote:
> > > > > > > >
> > > > > > > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@go=
ogle.com> wrote:
> > > > > > > > >
> > > > > > > > > KMSAN adds extra metadata fields to struct page, so it do=
es not fit into
> > > > > > > > > 64 bytes anymore.
> > > > > > > >
> > > > > > > > Does this somehow cause extra space being used in all kerne=
l configs?
> > > > > > > > If not, it would be good to note this in the commit message=
.
> > > > > > > >
> > > > > > > I actually couldn't verify this on QEMU, because the driver n=
ever got loaded.
> > > > > > > Looks like this increases the amount of memory used by the nv=
dimm
> > > > > > > driver in all kernel configs that enable it (including those =
that
> > > > > > > don't use KMSAN), but I am not sure how much is that.
> > > > > > >
> > > > > > > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can =
be?
> > > > > >
> > > > > > Apologies I missed this several months ago. The answer is that =
this
> > > > > > causes everyone creating PMEM namespaces on v6.1+ to lose doubl=
e the
> > > > > > capacity of their namespace even when not using KMSAN which is =
too
> > > > > > wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_d=
ev:
> > > > > > increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replace=
d with
> > > > > > something like:
> > > > > >
> > > > > > diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> > > > > > index 79d93126453d..5693869b720b 100644
> > > > > > --- a/drivers/nvdimm/Kconfig
> > > > > > +++ b/drivers/nvdimm/Kconfig
> > > > > > @@ -63,6 +63,7 @@ config NVDIMM_PFN
> > > > > >         bool "PFN: Map persistent (device) memory"
> > > > > >         default LIBNVDIMM
> > > > > >         depends on ZONE_DEVICE
> > > > > > +       depends on !KMSAN
> > > > > >         select ND_CLAIM
> > > > > >         help
> > > > > >           Map persistent memory, i.e. advertise it to the memor=
y
> > > > > >
> > > > > >
> > > > > > ...otherwise, what was the rationale for increasing this value?=
 Were you
> > > > > > actually trying to use KMSAN for DAX pages?
> > > > >
> > > > > I was just building the kernel with nvdimm driver and KMSAN enabl=
ed.
> > > > > Because KMSAN adds extra data to every struct page, it immediatel=
y hit
> > > > > the following assert:
> > > > >
> > > > > drivers/nvdimm/pfn_devs.c:796:3: error: call to
> > > > > __compiletime_assert_330 declared with 'error' attribute: BUILD_B=
UG_ON
> > > > > fE
> > > > >                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAG=
E_SIZE);
> > > > >
> > > > > The comment before MAX_STRUCT_PAGE_SIZE declaration says "max str=
uct
> > > > > page size independent of kernel config", but maybe we can afford
> > > > > making it dependent on CONFIG_KMSAN (and possibly other config op=
tions
> > > > > that increase struct page size)?
> > > > >
> > > > > I don't mind disabling the driver under KMSAN, but having an extr=
a
> > > > > ifdef to keep KMSAN support sounds reasonable, WDYT?
> > > >
> > > > How about a module parameter to opt-in to the increased permanent
> > > > capacity loss?
> > >
> > > Please no, this isn't the 1990's, we should never force users to keep
> > > track of new module parameters that you then have to support for
> > > forever.
> >
> > Fair enough, premature enabling. If someone really wants this they can
> > find this thread in the archives and ask for another solution like
> > compile time override.
> >
> > >
> > >
> > > >
> > > > -- >8 --
> > > > >From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 =
2001
> > > > From: Dan Williams <dan.j.williams@intel.com>
> > > > Date: Thu, 5 Jan 2023 13:27:34 -0800
> > > > Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_P=
AGE_SIZE
> > > >
> > > > Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_S=
IZE")
> > > >
> > > > ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> > > > potentially doubling in the case of CONFIG_KMSAN=3Dy. Unfortunately=
 this
> > > > doubles the amount of capacity stolen from user addressable capacit=
y for
> > > > everyone, regardless of whether they are using the debug option. Re=
vert
> > > > that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> > > > allow for debug scenarios to proceed with creating debug sized page=
 maps
> > > > with a new 'libnvdimm.page_struct_override' module parameter.
> > > >
> > > > Note that this only applies to cases where the page map is permanen=
t,
> > > > i.e. stored in a reservation of the pmem itself ("--map=3Ddev" in "=
ndctl
> > > > create-namespace" terms). For the "--map=3Dmem" case, since the all=
ocation
> > > > is ephemeral for the lifespan of the namespace, there are no explic=
it
> > > > restriction. However, the implicit restriction, of having enough
> > > > available "System RAM" to store the page map for the typically larg=
e
> > > > pmem, still applies.
> > > >
> > > > Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_S=
IZE")
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Alexander Potapenko <glider@google.com>
> > > > Cc: Marco Elver <elver@google.com>
> > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > ---
> > > >  drivers/nvdimm/nd.h       |  2 +-
> > > >  drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++---------=
----
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
> > > >  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pg=
map);
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
> > > > +            "Force namespace creation in the presence of mm-debug.=
");
> > >
> > > I can't figure out from this description what this is for so perhaps =
it
> > > should be either removed and made dynamic (if you know you want to de=
bug
> > > the mm core, why not turn it on then?) or made more obvious what is
> > > happening?
> >
> > I'll kill it and update the KMSAN Documentation that KMSAN has
> > interactions with the NVDIMM subsystem that may cause some namespaces t=
o
> > fail to enable. That Documentation needs to be a part of this patch
> > regardless as that would be the default behavior of this module
> > parameter.
> >
> > Unfortunately, it can not be dynamically enabled because the size of
> > 'struct page' is unfortunately recorded in the metadata of the device.
> > Recall this is for supporting platform configurations where the capacit=
y
> > of the persistent memory exceeds or consumes too much of System RAM.
> > Consider 4TB of PMEM consumes 64GB of space just for 'struct page'. So,
> > NVDIMM subsystem has a mode to store that page array in a reservation o=
n
> > the PMEM device itself.
>
> Sorry, I might be missing something, but why cannot we have
>
> #ifdef CONFIG_KMSAN
> #define MAX_STRUCT_PAGE_SIZE 128
> #else
> #define MAX_STRUCT_PAGE_SIZE 64
> #endif
>

Possibly because this needs to be a fixed size on permanent storage
(like an inode on a disk file system)



> ?
>
> KMSAN is a debug-only tool, it already consumes more than two thirds
> of the system memory, so you don't want to enable it in any production
> environment anyway.
>
> > KMSAN mandates either that all namespaces all the time reserve the extr=
a
> > capacity, or that those namespace cannot be mapped while KMSAN is
> > enabled.
>
> Struct page depends on a couple of config options that affect its
> size, and has already been approaching the 64 byte boundary.
> It is unfortunate that the introduction of KMSAN was the last straw,
> but it could've been any other debug config that needs to store data
> in the struct page.
> Keeping the struct within cacheline size sounds reasonable for the
> default configuration, but having a build-time assert that prevents us
> from building debug configs sounds excessive.
>
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kasan-dev/63bd0be8945a0_5178e29414%40dwillia2-xfh.jf.intel.com.notmuch.
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
