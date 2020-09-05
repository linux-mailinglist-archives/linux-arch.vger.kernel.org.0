Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3838A25E5F2
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIEHRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 03:17:39 -0400
Received: from verein.lst.de ([213.95.11.211]:43947 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHRj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Sep 2020 03:17:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B982C68BEB; Sat,  5 Sep 2020 09:17:35 +0200 (CEST)
Date:   Sat, 5 Sep 2020 09:17:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: remove set_fs for riscv
Message-ID: <20200905071735.GB13228@lst.de>
References: <20200904165216.1799796-1-hch@lst.de> <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 08:15:03PM +0200, Arnd Bergmann wrote:
> Is there a bigger plan for the rest? I can probably have a look at the Arm
> OABI code if nobody else working on that yet.

m68knommu seems mostly trivial and not interact much with m68k/mmu,
so that woud be my next target.  All the other seems to share more
code for the mmu and nommu case, so they'd have to be done per arch.

arm would be my first target because it is used widespread, and its
current set_fs implemenetation is very strange.  But given thar you
help maintaining arm SOCs and probably know the arch code much better
than I do I'd be more than happy to leave that to you.
