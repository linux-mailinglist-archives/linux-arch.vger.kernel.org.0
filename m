Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B198099
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfHUQrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 12:47:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHUQrn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85EA360;
        Wed, 21 Aug 2019 09:47:42 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09F003F718;
        Wed, 21 Aug 2019 09:47:40 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v9 0/3] arm64 tagged address ABI
Date:   Wed, 21 Aug 2019 17:47:27 +0100
Message-Id: <20190821164730.47450-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series is an update to the arm64 tagged address ABI documentation
patches v8, posted here:

http://lkml.kernel.org/r/20190815154403.16473-1-catalin.marinas@arm.com

From v8, I dropped patches 2 and 3 as they've been queued by Will via
the arm64 tree. Reposting patch 1 (unmodified) as it should be merged
via the mm tree.

Changes in v9:

- Replaced the emphasized/bold font with a typewriter one for
  function/constant names

- Simplified the mmap/brk bullet points when describing the tagged
  pointer origin

- Reworded expected syscall behaviour with valid tagged pointers

- Reworded the prctl/ioctl restrictions to clarify the allowed tagged
  pointers w.r.t. user data access by the kernel


Catalin Marinas (1):
  mm: untag user pointers in mmap/munmap/mremap/brk

Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.rst
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-address-abi.rst | 156 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.rst    |  23 ++-
 mm/mmap.c                                  |   5 +
 mm/mremap.c                                |   6 +-
 4 files changed, 178 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst

