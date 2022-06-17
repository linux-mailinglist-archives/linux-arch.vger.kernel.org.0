Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B7054F7F9
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiFQM6t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 08:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382418AbiFQM6Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 08:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5C2E084;
        Fri, 17 Jun 2022 05:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EE461FCC;
        Fri, 17 Jun 2022 12:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E9BC3411B;
        Fri, 17 Jun 2022 12:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655470696;
        bh=q6ahBsNODq++hnrTnzK6LlJOq33Neo0r38bziwQcZbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPmZ5BYtt0vbAbAXt6ya5plQRjChvgSM1c7v32PlkHWDhZDq1REQ6q5N+fc1iEzSu
         vqseKn5X4boZHVHwVZPF8SFi4I85YGy1ywm9jj8zNmAkSblvYtEIuHTcMr+W4oHjHi
         4oAUOWbX6H5L37llZ5+sPpn8XfUm2j2ZzqiT0zdLRSqX9Vl7/i4sbxwwxzYW0fAdT+
         t63UHa0fU+I+6IOnIev9JF/FtHIoVLwrmKIB5T5LqPL6E7dY/Nt6FVphG5fTcZ6nXi
         hu3jIDlj+yjToY1Jwafa7pqWAvBPkLWoibcjRh9fRBsqP9f4d+MTrxXnfJo/B/Sefj
         2f6lkwETcLXlA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Date:   Fri, 17 Jun 2022 14:57:50 +0200
Message-Id: <20220617125750.728590-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220617125750.728590-1-arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All architecture-independent users of virt_to_bus() and bus_to_virt()
have been fixed to use the dma mapping interfaces or have been
removed now.  This means the definitions on most architectures, and the
CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.

The only exceptions to this are a few network and scsi drivers for m68k
Amiga and VME machines and ppc32 Macintosh. These drivers work correctly
with the old interfaces and are probably not worth changing.

On alpha and parisc, virt_to_bus() were still used in asm/floppy.h.
alpha can use isa_virt_to_bus() like x86 does, and parisc can just
open-code the virt_to_phys() here, as this is architecture specific
code.

I tried updating the bus-virt-phys-mapping.rst documentation, which
started as an email from Linus to explain some details of the Linux-2.0
driver interfaces. The bits about virt_to_bus() were declared obsolete
backin 2000, and the rest is not all that relevant any more, so in the
end I just decided to remove the file completely.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../core-api/bus-virt-phys-mapping.rst        | 220 ------------------
 Documentation/core-api/dma-api-howto.rst      |  14 --
 Documentation/core-api/index.rst              |   1 -
 .../translations/zh_CN/core-api/index.rst     |   1 -
 arch/alpha/Kconfig                            |   1 -
 arch/alpha/include/asm/floppy.h               |   2 +-
 arch/alpha/include/asm/io.h                   |   8 +-
 arch/ia64/Kconfig                             |   1 -
 arch/ia64/include/asm/io.h                    |   8 -
 arch/m68k/Kconfig                             |   1 -
 arch/m68k/include/asm/virtconvert.h           |   4 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/microblaze/include/asm/io.h              |   2 -
 arch/mips/Kconfig                             |   1 -
 arch/mips/include/asm/io.h                    |   9 -
 arch/parisc/Kconfig                           |   1 -
 arch/parisc/include/asm/floppy.h              |   4 +-
 arch/parisc/include/asm/io.h                  |   2 -
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/io.h                 |   2 -
 arch/riscv/include/asm/page.h                 |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/io.h                     |   9 -
 arch/xtensa/Kconfig                           |   1 -
 arch/xtensa/include/asm/io.h                  |   3 -
 include/asm-generic/io.h                      |  14 --
 mm/Kconfig                                    |   8 -
 27 files changed, 10 insertions(+), 311 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst

