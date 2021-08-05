Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C196E3E0B69
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhHEAxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 20:53:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:12119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhHEAxf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 20:53:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201215413"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201215413"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437617163"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 17:53:17 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 00/15] Add TDX Guest Support (shared-mm support)
Date:   Wed,  4 Aug 2021 17:52:03 -0700
Message-Id: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. Since VMM is untrusted entity, it does
not allow VMM to access guest private memory. Any memory that is required
for communication with VMM must be shared explicitly. This series adds
support to securely share guest memory with VMM when it is required by
guest.

Originally TDX did automatic sharing of every ioremap. But it was found that
this ends up with a lot of memory shared that is supposed to be private, for
example ACPI tables. Also in general since only a few drivers are expected
to be used it's safer to mark them explicitly (for virtio it actually only
needs two places). This gives the advantage of automatically preventing
other drivers from doing MMIO, which can happen in some cases even with
the device filter. There is still a command line option to override this option,
which allows to use all drivers.

This series is the continuation of the patch series titled "Add TDX Guest
Support (Initial support)", "Add TDX Guest Support (#VE handler support)"
and "Add TDX Guest Support (boot fixes)" which added initial support,
 #VE handler support and boot fixes for TDX guests. You  can find the
related patchsets in the following links.

[set 1, v5] - https://lore.kernel.org/patchwork/project/lkml/list/?series=510805
[set 2, v4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=510814
[set 3, v4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=510816

Also please note that this series alone is not necessarily fully
functional. You need to apply all the above 3 patch series to get
a fully functional TDX guest.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Also, ioremap related changes in mips, parisc, alpha, sparch archs' are
only compile tested, and hence need help from the community users of these
archs' to make sure that it does not break any functionality.

In this patch series, following patches are in PCI domain and are
meant for the PCI domain reviewers.

  pci: Consolidate pci_iomap* and pci_iomap*wc
  pci: Add pci_iomap_shared{,_range}
  pci: Mark MSI data shared

Patch titled "asm/io.h: Add ioremap_shared fallback" adds generic
and arch specific ioremap_shared headers and are meant to be reviewed
by linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
sparclinux@vger.kernel.org.

Similarly patch titled "virtio: Use shared mappings for virtio
PCI devices" adds ioremap_shared() support for virtio drivers
and are meant to be reviewed by virtio driver maintainers.

I have CCed this patch series to all the related domain maintainers
and open lists. If you prefer to get only patches specific to your
domain, please let me know. I will fix this in next submission.

Changes since v3:
 * Rebased on top of Tom Lendacky's protected guest
   changes (https://lore.kernel.org/patchwork/cover/1468760/)
 * Added new API to share io-reamapped memory selectively
   (using ioremap_shared())
 * Added new wrapper (pci_iomap_shared_range()) for PCI IO
   remap shared mappings use case.

Changes since v2:
 * Rebased on top of v5.14-rc1.
 * No functional changes.

Andi Kleen (6):
  pci: Consolidate pci_iomap* and pci_iomap*wc
  asm/io.h: Add ioremap_shared fallback
  pci: Add pci_iomap_shared{,_range}
  pci: Mark MSI data shared
  virtio: Use shared mappings for virtio PCI devices
  x86/tdx: Implement ioremap_shared for x86

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (6):
  x86/mm: Move force_dma_unencrypted() to common code
  x86/tdx: Exclude Shared bit from physical_mask
  x86/tdx: Make pages shared in ioremap()
  x86/tdx: Add helper to do MapGPA hypercall
  x86/tdx: Make DMA pages shared
  x86/kvm: Use bounce buffers for TD guest

Kuppuswamy Sathyanarayanan (2):
  x86/tdx: Enable shared memory protected guest flags for TDX guest
  x86/tdx: Add cmdline option to force use of ioremap_shared

 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |  12 ++
 arch/alpha/include/asm/io.h                   |   1 +
 arch/mips/include/asm/io.h                    |   1 +
 arch/parisc/include/asm/io.h                  |   1 +
 arch/sparc/include/asm/io_64.h                |   1 +
 arch/x86/Kconfig                              |   9 +-
 arch/x86/include/asm/io.h                     |   5 +
 arch/x86/include/asm/mem_encrypt_common.h     |  20 +++
 arch/x86/include/asm/pgtable.h                |   5 +
 arch/x86/include/asm/tdx.h                    |  22 +++
 arch/x86/kernel/apic/io_apic.c                |  18 ++-
 arch/x86/kernel/tdx.c                         |  64 +++++++++
 arch/x86/mm/Makefile                          |   2 +
 arch/x86/mm/ioremap.c                         |  64 +++++++--
 arch/x86/mm/mem_encrypt.c                     |   8 +-
 arch/x86/mm/mem_encrypt_common.c              |  38 ++++++
 arch/x86/mm/pat/set_memory.c                  |  45 ++++++-
 drivers/pci/msi.c                             |   2 +-
 drivers/virtio/virtio_pci_modern_dev.c        |   2 +-
 include/asm-generic/io.h                      |   4 +
 include/asm-generic/pci_iomap.h               |   6 +
 include/linux/protected_guest.h               |   1 +
 lib/pci_iomap.c                               | 125 +++++++++++++-----
 24 files changed, 393 insertions(+), 64 deletions(-)
 create mode 100644 arch/x86/include/asm/mem_encrypt_common.h
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

-- 
2.25.1

