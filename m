Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2748EF9E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfHOPoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 11:44:09 -0400
Received: from foss.arm.com ([217.140.110.172]:45708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfHOPoI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 11:44:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9BA528;
        Thu, 15 Aug 2019 08:44:07 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 339C33F706;
        Thu, 15 Aug 2019 08:44:06 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v8 0/2] arm64 tagged address ABI
Date:   Thu, 15 Aug 2019 16:43:58 +0100
Message-Id: <20190815154403.16473-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series contains an update to the arm64 tagged address ABI
documentation posted here (v7):

http://lkml.kernel.org/r/20190807155321.9648-1-catalin.marinas@arm.com

together some adjustments to Andrey's patches (already queued through
different trees) following the discussions on the ABI documents:

http://lkml.kernel.org/r/cover.1563904656.git.andreyknvl@google.com

If there are not objections, I propose that that patch 1 (mm: untag user
pointers in mmap...) goes via the mm tree while the other 4 are routed
via the arm64 tree.

Changes in v8:

- removed mmap/munmap/mremap/brk from the list of syscalls not accepting
  tagged pointers

- added ioctl() to the list of syscalls not accepting tagged pointers

- added shmat/shmdt to a list of syscalls not accepting tagged pointers

- prctl() now requires all unused arguments to be 0

- note about two-stage ABI relaxation since even without the prctl()
  opt-in, the tag is still ignored on a few syscalls (untagged_addr() in
  the kernel is unconditional)

- compilable example code together with syscall use

- added a note on tag preservation in the tagged-pointers.rst document

- various rewordings and cleanups


Catalin Marinas (3):
  mm: untag user pointers in mmap/munmap/mremap/brk
  arm64: Tighten the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl() unused
    arguments
  arm64: Change the tagged_addr sysctl control semantics to only prevent
    the opt-in

Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.rst
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-address-abi.rst | 155 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.rst    |  23 ++-
 arch/arm64/kernel/process.c                |  17 ++-
 kernel/sys.c                               |   4 +
 mm/mmap.c                                  |   5 +
 mm/mremap.c                                |   6 +-
 6 files changed, 191 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst

