Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59226CDA3
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIPVCg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 17:02:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgIPQPR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2511D1435;
        Wed, 16 Sep 2020 04:07:09 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2C23F68F;
        Wed, 16 Sep 2020 04:07:06 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH v2 1/3] sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
Date:   Wed, 16 Sep 2020 12:06:56 +0100
Message-Id: <084753d3064fe946ff1963eda2eb425cfd7daa7b.1600254147.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1600254147.git.lorenzo.pieralisi@arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com> <cover.1600254147.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The __KERNEL_ preprocessor guard is useless in non-uapi headers.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io_32.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 9a52d9506f80..8179958e3ce1 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -121,8 +121,6 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
 	}
 }
 
-#ifdef __KERNEL__
-
 /*
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
@@ -148,8 +146,6 @@ static inline int sbus_can_burst64(void)
 struct device;
 void sbus_set_sbus64(struct device *, int);
 
-#endif
-
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
 
 
-- 
2.26.1

