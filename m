Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85BE8085
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJ2Gsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 02:48:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfJ2Gsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 02:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kvC81MLJ/qmd5AYuvebxpfEasbMc4g+6Jnsgdy2EELA=; b=t6NZJy/IMV5UPsFQNtfhwUj8F
        8Q4nhTVw4pCbXJchYaUZbNMx/7XoXiFNcH3MfSe37YfdiS7CV3nVelwKOyhyBpGP/G7VPMfnUJ/Yu
        M07Gr4NAg/tt8UJEX+wUXB4PfEjTcMpNpfGunJA/FmdfiA83RYCAXeKi1isD1X/c2fFB3L/M8Awfo
        +b4OWtqfeh9MJBwpCROvrTh2onnJKDk+ErnD8Q8KIh3IQMRVEpkBCvEo1Bru+W05+tCttQ9DxH5Dq
        q/irlXlhdaNYgTMeBhtFkthBc7UTXMdD1fYSwUdtTxpSe1p954StmN62lCC8Dfc5teOMVvx5dtJfH
        NB62onpNA==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPLIz-0003J0-DZ; Tue, 29 Oct 2019 06:48:37 +0000
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
Subject: generic ioremap (and lots of cleanups) v3
Date:   Tue, 29 Oct 2019 07:48:13 +0100
Message-Id: <20191029064834.23438-1-hch@lst.de>
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

Note that there is no good tree this would fit, which means I'd set up
a tree to it to Linus unless someone has a better idea.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git generic-ioremap

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap

Changes since v2:
 - fix various typos
 - move the m68k __free_io_area around instead of introducing a forward
   declaration

Changes since v1:
 - dropped various patches already merged
 - keep the parts of the parisc EISA hack that are still needed
