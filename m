Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84866BBEAB
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCOVP5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjCOVPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 17:15:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3A95E18;
        Wed, 15 Mar 2023 14:15:51 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 498B2378;
        Wed, 15 Mar 2023 21:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 498B2378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678914950; bh=bp9wnAq18A0+juKVo1Js4YF/qFjka3dcKSIzCMqh1OQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kknMgdkuAMTOoDuKrguJtOGWJ7aLTQEeQzurApW+cXl0iHhVUMHUZpwzIJsHS2fOH
         eWjyd2ATo+CztGkskDV+b5Nbj5aCroS6GbrUz2NV9njj/FcfZrC3JDS73vEGIwDh3T
         GHRa1xrhDaSo+f+CGlEvlo9agy7zHPprtYA8CfcP+NAFmUMth5x3kCP+1ArDD/TerA
         pVdrDEGQnubBhRBUqKSC0ColwCmtyqsxTHBXYRjh69tAvQGpn2JjxqiRfDweOKWK7q
         ZIJ41NLQys7oi3Rmdh54++zGJg/Gt4t5kv8uMZ9mBhO1IsnYx/iG7G3heC2n5FAG6x
         uE4OfBngzRiEA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH RFC 0/2] Begin reorganizing the arch documentation
Date:   Wed, 15 Mar 2023 15:15:21 -0600
Message-Id: <20230315211523.108836-1-corbet@lwn.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This two-patch series is a bare beginning of a project to reorganize the
Documentation directory somewhat; it's a toe in the water to see how many
sharks chomp at it.

The top-level Documentation/ directory, despite the efforts of the last few
years, is still a mess; there is too much stuff there, making it harder to
find anything.  We do not organize our source directories that way, and for
good reasons.

To bring the docs closer to the source organization, create a directory
Documentation/arch and move the x86 docs there, updating all of the
internal references that are broken by the move.  The appearance of the
rendered documentation does not change.  I've deliberately not changed
any overly long lines generated to keep the diff easy to read; that can
be fixed up later if warranted.

I can also break the second patch up if maintainers want to handle pieces
of it separately.

I think this move is worthwhile (for the other arches too) because it will
make our documentation better organized in a way that matches the source
and easier to navigate.  It will also make easier to experiment with tools
like intersphinx.

On the other hand, it *is* a fair amount of churn.  If it's more than
people can handle, I'll quietly back away and we'll muddle along as we have
been; this isn't something I'm going to dig in my heels over.