diff --git a/Documentation/core-api/bus-virt-phys-mapping.rst b/Documentation/core-api/bus-virt-phys-mapping.rst
deleted file mode 100644
index c72b24a7d52c..000000000000
--- a/Documentation/core-api/bus-virt-phys-mapping.rst
+++ /dev/null
@@ -1,220 +0,0 @@
-==========================================================
-How to access I/O mapped memory from within device drivers
-==========================================================
-
-:Author: Linus
-
-.. warning::
-
-	The virt_to_bus() and bus_to_virt() functions have been
-	superseded by the functionality provided by the PCI DMA interface
-	(see Documentation/core-api/dma-api-howto.rst).  They continue
-	to be documented below for historical purposes, but new code
-	must not use them. --davidm 00/12/12
-
-::
-
-  [ This is a mail message in response to a query on IO mapping, thus the
-    strange format for a "document" ]
-
-The AHA-1542 is a bus-master device, and your patch makes the driver give the
-controller the physical address of the buffers, which is correct on x86
-(because all bus master devices see the physical memory mappings directly). 
-
-However, on many setups, there are actually **three** different ways of looking
-at memory addresses, and in this case we actually want the third, the
-so-called "bus address". 
-
-Essentially, the three ways of addressing memory are (this is "real memory",
-that is, normal RAM--see later about other details): 
-
- - CPU untranslated.  This is the "physical" address.  Physical address 
-   0 is what the CPU sees when it drives zeroes on the memory bus.
-
- - CPU translated address. This is the "virtual" address, and is 
-   completely internal to the CPU itself with the CPU doing the appropriate
-   translations into "CPU untranslated". 
-
- - bus address. This is the address of memory as seen by OTHER devices, 
-   not the CPU. Now, in theory there could be many different bus 
-   addresses, with each device seeing memory in some device-specific way, but
-   happily most hardware designers aren't actually actively trying to make
-   things any more complex than necessary, so you can assume that all 
-   external hardware sees the memory the same way. 
-
-Now, on normal PCs the bus address is exactly the same as the physical
-address, and things are very simple indeed. However, they are that simple
-because the memory and the devices share the same address space, and that is
-not generally necessarily true on other PCI/ISA setups. 
-
-Now, just as an example, on the PReP (PowerPC Reference Platform), the 
-CPU sees a memory map something like this (this is from memory)::
-
-	0-2 GB		"real memory"
-	2 GB-3 GB	"system IO" (inb/out and similar accesses on x86)
-	3 GB-4 GB 	"IO memory" (shared memory over the IO bus)
-
-Now, that looks simple enough. However, when you look at the same thing from
-the viewpoint of the devices, you have the reverse, and the physical memory
-address 0 actually shows up as address 2 GB for any IO master.
-
-So when the CPU wants any bus master to write to physical memory 0, it 
-has to give the master address 0x80000000 as the memory address.
-
-So, for example, depending on how the kernel is actually mapped on the 
-PPC, you can end up with a setup like this::
-
- physical address:	0
- virtual address:	0xC0000000
- bus address:		0x80000000
-
-where all the addresses actually point to the same thing.  It's just seen 
-through different translations..
-
-Similarly, on the Alpha, the normal translation is::
-
- physical address:	0
- virtual address:	0xfffffc0000000000
- bus address:		0x40000000
-
-(but there are also Alphas where the physical address and the bus address
-are the same). 
-
-Anyway, the way to look up all these translations, you do::
-
-	#include <asm/io.h>
-
-	phys_addr = virt_to_phys(virt_addr);
-	virt_addr = phys_to_virt(phys_addr);
-	 bus_addr = virt_to_bus(virt_addr);
-	virt_addr = bus_to_virt(bus_addr);
-
-Now, when do you need these?
-
-You want the **virtual** address when you are actually going to access that
-pointer from the kernel. So you can have something like this::
-
-	/*
-	 * this is the hardware "mailbox" we use to communicate with
-	 * the controller. The controller sees this directly.
-	 */
-	struct mailbox {
-		__u32 status;
-		__u32 bufstart;
-		__u32 buflen;
-		..
-	} mbox;
-
-		unsigned char * retbuffer;
-
-		/* get the address from the controller */
-		retbuffer = bus_to_virt(mbox.bufstart);
-		switch (retbuffer[0]) {
-			case STATUS_OK:
-				...
-
-on the other hand, you want the bus address when you have a buffer that 
-you want to give to the controller::
-
-	/* ask the controller to read the sense status into "sense_buffer" */
-	mbox.bufstart = virt_to_bus(&sense_buffer);
-	mbox.buflen = sizeof(sense_buffer);
-	mbox.status = 0;
-	notify_controller(&mbox);
-
-And you generally **never** want to use the physical address, because you can't
-use that from the CPU (the CPU only uses translated virtual addresses), and
-you can't use it from the bus master. 
-
-So why do we care about the physical address at all? We do need the physical
-address in some cases, it's just not very often in normal code.  The physical
-address is needed if you use memory mappings, for example, because the
-"remap_pfn_range()" mm function wants the physical address of the memory to
-be remapped as measured in units of pages, a.k.a. the pfn (the memory
-management layer doesn't know about devices outside the CPU, so it
-shouldn't need to know about "bus addresses" etc).
-
-.. note::
-
-	The above is only one part of the whole equation. The above
-	only talks about "real memory", that is, CPU memory (RAM).
-
-There is a completely different type of memory too, and that's the "shared
-memory" on the PCI or ISA bus. That's generally not RAM (although in the case
-of a video graphics card it can be normal DRAM that is just used for a frame
-buffer), but can be things like a packet buffer in a network card etc. 
-
-This memory is called "PCI memory" or "shared memory" or "IO memory" or
-whatever, and there is only one way to access it: the readb/writeb and
-related functions. You should never take the address of such memory, because
-there is really nothing you can do with such an address: it's not
-conceptually in the same memory space as "real memory" at all, so you cannot
-just dereference a pointer. (Sadly, on x86 it **is** in the same memory space,
-so on x86 it actually works to just deference a pointer, but it's not
-portable). 
-
-For such memory, you can do things like:
-
- - reading::
-
-	/*
-	 * read first 32 bits from ISA memory at 0xC0000, aka
-	 * C000:0000 in DOS terms
-	 */
-	unsigned int signature = isa_readl(0xC0000);
-
- - remapping and writing::
-
-	/*
-	 * remap framebuffer PCI memory area at 0xFC000000,
-	 * size 1MB, so that we can access it: We can directly
-	 * access only the 640k-1MB area, so anything else
-	 * has to be remapped.
-	 */
-	void __iomem *baseptr = ioremap(0xFC000000, 1024*1024);
-
-	/* write a 'A' to the offset 10 of the area */
-	writeb('A',baseptr+10);
-
-	/* unmap when we unload the driver */
-	iounmap(baseptr);
-
- - copying and clearing::
-
-	/* get the 6-byte Ethernet address at ISA address E000:0040 */
-	memcpy_fromio(kernel_buffer, 0xE0040, 6);
-	/* write a packet to the driver */
-	memcpy_toio(0xE1000, skb->data, skb->len);
-	/* clear the frame buffer */
-	memset_io(0xA0000, 0, 0x10000);
-
-OK, that just about covers the basics of accessing IO portably.  Questions?
-Comments? You may think that all the above is overly complex, but one day you
-might find yourself with a 500 MHz Alpha in front of you, and then you'll be
-happy that your driver works ;)
-
-Note that kernel versions 2.0.x (and earlier) mistakenly called the
-ioremap() function "vremap()".  ioremap() is the proper name, but I
-didn't think straight when I wrote it originally.  People who have to
-support both can do something like::
- 
-	/* support old naming silliness */
-	#if LINUX_VERSION_CODE < 0x020100
-	#define ioremap vremap
-	#define iounmap vfree                                                     
-	#endif
- 
-at the top of their source files, and then they can use the right names
-even on 2.0.x systems. 
-
-And the above sounds worse than it really is.  Most real drivers really
-don't do all that complex things (or rather: the complexity is not so
-much in the actual IO accesses as in error handling and timeouts etc). 
-It's generally not hard to fix drivers, and in many cases the code
-actually looks better afterwards::
-
-	unsigned long signature = *(unsigned int *) 0xC0000;
-		vs
-	unsigned long signature = readl(0xC0000);
-
-I think the second version actually is more readable, no?
diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 358d495456d1..828846804e25 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -707,20 +707,6 @@ to use the dma_sync_*() interfaces::
 		}
 	}
 
