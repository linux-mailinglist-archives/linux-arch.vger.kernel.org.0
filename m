Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7872DE20
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbjFMJqx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbjFMJqt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 05:46:49 -0400
X-Greylist: delayed 76041 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 02:46:24 PDT
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB21BC0;
        Tue, 13 Jun 2023 02:46:23 -0700 (PDT)
Received: from tp8.. (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6FA294B0;
        Tue, 13 Jun 2023 09:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FA294B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686649581; bh=GcZgfIzn8xAVlbIW6Jc8AqrOLhvyHycI+sUeRN/Ztdg=;
        h=From:To:Cc:Subject:Date:From;
        b=MqKKpF76yPytU8zDF5R0t4nVkAqzCiQV5b+ascDKojw7tIQua+YOl+izTEqd0MR0t
         hqeI1B7HjdKrHf198sItqInI0LpYtQ0AVKUb0QhFZVdJbm3FjnmA2chG/5UnXt2MIT
         5FsczpiKKr+vvP9u5CVyTuJ7e+rwvTqIr65oNVccvYYrd6O40sK1BJv4EwYC1iZVwj
         uUQHBqe0GwTqLFUJWnAO1xjR3chAYdAM4LhLOGW2k4Tl162UdxK+GMARGOA12lXy8O
         tJSxC3xICLibfAk4MBEw1utzOCh86J01y6nRhe+dr+4/mRZhgrVk68kNoP4gfockGF
         w4Th/7W3cXP8g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/5] arm64: docs: Move the arm64 docs under Documentation/arch/
Date:   Tue, 13 Jun 2023 03:46:01 -0600
Message-Id: <20230613094606.334687-1-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture-specific documentation is being moved into Documentation/arch/
as a way of cleaning up the top-level documentation directory and making
the docs hierarchy more closely match the source hierarchy.  Move
Documentation/arm64 into arch/ and fix all in-tree references.

Jonathan Corbet (5):
  docs: arm64: Move arm64 documentation under Documentation/arch/
  dt-bindings: fix dangling Documentation/arm64 reference
  arm64: Fix dangling references to Documentation/arm64
  mm: Fix a dangling Documentation/arm64 reference
  perf arm-spe: Fix a dangling Documentation/arm64 reference

 Documentation/ABI/testing/sysfs-devices-system-cpu   |  2 +-
 Documentation/admin-guide/kernel-parameters.txt      |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst          |  2 +-
 Documentation/{ => arch}/arm64/acpi_object_usage.rst |  0
 Documentation/{ => arch}/arm64/amu.rst               |  0
 Documentation/{ => arch}/arm64/arm-acpi.rst          |  2 +-
 Documentation/{ => arch}/arm64/asymmetric-32bit.rst  |  0
 Documentation/{ => arch}/arm64/booting.rst           |  0
 .../{ => arch}/arm64/cpu-feature-registers.rst       |  0
 Documentation/{ => arch}/arm64/elf_hwcaps.rst        | 12 ++++++------
 Documentation/{ => arch}/arm64/features.rst          |  0
 Documentation/{ => arch}/arm64/hugetlbpage.rst       |  0
 Documentation/{ => arch}/arm64/index.rst             |  0
 Documentation/{ => arch}/arm64/kasan-offsets.sh      |  0
 .../{ => arch}/arm64/legacy_instructions.rst         |  0
 .../{ => arch}/arm64/memory-tagging-extension.rst    |  2 +-
 Documentation/{ => arch}/arm64/memory.rst            |  0
 Documentation/{ => arch}/arm64/perf.rst              |  0
 .../{ => arch}/arm64/pointer-authentication.rst      |  0
 Documentation/{ => arch}/arm64/silicon-errata.rst    |  0
 Documentation/{ => arch}/arm64/sme.rst               |  2 +-
 Documentation/{ => arch}/arm64/sve.rst               |  2 +-
 .../{ => arch}/arm64/tagged-address-abi.rst          |  2 +-
 Documentation/{ => arch}/arm64/tagged-pointers.rst   |  2 +-
 Documentation/arch/index.rst                         |  2 +-
 .../devicetree/bindings/cpu/idle-states.yaml         |  2 +-
 .../translations/zh_CN/{ => arch}/arm64/amu.rst      |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/booting.txt  |  4 ++--
 .../zh_CN/{ => arch}/arm64/elf_hwcaps.rst            | 10 +++++-----
 .../zh_CN/{ => arch}/arm64/hugetlbpage.rst           |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/index.rst    |  4 ++--
 .../zh_CN/{ => arch}/arm64/legacy_instructions.txt   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/memory.txt   |  4 ++--
 .../translations/zh_CN/{ => arch}/arm64/perf.rst     |  4 ++--
 .../zh_CN/{ => arch}/arm64/silicon-errata.txt        |  4 ++--
 .../zh_CN/{ => arch}/arm64/tagged-pointers.txt       |  4 ++--
 Documentation/translations/zh_CN/arch/index.rst      |  2 +-
 .../translations/zh_TW/{ => arch}/arm64/amu.rst      |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/booting.txt  |  4 ++--
 .../zh_TW/{ => arch}/arm64/elf_hwcaps.rst            | 10 +++++-----
 .../zh_TW/{ => arch}/arm64/hugetlbpage.rst           |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/index.rst    |  4 ++--
 .../zh_TW/{ => arch}/arm64/legacy_instructions.txt   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/memory.txt   |  4 ++--
 .../translations/zh_TW/{ => arch}/arm64/perf.rst     |  4 ++--
 .../zh_TW/{ => arch}/arm64/silicon-errata.txt        |  4 ++--
 .../zh_TW/{ => arch}/arm64/tagged-pointers.txt       |  4 ++--
 Documentation/translations/zh_TW/index.rst           |  2 +-
 Documentation/virt/kvm/api.rst                       |  2 +-
 MAINTAINERS                                          |  2 +-
 arch/arm64/Kconfig                                   |  4 ++--
 arch/arm64/include/asm/efi.h                         |  2 +-
 arch/arm64/include/asm/image.h                       |  2 +-
 arch/arm64/include/uapi/asm/sigcontext.h             |  2 +-
 arch/arm64/kernel/kexec_image.c                      |  2 +-
 mm/mremap.c                                          |  3 ++-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c    |  2 +-
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

-- 
2.40.1

