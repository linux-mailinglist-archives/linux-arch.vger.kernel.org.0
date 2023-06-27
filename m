Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A277403F3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjF0TRe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjF0TRd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 15:17:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211ABE6C;
        Tue, 27 Jun 2023 12:17:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5482D379;
        Tue, 27 Jun 2023 19:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5482D379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687893451; bh=HtMhJa4GsclKvK3rE+gtegHehvDpoPX4rQp4mI/ZonM=;
        h=From:To:Cc:Subject:Date:From;
        b=nF6pm+4pfkm2Spf7xeJ4tTd1sxP9UynePsd4Mph6b30a6Zu4gJs2LlmuURr6eXLtt
         8b0TcOws93EbTI059HPMI+okwySmsP8ILtqTruXxefkZR2ptvTp+gAadaWi6zRvyHQ
         XL6vYB41FTMM1Pe8groLxlJD05dARTW1CCMlrq/hbXEVB7KhynovI8+wIMKrpBqvv1
         taizRABHA+hod7vcUMgW2ZeW66qmC3J/nSiK3DRRAHidqmoNavnx7toNraYHVtYs2P
         I5NG8VzQ/KWD5RWdXEuzyHDQqGDp9yw/zUHDn5dcD2ljScadDnHWg8UJ0hS9KBy3Hh
         PGD/NVWDMSIBg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: [GIT PULL] Move arm64 documentation under Documentation/arch
