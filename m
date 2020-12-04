Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31752CEFF1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 15:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgLDOoU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 09:44:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387659AbgLDOoT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Dec 2020 09:44:19 -0500
Date:   Fri, 4 Dec 2020 15:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607093019;
        bh=8IFQb+g4CepgZFNlZSyPHbJfmLd+mYQGMaC2gGfCljI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTpZfMOy0th7vL1Rjoes4NAiWAo4V8xSUdno3IqvRKxZEU1IZaYZcHvvbI6oAnjIx
         7IlZjLdEXBP3U2HHtHW3Jpr69oT+hNCWMKCA0ihrf51BpncQh3Btg1SckzWphpMsgB
         2NVSI+ih0yZnOAXs3cwVpwiBIMJzJl/nvgHEnDQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] earlycon: simplify earlycon-table implementation
Message-ID: <X8pLYsprqsJMYanf@kroah.com>
References: <20201123102319.8090-1-johan@kernel.org>
 <20201123102319.8090-3-johan@kernel.org>
 <X8pBwTl7nZoOQ18m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8pBwTl7nZoOQ18m@localhost>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 04, 2020 at 03:03:45PM +0100, Johan Hovold wrote:
> Greg,
> 
> On Mon, Nov 23, 2020 at 11:23:13AM +0100, Johan Hovold wrote:
> > Instead of using the array-of-pointers trick to avoid having gcc mess up
> > the earlycon array stride, specify type alignment when declaring entries
> > to prevent gcc from increasing alignment.
> > 
> > This is essentially an alternative (one-line) fix to the problem
> > addressed by commit dd709e72cb93 ("earlycon: Use a pointer table to fix
> > __earlycon_table stride").
> > 
> > gcc can increase the alignment of larger objects with static extent as
> > an optimisation, but this can be suppressed by using the aligned
> > attribute when declaring variables.
> > 
> > Note that we have been relying on this behaviour for kernel parameters
> > for 16 years and it indeed hasn't changed since the introduction of the
> > aligned attribute in gcc-3.1.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Could you pick this one up for 5.11?

Sure, will pick this and patch 1/8 up now, thanks for the prod.

greg k-h
