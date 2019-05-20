Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0720222B9B
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfETGBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 02:01:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETGBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 02:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TtG/YNZz0y8mj8A1er4STirT5s0O9RpqqEC1rxfxJiw=; b=N28ceEQUAuU1xApEDffUynFzT
        NQ7r5r90qOpUH2HTUExB3tPdnqSPlGVpwivhL8itUmf97FMJaB8XZ2cmFtxzOCEHPNUooKfq7cA9e
        7tGLtWr/T/66PN6agyLUtVAQzhW7PcSFuJXr8DezcIfADw9m9qy0U8ANLkROi1EmdXGFy6Xn1NizG
        3Lu0ms/lCozg4q41X4FOBQYj496+6iy1note8PX5sNKPGJ+6DVsYqWBT29+tgo+UiZQ4r26RRZh9B
        kG6HWOVGgsRx10sxmQ7WEzY4qhWUV9Zg3LTKhxPsYZs5lEmkuh6BCnV30SqFAyKihTpLMMpJL5yO8
        tO7LpeWyA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSbME-0001St-Ko; Mon, 20 May 2019 06:01:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove asm-generic/ptrace.h v2
Date:   Mon, 20 May 2019 08:00:13 +0200
Message-Id: <20190520060018.25569-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design.

Changes since v1:
 - add a missing empty line between functions
