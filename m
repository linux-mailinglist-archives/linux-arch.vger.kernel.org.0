Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D293527F9
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhDBJG5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:06:57 -0400
Received: from marcansoft.com ([212.63.210.85]:34516 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234744AbhDBJGz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:06:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9B3B242720;
        Fri,  2 Apr 2021 09:06:44 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 08/18] docs: driver-api: device-io: Document I/O access functions
Date:   Fri,  2 Apr 2021 18:05:32 +0900
Message-Id: <20210402090542.131194-9-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This adds more detailed descriptions of the various read/write
primitives available for use with I/O memory/ports.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/driver-api/device-io.rst | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 764963876d08..b20864b3ddc7 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -146,6 +146,144 @@ There are also equivalents to memcpy. The ins() and
 outs() functions copy bytes, words or longs to the given
 port.
 
+__iomem pointer tokens
+======================
+
+The data type for an MMIO address is an ``__iomem`` qualified pointer, such as
+``void __iomem *reg``. On most architectures it is a regular pointer that
+points to a virtual memory address and can be offset or dereferenced, but in
+portable code, it must only be passed from and to functions that explicitly
+operated on an ``__iomem`` token, in particular the ioremap() and
+readl()/writel() functions. The 'sparse' semantic code checker can be used to
+verify that this is done correctly.
+
+While on most architectures, ioremap() creates a page table entry for an
+uncached virtual address pointing to the physical MMIO address, some
+architectures require special instructions for MMIO, and the ``__iomem`` pointer
+just encodes the physical address or an offsettable cookie that is interpreted
+by readl()/writel().
+
+Differences between I/O access functions
+========================================
+
+readq(), readl(), readw(), readb(), writeq(), writel(), writew(), writeb()
+
+  These are the most generic accessors, providing serialization against other
+  MMIO accesses and DMA accesses as well as fixed endianness for accessing
+  little-endian PCI devices and on-chip peripherals. Portable device drivers
+  should generally use these for any access to ``__iomem`` pointers.
+
+  Note that posted writes are not strictly ordered against a spinlock, see
+  Documentation/driver-api/io_ordering.rst.
+
+readq_relaxed(), readl_relaxed(), readw_relaxed(), readb_relaxed(),
+writeq_relaxed(), writel_relaxed(), writew_relaxed(), writeb_relaxed()
+
+  On architectures that require an expensive barrier for serializing against
+  DMA, these "relaxed" versions of the MMIO accessors only serialize against
+  each other, but contain a less expensive barrier operation. A device driver
+  might use these in a particularly performance sensitive fast path, with a
+  comment that explains why the usage in a specific location is safe without
+  the extra barriers.
+
+  See memory-barriers.txt for a more detailed discussion on the precise ordering
+  guarantees of the non-relaxed and relaxed versions.
+
+ioread64(), ioread32(), ioread16(), ioread8(),
+iowrite64(), iowrite32(), iowrite16(), iowrite8()
+
+  These are an alternative to the normal readl()/writel() functions, with almost
+  identical behavior, but they can also operate on ``__iomem`` tokens returned
+  for mapping PCI I/O space with pci_iomap() or ioport_map(). On architectures
+  that require special instructions for I/O port access, this adds a small
+  overhead for an indirect function call implemented in lib/iomap.c, while on
+  other architectures, these are simply aliases.
+
+ioread64be(), ioread32be(), ioread16be()
+iowrite64be(), iowrite32be(), iowrite16be()
+
+  These behave in the same way as the ioread32()/iowrite32() family, but with
+  reversed byte order, for accessing devices with big-endian MMIO registers.
+  Device drivers that can operate on either big-endian or little-endian
+  registers may have to implement a custom wrapper function that picks one or
+  the other depending on which device was found.
+
+  Note: On some architectures, the normal readl()/writel() functions
+  traditionally assume that devices are the same endianness as the CPU, while
+  using a hardware byte-reverse on the PCI bus when running a big-endian kernel.
+  Drivers that use readl()/writel() this way are generally not portable, but
+  tend to be limited to a particular SoC.
+
+hi_lo_readq(), lo_hi_readq(), hi_lo_readq_relaxed(), lo_hi_readq_relaxed(),
+ioread64_lo_hi(), ioread64_hi_lo(), ioread64be_lo_hi(), ioread64be_hi_lo(),
+hi_lo_writeq(), lo_hi_writeq(), hi_lo_writeq_relaxed(), lo_hi_writeq_relaxed(),
+iowrite64_lo_hi(), iowrite64_hi_lo(), iowrite64be_lo_hi(), iowrite64be_hi_lo()
+
+  Some device drivers have 64-bit registers that cannot be accessed atomically
+  on 32-bit architectures but allow two consecutive 32-bit accesses instead.
+  Since it depends on the particular device which of the two halves has to be
+  accessed first, a helper is provided for each combination of 64-bit accessors
+  with either low/high or high/low word ordering. A device driver must include
+  either <linux/io-64-nonatomic-lo-hi.h> or <linux/io-64-nonatomic-hi-lo.h> to
+  get the function definitions along with helpers that redirect the normal
+  readq()/writeq() to them on architectures that do not provide 64-bit access
+  natively.
+
+__raw_readq(), __raw_readl(), __raw_readw(), __raw_readb(),
+__raw_writeq(), __raw_writel(), __raw_writew(), __raw_writeb()
+
+  These are low-level MMIO accessors without barriers or byteorder changes and
+  architecture specific behavior. Accesses are usually atomic in the sense that
+  a four-byte __raw_readl() does not get split into individual byte loads, but
+  multiple consecutive accesses can be combined on the bus. In portable code, it
+  is only safe to use these to access memory behind a device bus but not MMIO
+  registers, as there are no ordering guarantees with regard to other MMIO
+  accesses or even spinlocks. The byte order is generally the same as for normal
+  memory, so unlike the other functions, these can be used to copy data between
+  kernel memory and device memory.
+
+inl(), inw(), inb(), outl(), outw(), outb()
+
+  PCI I/O port resources traditionally require separate helpers as they are
+  implemented using special instructions on the x86 architecture. On most other
+  architectures, these are mapped to readl()/writel() style accessors
+  internally, usually pointing to a fixed area in virtual memory. Instead of an
+  ``__iomem`` pointer, the address is a 32-bit integer token to identify a port
+  number. PCI requires I/O port access to be non-posted, meaning that an outb()
+  must complete before the following code executes, while a normal writeb() may
+  still be in progress. On architectures that correctly implement this, I/O port
+  access is therefore ordered against spinlocks. Many non-x86 PCI host bridge
+  implementations and CPU architectures however fail to implement non-posted I/O
+  space on PCI, so they can end up being posted on such hardware.
+
+  In some architectures, the I/O port number space has a 1:1 mapping to
+  ``__iomem`` pointers, but this is not recommended and device drivers should
+  not rely on that for portability. Similarly, an I/O port number as described
+  in a PCI base address register may not correspond to the port number as seen
+  by a device driver. Portable drivers need to read the port number for the
+  resource provided by the kernel.
+
+  There are no direct 64-bit I/O port accessors, but pci_iomap() in combination
+  with ioread64/iowrite64 can be used instead.
+
+inl_p(), inw_p(), inb_p(), outl_p(), outw_p(), outb_p()
+
+  On ISA devices that require specific timing, the _p versions of the I/O
+  accessors add a small delay. On architectures that do not have ISA buses,
+  these are aliases to the normal inb/outb helpers.
+
+readsq, readsl, readsw, readsb
+writesq, writesl, writesw, writesb
+ioread64_rep, ioread32_rep, ioread16_rep, ioread8_rep
+iowrite64_rep, iowrite32_rep, iowrite16_rep, iowrite8_rep
+insl, insw, insb, outsl, outsw, outsb
+
+  These are helpers that access the same address multiple times, usually to copy
+  data between kernel memory byte stream and a FIFO buffer. Unlike the normal
+  MMIO accessors, these do not perform a byteswap on big-endian kernels, so the
+  first byte in the FIFO register corresponds to the first byte in the memory
+  buffer regardless of the architecture.
+
 Public Functions Provided
 =========================
 
-- 
2.30.0

