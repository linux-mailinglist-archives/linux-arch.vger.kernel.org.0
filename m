Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD12D768C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436772AbgLKN2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 08:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392778AbgLKN1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 08:27:37 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Dec 2020 05:26:57 PST
Received: from orcam.me.uk (unknown [IPv6:2001:4190:8020::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3045AC0613CF;
        Fri, 11 Dec 2020 05:26:57 -0800 (PST)
Received: from bugs.linux-mips.org (eddie.linux-mips.org [IPv6:2a01:4f8:201:92aa::3])
        by orcam.me.uk (Postfix) with ESMTPS id 3E6062BE0F2;
        Fri, 11 Dec 2020 13:20:14 +0000 (GMT)
Date:   Fri, 11 Dec 2020 13:20:09 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: RFC: arch: shall we have generic readl_be()/writel_be()/... or
 in_be32()/out_be32() ?
In-Reply-To: <20201209202024.GA1355417@rowland.harvard.edu>
Message-ID: <alpine.LFD.2.21.2012111250320.2104409@eddie.linux-mips.org>
References: <da9cb964-18a7-bff1-1249-b0df24daa05e@metux.net> <20201209202024.GA1355417@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 9 Dec 2020, Alan Stern wrote:

> > I believe we should have generic functions, that all archs implement
> > (possibly doing automatic conversion, if necessary), which are used
> > by everybody else.
> > 
> > What's your oppionion on that ?
> 
> It certainly seems reasonable.  Another possibility, less stringent, is 
> to require that definitions exist on all architectures that can have 
> big-endian MMIO (or port-based IO).  For example, any architecture 
> which might select CONFIG_EHCI_BIG_ENDIAN_MMIO, as used in ehci.h.

 Lane swapping is a complex matter where there is an endianness mismatch 
between buses.  A bus bridge may implement the byte lane match policy or 
the bit lane match policy, or even both to choose from, perhaps on a 
case-by-case basis for individual accesses (e.g. with a pair of address 
windows decoded to the other bus according to a different policy each; I 
actually have such a system).

 Consequently not only data transferred may have to be transformed, but so 
may have the address used.  Also the transformation will be different 
depending on whether data accessed is to be interpreted numerically (where 
the bit lane match policy is more suitable) such as with CSR access, or as 
a byte stream (where the byte lane match policy is) such as with PIO data 
moves.

 See arch/mips/include/asm/io.h and arch/mips/include/asm/*/mangle-port.h 
for an example where we take care of different cases.

 Building infrastructure for doing this all in a generic manner would I 
think be a good idea, but then a major effort as well, and you'd have to 
coordinate it with all the arch maintainers.

  Maciej
