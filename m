Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4073C9FFE
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhGONup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGONuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E7C06175F;
        Thu, 15 Jul 2021 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=S6KcoUIpvrQVi4fHiaoEy/q8bKqLt5r6wwB0LH6OQ30=; b=qIoHgMkZGS55ZNZ53wOSE+skQC
        D8FpuTVGMgh0TlAxlf+mx+aYylStnfYfFkp0wHjqJV63zzAKMcmDh5INBcD0bjZ0Wy3YnhrUUVIud
        a+nVTamRqymx60nkQwB293VrSUPUoKFkDlcuxWOgHppbF03xfDbeH7JUrzaEC2u5xU4w/XbtPTKKJ
        swOWp4g8mthXg+DEWrHIt4xlaGwWsEen42MaZVgNBocTD5yziQNsJB3C+8CKLok5I1z7BXPvb3wJ6
        VVxkl3C2dPvviZWvQGpVl4l3zAUD0tKdTzX29SfEoZcnbH6dQ5PUbWLefPNlZtT++WtZfPbBSzQKw
        BR+GmYRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m41gw-003OYa-Il; Thu, 15 Jul 2021 13:46:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Make PMD_ORDER generically available
Date:   Thu, 15 Jul 2021 14:46:09 +0100
Message-Id: <20210715134612.809280-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These three architectures each define PMD_ORDER to mean "the order of
an allocation for a PMD table", but logically PMD_ORDER should be the
order of a PMD allocation, ie (PMD_SHIFT - PAGE_SHIFT) as DAX defines it.

Could each architecture maintainer please apply the appropriate patch
to their respective trees?

Matthew Wilcox (Oracle) (3):
  arm: Rename PMD_ORDER to PMD_TABLE_ORDER
  mips: Rename PMD_ORDER to PMD_TABLE_ORDER
  parisc: Rename PMD_ORDER to PMD_TABLE_ORDER

 arch/arm/kernel/head.S             | 34 +++++++++++++++---------------
 arch/mips/include/asm/pgalloc.h    |  2 +-
 arch/mips/include/asm/pgtable-32.h |  2 +-
 arch/mips/include/asm/pgtable-64.h | 18 ++++++++--------
 arch/mips/kernel/asm-offsets.c     |  2 +-
 arch/parisc/include/asm/pgalloc.h  |  6 +++---
 arch/parisc/include/asm/pgtable.h  |  4 ++--
 arch/parisc/mm/init.c              |  4 ++--
 8 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.30.2

