Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E389B4A3
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391229AbfHWQhX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 12:37:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390933AbfHWQhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 12:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40C0C28;
        Fri, 23 Aug 2019 09:37:22 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 865353F246;
        Fri, 23 Aug 2019 09:37:20 -0700 (PDT)
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
Subject: [PATCH v10 0/1] arm64 tagged address ABI
Date:   Fri, 23 Aug 2019 17:37:16 +0100
Message-Id: <20190823163717.19569-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Minor update to the arm64 tagged address ABI documentation since v9,
posted here:

http://lkml.kernel.org/r/20190821164730.47450-1-catalin.marinas@arm.com

The mmap/mremap/... patch (1/3) has been queued in the -mm tree and
removed from this series. The tagged-address-abi.rst patch (2/3) has
been queued in the arm64 for-next/core tree. There is only one patch
left in this series (keeping the cover letter for consistency).

Changes in v10:

- Remove the tag preservation paragraph since the new ABI does not
  change the behaviour we already have. The only difference is that now
  the kernel can access tagged addresses (e.g. delivering a signal on a
  tagged alternate stack).

Vincenzo Frascino (1):
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-pointers.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

