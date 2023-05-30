Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09F71643A
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjE3OcI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjE3OcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 10:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15533E40;
        Tue, 30 May 2023 07:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A398A63174;
        Tue, 30 May 2023 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADBFC433EF;
        Tue, 30 May 2023 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685457102;
        bh=2UrwCBvsEb03Pam8cIultJu53VoGUD/3FOgTl1c+Y/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJyspx12pHz2lHcVcN3GA6XVe7qqTzzS50XBYdXCsdKUgbMT2EJwxdvDfc0pLdseB
         cM08kIsBd/7aNqwuU5T+1k2BMtvO7XqbGfg3csGvPTwf3ItZpURfPyYMpPpXgkihZx
         XqYyVZp+GdA0dkWXlfqyzQiAoktHp9+g3MsX68EY=
Date:   Tue, 30 May 2023 15:31:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 33/41] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <2023053019-shuffle-gusty-9b6b@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-34-schnelle@linux.ibm.com>
 <2023053059-self-mangle-30b6@gregkh>
 <891e6ac4-30ae-4b86-b692-3b6b7b8b4e57@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891e6ac4-30ae-4b86-b692-3b6b7b8b4e57@app.fastmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023 at 01:53:50PM +0200, Arnd Bergmann wrote:
> On Tue, May 30, 2023, at 12:48, Greg Kroah-Hartman wrote:
> > On Tue, May 16, 2023 at 01:00:29PM +0200, Niklas Schnelle wrote:
> >> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> >> not being declared. We thus need to add HAS_IOPORT as dependency for
> >> those drivers using them unconditionally. For 8250 based drivers some
> >> support MMIO only use so fence only the parts requiring I/O ports.
> >
> > Why can't you have dummy inb()/outb() so we don't need these #ifdefs all
> > over the place in .c files?  Was that documented somewhere?  We do that
> > for other driver/hardware apis, why are these so special they don't
> > deserve that?
> 
> That was what our original approach did years ago, and Linus rightfully
> rejected it. Almost every driver either requires inb()/outb() to do
> anything, or it doesn't use them at all. The 8250 uart is one of the
> few exceptions to this, as it has many variants.
> It would be possible to separate this out more in the 8250 driver
> as well and split it out into separate modules and indirect function
> pointers, but that would be a larger rework and have a higher
> risk of regressions.
> 
> Also, the 8250 driver is already full of #ifdef in .c files, 

Yeah, just trying to hope it could be better :(

Ok, I'll go queue up the v5 version of this patch now, thanks.

greg k-h