-Drivers converted fully to this interface should not use virt_to_bus() any
-longer, nor should they use bus_to_virt(). Some drivers have to be changed a
-little bit, because there is no longer an equivalent to bus_to_virt() in the
-dynamic DMA mapping scheme - you have to always store the DMA addresses
-returned by the dma_alloc_coherent(), dma_pool_alloc(), and dma_map_single()
-calls (dma_map_sg() stores them in the scatterlist itself if the platform
-supports dynamic DMA mapping in hardware) in your driver structures and/or
-in the card registers.
-
-All drivers should be using these interfaces with no exceptions.  It
-is planned to completely remove virt_to_bus() and bus_to_virt() as
-they are entirely deprecated.  Some ports already do not provide these
-as it is impossible to correctly support them.
-
 Handling Errors
 ===============
 
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 9ef37e985a40..0550282cfd6f 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -42,7 +42,6 @@ Library functionality that is used throughout the kernel.
    rbtree
    generic-radix-tree
    packing
-   bus-virt-phys-mapping
    this_cpu_ops
    timekeeping
    errseq
diff --git a/Documentation/translations/zh_CN/core-api/index.rst b/Documentation/translations/zh_CN/core-api/index.rst
index 26d9913fc8b6..c52175fc1b61 100644
--- a/Documentation/translations/zh_CN/core-api/index.rst
+++ b/Documentation/translations/zh_CN/core-api/index.rst
@@ -52,7 +52,6 @@ Todolist:
    circular-buffers
    generic-radix-tree
    packing
