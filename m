Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984FE3A7F26
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFON2I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFON2H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:28:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D75C06175F;
        Tue, 15 Jun 2021 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LANErqvAt5Dho8b4cxyvD6Xv2I3E/TWFG2nVLqqeNt0=; b=palQ/f5WxTm8MUXTTCoy3VZFDC
        n8V4XRmTumCgcm0WNBknFJw6HQJiqjd54owgb8f+cYy83XUlgvRsmb+DlLDYA5wxXFpqkTqJAjB50
        efm1YQoc8XGJEamHRMsKYvrtPZ2S181JWCEuoNqOQ7Pt7tOW4cQ8XCVrne+pRUfgChrgEsiHNND/k
        wLywRQ9TWOnneUJ0N+Ey5Du3YzlLQW09zJMR++vzJXygwVyvD8WwNUP0G+Ch40K3M/aDfbBdo7gn/
        QcL6T1+U3ecGgL2it0yE/+EreZ7FQj2mvuiecuAao9Hla+hgUstciBYyETsk96ZeXFsk3YIINLX0j
        IEL5j9+w==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt93p-006nu2-6X; Tue, 15 Jun 2021 13:25:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: switch the block layer to use kmap_local_page v2
Date:   Tue, 15 Jun 2021 15:24:38 +0200
Message-Id: <20210615132456.753241-1-hch@lst.de>
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
