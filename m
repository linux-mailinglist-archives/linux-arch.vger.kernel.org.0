Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102E248A975
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbiAKIfX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 03:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbiAKIfW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 03:35:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08DFC061751;
        Tue, 11 Jan 2022 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CU5LQhHY97m/zrR0ou1Z0luP2bvz84uebvlIJdNgfcM=; b=JKg+8y749rXvzQFuLkcDh/W5q4
        GwaQU9CGaJSW8mOTGamOOFRFcdSnzWTAF91Rr0vwbFPbl3QmuKolvcmjDrP3oi+/4ZnsECQAwzv2/
        6SaYHyAeeTH5JjGiEgz4aBJ02nEKhF1NEew1KrGdg+8Wv5rSI9SGLgtluzQdwtPnvUlGl5gIIFg9I
        ts5WnNwfbeAc1gcpAyPWACA/+90rSuusYDCXioQTcynhLvu7ynDgWFXqbkxeNKvUrccitJMWyUh7I
        BTA2oqP1C1LSXqgtomTQNPeM9xImKfeNxb4GWZEQL2N2n3ownSf4StS6PRd+4ziXhLXxz91mNyfru
        J3Pv/xDw==;
Received: from [2001:4bb8:18c:6af6:82da:93cd:da5b:aa3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Ccg-00FKpV-1j; Tue, 11 Jan 2022 08:35:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: consolidate the compat fcntl definitions
Date:   Tue, 11 Jan 2022 09:35:10 +0100
Message-Id: <20220111083515.502308-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

currenty the compat fcnt definitions are duplicate for all compat
architectures, and the native fcntl64 definitions aren't even usable
from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
to sort out all that.

Diffstat:
 arch/arm64/include/asm/compat.h        |   20 --------------------
 arch/mips/include/asm/compat.h         |   23 ++---------------------
 arch/mips/include/uapi/asm/fcntl.h     |   28 +++-------------------------
 arch/parisc/include/asm/compat.h       |   16 ----------------
 arch/powerpc/include/asm/compat.h      |   20 --------------------
 arch/s390/include/asm/compat.h         |   20 --------------------
 arch/sparc/include/asm/compat.h        |   22 +---------------------
 arch/x86/include/asm/compat.h          |   24 +++---------------------
 include/linux/compat.h                 |   31 +++++++++++++++++++++++++++++++
 include/uapi/asm-generic/fcntl.h       |   21 +++++++--------------
 tools/include/uapi/asm-generic/fcntl.h |   21 +++++++--------------
 11 files changed, 54 insertions(+), 192 deletions(-)
