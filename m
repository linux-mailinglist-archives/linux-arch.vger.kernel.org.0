Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784B2D4B97
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgLIUVH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 15:21:07 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33911 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732904AbgLIUVH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2020 15:21:07 -0500
Received: (qmail 1355904 invoked by uid 1000); 9 Dec 2020 15:20:24 -0500
Date:   Wed, 9 Dec 2020 15:20:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: RFC: arch: shall we have generic readl_be()/writel_be()/... or
 in_be32()/out_be32() ?
Message-ID: <20201209202024.GA1355417@rowland.harvard.edu>
References: <da9cb964-18a7-bff1-1249-b0df24daa05e@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9cb964-18a7-bff1-1249-b0df24daa05e@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 09, 2020 at 12:08:51PM +0100, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> while trying to make some more drivers compile-test'able, i've
> discovered some arch specific calls in here, eg.:
> 
> 
> In file included from
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci-spear.c:23:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
> In function 'ehci_readl':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:743:3:
> error: implicit declaration of function 'readl_be'; did you mean
> 'readsb'? [-Werror=implicit-function-declaration]
>   743 |   readl_be(regs) :
>       |   ^~~~~~~~
>       |   readsb
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
> In function 'ehci_writel':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:767:3:
> error: implicit declaration of function 'writel_be'; did you mean
> 'writesb'? [-Werror=implicit-function-declaration]
>   767 |   writel_be(val, regs) :
>       |   ^~~~~~~~~
>       |   writesb
> In file included from
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci-hcd.c:97:
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
> In function 'ehci_readl':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:743:3:
> error: implicit declaration of function 'readl_be'; did you mean
> 'readsb'? [-Werror=implicit-function-declaration]
>   743 |   readl_be(regs) :
>       |   ^~~~~~~~
>       |   readsb
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
> In function 'ehci_writel':
> /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:767:3:
> error: implicit declaration of function 'writel_be'; did you mean
> 'writesb'? [-Werror=implicit-function-declaration]
>   767 |   writel_be(val, regs) :
>       |   ^~~~~~~~~
>       |   writesb
> 
> 
> It seems that only few archs (microblaze, ppc, sparc) define them.
> 
> Also drivers/usb/host/ehci.h defines them, but only for one particular
> arch/subarch.
> 
> IIRC, these funcs are for accessing hw registers that are in BEs, so
> BE cpus can do direct access, while LE cpus need to do a conversion.
> 
> OTOH, we also have in_be32() / out_be32. They seem to do quite the same
> thing, referenced much more often, but also just defined on a few archs.
> 
> 
> I believe we should have generic functions, that all archs implement
> (possibly doing automatic conversion, if necessary), which are used
> by everybody else.
> 
> What's your oppionion on that ?

It certainly seems reasonable.  Another possibility, less stringent, is 
to require that definitions exist on all architectures that can have 
big-endian MMIO (or port-based IO).  For example, any architecture 
which might select CONFIG_EHCI_BIG_ENDIAN_MMIO, as used in ehci.h.

Otherwise we're left in the unfortunate position of having to provide 
definitions for these functions, but _only_ on architectures that don't 
already make their own definitions -- basically an impossible task.

Alan Stern
