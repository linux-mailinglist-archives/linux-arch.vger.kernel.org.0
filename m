Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5335BEE2
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbhDLJCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbhDLI7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 04:59:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D53C061359;
        Mon, 12 Apr 2021 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AsS0qVynmQzQb3jMNW5nUdgLQlBP5gem8xAk3DyV6Nw=; b=N3qsnG3AazzqKHA9ERMeLn+ayA
        79zNMoOF8+tpwX3fO2Rh+XPpOxrsh5chPi9nl+OS+weKbQfRS1RhnAezt+rbfC8878F3qJcAWs1G8
        h1XkE6AKPUP0C1gSxJeRBD7OMHv8/OCx5KxF+Yi65kg+E2JiKFB++8QOpbhseR6Oi8zyXmYlH2MQh
        rzjyTDH2JUqIFhl4k3bFg/QleggRLVQW3VeTocjbzt8x45w4mHx+7g+anay83LhRTwKPDhdf8frSx
        qRuf7GS1+ruREWDPzYBTnLoH1vqzztN9pVyAE2pDOAtcZGZqvpfTvN5Q1czxF2ql9ZMBOgwFVUtJB
        rNnUaw9w==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVsMF-0060DS-FS; Mon, 12 Apr 2021 08:55:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: consolidate the flock uapi definitions
Date:   Mon, 12 Apr 2021 10:55:40 +0200
Message-Id: <20210412085545.2595431-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

currently we deal with the slight differents in the various architecture
variants of the flock and flock64 stuctures in a very cruft way.  This
series switches to just use small arch hooks and define the rest in
asm-generic and linux/compat.h instead.

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
