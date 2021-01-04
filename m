Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E612E9E71
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhADT7j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 14:59:39 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38829 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhADT7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 14:59:39 -0500
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7DD92E0009;
        Mon,  4 Jan 2021 19:58:53 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 00/12] Introduce sv48 support without relocable kernel
Date:   Mon,  4 Jan 2021 14:58:28 -0500
Message-Id: <20210104195840.1593-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset, contrary to the previous versions, allows to have a single        
kernel for sv39 and sv48 without being relocatable.                              
                                                                                 
The idea comes from Arnd Bergmann who suggested to do the same as x86,           
that is mapping the kernel to the end of the address space, which allows         
the kernel to be linked at the same address for both sv39 and sv48 and           
then does not require to be relocated at runtime.                                
                                                                                 
This is an RFC because I need to at least rebase a few commits and add           
documentation. The most interesting patches where I expect feedbacks are         
1/12, 2/12 and 8/12. Note that moving the kernel out of the linear
mapping and sv48 support can be separate patchsets, I share them together
today to show that it works (this patchset is rebased on top of v5.10). 

If we agree about the overall idea, I'll rebase my relocatable patchset
on top of that and then KASLR implementation from Zong will be greatly
simplified since moving the kernel out of the linear mapping will avoid
to copy the kernel physically. 
                                                                                 
This implements sv48 support at runtime. The kernel will try to                  
boot with 4-level page table and will fallback to 3-level if the HW does not     
support it. Folding the 4th level into a 3-level page table has almost no        
cost at runtime.                                                                 
                                                                                 
Finally, the user can now ask for sv39 explicitly by using the device-tree       
which will reduce memory footprint and reduce the number of memory accesses      
in case of TLB miss.   

Alexandre Ghiti (12):
  riscv: Move kernel mapping outside of linear mapping
  riscv: Protect the kernel linear mapping
  riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
  riscv: Allow to dynamically define VA_BITS
  riscv: Simplify MAXPHYSMEM config
  riscv: Prepare ptdump for vm layout dynamic addresses
  asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
  riscv: Implement sv48 support
  riscv: Allow user to downgrade to sv39 when hw supports sv48
  riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
  riscv: Explicit comment about user virtual address space size
  riscv: Improve virtual kernel memory layout dump

 arch/riscv/Kconfig                      |  34 +--
 arch/riscv/boot/loader.lds.S            |   3 +-
 arch/riscv/include/asm/csr.h            |   3 +-
 arch/riscv/include/asm/fixmap.h         |   3 +
 arch/riscv/include/asm/page.h           |  33 ++-
 arch/riscv/include/asm/pgalloc.h        |  40 +++
 arch/riscv/include/asm/pgtable-64.h     | 104 ++++++-
 arch/riscv/include/asm/pgtable.h        |  68 +++--
 arch/riscv/include/asm/sparsemem.h      |   6 +-
 arch/riscv/kernel/cpu.c                 |  23 +-
 arch/riscv/kernel/head.S                |   6 +-
 arch/riscv/kernel/module.c              |   4 +-
 arch/riscv/kernel/vmlinux.lds.S         |   3 +-
 arch/riscv/mm/context.c                 |   2 +-
 arch/riscv/mm/init.c                    | 376 ++++++++++++++++++++----
 arch/riscv/mm/physaddr.c                |   2 +-
 arch/riscv/mm/ptdump.c                  |  56 +++-
 drivers/firmware/efi/libstub/efi-stub.c |   2 +-
 include/asm-generic/pgalloc.h           |  24 +-
 include/linux/sizes.h                   |   3 +-
 20 files changed, 648 insertions(+), 147 deletions(-)

-- 
2.20.1

