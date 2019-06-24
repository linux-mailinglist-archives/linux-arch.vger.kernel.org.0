Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEBB50157
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 07:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfFXFrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 01:47:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 01:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NzVbzZxa/8BDA0K/gN2hfOrO5797OT+UZoKovaRFABE=; b=ILvkzXYnLHZr+WZE5Kgd4hi5U
        QLq0PAbCmBNzXLXt1JG4oxsORw00Wkl2IFjUORg5pLnWfnoQokiLAW/QY0xFSEKkA9ASxKUGDNMDn
        q/mBHvoX9S8s90WxlPWhEYGOYwQ2Hgae8pVsAfkk1BzrfDGh8LZwBE88sLh5IRDC27uvXjkiMjQo4
        6vBYFwW0zeqLHROz7uUsMV/VXFu4x8KT9Pqklxo/IJwdtAPXTyDk+ctL8R36ap9BjVDs5KCQQ5z5l
        yayFf6MOP9vsIlocCfDUAMORJdaadbykBlLb2dcmyXpYk+kw/Zq/HcBuh2akJz/vbKk+VqssOcnLn
        ptKiB9bBQ==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHpD-0000No-1q; Mon, 24 Jun 2019 05:47:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove asm-generic/ptrace.h v3
Date:   Mon, 24 Jun 2019 07:47:23 +0200
Message-Id: <20190624054728.30966-1-hch@lst.de>
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

I'm not sure which tree is the right place, but may this can go through
the asm-generic tree since it removes an asm-generic header?


Changes since v2:
 - rebase to latest Linus' tree that added an SPDX tag to
   asm-generic/ptrace.h
 - collected two more Acks from Oleg
Changes since v1:
 - add a missing empty line between functions
