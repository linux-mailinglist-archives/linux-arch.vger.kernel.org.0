Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16C653EC1C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiFFKk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiFFKkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 06:40:25 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0EF62AC5D;
        Mon,  6 Jun 2022 03:40:23 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9DC8C92009C; Mon,  6 Jun 2022 12:40:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9686692009B;
        Mon,  6 Jun 2022 11:40:21 +0100 (BST)
Date:   Mon, 6 Jun 2022 11:40:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Matt Wang <wwentao@vmware.com>
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
In-Reply-To: <20220606084109.4108188-6-arnd@kernel.org>
Message-ID: <alpine.DEB.2.21.2206061057060.19680@angie.orcam.me.uk>
References: <20220606084109.4108188-1-arnd@kernel.org> <20220606084109.4108188-6-arnd@kernel.org>
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

On Mon, 6 Jun 2022, Arnd Bergmann wrote:

> This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> 64-bit system enumeration error for Buslogic"), 8 years later.
> 
> The fact that this was found at all is an indication that there are
> users, and it seems that Maciej, Matt and Khalid all have access to
> this hardware, but if it took eight years to find the problem,
> it's likely that nobody actually relies on it.

 Umm, I use it with a 32-bit system, so it would be quite an issue for me 
to discover a problem with 64-bit configurations.  And I quite rely on 
this system for various stuff too!

> Remove it as part of the global virt_to_bus()/bus_to_virt() removal.
> If anyone is still interested in keeping this driver, the alternative
> is to stop it from using bus_to_virt(), possibly along the lines of
> how dpt_i2o gets around the same issue.

 Thanks for the pointer and for cc-ing me.  Please refrain from removing 
the driver at least for this release cycle and let me fix it.  It should 
be easy to mimic what I did for the defza driver: all bus addresses in the 
DMA API come associated with virtual addresses, so it is just a matter of 
recording those somewhere for later use rather than trying to mess up with 
bus addresses to figure out a reverse mapping.

  Maciej