Date:   Tue, 27 Jun 2023 13:17:29 -0600
Message-ID: <871qhwemuu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit f8c25662028b38f31f55f9c5d8da45a75dbf094a:

  dt-bindings: Update Documentation/arm references (2023-06-16 08:32:06 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-arm64-move

for you to fetch changes up to f40f97aaf7fa6222f4ec073c24fb14f04ffb6f80:

  perf arm-spe: Fix a dangling Documentation/arm64 reference (2023-06-21 08:53:31 -0600)

----------------------------------------------------------------
Move the arm64 architecture documentation under Documentation/arch/.  This
brings some order to the documentation directory, declutters the top-level
directory, and makes the documentation organization more closely match that
of the source.

This move generates a couple of last-minute conflicts with the arm64
tree (and, thus, mainline).  They are easy enough to resolve by just
adding the changed files in the new location.

(This is the last such move for this cycle)
----------------------------------------------------------------
Jonathan Corbet (5):
      docs: arm64: Move arm64 documentation under Documentation/arch/
      dt-bindings: fix dangling Documentation/arm64 reference
      arm64: Fix dangling references to Documentation/arm64
      mm: Fix a dangling Documentation/arm64 reference
      perf arm-spe: Fix a dangling Documentation/arm64 reference

 Documentation/ABI/testing/sysfs-devices-system-cpu           |  2 +-
 Documentation/admin-guide/kernel-parameters.txt              |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst                  |  2 +-
 Documentation/{ => arch}/arm64/acpi_object_usage.rst         |  0
 Documentation/{ => arch}/arm64/amu.rst                       |  0
 Documentation/{ => arch}/arm64/arm-acpi.rst                  |  2 +-
 Documentation/{ => arch}/arm64/asymmetric-32bit.rst          |  0
 Documentation/{ => arch}/arm64/booting.rst                   |  0
 Documentation/{ => arch}/arm64/cpu-feature-registers.rst     |  0
 Documentation/{ => arch}/arm64/elf_hwcaps.rst                | 12 ++++++------
 Documentation/{ => arch}/arm64/features.rst                  |  0
 Documentation/{ => arch}/arm64/hugetlbpage.rst               |  0
 Documentation/{ => arch}/arm64/index.rst                     |  0
 Documentation/{ => arch}/arm64/kasan-offsets.sh              |  0
 Documentation/{ => arch}/arm64/legacy_instructions.rst       |  0
 Documentation/{ => arch}/arm64/memory-tagging-extension.rst  |  2 +-
 Documentation/{ => arch}/arm64/memory.rst                    |  0
 Documentation/{ => arch}/arm64/perf.rst                      |  0
 Documentation/{ => arch}/arm64/pointer-authentication.rst    |  0
 Documentation/{ => arch}/arm64/silicon-errata.rst            |  0
 Documentation/{ => arch}/arm64/sme.rst                       |  2 +-
 Documentation/{ => arch}/arm64/sve.rst                       |  2 +-
 Documentation/{ => arch}/arm64/tagged-address-abi.rst        |  2 +-
 Documentation/{ => arch}/arm64/tagged-pointers.rst           |  2 +-
 Documentation/arch/index.rst                                 |  2 +-
 Documentation/devicetree/bindings/cpu/idle-states.yaml       |  2 +-
 Documentation/translations/zh_CN/{ => arch}/arm64/amu.rst    |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/booting.txt          |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/elf_hwcaps.rst       | 10 +++++-----
 .../translations/zh_CN/{ => arch}/arm64/hugetlbpage.rst      |  4 ++--
 Documentation/translations/zh_CN/{ => arch}/arm64/index.rst  |  4 ++--
 .../zh_CN/{ => arch}/arm64/legacy_instructions.txt           |  4 ++--
 Documentation/translations/zh_CN/{ => arch}/arm64/memory.txt |  4 ++--
 Documentation/translations/zh_CN/{ => arch}/arm64/perf.rst   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/silicon-errata.txt   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/tagged-pointers.txt  |  4 ++--
 Documentation/translations/zh_CN/arch/index.rst              |  2 +-
 Documentation/translations/zh_TW/{ => arch}/arm64/amu.rst    |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/booting.txt          |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/elf_hwcaps.rst       | 10 +++++-----
 .../translations/zh_TW/{ => arch}/arm64/hugetlbpage.rst      |  4 ++--
 Documentation/translations/zh_TW/{ => arch}/arm64/index.rst  |  4 ++--
 .../zh_TW/{ => arch}/arm64/legacy_instructions.txt           |  4 ++--
 Documentation/translations/zh_TW/{ => arch}/arm64/memory.txt |  4 ++--
 Documentation/translations/zh_TW/{ => arch}/arm64/perf.rst   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/silicon-errata.txt   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/tagged-pointers.txt  |  4 ++--
 Documentation/translations/zh_TW/index.rst                   |  2 +-
 Documentation/virt/kvm/api.rst                               |  2 +-
 MAINTAINERS                                                  |  2 +-
 arch/arm64/Kconfig                                           |  4 ++--
 arch/arm64/include/asm/efi.h                                 |  2 +-
 arch/arm64/include/asm/image.h                               |  2 +-
 arch/arm64/include/uapi/asm/sigcontext.h                     |  2 +-
 arch/arm64/kernel/kexec_image.c                              |  2 +-
 mm/mremap.c                                                  |  3 ++-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c            |  2 +-
 57 files changed, 76 insertions(+), 75 deletions(-)
 rename Documentation/{ => arch}/arm64/acpi_object_usage.rst (100%)
 rename Documentation/{ => arch}/arm64/amu.rst (100%)
 rename Documentation/{ => arch}/arm64/arm-acpi.rst (99%)
 rename Documentation/{ => arch}/arm64/asymmetric-32bit.rst (100%)
 rename Documentation/{ => arch}/arm64/booting.rst (100%)
 rename Documentation/{ => arch}/arm64/cpu-feature-registers.rst (100%)
 rename Documentation/{ => arch}/arm64/elf_hwcaps.rst (96%)
 rename Documentation/{ => arch}/arm64/features.rst (100%)
 rename Documentation/{ => arch}/arm64/hugetlbpage.rst (100%)
 rename Documentation/{ => arch}/arm64/index.rst (100%)
 rename Documentation/{ => arch}/arm64/kasan-offsets.sh (100%)
 rename Documentation/{ => arch}/arm64/legacy_instructions.rst (100%)
 rename Documentation/{ => arch}/arm64/memory-tagging-extension.rst (99%)
 rename Documentation/{ => arch}/arm64/memory.rst (100%)
 rename Documentation/{ => arch}/arm64/perf.rst (100%)
 rename Documentation/{ => arch}/arm64/pointer-authentication.rst (100%)
 rename Documentation/{ => arch}/arm64/silicon-errata.rst (100%)
 rename Documentation/{ => arch}/arm64/sme.rst (99%)
 rename Documentation/{ => arch}/arm64/sve.rst (99%)
 rename Documentation/{ => arch}/arm64/tagged-address-abi.rst (99%)
 rename Documentation/{ => arch}/arm64/tagged-pointers.rst (98%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/amu.rst (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/booting.txt (98%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/elf_hwcaps.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/hugetlbpage.rst (91%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/index.rst (63%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/legacy_instructions.txt (95%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/memory.txt (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/perf.rst (96%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/silicon-errata.txt (97%)
 rename Documentation/translations/zh_CN/{ => arch}/arm64/tagged-pointers.txt (94%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/amu.rst (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/booting.txt (98%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/elf_hwcaps.rst (94%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/hugetlbpage.rst (91%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/index.rst (71%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/legacy_instructions.txt (96%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/memory.txt (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/perf.rst (96%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/silicon-errata.txt (97%)
 rename Documentation/translations/zh_TW/{ => arch}/arm64/tagged-pointers.txt (95%)
