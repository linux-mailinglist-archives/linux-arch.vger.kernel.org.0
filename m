Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9063527FB
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhDBJHC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 05:07:02 -0400
Received: from marcansoft.com ([212.63.210.85]:34572 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234793AbhDBJHA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:07:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7F19642725;
        Fri,  2 Apr 2021 09:06:51 +0000 (UTC)
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
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/18] docs: driver-api: device-io: Document ioremap() variants & access funcs
Date:   Fri,  2 Apr 2021 18:05:33 +0900
Message-Id: <20210402090542.131194-10-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This documents the newly introduced ioremap_np() along with all the
other common ioremap() variants, and some higher-level abstractions
available.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/driver-api/device-io.rst | 218 +++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index b20864b3ddc7..e9f04b1815d1 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -284,6 +284,224 @@ insl, insw, insb, outsl, outsw, outsb
   first byte in the FIFO register corresponds to the first byte in the memory
   buffer regardless of the architecture.
 
+Device memory mapping modes
+===========================
+
+Some architectures support multiple modes for mapping device memory.
+ioremap_*() variants provide a common abstraction around these
+architecture-specific modes, with a shared set of semantics.
+
+ioremap() is the most common mapping type, and is applicable to typical device
+memory (e.g. I/O registers). Other modes can offer weaker or stronger
+guarantees, if supported by the architecture. From most to least common, they
+are as follows:
+
+ioremap()
+---------
+
+The default mode, suitable for most memory-mapped devices, e.g. control
+registers. Memory mapped using ioremap() has the following characteristics:
+
+* Uncached - CPU-side caches are bypassed, and all reads and writes are handled
+  directly by the device
+* No speculative operations - the CPU may not issue a read or write to this
+  memory, unless the instruction that does so has been reached in committed
+  program flow.
+* No reordering - The CPU may not reorder accesses to this memory mapping with
+  respect to each other. On some architectures, this relies on barriers in
+  readl_relaxed()/writel_relaxed().
+* No repetition - The CPU may not issue multiple reads or writes for a single
+  program instruction.
+* No write-combining - Each I/O operation results in one discrete read or write
+  being issued to the device, and multiple writes are not combined into larger
+  writes. This may or may not be enforced when using __raw I/O accessors or
+  pointer dereferences.
+* Non-executable - The CPU is not allowed to speculate instruction execution
+  from this memory (it probably goes without saying, but you're also not
+  allowed to jump into device memory).
+
+On many platforms and buses (e.g. PCI), writes issued through ioremap()
+mappings are posted, which means that the CPU does not wait for the write to
+actually reach the target device before retiring the write instruction.
+
+On many platforms, I/O accesses must be aligned with respect to the access
+size; failure to do so will result in an exception or unpredictable results.
+
+ioremap_wc()
+------------
+
+Maps I/O memory as normal memory with write combining. Unlike ioremap(),
+
+* The CPU may speculatively issue reads from the device that the program
+  didn't actually execute, and may choose to basically read whatever it wants.
+* The CPU may reorder operations as long as the result is consistent from the
+  program's point of view.
+* The CPU may write to the same location multiple times, even when the program
+  issued a single write.
+* The CPU may combine several writes into a single larger write.
+
+This mode is typically used for video framebuffers, where it can increase
+performance of writes. It can also be used for other blocks of memory in
+devices (e.g. buffers or shared memory), but care must be taken as accesses are
+not guaranteed to be ordered with respect to normal ioremap() MMIO register
+accesses without explicit barriers.
+
+On a PCI bus, it is usually safe to use ioremap_wc() on MMIO areas marked as
+``IORESOURCE_PREFETCH``, but it may not be used on those without the flag.
+For on-chip devices, there is no corresponding flag, but a driver can use
+ioremap_wc() on a device that is known to be safe.
+
+ioremap_wt()
+------------
+
+Maps I/O memory as normal memory with write-through caching. Like ioremap_wc(),
+but also,
+
+* The CPU may cache writes issued to and reads from the device, and serve reads
+  from that cache.
+
+This mode is sometimes used for video framebuffers, where drivers still expect
+writes to reach the device in a timely manner (and not be stuck in the CPU
+cache), but reads may be served from the cache for efficiency. However, it is
+rarely useful these days, as framebuffer drivers usually perform writes only,
+for which ioremap_wc() is more efficient (as it doesn't needlessly trash the
+cache). Most drivers should not use this.
+
+ioremap_np()
+------------
+
+Like ioremap(), but explicitly requests non-posted write semantics. On some
+architectures and buses, ioremap() mappings have posted write semantics, which
+means that writes can appear to "complete" from the point of view of the
+CPU before the written data actually arrives at the target device. Writes are
+still ordered with respect to other writes and reads from the same device, but
+due to the posted write semantics, this is not the case with respect to other
+devices. ioremap_np() explicitly requests non-posted semantics, which means
+that the write instruction will not appear to complete until the device has
+received (and to some platform-specific extent acknowledged) the written data.
+
+This mapping mode primarily exists to cater for platforms with bus fabrics that
+require this particular mapping mode to work correctly. These platforms set the
+``IORESOURCE_MEM_NONPOSTED`` flag for a resource that requires ioremap_np()
+semantics and portable drivers should use an abstraction that automatically
+selects it where appropriate (see the `Higher-level ioremap abstractions`_
+section below).
+
+The bare ioremap_np() is only available on some architectures; on others, it
+always returns NULL. Drivers should not normally use it, unless they are
+platform-specific or they derive benefit from non-posted writes where
+supported, and can fall back to ioremap() otherwise. The normal approach to
+ensure posted write completion is to do a dummy read after a write as
+explained in `Accessing the device`_, which works with ioremap() on all
+platforms.
+
+ioremap_np() should never be used for PCI drivers. PCI memory space writes are
+always posted, even on architectures that otherwise implement ioremap_np().
+Using ioremap_np() for PCI BARs will at best result in posted write semantics,
+and at worst result in complete breakage.
+
+Note that non-posted write semantics are orthogonal to CPU-side ordering
+guarantees. A CPU may still choose to issue other reads or writes before a
+non-posted write instruction retires. See the previous section on MMIO access
+functions for details on the CPU side of things.
+
+ioremap_uc()
+------------
+
+ioremap_uc() behaves like ioremap() except that on the x86 architecture without
+'PAT' mode, it marks memory as uncached even when the MTRR has designated
+it as cacheable, see Documentation/x86/pat.rst.
+
+Portable drivers should avoid the use of ioremap_uc().
+
+ioremap_cache()
+---------------
+
+ioremap_cache() effectively maps I/O memory as normal RAM. CPU write-back
+caches can be used, and the CPU is free to treat the device as if it were a
+block of RAM. This should never be used for device memory which has side
+effects of any kind, or which does not return the data previously written on
+read.
+
+It should also not be used for actual RAM, as the returned pointer is an
+``__iomem`` token. memremap() can be used for mapping normal RAM that is outside
+of the linear kernel memory area to a regular pointer.
+
+Portable drivers should avoid the use of ioremap_cache().
+
+Architecture example
+--------------------
+
+Here is how the above modes map to memory attribute settings on the ARM64
+architecture:
+
++------------------------+--------------------------------------------+
+| API                    | Memory region type and cacheability        |
++------------------------+--------------------------------------------+
+| ioremap_np()           | Device-nGnRnE                              |
++------------------------+--------------------------------------------+
+| ioremap()              | Device-nGnRE                               |
++------------------------+--------------------------------------------+
+| ioremap_uc()           | (not implemented)                          |
++------------------------+--------------------------------------------+
+| ioremap_wc()           | Normal-Non Cacheable                       |
++------------------------+--------------------------------------------+
+| ioremap_wt()           | (not implemented; fallback to ioremap)     |
++------------------------+--------------------------------------------+
+| ioremap_cache()        | Normal-Write-Back Cacheable                |
++------------------------+--------------------------------------------+
+
+Higher-level ioremap abstractions
+=================================
+
+Instead of using the above raw ioremap() modes, drivers are encouraged to use
+higher-level APIs. These APIs may implement platform-specific logic to
+automatically choose an appropriate ioremap mode on any given bus, allowing for
+a platform-agnostic driver to work on those platforms without any special
+cases. At the time of this writing, the following ioremap() wrappers have such
+logic:
+
+devm_ioremap_resource()
+
+  Can automatically select ioremap_np() over ioremap() according to platform
+  requirements, if the ``IORESOURCE_MEM_NONPOSTED`` flag is set on the struct
+  resource. Uses devres to automatically unmap the resource when the driver
+  probe() function fails or a device in unbound from its driver.
+
+  Documented in Documentation/driver-api/driver-model/devres.rst.
+
+of_address_to_resource()
+
+  Automatically sets the ``IORESOURCE_MEM_NONPOSTED`` flag for platforms that
+  require non-posted writes for certain buses (see the nonposted-mmio and
+  posted-mmio device tree properties).
+
+of_iomap()
+
+  Maps the resource described in a ``reg`` property in the device tree, doing
+  all required translations. Automatically selects ioremap_np() according to
+  platform requirements, as above.
+
+pci_ioremap_bar(), pci_ioremap_wc_bar()
+
+  Maps the resource described in a PCI base address without having to extract
+  the physical address first.
+
+pci_iomap(), pci_iomap_wc()
+
+  Like pci_ioremap_bar()/pci_ioremap_bar(), but also works on I/O space when
+  used together with ioread32()/iowrite32() and similar accessors
+
+pcim_iomap()
+
+  Like pci_iomap(), but uses devres to automatically unmap the resource when
+  the driver probe() function fails or a device in unbound from its driver
+
+  Documented in Documentation/driver-api/driver-model/devres.rst.
+
+Not using these wrappers may make drivers unusable on certain platforms with
+stricter rules for mapping I/O memory.
+
 Public Functions Provided
 =========================
 
-- 
2.30.0

