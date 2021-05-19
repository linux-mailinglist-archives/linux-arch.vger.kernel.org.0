Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C399938865C
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 07:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbhESFGk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 01:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244371AbhESFGh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6B7A61355;
        Wed, 19 May 2021 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621400718;
        bh=FUR+kgZ+mw6mQw3yvdnnfad7YItNxZiYZYD2BKwK/SQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i7EKFQigqGmUdb8wYjNQHOwKJkDxkY3IxJXsCMm/WnSs3Q3TgMcH4lt917hLkjtH+
         6L1kLdk9P5li0WQzsEsAzZ02qa9W3r9WGdsh8J4VSMU89257YxpBkzYM7qVSXLBvpp
         2kIpk4Pu2cbOVb6sz2EvDUj3J0o5Am6Td9n2BMmSosbqFwVW+4O23BFXpk4wrS357Q
         Lw/TjRESwjTy9MkCBEprl0eIKkenIS8nBmy9FAlanquBC9dD7/Cr3ZMJBtxbmShTyJ
         c9o57+MKko2T8D9fNPZ6rS66E+U3rPpmQIHnTvj6xrY7ymyyyfl+E6p5DpjL2hGUGu
         fUKUd1DUMl/yQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        drew@beagleboard.org, hch@lst.de, wefu@redhat.com,
        lazyparser@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Date:   Wed, 19 May 2021 05:04:13 +0000
Message-Id: <1621400656-25678-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
vendors define the custom properties of memory regions in PTE.

This patchset helps SOC vendors to support their own custom interconnect
coherent solution with PTE attributes.

For example, allwinner D1[1] uses T-HEAD C906 as main processor, C906 has
two modes in MMU:
 - Compatible mode, the same as the definitions in spec.
 - Enhanced mode, add custom DMA_COHERENT attribute bits in PTE which
   not mentioned in spec.

Allwinner D1 needs the enhanced mode to support the DMA type device with
non-coherent interconnect in its SOC. C906 uses BITS(63 - 59) as custom
attribute bits in PTE.

Here is the config example for Allwinner D1:
CONFIG_RISCV_DMA_COHERENT=y
CONFIG_RISCV_PAGE_DMA_MASK=0xf800000000000000
CONFIG_RISCV_PAGE_CACHE=0x7000000000000000
CONFIG_RISCV_PAGE_DMA_NONCACHE=0x8000000000000000

Link: https://linux-sunxi.org/D1 [1]

Guo Ren (3):
  riscv: pgtable.h: Fixup _PAGE_CHG_MASK usage
  riscv: Add DMA_COHERENT for custom PTE attributes
  riscv: Add SYNC_DMA_FOR_CPU/DEVICE for DMA_COHERENT

 arch/riscv/Kconfig                    | 31 ++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable-64.h   |  8 ++++---
 arch/riscv/include/asm/pgtable-bits.h | 13 ++++++++++-
 arch/riscv/include/asm/pgtable.h      | 26 +++++++++++++++++-----
 arch/riscv/include/asm/sbi.h          | 16 ++++++++++++++
 arch/riscv/kernel/sbi.c               | 19 ++++++++++++++++
 arch/riscv/mm/Makefile                |  4 ++++
 arch/riscv/mm/dma-mapping.c           | 41 +++++++++++++++++++++++++++++++++++
 8 files changed, 148 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/mm/dma-mapping.c

-- 
2.7.4

