Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8205D6B7FCC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 18:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMRzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMRzo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 13:55:44 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B49D929162;
        Mon, 13 Mar 2023 10:55:40 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pbmOT-0002OB-00; Mon, 13 Mar 2023 18:55:33 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id ABE78C1252; Mon, 13 Mar 2023 18:55:21 +0100 (CET)
Date:   Mon, 13 Mar 2023 18:55:21 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Message-ID: <20230313175521.GA14404@alpha.franken.de>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308130710.368085-3-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 08, 2023 at 09:07:08PM +0800, Baoquan He wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/include/asm/io.h | 78 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index cec8347f0b85..6756baadba6c 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -126,6 +126,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
>   *     almost all conceivable cases a device driver should not be using
>   *     this function
>   */
> +#define phys_to_virt phys_to_virt
>  static inline void * phys_to_virt(unsigned long address)
>  {
>  	return __va(address);
> @@ -359,6 +360,27 @@ __BUILD_MEMORY_PFX(__raw_, q, u64, 0)
>  __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
>  #endif
>  
> +#define readb readb
> +#define readw readw
> +#define readl readl
> +#define writeb writeb
> +#define writew writew
> +#define writel writel
> +
> +#ifdef CONFIG_64BIT
> +#define readq readq
> +#define writeq writeq
> +#define __raw_readq __raw_readq
> +#define __raw_writeq __raw_writeq
> +#endif
> +
> +#define __raw_readb __raw_readb
> +#define __raw_readw __raw_readw
> +#define __raw_readl __raw_readl
> +#define __raw_writeb __raw_writeb
> +#define __raw_writew __raw_writew
> +#define __raw_writel __raw_writel
> +
>  #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
>  	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
>  	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
> @@ -374,6 +396,27 @@ BUILDIO_IOPORT(l, u32)
>  BUILDIO_IOPORT(q, u64)
>  #endif
>  
> +#define inb inb
> +#define inw inw
> +#define inl inl
> +#define inb_p inb_p
> +#define inw_p inw_p
> +#define inl_p inl_p
> +
> +#define outb outb
> +#define outw outw
> +#define outl outl
> +#define outb_p outb_p
> +#define outw_p outw_p
> +#define outl_p outl_p
> +
> +#ifdef CONFIG_64BIT
> +#define inq inq
> +#define outq outq
> +#define inq_p inq_p
> +#define outq_p outq_p
> +#endif
> +
>  #define __BUILDIO(bwlq, type)						\
>  									\
>  __BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0, 0)
> @@ -412,14 +455,6 @@ __BUILDIO(q, u64)
>  #define writeq_be(val, addr)						\
>  	__raw_writeq(cpu_to_be64((val)), (__force unsigned *)(addr))
>  
> -/*
> - * Some code tests for these symbols
> - */
> -#ifdef CONFIG_64BIT
> -#define readq				readq
> -#define writeq				writeq
> -#endif
> -
>  #define __BUILD_MEMORY_STRING(bwlq, type)				\
>  									\
>  static inline void writes##bwlq(volatile void __iomem *mem,		\
> @@ -480,14 +515,39 @@ BUILDSTRING(l, u32)
>  BUILDSTRING(q, u64)
>  #endif
>  
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +
> +#define readsb readsb
> +#define readsw readsw
> +#define readsl readsl
> +#define writesb writesb
> +#define writesw writesw
> +#define writesl writesl
> +
> +#ifdef CONFIG_64BIT
> +#define insq insq
> +#define readsq readsq
> +#define readsq readsq
> +#define writesq writesq
> +#endif
> +
> +
> +#define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
>  {
>  	memset((void __force *) addr, val, count);
>  }
> +#define memcpy_fromio memcpy_fromio
>  static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
>  {
>  	memcpy(dst, (void __force *) src, count);
>  }
> +#define memcpy_toio memcpy_toio
>  static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
>  {
>  	memcpy((void __force *) dst, src, count);
> @@ -556,4 +616,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>  
>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);
>  
> +#include <asm-generic/io.h>

this #include blows up builds with:

  GEN     Makefile
  Checking missing-syscalls for N32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CC      init/version.o
In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
                 from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
                 from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
                 from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
                 from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
                 from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
                 from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
                 from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
                 from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
                 from /local/tbogendoerfer/korg/linux/init/version.c:17:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_trylock’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function ‘spin_acquire’ [-Werror=implicit-function-declaration]
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
   ^~~~~~~~~~~~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:21: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
                     ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_lock_irqsave’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:110:20: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
                    ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
  LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
  ^~~~~~~~~~~~~~
  GEN     Makefile
  Checking missing-syscalls for N32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CC      init/version.o
In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
                 from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
                 from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
                 from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
                 from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
                 from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
                 from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
                 from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
                 from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
                 from /local/tbogendoerfer/korg/linux/init/version.c:17:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_trylock’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function ‘spin_acquire’ [-Werror=implicit-function-declaration]
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
   ^~~~~~~~~~~~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:21: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
                     ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_lock_irqsave’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:110:20: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
                    ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
  LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
  ^~~~~~~~~~~~~~
  GEN     Makefile
  Checking missing-syscalls for N32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
  CC      init/version.o
In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
                 from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
                 from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
                 from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
                 from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
                 from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
                 from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
                 from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
                 from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
                 from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
                 from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
                 from /local/tbogendoerfer/korg/linux/init/version.c:17:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_trylock’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function ‘spin_acquire’ [-Werror=implicit-function-declaration]
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
   ^~~~~~~~~~~~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:21: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
                     ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_lock_irqsave’:
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:110:20: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
  spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
                    ^~
/local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
  LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
  ^~~~~~~~~~~~~~
[...]

I've cut the compiler output. Removing the asm-generic doesn't show this
problem, but so far I fail to see the reason...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
