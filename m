Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1765F3A6DAD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhFNRyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 13:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234031AbhFNRyC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 13:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 827DE60FEA;
        Mon, 14 Jun 2021 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623693119;
        bh=w6yEl6RdNBce/fM+QwtQ8kaN8ZBcaj88bvIJYqQiqWE=;
        h=From:To:Cc:Subject:Date:From;
        b=CYV9czSkjRP4LdvMU9VxTMqEGCe5n1d/EBSjIvR9gHcyfwJuSRTkmVyYzxr0mPz6T
         FIkdFELsy/LoTBt/VXXTgJwhKsOk+cUGUH4yXFcIOR4n3I3TzN8iLE7KIDNb85vGLl
         W+ou9zfbWXYBzbPUnA+PStAK/B8qvyCt2O8SQDuOOFucnuWmHel8OcCBPIR7UhP0DV
         mXMnXjNCSs1G9gkKBwsBkzsG292IZnCsxGDGikAyOjTvUgeuY9bxtQ/Ipb2QHQjVpy
         LaxuWv6ITwYHAf8RY8ckaF4CYe4YehO5MntIA5z8cPL6sxLW0EI8ZJEJwiBX8+n6jz
         rqN/opCt1ylLw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        tech-virt-mem@lists.riscv.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v3 0/2] riscv: pgtable: Add "PBMT" extension supported
Date:   Mon, 14 Jun 2021 17:51:05 +0000
Message-Id: <1623693067-53886-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These patches are a continuation of "riscv: Add DMA_COHERENT support for
Allwinner D1". Compared with the previous factory-defined hardware
implementation, it now follows the PBMT extension proposal.

V2: https://lore.kernel.org/linux-riscv/1622970249-50770-10-git-send-email-guoren@kernel.org/
V1: https://lore.kernel.org/linux-riscv/1621400656-25678-3-git-send-email-guoren@kernel.org/

Changes since v2:
 - Change to PBMT extension proposal
 - Add pbmt in dts
 - Using img hdr for custom memory types moification

Changes since v1:
 - Rebase on linux-5.13-rc4
 - Support defconfig for different PTE attributes

Guo Ren (2):
  riscv: pgtable: Add custom protection_map init
  riscv: pgtable: Add "PBMT" extension supported

 arch/riscv/Kconfig                    |  4 +++
 arch/riscv/include/asm/image.h        |  6 ++--
 arch/riscv/include/asm/pgtable-64.h   |  8 +++--
 arch/riscv/include/asm/pgtable-bits.h | 55 ++++++++++++++++++++++++++--
 arch/riscv/include/asm/pgtable.h      | 17 ++++-----
 arch/riscv/kernel/head.S              |  6 ++++
 arch/riscv/mm/init.c                  | 68 +++++++++++++++++++++++++++++++++++
 mm/mmap.c                             |  4 +++
 8 files changed, 149 insertions(+), 19 deletions(-)

-- 
2.7.4

