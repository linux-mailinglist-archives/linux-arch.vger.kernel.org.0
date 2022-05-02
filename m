Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37E51702D
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 15:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiEBNYi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiEBNYh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 09:24:37 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12575645B;
        Mon,  2 May 2022 06:21:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 54E9C92009C; Mon,  2 May 2022 15:21:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 50E1992009B;
        Mon,  2 May 2022 14:21:06 +0100 (BST)
Date:   Mon, 2 May 2022 14:21:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     William Breathitt Gray <william.gray@linaro.org>
cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
In-Reply-To: <YmwGLrh4U+pVJo0m@fedora>
Message-ID: <alpine.DEB.2.21.2205021406080.64520@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora> <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com> <YmwGLrh4U+pVJo0m@fedora>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 29 Apr 2022, William Breathitt Gray wrote:

> > Good question. As far as I can see most (all?) of these have "select
> > ISA_BUS_API" which is "def_bool ISA". Now "config ISA" seems to
> > currently be repeated in architectures and doesn't have an explicit
> > HAS_IOPORT dependency (it maybe should have one). But it does only make
> > sense on architectures with HAS_IOPORT set.
> 
> There is such a thing as ISA DMA, but you'll still need to initialize
> the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
> "config ISA" is the right thing to do: all ISA devices are expected to
> communicate in some way via ioport.

 Strictly speaking you can make an ISA device that only does MMIO (and I 
believe in the early PC days there used to be ISA memory expansion cards 
along with the EMS standard) which is also why the host memory area in the 
15-16MiB range, the top 1MiB addressable on 16-bit ISA, can be excluded 
from decoding to DRAM and accesses made there forwarded to ISA in I 
believe all chipsets that provide actual ISA bus circuitry (rather than 
just a degenerate form like LPC).  That's an exception rather than the 
rule though, nearly all ISA devices do decode in the port I/O space.  
After all I/O is what the port I/O address space has been invented for.

 FWIW,

  Maciej
