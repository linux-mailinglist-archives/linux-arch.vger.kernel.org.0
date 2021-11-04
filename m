Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6432C4455FB
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 16:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKDPGO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKDPGN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 11:06:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8EFC061714;
        Thu,  4 Nov 2021 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZTxXopUmkY1B4mLUzgPVJBNJwKWxxnzj2Sovw24wOoc=; b=kNcXKRBS3xPEMduGlZBk7OiC4l
        UlIRsZ/HYitqc0YSiAfQiNxmg89EqIttpiT4eJHxAwffCnNTDbdaFkJGrikp/c3XYgyP6QljYld9i
        ug6w9H7556vzkvMcfygGkzj7e/bu+NrZp3lAfE1+uYuu0Mvi9ufMbsIQinP27Eku2KLVso0p6iEyH
        ePyJ/CBi62bJq+w0JafU4jyLi1dzE4Kq7meWAr/gJfozu9XcRfmP3N3Dxe1Jh3HtKbiTDz52XX/Ws
        I5vinVxtKVg8mj/F7GpI9NncAd11fTK2HS3pF65G5TgeQBoAqwdmCJ5cpi1CIinZWC6n82yRSRz/M
        SD0hvNyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mieEG-005wYd-CL; Thu, 04 Nov 2021 15:01:40 +0000
Date:   Thu, 4 Nov 2021 15:00:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: flush_dcache_page vs kunmap_local
Message-ID: <YYP1lAq46NWzhOf0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In https://lore.kernel.org/lkml/CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com/
Linus offers the opinion that kunmap calls should imply a
flush_dcache_page().  Christoph added calls to flush_dcache_page()
in commit 8dad53a11f8d.  Was this "voodoo programming", or was there
a real problem being addressed?

