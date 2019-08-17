Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40BF90DC2
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2019 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfHQHfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 03:35:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfHQHfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Aug 2019 03:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8stPQbNrg3B/R2Xd5KO2eeuMSLol2LwoVvz90ca57Uc=; b=W0bwqZTtbBiXb6VnEfyfA9mVE
        9W9bQiZ+oFFnztrtL29HNStHhzgEzKZRwR0Y2Yt9fbTPXro2ana913j8J/x4VOrNIf7Vpp1s5xTBT
        JBBgWHNPJDHxK8YM2EH/1iy4ZFyxsqX/E8MVm9oFi7/haC79fhkUSp31sjsxo5ixN+LjUtq5YiE/H
        JgzEH6lBn4zXt6f6tZUImXk13a1mBaoeUkv03QCkMCv+JI9Ou3L3XpKNVs1qsGQXI8TQioogd4019
        +YKCAK/dGkmyOlN7PU2frQDwzB/jnJxCvAQI78eDWfALqX6NNPVPNQ7KrDd1EV17QZV7xNJeKsN2w
        pL/zibEBg==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytEw-0005B4-6B; Sat, 17 Aug 2019 07:35:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: generic ioremap (and lots of cleanups)
Date:   Sat, 17 Aug 2019 09:32:27 +0200
Message-Id: <20190817073253.27819-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

the last patches in this series add a generic ioremap implementation,
and switch our 3 most recent and thus most tidy architeture ports over
to use it.  With a little work and an additional arch hook or two the
implementation should be able to eventually cover more than half of
our ports.

The patches before that clean up various lose ends in the ioremap
and iounmap implementations.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git generic-ioremap

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
