Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558F27AE26
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgI1Mtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 08:49:33 -0400
Received: from verein.lst.de ([213.95.11.211]:35466 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgI1Mtd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 08:49:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CC5468B02; Mon, 28 Sep 2020 14:49:29 +0200 (CEST)
Date:   Mon, 28 Sep 2020 14:49:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: remove set_fs for riscv v2
Message-ID: <20200928124928.GA5834@lst.de>
References: <20200922043752.GA29151@lst.de> <mhng-9b0b114e-a104-40b7-b4f5-ad64dbbbd5bd@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-9b0b114e-a104-40b7-b4f5-ad64dbbbd5bd@palmerdabbelt-glaptop1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 26, 2020 at 10:50:52AM -0700, Palmer Dabbelt wrote:
> On Mon, 21 Sep 2020 21:37:52 PDT (-0700), Christoph Hellwig wrote:
>> Given tht we've not made much progress with the common branch,
>> are you fine just picking this up through the riscv tree for 5.10?
>>
>> I'll defer other architectures that depend on the common changes to
>> 5.11 then.
>
> I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
> on a temporary branch over here
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>
> under the assumption it might get lost otherwise, but let me know if that's not
> what you were looking for.

Well, we'll want it in linux-next and then 5.10.  Either a merge through
the RISC-V maintainer, or as part of the base branch from Al would
make sense to me.

>
> Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
> mail history, so sorry if I just missed it.
>
> Al: IIRC the plan here was to have me merge in a feature branch with this
> stuff, but it'd have to be based on your for-next as there are some
> dependencies over there.  I see 5ae4998b5d6f ("powerpc: remove address space
> overrides using set_fs()") in vfs/for-next so I think we should be OK, but let
> me know if I'm doing something wrong.