-   bus-virt-phys-mapping
    this_cpu_ops
    timekeeping
    errseq
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7d0d26b5b3f5..97fce7386b00 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -17,7 +17,6 @@ config ALPHA
 	select HAVE_PERF_EVENTS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
-	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
 	select AUTO_IRQ_AFFINITY if SMP
diff --git a/arch/alpha/include/asm/floppy.h b/arch/alpha/include/asm/floppy.h
index 588758685439..64b42d9591fc 100644
--- a/arch/alpha/include/asm/floppy.h
+++ b/arch/alpha/include/asm/floppy.h
@@ -20,7 +20,7 @@
 #define fd_free_dma()           free_dma(FLOPPY_DMA)
 #define fd_clear_dma_ff()       clear_dma_ff(FLOPPY_DMA)
 #define fd_set_dma_mode(mode)   set_dma_mode(FLOPPY_DMA,mode)
-#define fd_set_dma_addr(addr)   set_dma_addr(FLOPPY_DMA,virt_to_bus(addr))
+#define fd_set_dma_addr(addr)   set_dma_addr(FLOPPY_DMA,isa_virt_to_bus(addr))
 #define fd_set_dma_count(count) set_dma_count(FLOPPY_DMA,count)
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index c9cb554fbe54..d277189b2677 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -106,15 +106,15 @@ static inline void * phys_to_virt(unsigned long address)
 extern unsigned long __direct_map_base;
 extern unsigned long __direct_map_size;
 
-static inline unsigned long __deprecated virt_to_bus(volatile void *address)
+static inline unsigned long __deprecated isa_virt_to_bus(volatile void *address)
 {
 	unsigned long phys = virt_to_phys(address);
 	unsigned long bus = phys + __direct_map_base;
 	return phys <= __direct_map_size ? bus : 0;
 }
-#define isa_virt_to_bus virt_to_bus
+#define isa_virt_to_bus isa_virt_to_bus
 
-static inline void * __deprecated bus_to_virt(unsigned long address)
+static inline void * __deprecated isa_bus_to_virt(unsigned long address)
 {
 	void *virt;
 
@@ -125,7 +125,7 @@ static inline void * __deprecated bus_to_virt(unsigned long address)
 	virt = phys_to_virt(address);
 	return (long)address <= 0 ? NULL : virt;
 }