Also, it is worth noting that, while the rendered HTML looks the same,
links that went to Documentation/x86 (on https://kernel.org, say) will be
broken by this change.  We have never considered whether we care about
preserving external links to the rendered docs on kernel.org or not; I
don't think we should break them without thinking about it.

Thoughts?

Thanks,

jon


Jonathan Corbet (2):
  docs: create a top-level arch/ directory
  docs: move x86 documentation into Documentation/arch/

 Documentation/admin-guide/hw-vuln/mds.rst     |  2 +-
 .../admin-guide/hw-vuln/tsx_async_abort.rst   |  2 +-
 .../admin-guide/kernel-parameters.rst         |  6 ++--
 .../admin-guide/kernel-parameters.txt         |  8 +++---
 Documentation/admin-guide/ras.rst             |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst   |  4 +--
 Documentation/arch.rst                        | 28 -------------------
 Documentation/arch/index.rst                  | 28 +++++++++++++++++++
 .../{ => arch}/x86/amd-memory-encryption.rst  |  0
 Documentation/{ => arch}/x86/amd_hsmp.rst     |  0
 Documentation/{ => arch}/x86/boot.rst         |  4 +--
 Documentation/{ => arch}/x86/booting-dt.rst   |  2 +-
 Documentation/{ => arch}/x86/buslock.rst      |  0
 Documentation/{ => arch}/x86/cpuinfo.rst      |  0
 Documentation/{ => arch}/x86/earlyprintk.rst  |  0
 Documentation/{ => arch}/x86/elf_auxvec.rst   |  0
 Documentation/{ => arch}/x86/entry_64.rst     |  0
 .../{ => arch}/x86/exception-tables.rst       |  0
 Documentation/{ => arch}/x86/features.rst     |  0
 Documentation/{ => arch}/x86/i386/IO-APIC.rst |  0
 Documentation/{ => arch}/x86/i386/index.rst   |  0
 Documentation/{ => arch}/x86/ifs.rst          |  0
 Documentation/{ => arch}/x86/index.rst        |  0
 Documentation/{ => arch}/x86/intel-hfi.rst    |  0
 Documentation/{ => arch}/x86/intel_txt.rst    |  0
 Documentation/{ => arch}/x86/iommu.rst        |  0
 .../{ => arch}/x86/kernel-stacks.rst          |  0
 Documentation/{ => arch}/x86/mds.rst          |  0
 Documentation/{ => arch}/x86/microcode.rst    |  0
 Documentation/{ => arch}/x86/mtrr.rst         |  2 +-
 Documentation/{ => arch}/x86/orc-unwinder.rst |  0
 Documentation/{ => arch}/x86/pat.rst          |  0
 Documentation/{ => arch}/x86/pti.rst          |  0
 Documentation/{ => arch}/x86/resctrl.rst      |  0
 Documentation/{ => arch}/x86/sgx.rst          |  0
 Documentation/{ => arch}/x86/sva.rst          |  0
 Documentation/{ => arch}/x86/tdx.rst          |  0
 Documentation/{ => arch}/x86/tlb.rst          |  0
 Documentation/{ => arch}/x86/topology.rst     |  0
 .../{ => arch}/x86/tsx_async_abort.rst        |  0
 .../{ => arch}/x86/usb-legacy-support.rst     |  0
 .../{ => arch}/x86/x86_64/5level-paging.rst   |  2 +-
 .../{ => arch}/x86/x86_64/boot-options.rst    |  4 +--
 .../x86/x86_64/cpu-hotplug-spec.rst           |  0
 .../x86/x86_64/fake-numa-for-cpusets.rst      |  2 +-
 Documentation/{ => arch}/x86/x86_64/fsgs.rst  |  0
 Documentation/{ => arch}/x86/x86_64/index.rst |  0
 .../{ => arch}/x86/x86_64/machinecheck.rst    |  0
 Documentation/{ => arch}/x86/x86_64/mm.rst    |  0
 Documentation/{ => arch}/x86/x86_64/uefi.rst  |  0
 Documentation/{ => arch}/x86/xstate.rst       |  0
 Documentation/{ => arch}/x86/zero-page.rst    |  0
 Documentation/core-api/asm-annotations.rst    |  2 +-
 Documentation/driver-api/device-io.rst        |  2 +-
 Documentation/index.rst                       |  2 +-
 Documentation/virt/kvm/api.rst                |  2 +-
 MAINTAINERS                                   | 12 ++++----
 arch/arm/Kconfig                              |  2 +-
 arch/x86/Kconfig                              | 10 +++----
 arch/x86/Kconfig.debug                        |  2 +-
 arch/x86/boot/header.S                        |  2 +-
 arch/x86/entry/entry_64.S                     |  2 +-
 arch/x86/include/asm/bootparam_utils.h        |  2 +-
 arch/x86/include/asm/page_64_types.h          |  2 +-
 arch/x86/include/asm/pgtable_64_types.h       |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c           |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  2 +-
 arch/x86/kernel/cpu/sgx/sgx.h                 |  2 +-
 arch/x86/kernel/kexec-bzimage64.c             |  2 +-
 arch/x86/kernel/pci-dma.c                     |  2 +-
 arch/x86/mm/pat/set_memory.c                  |  2 +-
 arch/x86/mm/tlb.c                             |  2 +-
 arch/x86/platform/pvh/enlighten.c             |  2 +-
 drivers/vhost/vhost.c                         |  2 +-
 security/Kconfig                              |  2 +-
 tools/include/linux/err.h                     |  2 +-
 tools/objtool/Documentation/objtool.txt       |  2 +-
 77 files changed, 82 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/arch.rst
 create mode 100644 Documentation/arch/index.rst
 rename Documentation/{ => arch}/x86/amd-memory-encryption.rst (100%)
 rename Documentation/{ => arch}/x86/amd_hsmp.rst (100%)
 rename Documentation/{ => arch}/x86/boot.rst (99%)
 rename Documentation/{ => arch}/x86/booting-dt.rst (96%)
 rename Documentation/{ => arch}/x86/buslock.rst (100%)
 rename Documentation/{ => arch}/x86/cpuinfo.rst (100%)
 rename Documentation/{ => arch}/x86/earlyprintk.rst (100%)
 rename Documentation/{ => arch}/x86/elf_auxvec.rst (100%)
 rename Documentation/{ => arch}/x86/entry_64.rst (100%)
 rename Documentation/{ => arch}/x86/exception-tables.rst (100%)
 rename Documentation/{ => arch}/x86/features.rst (100%)
 rename Documentation/{ => arch}/x86/i386/IO-APIC.rst (100%)
 rename Documentation/{ => arch}/x86/i386/index.rst (100%)
 rename Documentation/{ => arch}/x86/ifs.rst (100%)
 rename Documentation/{ => arch}/x86/index.rst (100%)
 rename Documentation/{ => arch}/x86/intel-hfi.rst (100%)
 rename Documentation/{ => arch}/x86/intel_txt.rst (100%)
 rename Documentation/{ => arch}/x86/iommu.rst (100%)
 rename Documentation/{ => arch}/x86/kernel-stacks.rst (100%)
 rename Documentation/{ => arch}/x86/mds.rst (100%)
 rename Documentation/{ => arch}/x86/microcode.rst (100%)
 rename Documentation/{ => arch}/x86/mtrr.rst (99%)
 rename Documentation/{ => arch}/x86/orc-unwinder.rst (100%)
 rename Documentation/{ => arch}/x86/pat.rst (100%)
 rename Documentation/{ => arch}/x86/pti.rst (100%)
 rename Documentation/{ => arch}/x86/resctrl.rst (100%)
 rename Documentation/{ => arch}/x86/sgx.rst (100%)
 rename Documentation/{ => arch}/x86/sva.rst (100%)
 rename Documentation/{ => arch}/x86/tdx.rst (100%)
 rename Documentation/{ => arch}/x86/tlb.rst (100%)
 rename Documentation/{ => arch}/x86/topology.rst (100%)
 rename Documentation/{ => arch}/x86/tsx_async_abort.rst (100%)
 rename Documentation/{ => arch}/x86/usb-legacy-support.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/5level-paging.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/boot-options.rst (98%)
 rename Documentation/{ => arch}/x86/x86_64/cpu-hotplug-spec.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/fake-numa-for-cpusets.rst (97%)
 rename Documentation/{ => arch}/x86/x86_64/fsgs.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/index.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/machinecheck.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/mm.rst (100%)
 rename Documentation/{ => arch}/x86/x86_64/uefi.rst (100%)
 rename Documentation/{ => arch}/x86/xstate.rst (100%)
 rename Documentation/{ => arch}/x86/zero-page.rst (100%)

-- 
2.39.2

