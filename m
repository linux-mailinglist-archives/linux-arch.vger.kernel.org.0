Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406801B579
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2019 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfEMME4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 May 2019 08:04:56 -0400
Received: from verein.lst.de ([213.95.11.211]:38873 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfEMME4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 May 2019 08:04:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4D9D868AFE; Mon, 13 May 2019 14:04:35 +0200 (CEST)
Date:   Mon, 13 May 2019 14:04:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Message-ID: <20190513120435.GB22993@lst.de>
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com> <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com> <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com> <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com> <87woiutwq4.fsf@concordia.ellerman.id.au> <CACT4Y+YT52wGuARxe9RqUsMYGNZTwaBowWWUUawyqTBq4G1NDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YT52wGuARxe9RqUsMYGNZTwaBowWWUUawyqTBq4G1NDg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 13, 2019 at 01:50:19PM +0200, Dmitry Vyukov wrote:
> > We did have some bugs in the past (~1-2 y/ago) but AFAIK they are all
> > fixed now. These days I build most of my kernels with a bi-endian 64-bit
> > toolchain, and switching endian without running `make clean` also works.
> 
> For the record, yes, it turn out to be a problem in our code (a latent
> bug). We actually used host (x86) gcc to build as-if ppc code that can
> run on the host, so it defined neither LE no BE macros. It just
> happened to work in the past :)

So Nick was right and these checks actually are useful..
