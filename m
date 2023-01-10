Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F916638F3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jan 2023 06:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjAJF5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Jan 2023 00:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjAJF4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2023 00:56:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725EA34752;
        Mon,  9 Jan 2023 21:56:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EA76B81104;
        Tue, 10 Jan 2023 05:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD6C433EF;
        Tue, 10 Jan 2023 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673330169;
        bh=1oB4sDoRZa+XX472HDJnAMRcAUiZvaW++oq7wJF7Uog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbAmOZqB1yPX+AUbM/yAbQ04gBVVQevbEDUaje8m95IudMdNMBXujS1NNjesKTE8g
         sPYFHKpSATTuDXmuRIh4xTsgZu2hqtb8j2vZgytNs1YOU7B/1V5ZK8vgTQH4fjQNi9
         /X/QKhyktLVv2+UPu8g00l1TbVaX/TD/k+YDf9fs=
Date:   Tue, 10 Jan 2023 06:56:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
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
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
Message-ID: <Y7z99mf1M5edxV4A@kroah.com>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
 <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 09, 2023 at 02:06:36PM -0800, Dan Williams wrote:
> Alexander Potapenko wrote:
> > On Thu, Jan 5, 2023 at 11:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Alexander Potapenko wrote:
> > > > (+ Dan Williams)
> > > > (resending with patch context included)
> > > >
> > > > On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
> > > > > >
> > > > > > KMSAN adds extra metadata fields to struct page, so it does not fit into
> > > > > > 64 bytes anymore.
> > > > >
> > > > > Does this somehow cause extra space being used in all kernel configs?
> > > > > If not, it would be good to note this in the commit message.
> > > > >
> > > > I actually couldn't verify this on QEMU, because the driver never got loaded.
> > > > Looks like this increases the amount of memory used by the nvdimm
> > > > driver in all kernel configs that enable it (including those that
> > > > don't use KMSAN), but I am not sure how much is that.
> > > >
> > > > Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?
> > >
> > > Apologies I missed this several months ago. The answer is that this
> > > causes everyone creating PMEM namespaces on v6.1+ to lose double the
> > > capacity of their namespace even when not using KMSAN which is too
> > > wasteful to tolerate. So, I think "6e9f05dc66f9 libnvdimm/pfn_dev:
> > > increase MAX_STRUCT_PAGE_SIZE" needs to be reverted and replaced with
> > > something like:
> > >
> > > diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
> > > index 79d93126453d..5693869b720b 100644
> > > --- a/drivers/nvdimm/Kconfig
> > > +++ b/drivers/nvdimm/Kconfig
> > > @@ -63,6 +63,7 @@ config NVDIMM_PFN
> > >         bool "PFN: Map persistent (device) memory"
> > >         default LIBNVDIMM
> > >         depends on ZONE_DEVICE
> > > +       depends on !KMSAN
> > >         select ND_CLAIM
> > >         help
> > >           Map persistent memory, i.e. advertise it to the memory
> > >
> > >
> > > ...otherwise, what was the rationale for increasing this value? Were you
> > > actually trying to use KMSAN for DAX pages?
> > 
> > I was just building the kernel with nvdimm driver and KMSAN enabled.
> > Because KMSAN adds extra data to every struct page, it immediately hit
> > the following assert:
> > 
> > drivers/nvdimm/pfn_devs.c:796:3: error: call to
> > __compiletime_assert_330 declared with 'error' attribute: BUILD_BUG_ON
> > fE
> >                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
> > 
> > The comment before MAX_STRUCT_PAGE_SIZE declaration says "max struct
> > page size independent of kernel config", but maybe we can afford
> > making it dependent on CONFIG_KMSAN (and possibly other config options
> > that increase struct page size)?
> > 
> > I don't mind disabling the driver under KMSAN, but having an extra
> > ifdef to keep KMSAN support sounds reasonable, WDYT?
> 
> How about a module parameter to opt-in to the increased permanent
> capacity loss?

Please no, this isn't the 1990's, we should never force users to keep
track of new module parameters that you then have to support for
forever.


> 
> -- >8 --
> >From 693563817dea3fd8f293f9b69ec78066ab1d96d2 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Thu, 5 Jan 2023 13:27:34 -0800
> Subject: [PATCH] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
> 
> Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> 
> ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
> doubles the amount of capacity stolen from user addressable capacity for
> everyone, regardless of whether they are using the debug option. Revert
> that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> allow for debug scenarios to proceed with creating debug sized page maps
> with a new 'libnvdimm.page_struct_override' module parameter.
> 
> Note that this only applies to cases where the page map is permanent,
> i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
> create-namespace" terms). For the "--map=mem" case, since the allocation
> is ephemeral for the lifespan of the namespace, there are no explicit
> restriction. However, the implicit restriction, of having enough
> available "System RAM" to store the page map for the typically large
> pmem, still applies.
> 
> Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> Cc: <stable@vger.kernel.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  drivers/nvdimm/nd.h       |  2 +-
>  drivers/nvdimm/pfn_devs.c | 45 ++++++++++++++++++++++++++-------------
>  2 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 85ca5b4da3cf..ec5219680092 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -652,7 +652,7 @@ void devm_namespace_disable(struct device *dev,
>  		struct nd_namespace_common *ndns);
>  #if IS_ENABLED(CONFIG_ND_CLAIM)
>  /* max struct page size independent of kernel config */
> -#define MAX_STRUCT_PAGE_SIZE 128
> +#define MAX_STRUCT_PAGE_SIZE 64
>  int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
>  #else
>  static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 61af072ac98f..978d63559c0e 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -13,6 +13,11 @@
>  #include "pfn.h"
>  #include "nd.h"
>  
> +static bool page_struct_override;
> +module_param(page_struct_override, bool, 0644);
> +MODULE_PARM_DESC(page_struct_override,
> +		 "Force namespace creation in the presence of mm-debug.");

I can't figure out from this description what this is for so perhaps it
should be either removed and made dynamic (if you know you want to debug
the mm core, why not turn it on then?) or made more obvious what is
happening?

thanks,

greg k-h
