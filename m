Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5439822824B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgGUOeP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:34:15 -0400
Received: from verein.lst.de ([213.95.11.211]:52411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgGUOeP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 10:34:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6186C68AFE; Tue, 21 Jul 2020 16:34:12 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:34:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
Subject: Re: io_uring vs in_compat_syscall()
Message-ID: <20200721143412.GA8099@lst.de>
References: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk> <8987E376-6B13-4798-BDBA-616A457447CF@amacapital.net> <20200721070709.GB11432@lst.de> <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXWZBXZuCeRYvYY8AWG51e_P3bOeNeqc8zXPLOTDTHY0g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 07:31:02AM -0700, Andy Lutomirski wrote:
> > What do you mean with "properly wired up".  Do you really want to spread
> > ->compat_foo methods everywhere, including read and write?  I found
> > in_compat_syscall() a lot small and easier to maintain than all the
> > separate compat cruft.
> 
> I was imagining using a flag.  Some of the net code uses
> MSG_CMSG_COMPAT for this purpose.

Killing that nightmarish monster is what actually got me into looking
io_uring and starting this thread.
