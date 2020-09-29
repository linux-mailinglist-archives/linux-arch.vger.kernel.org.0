Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1927D561
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgI2SDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 14:03:43 -0400
Received: from verein.lst.de ([213.95.11.211]:41202 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgI2SDn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 14:03:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21E3667373; Tue, 29 Sep 2020 20:03:39 +0200 (CEST)
Date:   Tue, 29 Sep 2020 20:03:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: remove set_fs for riscv v2
Message-ID: <20200929180339.GA12546@lst.de>
References: <20200928124928.GA5834@lst.de> <mhng-a034d2ee-67eb-4432-be9e-66fff000acda@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-a034d2ee-67eb-4432-be9e-66fff000acda@palmerdabbelt-glaptop1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 28, 2020 at 09:45:30AM -0700, Palmer Dabbelt wrote:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>>>
>>> under the assumption it might get lost otherwise, but let me know if that's not
>>> what you were looking for.
>>
>> Well, we'll want it in linux-next and then 5.10.  Either a merge through
>> the RISC-V maintainer, or as part of the base branch from Al would
>> make sense to me.
>
> Sorry, I guess my question was really: does that branch have all the
> dependencies necessary for the RISC-V stuff to actually work?  IIRC this actual
> patch set depended on some other one, and while I thinK I got everything I
> don't want to pull in something broken.

The riscv patchset depend only on the base.set_fs branch in Als tree.