-#define isa_bus_to_virt bus_to_virt
+#define isa_bus_to_virt isa_bus_to_virt
 
 /*
  * There are different chipsets to interface the Alpha CPUs to the world.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index cb93769a9f2a..26ac8ea15a9e 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -39,7 +39,6 @@ config IA64
 	select HAVE_FUNCTION_DESCRIPTORS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HUGETLB_PAGE_SIZE_VARIABLE if HUGETLB_PAGE
-	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 6d93b923b379..ce66dfc0e719 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -96,14 +96,6 @@ extern u64 kern_mem_attribute (unsigned long phys_addr, unsigned long size);
 extern int valid_phys_addr_range (phys_addr_t addr, size_t count); /* efi.c */
 extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
 
-/*
- * The following two macros are deprecated and scheduled for removal.
- * Please use the PCI-DMA interface defined in <asm/pci.h> instead.
- */
-#define bus_to_virt	phys_to_virt
-#define virt_to_bus	virt_to_phys
-#define page_to_bus	page_to_phys
-
 # endif /* KERNEL */
 
 /*
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936cce42ae9a..b06faf6c0b27 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -30,7 +30,6 @@ config M68K
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select UACCESS_MEMCPY if !MMU
-	select VIRT_TO_BUS
 	select ZONE_DMA
 
 config CPU_BIG_ENDIAN
diff --git a/arch/m68k/include/asm/virtconvert.h b/arch/m68k/include/asm/virtconvert.h
index ca91b32dc6ef..0a27905b0036 100644
--- a/arch/m68k/include/asm/virtconvert.h
+++ b/arch/m68k/include/asm/virtconvert.h
@@ -33,9 +33,11 @@ static inline void *phys_to_virt(unsigned long address)
 
 /*
  * IO bus memory addresses are 1:1 with the physical address,
+ * deprecated globally but still used on two machines.
  */
+#if defined(CONFIG_AMIGA) || defined(CONFIG_VME)
 #define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
+#endif
 
 #endif
 #endif
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 8cf429ad1c84..415182eeb082 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -38,7 +38,6 @@ config MICROBLAZE
 	select OF_EARLY_FLATTREE
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
-	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
 	select SPARSE_IRQ
diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
index b6a57f8468f0..c1d78b8977a6 100644
--- a/arch/microblaze/include/asm/io.h
+++ b/arch/microblaze/include/asm/io.h
@@ -30,8 +30,6 @@ extern resource_size_t isa_mem_base;
 #define PCI_IOBASE	((void __iomem *)_IO_BASE)
 #define IO_SPACE_LIMIT (0xFFFFFFFF)
 
-#define page_to_bus(page)	(page_to_phys(page))
-
 extern void iounmap(volatile void __iomem *addr);
 
 extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9457894db237..69f3b9b4677b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -100,7 +100,6 @@ config MIPS
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select TRACE_IRQFLAGS_SUPPORT
-	select VIRT_TO_BUS
 	select ARCH_HAS_ELFCORE_COMPAT
 	select HAVE_ARCH_KCSAN if 64BIT
 
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 6f5c86d2bab4..cd9168f34fb7 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -147,15 +147,6 @@ static inline void *isa_bus_to_virt(unsigned long address)
 	return phys_to_virt(address);
 }
 
-/*
- * However PCI ones are not necessarily 1:1 and therefore these interfaces
- * are forbidden in portable PCI drivers.
- *
- * Allow them for x86 for legacy drivers, though.
- */
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
-
 /*
  * Change "struct page" to physical address.
  */
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 5f2448dc5a2b..b0d68e9e2df0 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -43,7 +43,6 @@ config PARISC
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_MOD_ARCH_SPECIFIC
-	select VIRT_TO_BUS
 	select MODULES_USE_ELF_RELA
 	select CLONE_BACKWARDS
 	select TTY # Needed for pdc_cons.c
