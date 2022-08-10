Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E553758EDFF
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHJOPT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Aug 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiHJOPS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2022 10:15:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F98193F2;
        Wed, 10 Aug 2022 07:15:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FBF1FB;
        Wed, 10 Aug 2022 07:15:17 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.44.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BE0F3F67D;
        Wed, 10 Aug 2022 07:15:13 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:15:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 10/15] x86: add an arch helper function to invalidate
 all cache for nvdimm
Message-ID: <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 09, 2022 at 02:47:06PM -0700, Dave Jiang wrote:
> 
> On 8/3/2022 10:37 AM, Jonathan Cameron wrote:
> > On Tue, 19 Jul 2022 12:07:03 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > > On 7/17/2022 10:30 PM, Davidlohr Bueso wrote:
> > > > On Fri, 15 Jul 2022, Dave Jiang wrote:
> > > > > The original implementation to flush all cache after unlocking the
> > > > > nvdimm
> > > > > resides in drivers/acpi/nfit/intel.c. This is a temporary stop gap until
> > > > > nvdimm with security operations arrives on other archs. With support CXL
> > > > > pmem supporting security operations, specifically "unlock" dimm, the
> > > > > need
> > > > > for an arch supported helper function to invalidate all CPU cache for
> > > > > nvdimm has arrived. Remove original implementation from acpi/nfit and
> > > > > add
> > > > > cross arch support for this operation.
> > > > > 
> > > > > Add CONFIG_ARCH_HAS_NVDIMM_INVAL_CACHE Kconfig and allow x86_64 to
> > > > > opt in
> > > > > and provide the support via wbinvd_on_all_cpus() call.
> > > > So the 8.2.9.5.5 bits will also need wbinvd - and I guess arm64 will need
> > > > its own semantics (iirc there was a flush all call in the past). Cc'ing
> > > > Jonathan as well.
> > > > 
> > > > Anyway, I think this call should not be defined in any place other
> > > > than core
> > > > kernel headers, and not in pat/nvdimm. I was trying to make it fit in
> > > > smp.h,
> > > > for example, but conviniently we might be able to hijack
> > > > flush_cache_all()
> > > > for our purposes as of course neither x86-64 arm64 uses it :)
> > > > 
> > > > And I see this as safe (wrt not adding a big hammer on unaware
> > > > drivers) as
> > > > the 32bit archs that define the call are mostly contained thin their
> > > > arch/,
> > > > and the few in drivers/ are still specific to those archs.
> > > > 
> > > > Maybe something like the below.
> > > Ok. I'll replace my version with yours.
> > Careful with flush_cache_all(). The stub version in
> > include/asm-generic/cacheflush.h has a comment above it that would
> > need updating at very least (I think).
> > Note there 'was' a flush_cache_all() for ARM64, but:
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/1429521875-16893-1-git-send-email-mark.rutland@arm.com/
> 
> 
> flush_and_invalidate_cache_all() instead given it calls wbinvd on x86? I
> think other archs, at least ARM, those are separate instructions aren't
> they?

On arm and arm64 there is no way to perform maintenance on *all* caches; it has
to be done in cacheline increments by address. It's not realistic to do that
for the entire address space, so we need to know the relevant address ranges
(as per the commit referenced above).

So we probably need to think a bit harder about the geenric interface, since
"all" isn't possible to implement. :/

Thanks,
Mark.

