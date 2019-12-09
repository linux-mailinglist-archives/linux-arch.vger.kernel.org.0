Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58218116E5D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 14:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfLIN6a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 08:58:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfLIN63 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 08:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p3AHg01GzBfCAwXTHfYhqubAMqRq0EW1LlGivKYK9aQ=; b=du0d4ED4pEft4i4vPCtqfLCOp
        esqaMKpCD8hPWIQ2zbctS9HG0DPGFiqt521Yb1eHEYFVPkTDXzIa6vmlKc9LsggxVBECPjHTHBPpo
        tEzQu3x4r2id8j5DwWvcRE5V9u5FpImc6+HXCaiPvh8UEK9O6CBAs78ueFhdRo/jmEQXVI8BIvLeS
        X9swmJQ3duj43u4g7x0XVF8IpIyskbQkrpMXVbAADZ5nI2K2p2t4ti29ckzcRd6KKIjEvCyIUZRNG
        v9IkiU/28Q8moHjDunbEXcW95RGyC0P9aZF+mGKUafr7AQYSQGpECkRgz5v0rWRgrs7wvZI2Hio5Y
        zM6/TnQ1Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieJYP-0001aO-8x; Mon, 09 Dec 2019 13:58:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: kill off ioremap_nocache
Date:   Mon,  9 Dec 2019 14:58:20 +0100
Message-Id: <20191209135823.28465-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

with the ioremap changes that did land in 5.5-rc1 ioremap_nocache is
now equal to ioremap for all architectures.  For most architectures
including the common one this has been the case for about 20 years,
but we had a few holdouts.

That means ioremap_nocache is entirely superflous now and can be
killed off.  This series has one big scripted patch to do just that
after a little prep patch to fix up the not entirely obvious mips
definition.

Let me know what you think and if this is something acceptable for
just after -rc1.
