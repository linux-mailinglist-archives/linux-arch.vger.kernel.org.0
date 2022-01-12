Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15F48BF57
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiALH4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 02:56:14 -0500
Received: from verein.lst.de ([213.95.11.211]:45167 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237500AbiALH4O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jan 2022 02:56:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD67E68AFE; Wed, 12 Jan 2022 08:56:09 +0100 (CET)
Date:   Wed, 12 Jan 2022 08:56:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64
 in fcntl.h
Message-ID: <20220112075609.GA4854@lst.de>
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de> <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 11, 2022 at 04:33:30PM +0100, Arnd Bergmann wrote:
> This is a very subtle change to the exported UAPI header contents:
> On 64-bit architectures, the three unusable numbers are now always
> shown, rather than depending on a user-controlled symbol.

Well, the change is bigger and less subtle.  Before this change the
constants were never visible to userspace at all (except on mips),
because the #ifdef CONFIG_64BIT it never set for userspace builds.

> This is probably what we want here for compatibility reasons, but I think
> it should be explained in the changelog text, and I'd like Jeff or Bruce
> to comment on it as well: the alternative here would be to make the
> uapi definition depend on __BITS_PER_LONG==32, which is
> technically the right thing to do but more a of a change.

I can change this to #if __BITS_PER_LONG==32 || defined(__KERNEL__),
but it will still be change in what userspace sees.
