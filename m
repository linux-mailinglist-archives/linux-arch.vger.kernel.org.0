Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1003426A234
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgIOJcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 05:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:59038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOJcO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 05:32:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F8B106F;
        Tue, 15 Sep 2020 02:32:13 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.14.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019553F68F;
        Tue, 15 Sep 2020 02:32:11 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
Date:   Tue, 15 Sep 2020 10:32:01 +0100
Message-Id: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix the empty pci_iounmap() implementation that is causing memory leaks on
!CONFIG_GENERIC_IOMAP configs relying on asm-generic/io.h.

A small tweak is required on sparc32 to pull in some declarations,
hopefully nothing problematic, subject to changes as requested.

Previous tentatives:
https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: George Cherian <george.cherian@marvell.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>

Lorenzo Pieralisi (2):
  sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
    include
  asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
    implementation

 arch/sparc/include/asm/io_32.h | 16 ++++++++------
 include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.26.1

