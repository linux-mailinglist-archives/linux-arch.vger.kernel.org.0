Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5183C25F2ED
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 08:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIGGEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 02:04:00 -0400
Received: from verein.lst.de ([213.95.11.211]:47705 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIGGEA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 02:04:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09E1468BFE; Mon,  7 Sep 2020 08:03:57 +0200 (CEST)
Date:   Mon, 7 Sep 2020 08:03:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Subject: Re: remove set_fs for riscv
Message-ID: <20200907060356.GA18655@lst.de>
References: <20200904165216.1799796-1-hch@lst.de> <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com> <20200905071735.GB13228@lst.de> <CAK8P3a3BN-Afy4Gj+mGjxiKODUBZwjh+XRbXqQKV-uEhyhOTfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3BN-Afy4Gj+mGjxiKODUBZwjh+XRbXqQKV-uEhyhOTfA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 07, 2020 at 12:14:59AM +0200, Arnd Bergmann wrote:
> I've had a first pass at this now, see
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=arm-kill-set_fs
> 
> There are a couple of things in there that ended up uglier than I was
> hoping for, and it's completely untested beyond compilation. Is this
> roughly what you had in mind? I can do some testing then and post
> it to the Arm mailing list.

Looks sensible.  The OABI hacks a are a little ugly, but so would be
every other alternative.

Note that you don't need to add a TASK_SIZE_MAX definition to arm if you
base it on my series as that provides a default one.  I also think with
these changes arm/nommu should be able to use UACCESS_MEMCPY.
