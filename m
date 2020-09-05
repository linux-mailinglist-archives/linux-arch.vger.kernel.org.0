Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B618525E5EB
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 09:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIEHOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 03:14:52 -0400
Received: from verein.lst.de ([213.95.11.211]:43936 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Sep 2020 03:14:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F1F6568BEB; Sat,  5 Sep 2020 09:14:47 +0200 (CEST)
Date:   Sat, 5 Sep 2020 09:14:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from,to}_user
Message-ID: <20200905071447.GA13228@lst.de>
References: <20200904165216.1799796-1-hch@lst.de> <20200904165216.1799796-4-hch@lst.de> <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 08:04:34PM +0200, Arnd Bergmann wrote:
> >         if (__builtin_constant_p(n)) {
> >                 switch(n) {
> >                 case 1:
> > -                       *(u8 *)to = *(u8 __force *)from;
> > +                       *(u8 *)to = get_unaligned((u8 __force *)from);
> >                         return 0;
> >                 case 2:
> > -                       *(u16 *)to = *(u16 __force *)from;
> > +                       *(u16 *)to = get_unaligned((u16 __force *)from);
> >                         return 0;
> 
> The change look correct and necessary, but I wonder if this could be done
> in a way that is a little easier on the compiler than the nested switch/case.
> 
> If I see it right, __put_user() and __get_user() can probably
> be reduced to a plain put_unaligned() and get_unaligned() here,
> which would simplify these a lot.
> 
> In turn it seems that the generic raw_copy_to_user() can just be the
> a plain memcpy(), IIRC the optimization for small sizes should also
> be done by modern compilers whenever they can.

Sure, I can look into that.
