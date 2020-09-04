Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2825E036
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgIDQwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgIDQwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 12:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E05C061244;
        Fri,  4 Sep 2020 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vg3eMp3qgi31sLSmCrf5FHDomo2X8qRKjrMoI4zUJzk=; b=STmnWLK+ma1qwigPmOi+LTrWVt
        VwzJER0Yn+fHMRwnVnqTdt6SoKqMbguQN+a/9bm0TVtSBXW1C0gxIbGfwNlfBpjUGygw9Jy5wDvUv
        xr1cJZi5CxRDXK5waonglnCVvRpTvJigi0Xp8+exRfuXksMBm5WrSmB3843+DaNxCUYmQ6zNwjN+p
        wUEo8kW7glq7Y543bYAln+e6JO4HTZfPSjf1hgWWsqPLqnhDudBhuwc3JQ4AwZYpnPllEmCW/Fws2
        qGDF7LNFWUu80E/41QdN1iBPTrGz6vjS4cUbH9gv6G9ZFx6oiTwDxnY2HZ9Az9a0BFoI5B/3aYdML
        eFeBiq/Q==;
Received: from [2001:4bb8:184:af1:704:22b1:700d:1395] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEEwj-00012Z-Fz; Fri, 04 Sep 2020 16:52:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: remove set_fs for riscv
Date:   Fri,  4 Sep 2020 18:52:08 +0200
Message-Id: <20200904165216.1799796-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

this series converts riscv to the new set_fs less world and is on top of this
branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs

The first four patches are general improvements and enablement for all nommu
ports, and might make sense to merge through the above base branch.

Diffstat
 arch/riscv/Kconfig                   |    2 
 arch/riscv/include/asm/thread_info.h |    6 -
 arch/riscv/include/asm/uaccess.h     |  177 +++++++++++++++++------------------
 arch/riscv/kernel/process.c          |    1 
 arch/riscv/lib/Makefile              |    2 
 include/asm-generic/uaccess.h        |   42 +++++---
 include/linux/uaccess.h              |    4 
 7 files changed, 127 insertions(+), 107 deletions(-)
