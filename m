Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BA718543
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjEaOrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjEaOru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 10:47:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCBC5C5;
        Wed, 31 May 2023 07:47:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76BE21042;
        Wed, 31 May 2023 07:48:32 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.33.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8273A3F663;
        Wed, 31 May 2023 07:47:41 -0700 (PDT)
Date:   Wed, 31 May 2023 15:47:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org, sfr@canb.auug.org.au,
        mpe@ellerman.id.au, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 00/12] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Message-ID: <ZHdeAwOM6ciFobkL@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531130833.635651916@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531130833.635651916@infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 31, 2023 at 03:08:33PM +0200, Peter Zijlstra wrote:
> Hi!
> 
> After much breaking of things, find here the improved version.
> 
> Since v3:
> 
>  - unbreak everything that does *NOT* have cmpxchg128()
> 
>    Notably this_cpu_cmpxchg_double() is used unconditionally by SLUB
>    which means that this_cpu_try_cmpxchg128() needs to be unconditionally
>    available on all 64bit architectures.
> 
>  - fixed up x86/x86_64 cmpxchg{8,16}b emulation for this_cpu_cmpxchg{64,128}()
> 
>  - introduce {raw,this}_cpu_try_cmpxchg*()
> 
>  - add fallback for !__SIZEOF_INT128__ 64bit architectures
> 
>    Sadly there are supported 64bit architecture/compiler combinations that do
>    not have __SIZEOF_INT128__, specifically it was found that HPPA64 only added
>    this with GCC-11.
> 
>    this is yuck, and ideally we'd simply raise compiler requirements, but this
>    'works'.

The patches look good to me, and I used my local cross-build script to build
test this with the kernel.org GCC 10.3.0 cross toolchain for all of the
following arch/triplet/config combinations:

  alpha           alpha-linux             defconfig
  arc             arc-linux               defconfig
  arm             arm-linux-gnueabi       multi_v4t_defconfig
  arm             arm-linux-gnueabi       multi_v5_defconfig
  arm             arm-linux-gnueabi       multi_v7_defconfig
  arm             arm-linux-gnueabi       omap1_defconfig
  arm64           aarch64-linux           defconfig
  csky            csky-linux              defconfig
  i386            i386-linux              defconfig
  ia64            ia64-linux              defconfig
  m68k            m68k-linux              defconfig
  microblaze      microblaze-linux        defconfig
  mips            mips-linux              32r1_defconfig
  mips            mips-linux              32r2_defconfig
  mips            mips-linux              32r6_defconfig
  mips            mips64-linux            64r1_defconfig
  mips            mips64-linux            64r2_defconfig
  mips            mips64-linux            64r6_defconfig
  nios2           nios2-linux             defconfig
  openrisc        or1k-linux              defconfig
  parisc          hppa-linux              generic-32bit_defconfig
  parisc          hppa64-linux            generic-64bit_defconfig
  powerpc         powerpc-linux           ppc40x_defconfig
  powerpc         powerpc64-linux         ppc64_defconfig
  powerpc         powerpc64-linux         ppc64e_defconfig
  riscv           riscv32-linux           rv32_defconfig
  riscv           riscv64-linux           defconfig
  s390            s390-linux              defconfig
  sh              sh4-linux               defconfig
  sparc           sparc-linux             sparc32_defconfig
  sparc           sparc64-linux           sparc64_defconfig
  x86_64          x86_64-linux            defconfig
  xtensa          xtensa-linux            defconfig

... and everything seemed happy.

I've also boot-tested arm64 defconfig.

So FWIW, for the series:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

> My plan is to re-add this to tip/locking/core and thus -next later this week.

I'll need to rebase my kerneldoc series atop this, so getting this into a
stable branch soon would be great!

Thanks,
Mark.

> 
> Also available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> 
> ---
>  Documentation/core-api/this_cpu_ops.rst     |   2 -
>  arch/arm64/include/asm/atomic_ll_sc.h       |  56 +++---
>  arch/arm64/include/asm/atomic_lse.h         |  39 ++---
>  arch/arm64/include/asm/cmpxchg.h            |  48 ++----
>  arch/arm64/include/asm/percpu.h             |  30 ++--
>  arch/s390/include/asm/cmpxchg.h             |  32 +---
>  arch/s390/include/asm/cpu_mf.h              |   2 +-
>  arch/s390/include/asm/percpu.h              |  34 ++--
>  arch/s390/kernel/perf_cpum_sf.c             |  16 +-
>  arch/x86/include/asm/cmpxchg.h              |  25 ---
>  arch/x86/include/asm/cmpxchg_32.h           |   2 +-
>  arch/x86/include/asm/cmpxchg_64.h           |  63 ++++++-
>  arch/x86/include/asm/percpu.h               | 102 ++++++-----
>  arch/x86/lib/Makefile                       |   3 +-
>  arch/x86/lib/cmpxchg16b_emu.S               |  43 +++--
>  arch/x86/lib/cmpxchg8b_emu.S                |  67 ++++++--
>  drivers/iommu/amd/amd_iommu_types.h         |   9 +-
>  drivers/iommu/amd/iommu.c                   |  10 +-
>  drivers/iommu/intel/irq_remapping.c         |   8 +-
>  include/asm-generic/percpu.h                | 257 ++++++++++++++++++++++------
>  include/crypto/b128ops.h                    |  14 +-
>  include/linux/atomic/atomic-arch-fallback.h |  95 +++++++++-
>  include/linux/atomic/atomic-instrumented.h  |  93 ++++++++--
>  include/linux/dmar.h                        | 125 +++++++-------
>  include/linux/percpu-defs.h                 |  45 ++---
>  include/linux/slub_def.h                    |  12 +-
>  include/linux/types.h                       |  12 ++
>  include/uapi/linux/types.h                  |   4 +
>  lib/crypto/curve25519-hacl64.c              |   2 -
>  lib/crypto/poly1305-donna64.c               |   2 -
>  mm/slab.h                                   |  53 +++++-
>  mm/slub.c                                   | 139 +++++++++------
>  scripts/atomic/gen-atomic-fallback.sh       |   4 +-
>  scripts/atomic/gen-atomic-instrumented.sh   |  19 +-
>  34 files changed, 952 insertions(+), 515 deletions(-)
> 