diff --git a/arch/parisc/include/asm/floppy.h b/arch/parisc/include/asm/floppy.h
index 762cfe7778c0..b318a7df52f6 100644
--- a/arch/parisc/include/asm/floppy.h
+++ b/arch/parisc/include/asm/floppy.h
@@ -179,7 +179,7 @@ static void _fd_chose_dma_mode(char *addr, unsigned long size)
 {
 	if(can_use_virtual_dma == 2) {
 		if((unsigned int) addr >= (unsigned int) high_memory ||
-		   virt_to_bus(addr) >= 0x1000000 ||
+		   virt_to_phys(addr) >= 0x1000000 ||
 		   _CROSS_64KB(addr, size, 0))
 			use_virtual_dma = 1;
 		else
@@ -215,7 +215,7 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 	doing_pdma = 0;
 	clear_dma_ff(FLOPPY_DMA);
 	set_dma_mode(FLOPPY_DMA,mode);
-	set_dma_addr(FLOPPY_DMA,virt_to_bus(addr));
+	set_dma_addr(FLOPPY_DMA,virt_to_phys(addr));
 	set_dma_count(FLOPPY_DMA,size);
 	enable_dma(FLOPPY_DMA);
 	return 0;
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 837ddddbac6a..42ffb60a6ea9 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -7,8 +7,6 @@
 
 #define virt_to_phys(a) ((unsigned long)__pa(a))
 #define phys_to_virt(a) __va(a)
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
 
 static inline unsigned long isa_bus_to_virt(unsigned long addr) {
 	BUG();
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8f76499919fe..66418dfeb771 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -277,7 +277,6 @@ config PPC
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
-	select VIRT_TO_BUS			if !PPC64
 	#
 	# Please keep this list sorted alphabetically.
 	#
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index c5a5f7c9b231..73fcd5cdb662 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -985,8 +985,6 @@ static inline void * bus_to_virt(unsigned long address)
 }
 #define bus_to_virt bus_to_virt
 
-#define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)
-
 #endif /* CONFIG_PPC32 */
 
 /* access ports */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 1526e410e802..ac70b0fd9a9a 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -167,7 +167,6 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
 
 #define page_to_phys(page)	(pfn_to_phys(page_to_pfn(page)))
-#define page_to_bus(page)	(page_to_phys(page))
 #define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
 
 #define sym_to_pfn(x)           __phys_to_pfn(__pa_symbol(x))
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index abe751626a35..9c50d53fa6e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -279,7 +279,6 @@ config X86
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select USER_STACKTRACE_SUPPORT
-	select VIRT_TO_BUS
 	select HAVE_ARCH_KCSAN			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1870b99c3356..e9025640f634 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -169,15 +169,6 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
 }
 #define isa_bus_to_virt		phys_to_virt
 
-/*
- * However PCI ones are not necessarily 1:1 and therefore these interfaces
- * are forbidden in portable PCI drivers.
- *
- * Allow them on x86 for legacy drivers, though.
- */
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
-
 /*
  * The default ioremap() behavior is non-cached; if you need something
  * else, you probably want one of the following.
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 0b0f0172cced..92a24ed738a5 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -50,7 +50,6 @@ config XTENSA
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select TRACE_IRQFLAGS_SUPPORT
-	select VIRT_TO_BUS
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 54188e69b988..a5b707e1c0f4 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -63,9 +63,6 @@ static inline void iounmap(volatile void __iomem *addr)
 		xtensa_iounmap(addr);
 }
 
-#define virt_to_bus     virt_to_phys
-#define bus_to_virt     phys_to_virt
-
 #endif /* CONFIG_MMU */
 
 #include <asm-generic/io.h>
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..f57015eaed73 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1059,20 +1059,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 }
 #endif
 
-#ifdef CONFIG_VIRT_TO_BUS
-#ifndef virt_to_bus
-static inline unsigned long virt_to_bus(void *address)
-{
-	return (unsigned long)address;
-}
-
-static inline void *bus_to_virt(unsigned long address)
-{
-	return (void *)address;
-}
-#endif
-#endif
-
 #ifndef memset_io
 #define memset_io memset_io
 /**
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..b7a44b17c79f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -639,14 +639,6 @@ config BOUNCE
 	  memory available to the CPU. Enabled by default when HIGHMEM is
 	  selected, but you may say n to override this.
 
-config VIRT_TO_BUS
-	bool
-	help
-	  An architecture should select this if it implements the
-	  deprecated interface virt_to_bus().  All new architectures
-	  should probably not select this.
-
-
 config MMU_NOTIFIER
 	bool
 	select SRCU
-- 
2.29.2

