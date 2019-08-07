Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDAF85053
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbfHGPx1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 11:53:27 -0400
Received: from foss.arm.com ([217.140.110.172]:50660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388779AbfHGPx1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Aug 2019 11:53:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B60344;
        Wed,  7 Aug 2019 08:53:26 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CD9C3F706;
        Wed,  7 Aug 2019 08:53:25 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v7 0/2] arm64 tagged address ABI
Date:   Wed,  7 Aug 2019 16:53:19 +0100
Message-Id: <20190807155321.9648-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Thanks for the feedback so far. This is an updated series documenting
the AArch64 Tagged Address ABI as implemented by these patches:

http://lkml.kernel.org/r/cover.1563904656.git.andreyknvl@google.com

Version 6 of the documentation series is available here:

http://lkml.kernel.org/r/20190725135044.24381-1-vincenzo.frascino@arm.com

Changes in v7:

- Dropped the MAP_PRIVATE requirements for tagged pointers for both
  anonymous and file mappings. One reason is that we can't enforce such
  restriction anyway. The other reason is that a future series
  implementing support for the hardware MTE will detect
  incompatibilities of the new PROT_MTE flag with various mmap()
  options.

- As a consequence of the above, I removed Szabolcs ack as I'm not sure
  he's ok with the change.

- Clarified the sysctl and prctl() interaction and reordered the
  descriptions.

- Reworded the prctl(PR_SET_MM) restrictions.

- Removed the description of the tag preservation from the first patch
  as it didn't really make sense (the syscall ABI has always preserved
  all registers other than x0 on return to user).

- s/ARM64/AArch64/ for consistency with the tagged-pointers.rst
  document.

- Other minor rewordings.

Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.rst
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-address-abi.rst | 151 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.rst    |  23 +++-
 2 files changed, 167 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst

