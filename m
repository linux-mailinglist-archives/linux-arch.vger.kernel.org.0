Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D84663BAE
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 09:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAJItf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 03:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjAJItU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 03:49:20 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19722DEE
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:49:18 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4a2f8ad29d5so145534037b3.8
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2023 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnOeOYalhwEQCO6UPq5gBGy6Ta3zdz6VrIAftglxGYY=;
        b=ATTDuPohVmROjY4u4qmAQpgs6sZIex3xwKpA858iVRKBU+0MvcQvCrmaWOS6f7meST
         IPDQ1mu7t4Cp6iAmZig04HjPlwbPXdO3o97hMinWqTGjP+LCXqnHigQap0MyVaI6ehdU
         F7DPPudQGLshVzcYqNtgmVzDQ4TR4/UyH+fbJgDE2Z4RtMqlvTSMtnEFt7VzF1b+Gjph
         Iz1x+NqA67ArBVMoEhPzRHhnoAR6YPxLdjalgNaM1gluHn1657DeIXlVDsoLKIqi/p+u
         NVuz849RT7dCgcMfN89RUDWZpQLeoSFL9QI9lCK0UYNxE4GVgDgzz8rH8V0tdgby3nKa
         amQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnOeOYalhwEQCO6UPq5gBGy6Ta3zdz6VrIAftglxGYY=;
        b=PGne6TxEcqNrTEDkbXmjiTOHf+hYQZiD6PL6XkEKCYF5LVYwcgPhYv9hWA2kWwvGtR
         GwtB563Kb5B8WitLRlz7nD/dVEN8pWMkWj9a6wwQJB08dK1sLW45i4muEO7jqBxHxWhw
         mJISO6Tdp4sMfaPGpCj8XQVNIr9UlKNvulcnZT8ULTRJ3wg6o6GKpsxXRUJcNykK/IQ3
         ti6BVQZ/iFeKTpq9m47j2ULp5jSlDrdX67CEGUG0IjKgZXE9NBrdYbvwgBPDpbsV679O
         mBQbxxj6tKG6h8RAcabIbPegIGgpRZRDqNiCeGD1DVEfAxcnB7vn7942VKJUvRn4+s/E
         hdIQ==
X-Gm-Message-State: AFqh2kr/hgTgbfjoq42TCPkwGIHxz6FStBmJ/rsf+lA9Za4y/EI18yRx
        yRDLHAj2nHDsN3KG41QmcMkTikpfq3B5KMrrEQUgdQ==
X-Google-Smtp-Source: AMrXdXsdUYZ6cu4gDblOMyPCrFA0Tcv5/xj2o0qI3OtbW5FpPIKKWdcbtBQ+BinIqOgR0WHVn8bgYm5zgNhAgvcE4Ng=
X-Received: by 2002:a81:c313:0:b0:3e5:4d1a:e506 with SMTP id
 r19-20020a81c313000000b003e54d1ae506mr2190904ywk.299.1673340557796; Tue, 10
 Jan 2023 00:49:17 -0800 (PST)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
 <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7z99mf1M5edxV4A@kroah.com> <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Jan 2023 09:48:31 +0100
Message-ID: <CAG_fn=X9jBwAvz9gph-02WcLhv3MQkBpvkZAsZRMwEYyT8zVeQ@mail.gmail.com>
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

On Tue, Jan 10, 2023 at 7:55 AM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> Greg Kroah-Hartman wrote:
> > On Mon, Jan 09, 2023 at 02:06:36PM -0800, Dan Williams wrote:
> > > Alexander Potapenko wrote:
> > > > On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.=
com> wrote:
> > > > >
> > > > > Alexander Potapenko wrote:
> > > > > > (+ Dan Williams)
> > > > > > (resending with patch context included)
> > > > > >
> > > > > > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> =
wrote:
> > > > > > >
> > > > > > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@goog=
le.com> wrote:
> > > > > > > >
> > > > > > > > KMSAN adds extra metadata fields to struct page, so it does=
 not fit into
