Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84A9716462
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjE3OjU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjE3OjT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 10:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139958F;
        Tue, 30 May 2023 07:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C386167D;
        Tue, 30 May 2023 14:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C03BC433D2;
        Tue, 30 May 2023 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685457557;
        bh=o4tpbU823ZvDH0zikrH1WbEEN9ld+0DC5TSzAlggrDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFC4dNFYo6U2/cb0RD/dYedoJi79GLYvB3vEqJn92ZYsZlvchM4SABG7CLX/g1bfX
         8D27fV7G77wYR5HeLP6H/UZMsRlSrow6OygdI1SM/3f3/DrupT3g8bJKOUfqgJ9DvT
         NZZgdlqs3/WDB3GCSRKO2kdSQfFd5lMOA3BNGhXY=
Date:   Tue, 30 May 2023 15:39:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 35/44] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <2023053050-prodigal-shine-4d1c@gregkh>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-36-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522105049.1467313-36-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 22, 2023 at 12:50:40PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them unconditionally. For 8250 based drivers some
> support MMIO only use so fence only the parts requiring I/O ports.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/tty/Kconfig                  |  4 +--
>  drivers/tty/serial/8250/8250_early.c |  4 +++
>  drivers/tty/serial/8250/8250_pci.c   | 14 +++++++++
>  drivers/tty/serial/8250/8250_port.c  | 44 +++++++++++++++++++++++-----
>  drivers/tty/serial/8250/Kconfig      |  5 ++--
>  drivers/tty/serial/Kconfig           |  2 +-
>  6 files changed, 60 insertions(+), 13 deletions(-)

This doesn't apply at all to my tree, so I'll just let you take it as
there must be some merge issues somewhere:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