> 
> > 
> > Also, I'm far from sure it will be the right choice on all CXL supporting
> > architectures.
> > +CC linux-arch, linux-arm and Arnd.
> > 
> > > 
> > > > Thanks,
> > > > Davidlohr
> > > > 
> > > > ------8<----------------------------------------
> > > > Subject: [PATCH] arch/x86: define flush_cache_all as global wbinvd
> > > > 
> > > > With CXL security features, global CPU cache flushing nvdimm
> > > > requirements are no longer specific to that subsystem, even
> > > > beyond the scope of security_ops. CXL will need such semantics
> > > > for features not necessarily limited to persistent memory.
> > > > 
> > > > So use the flush_cache_all() for the wbinvd across all
> > > > CPUs on x86. arm64, which is another platform to have CXL
> > > > support can also define its own semantics here.
> > > > 
> > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > > ---
> > > >   arch/x86/Kconfig                  |  1 -
> > > >   arch/x86/include/asm/cacheflush.h |  5 +++++
> > > >   arch/x86/mm/pat/set_memory.c      |  8 --------
> > > >   drivers/acpi/nfit/intel.c         | 11 ++++++-----
> > > >   drivers/cxl/security.c            |  5 +++--
> > > >   include/linux/libnvdimm.h         |  9 ---------
> > > >   6 files changed, 14 insertions(+), 25 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index 8dbe89eba639..be0b95e51df6 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -83,7 +83,6 @@ config X86
> > > >      select ARCH_HAS_MEMBARRIER_SYNC_CORE
> > > >      select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> > > >      select ARCH_HAS_PMEM_API        if X86_64
> > > > -    select ARCH_HAS_NVDIMM_INVAL_CACHE    if X86_64
> > > >      select ARCH_HAS_PTE_DEVMAP        if X86_64
> > > >      select ARCH_HAS_PTE_SPECIAL
> > > >      select ARCH_HAS_UACCESS_FLUSHCACHE    if X86_64
> > > > diff --git a/arch/x86/include/asm/cacheflush.h
> > > > b/arch/x86/include/asm/cacheflush.h
> > > > index b192d917a6d0..05c79021665d 100644
> > > > --- a/arch/x86/include/asm/cacheflush.h
> > > > +++ b/arch/x86/include/asm/cacheflush.h
> > > > @@ -10,4 +10,9 @@
> > > > 
> > > >   void clflush_cache_range(void *addr, unsigned int size);
> > > > 
> > > > +#define flush_cache_all()        \
> > > > +do {                    \
> > > > +    wbinvd_on_all_cpus();        \
> > > > +} while (0)
> > > > +
> > > >   #endif /* _ASM_X86_CACHEFLUSH_H */
> > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > index e4cd1286deef..1abd5438f126 100644
> > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > @@ -330,14 +330,6 @@ void arch_invalidate_pmem(void *addr, size_t size)
> > > >   EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> > > >   #endif
> > > > 
> > > > -#ifdef CONFIG_ARCH_HAS_NVDIMM_INVAL_CACHE
> > > > -void arch_invalidate_nvdimm_cache(void)
> > > > -{
> > > > -    wbinvd_on_all_cpus();
> > > > -}
> > > > -EXPORT_SYMBOL_GPL(arch_invalidate_nvdimm_cache);
> > > > -#endif
> > > > -
> > > >   static void __cpa_flush_all(void *arg)
> > > >   {
> > > >      unsigned long cache = (unsigned long)arg;
> > > > diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> > > > index 242d2e9203e9..1b0ecb4d67e6 100644
> > > > --- a/drivers/acpi/nfit/intel.c
> > > > +++ b/drivers/acpi/nfit/intel.c
> > > > @@ -1,6 +1,7 @@
> > > >   // SPDX-License-Identifier: GPL-2.0
> > > >   /* Copyright(c) 2018 Intel Corporation. All rights reserved. */
> > > >   #include <linux/libnvdimm.h>
> > > > +#include <linux/cacheflush.h>
> > > >   #include <linux/ndctl.h>
> > > >   #include <linux/acpi.h>
> > > >   #include <asm/smp.h>
> > > > @@ -226,7 +227,7 @@ static int __maybe_unused
> > > > intel_security_unlock(struct nvdimm *nvdimm,
> > > >      }
> > > > 
> > > >      /* DIMM unlocked, invalidate all CPU caches before we read it */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > > 
> > > >      return 0;
> > > >   }
> > > > @@ -296,7 +297,7 @@ static int __maybe_unused
> > > > intel_security_erase(struct nvdimm *nvdimm,
> > > >          return -ENOTTY;
> > > > 
> > > >      /* flush all cache before we erase DIMM */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      memcpy(nd_cmd.cmd.passphrase, key->data,
> > > >              sizeof(nd_cmd.cmd.passphrase));
> > > >      rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> > > > @@ -316,7 +317,7 @@ static int __maybe_unused
> > > > intel_security_erase(struct nvdimm *nvdimm,
> > > >      }
> > > > 
> > > >      /* DIMM erased, invalidate all CPU caches before we read it */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      return 0;
> > > >   }
> > > > 
> > > > @@ -353,7 +354,7 @@ static int __maybe_unused
> > > > intel_security_query_overwrite(struct nvdimm *nvdimm)
> > > >      }
> > > > 
> > > >      /* flush all cache before we make the nvdimms available */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      return 0;
> > > >   }
> > > > 
> > > > @@ -379,7 +380,7 @@ static int __maybe_unused
> > > > intel_security_overwrite(struct nvdimm *nvdimm,
> > > >          return -ENOTTY;
> > > > 
> > > >      /* flush all cache before we erase DIMM */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      memcpy(nd_cmd.cmd.passphrase, nkey->data,
> > > >              sizeof(nd_cmd.cmd.passphrase));
> > > >      rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
> > > > diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> > > > index 3dc04b50afaf..e2977872bf2f 100644
> > > > --- a/drivers/cxl/security.c
> > > > +++ b/drivers/cxl/security.c
> > > > @@ -6,6 +6,7 @@
> > > >   #include <linux/ndctl.h>
> > > >   #include <linux/async.h>
> > > >   #include <linux/slab.h>
> > > > +#include <linux/cacheflush.h>
> > > >   #include "cxlmem.h"
> > > >   #include "cxl.h"
> > > > 
> > > > @@ -137,7 +138,7 @@ static int cxl_pmem_security_unlock(struct nvdimm
> > > > *nvdimm,
> > > >          return rc;
> > > > 
> > > >      /* DIMM unlocked, invalidate all CPU caches before we read it */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      return 0;
> > > >   }
> > > > 
> > > > @@ -165,7 +166,7 @@ static int
> > > > cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
> > > >          return rc;
> > > > 
> > > >      /* DIMM erased, invalidate all CPU caches before we read it */
> > > > -    arch_invalidate_nvdimm_cache();
> > > > +    flush_cache_all();
> > > >      return 0;
> > > >   }
> > > > 
> > > > diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> > > > index 07e4e7572089..0769afb73380 100644
> > > > --- a/include/linux/libnvdimm.h
> > > > +++ b/include/linux/libnvdimm.h
> > > > @@ -309,13 +309,4 @@ static inline void arch_invalidate_pmem(void
> > > > *addr, size_t size)
> > > >   {
> > > >   }
> > > >   #endif
> > > > -
> > > > -#ifdef CONFIG_ARCH_HAS_NVDIMM_INVAL_CACHE
> > > > -void arch_invalidate_nvdimm_cache(void);
> > > > -#else
> > > > -static inline void arch_invalidate_nvdimm_cache(void)
> > > > -{
> > > > -}
> > > > -#endif
> > > > -
> > > >   #endif /* __LIBNVDIMM_H__ */
> > > > -- 
> > > > 2.36.1