> > > > > > > > 64 bytes anymore.
> > > > > > >
> > > > > > > Does this somehow cause extra space being used in all kernel =
configs?
> > > > > > > If not, it would be good to note this in the commit message.
> > > > > > >
> > > > > > I actually couldn't verify this on QEMU, because the driver nev=
er got loaded.
> > > > > > Looks like this increases the amount of memory used by the nvdi=
mm
> > > > > > driver in all kernel configs that enable it (including those th=
at
> > > > > > don't use KMSAN), but I am not sure how much is that.
> > > > > >
> > > > > > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be=
?
> > > > >
> > > > > Apologies I missed this several months ago. The answer is that th=
is
> > > > > causes everyone creating PMEM namespaces on v6.1+ to lose double =
the
> > > > > capacity of their namespace even when not using KMSAN which is to=
o
> > > > > wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev=
:
> > > > > increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced =
with
> > > > > something like:
> > > > >
> > > > > diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> > > > > index 79d93126453d..5693869b720b 100644
> > > > > --- a/drivers/nvdimm/Kconfig
> > > > > +++ b/drivers/nvdimm/Kconfig
> > > > > @@ -63,6 +63,7 @@ config NVDIMM_PFN
> > > > >         bool "PFN: Map persistent (device) memory"
> > > > >         default LIBNVDIMM
> > > > >         depends on ZONE_DEVICE
> > > > > +       depends on !KMSAN
> > > > >         select ND_CLAIM
> > > > >         help
> > > > >           Map persistent memory, i.e. advertise it to the memory
> > > > >
> > > > >
> > > > > ...otherwise, what was the rationale for increasing this value? W=
ere you
> > > > > actually trying to use KMSAN for DAX pages?
> > > >
> > > > I was just building the kernel with nvdimm driver and KMSAN enabled=
.
> > > > Because KMSAN adds extra data to every struct page, it immediately =
hit
> > > > the following assert:
> > > >
> > > > drivers/nvdimm/pfn_devs.c:796:3: error: call to
> > > > __compiletime_assert_330 declared with 'error' attribute: BUILD_BUG=
_ON
> > > > fE
> > > >                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_=
SIZE);
> > > >
> > > > The comment before MAX_STRUCT_PAGE_SIZE declaration says "max struc=
t
> > > > page size independent of kernel config", but maybe we can afford
> > > > making it dependent on CONFIG_KMSAN (and possibly other config opti=
ons
> > > > that increase struct page size)?
> > > >
> > > > I don't mind disabling the driver under KMSAN, but having an extra
> > > > ifdef to keep KMSAN support sounds reasonable, WDYT?
> > >
> > > How about a module parameter to opt-in to the increased permanent
> > > capacity loss?
> >
> > Please no, this isn't the 1990's, we should never force users to keep
> > track of new module parameters that you then have to support for
> > forever.
>
> Fair enough, premature enabling. If someone really wants this they can
> find this thread in the archives and ask for another solution like
> compile time override.
>
> >
> >
> > >
> > > -- >8 --
> > > >From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 20=
01
> > > From: Dan Williams <dan.j.williams@intel.com>
> > > Date: Thu, 5 Jan 2023 13:27:34 -0800
> > > Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAG=
E_SIZE
> > >
> > > Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZ=
E")
> > >
> > > ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> > > potentially doubling in the case of CONFIG_KMSAN=3Dy. Unfortunately t=
his
> > > doubles the amount of capacity stolen from user addressable capacity =
for
> > > everyone, regardless of whether they are using the debug option. Reve=
rt
> > > that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> > > allow for debug scenarios to proceed with creating debug sized page m=
aps
> > > with a new 'libnvdimm.page_struct_override' module parameter.
> > >
> > > Note that this only applies to cases where the page map is permanent,
> > > i.e. stored in a reservation of the pmem itself ("--map=3Ddev" in "nd=
ctl
> > > create-namespace" terms). For the "--map=3Dmem" case, since the alloc=
ation
> > > is ephemeral for the lifespan of the namespace, there are no explicit
> > > restriction. However, the implicit restriction, of having enough
> > > available "System RAM" to store the page map for the typically large
> > > pmem, still applies.
> > >
> > > Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZ=
E")
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Marco Elver <elver@google.com>
> > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > ---
> > >  drivers/nvdimm/nd.h       |  2 +-
> > >  drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++-----------=
--
> > >  2 files changed, 31 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> > > index 85ca5b4da3cf..ec5219680092 100644
> > > --- a/drivers/nvdimm/nd.h
> > > +++ b/drivers/nvdimm/nd.h
> > > @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
> > >             struct nd_namespace_common *ndns);
> > >  #if IS_ENABLED(CONFIG_ND_CLAIM)
> > >  /* max struct page size independent of kernel config */
> > > -#define MAX_STRUCT_PAGE_SIZE 128
> > > +#define MAX_STRUCT_PAGE_SIZE 64
> > >  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgma=
p);
> > >  #else
> > >  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> > > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > > index 61af072ac98f..978d63559c0e 100644
> > > --- a/drivers/nvdimm/pfn_devs.c
> > > +++ b/drivers/nvdimm/pfn_devs.c
> > > @@ -13,6 +13,11 @@
> > >  #include "pfn.h"
> > >  #include "nd.h"
> > >
> > > +static bool page_struct_override;
> > > +module_param(page_struct_override, bool, 0644);
> > > +MODULE_PARM_DESC(page_struct_override,
> > > +            "Force namespace creation in the presence of mm-debug.")=
;
> >
> > I can't figure out from this description what this is for so perhaps it
> > should be either removed and made dynamic (if you know you want to debu=
g
> > the mm core, why not turn it on then?) or made more obvious what is
> > happening?
>
> I'll kill it and update the KMSAN Documentation that KMSAN has
> interactions with the NVDIMM subsystem that may cause some namespaces to
> fail to enable. That Documentation needs to be a part of this patch
> regardless as that would be the default behavior of this module
> parameter.
>
> Unfortunately, it can not be dynamically enabled because the size of
> 'struct page' is unfortunately recorded in the metadata of the device.
> Recall this is for supporting platform configurations where the capacity
> of the persistent memory exceeds or consumes too much of System RAM.
> Consider 4TB of PMEM consumes 64GB of space just for 'struct page'. So,
> NVDIMM subsystem has a mode to store that page array in a reservation on
> the PMEM device itself.

Sorry, I might be missing something, but why cannot we have

#ifdef CONFIG_KMSAN
#define MAX_STRUCT_PAGE_SIZE 128
#else
#define MAX_STRUCT_PAGE_SIZE 64
#endif

?

KMSAN is a debug-only tool, it already consumes more than two thirds
of the system memory, so you don't want to enable it in any production
environment anyway.

> KMSAN mandates either that all namespaces all the time reserve the extra
> capacity, or that those namespace cannot be mapped while KMSAN is
> enabled.

Struct page depends on a couple of config options that affect its
size, and has already been approaching the 64 byte boundary.
It is unfortunate that the introduction of KMSAN was the last straw,
but it could've been any other debug config that needs to store data
in the struct page.
Keeping the struct within cacheline size sounds reasonable for the
default configuration, but having a build-time assert that prevents us
from building debug configs sounds excessive.

> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/63bd0be8945a0_5178e29414%40dwillia2-xfh.jf.intel.com.notmuch.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
