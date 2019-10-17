Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF7DB3E0
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfJQRqE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 13:46:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389827AbfJQRqD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 13:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xCRQFy9+IPozuA6foR1LSQETFb0B/WIEsA+BjHPyM30=; b=QSTEOTclGysuQmJmkIo0siPhK
        /pLUUoz+i79TA+VG6nSlISLGCLkIr1ggrDZvwpQ3NLEg2QUFoisPbZwaVnxaG5RDV8OjPBPKoCVdh
        tfOsZTOmTulSBDEkEOjLWPRM099VRngsLVn0kVNc3mZdqizosIMTpCNj/RDDgkVqS/GifxjwsRaqP
        J+Qjadf6dtwYvxkn7ev6qVAfQliw55xpUjhcCgKVqqUPIFO6BH6iBpmm8fYCRFRgPGB4MIxI2E9on
        RxttYwCplOf4tQOQpkPNU8QczjCt5DUUHhczA9nf9o/yof+J21QHemhfr90FGfBiGTUmrEb/M6V5p
        dd9W3DXFw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9qW-0005RL-Hy; Thu, 17 Oct 2019 17:45:56 +0000
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
Subject: generic ioremap (and lots of cleanups) v2
Date:   Thu, 17 Oct 2019 19:45:33 +0200
Message-Id: <20191017174554.29840-1-hch@lst.de>
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

Changes since v1:
 - dropped various patches already merged
 - keep the parts of the parisc EISA hack that are still needed
