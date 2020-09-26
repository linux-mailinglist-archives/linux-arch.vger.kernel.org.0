Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB30279765
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIZG6b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 02:58:31 -0400
Received: from verein.lst.de ([213.95.11.211]:58532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZG6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 26 Sep 2020 02:58:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D73068B02; Sat, 26 Sep 2020 08:58:29 +0200 (CEST)
Date:   Sat, 26 Sep 2020 08:58:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove set_fs for riscv v2
Message-ID: <20200926065829.GA3954@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Can we get this series picked up either in Al's base.set_fs tree, or
a branch in the riscv tree?

On Mon, Sep 07, 2020 at 07:58:17AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series converts riscv to the new set_fs less world and is on top of this
> branch:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
> 
> The first four patches are general improvements and enablement for all nommu
> ports, and might make sense to merge through the above base branch.
> 
> Changes since v1:
>  - implement __get_user_fn and __put_user_fn for the UACCESS_MEMCPY case
>    and remove the small constant size optimizations in raw_copy_from_user
>    and raw_copy_to_user
>  - reshuffle the patch order a little
> 
> Diffstat
>  arch/riscv/Kconfig                   |    2 
>  arch/riscv/include/asm/thread_info.h |    6 -
>  arch/riscv/include/asm/uaccess.h     |  177 +++++++++++++++++------------------
>  arch/riscv/kernel/process.c          |    1 
>  arch/riscv/lib/Makefile              |    2 
>  include/asm-generic/uaccess.h        |  109 +++++++++++++--------
>  include/linux/uaccess.h              |    4 
>  7 files changed, 166 insertions(+), 135 deletions(-)
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
---end quoted text---
