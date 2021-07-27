Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105AC3D6E8F
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhG0GA6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0GA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 02:00:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD20C061757;
        Mon, 26 Jul 2021 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=r1glimHAK1enYyvXjb7/p34hcH8iizqcqcTqLcbpL40=; b=T5d98nxPB2NSUwaDW1/4ThOw4h
        mwBZPoHDeyOsBF649ZNNo33MNZQzWi0ZFuhI4eKK0LgULX0MsqgeIQOBYFcVdvKjWetSjsEtcEbgT
        bzCKnlOCmB9pBMg+vYWLfuVKM/S+kiKgQsy9VXVewqDLm9/kntrDKGQt6AqK5rIL5UbZERIYfa9n9
        vDtCDAa7QtxDyflxi3fLu6Wx3l7oA/wMF90H2zvKDirZpl6hxERMkCGDdYj1Wn6+0Mu1uCyFRVPZ5
        Czm9ZKlXm044gwqHaG8d0dmum4I+zX+maX24o8ilAWbmfhZy83uCU/ZwHgs5GqXAZw0JuYosBPpI6
        2Yvj4Lxg==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8G59-00EiCP-1F; Tue, 27 Jul 2021 05:57:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: switch the block layer to use kmap_local_page v3
Date:   Tue, 27 Jul 2021 07:56:31 +0200
Message-Id: <20210727055646.118787-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

this series switches the core block layer code and all users of the
existing bvec kmap helpers to use kmap_local_page.  Drivers that
currently use open coded kmap_atomic calls will converted in a follow
on series.

To do so a new kunmap variant is added that calls
flush_kernel_dcache_page.  I'm not entirely sure where to call
flush_dcache_page vs flush_kernel_dcache_page, so I've tried to follow
the documentation here, but additional feedback would be welcome.

Note that the ps3disk has a minir conflict with the
flush_kernel_dcache_page removal in linux-next through the -mm tree.
I had hoped that change would go into 5.14, but it seems like it is
being held for 5.15.

Changes since v2:
 - rely on the flush_dcache_helpers in memcpy_to_page and memzero_page
   that now hit mainline

Changes since v1:
 - add more/better comments
 - add a new kunmap_local_dirty helper to feal with
   flush(_kernel)_dcache_page

Diffstat:
 arch/mips/include/asm/mach-rc32434/rb.h |    2 -
 block/bio-integrity.c                   |   14 +++-----
 block/bio.c                             |   37 ++++++----------------
 block/blk-map.c                         |    2 -
 block/bounce.c                          |   39 +++++-------------------
 block/t10-pi.c                          |   16 +++------
 drivers/block/ps3disk.c                 |   19 +----------
 drivers/block/rbd.c                     |   15 +--------
 drivers/md/dm-writecache.c              |    5 +--
 include/linux/bio.h                     |   42 -------------------------
 include/linux/bvec.h                    |   52 ++++++++++++++++++++++++++++++--
 include/linux/highmem-internal.h        |    7 ++++
 include/linux/highmem.h                 |   10 ++++--
 13 files changed, 102 insertions(+), 158 deletions(-)
