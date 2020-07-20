Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8A226A0C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgGTPyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jul 2020 11:54:52 -0400
Received: from verein.lst.de ([213.95.11.211]:47608 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731607AbgGTPyt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4782D68AFE; Mon, 20 Jul 2020 17:54:43 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:54:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm: don't call addr_limit_user_check for nommu
Message-ID: <20200720155441.GA13067@lst.de>
References: <20200714105505.935079-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On arm nommu kernel use the same constant for USER_DS and KERNEL_DS,
and seqment_eq always returns false.  With the current check in
addr_limit_user_check that works by accident, but when replacing
seqment_eq with uaccess_kerne it will fail.  Just remove the not
needed check entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---

Andrew: this should preferably go before the other patches in this
series.

 arch/arm/kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index ab2568996ddb0c..c9dc912b83f012 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -713,7 +713,9 @@ struct page *get_signal_page(void)
 /* Defer to generic check */
 asmlinkage void addr_limit_check_failed(void)
 {
+#ifdef CONFIG_MMU
 	addr_limit_user_check();
+#endif
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
-- 
2.27.0

