Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1EAEA833
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJaAcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 20:32:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJaAcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1so4331754wra.10
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LuWs8dcQ+Sr64TXmHkexn1zViahF1FUWncWFh41F/hk=;
        b=KkZ+NNwMPyqf8TZ/0SNrTMfEEbtY6AkiKFiX1KC01wShyWiWJD4un4RhPqMCse8c3V
         8vK8gBksSfUJfxpaB4aCkY3CXRfcAjThUYGNBHRSplOKOXvu8P10aMmaFwAncndK+2n7
         WBZui9XlT7Gxb2n8XS6MJwcIgLAsADNcZ+Lu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LuWs8dcQ+Sr64TXmHkexn1zViahF1FUWncWFh41F/hk=;
        b=il35RrqMKylqUC2mi+pAjUij12bJgMF5pegy+PMEaFdXQl5hmTJO1bv7+aqPmH/+ti
         6q7q2YQhr/GYk0Vil2jcmvXCBXAHdhybF49djB8NBV8oOsV6eTXXzfJTREUT4jNarU7C
         j52pqfQYwq4s+pQX3HQAyaSLTfoa9HYz4FopJ0rn6323F5VOsitP5qxH/kFB7FrRrtSj
         lvNpo+uOCljmnH153+MGA1oQl2iZbm9cx1ZOz3i2HoNA9T4Jgj1lFUtth/o0NYesThN6
         6IDsa6mghGSoR9TSSN+AdPTGWKT0vpI/uweCmRwCXIsYuJzCpD0Sa5+5PBb+R8CgybUS
         mDnw==
X-Gm-Message-State: APjAAAUpndEyhMAq/pAE1FC8JniRPDKviJzaTLBEUXTcviHyYePPOs1W
        6Ti6YkN1tvq8yPuiiBwhmL2JJ5k3TJVsdSGC
X-Google-Smtp-Source: APXvYqz3E0Ue8yL/CCvXcgs/63oYTW+qO+n65QfV1mF9yHdNK4XvvLNQHrS7g7vfk5Y07iStl+BOkw==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr2407775wrp.353.1572481920804;
        Wed, 30 Oct 2019 17:32:00 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:00 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
Date:   Thu, 31 Oct 2019 01:31:49 +0100
Message-Id: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When trying to make the QUICC Engine drivers compile on arm, I
mechanically (with coccinelle) changed out_be32() to iowrite32be()
etc. Christophe pointed out [1][2] that that would pessimize the
powerpc SOCs since the IO accesses now incur a function call
overhead. He asked that I try to make those io accessors inline on
ppc, and this is the best I could come up with.

At first I tried something that wouldn't need to touch anything
outside arch/powerpc/, but I ended up with conditional inclusion of
asm-generic headers and/or duplicating a lot of their contents.

The diffstat may become a little better if kernel/iomap.c can indeed
be removed (due to !CONFIG_PPC_INDIRECT_PIO &&
CONFIG_PPC_INDIRECT_MMIO never happening).

[1] https://lore.kernel.org/lkml/6ee121cf-0e3d-4aa0-2593-fcb00995e429@c-s.fr/
[2] https://lore.kernel.org/lkml/886d5218-6d6b-824c-3ab9-63aafe41ff40@c-s.fr/

Rasmus Villemoes (5):
  asm-generic: move pcu_iounmap from iomap.h to pci_iomap.h
  asm-generic: employ "ifndef foo; define foo foo" idiom in iomap.h
  powerpc: move pci_iounmap() from iomap.c to pci-common.c
  powerpc: make pcibios_vaddr_is_ioport() static
  powerpc: make iowrite32 and friends static inline when no indirection

 arch/powerpc/include/asm/io.h         | 172 ++++++++++++++++++++++++++
 arch/powerpc/include/asm/pci-bridge.h |   9 --
 arch/powerpc/kernel/Makefile          |   2 +-
 arch/powerpc/kernel/iomap.c           |  13 --
 arch/powerpc/kernel/pci-common.c      |  15 ++-
 include/asm-generic/iomap.h           | 104 +++++++++++++---
 include/asm-generic/pci_iomap.h       |   7 ++
 7 files changed, 282 insertions(+), 40 deletions(-)

-- 
2.23.0

