Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87951AC22
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359483AbiEDSGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359845AbiEDSGN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 14:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051F50453;
        Wed,  4 May 2022 10:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC6CB8279D;
        Wed,  4 May 2022 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9272C385A5;
        Wed,  4 May 2022 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651684924;
        bh=7ebi4yCgI8D7GOL1tZDTxmOW2rgVmfcl5Te5keZEMNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JfwHZ5SOCyIL8P/OP1RJofkC9XAomZekXM4qGdrXC5F2aPwsjJp7se1LV9ou9hNg4
         4RCEWR+VpxXCfohJ0xC9VpOyUDih3avDDkGqjtM0UfT6QCb5LEMx7+mNUWhqw1LRFr
         mxiYwNx4tsZ3TJmett6XaF+dRwVbvmTBj3LOu3bgPGz1Xy4Pn8KTUmyB1zQ6/GVfw/
         PcxBW90bAJYgLMdCVEINGl+WrO6UpvanuOeTW30/73DKgxHOK5azQnDeS6BYB9PNXx
         eUpeQ4wQcOKt/jwspavfT1+dDqKe4zFl0CYVjtE1WlVET9oTaQV913dMk6mqwxgUtM
         rw/Hsz2jFhhmw==
Date:   Wed, 4 May 2022 12:22:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
Message-ID: <20220504172201.GA454911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2205041516110.9548@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 04, 2022 at 03:24:39PM +0100, Maciej W. Rozycki wrote:
> On Wed, 4 May 2022, Arnd Bergmann wrote:
> 
> > >  POWER9 is another architecture with no port I/O space[1]:
> > 
> > POWER9 is just an implementation of the power architecture
> > that has a particular PCI host bridge. I would assume that
> > arch/powerpc/ would continue to set HAS_IOPORT because
> > it knows how to access I/O ports at compile-time.
> 
>  Well, yes, except I would expect POWER9_CPU (and any higher versions we 
> eventually get) to clear HAS_IOPORT.  Generic configurations (GENERIC_CPU) 
> would set HAS_IOPORT of course, as would any lower architecture variants 
> that do or may support port I/O (it's not clear to me if there are any 
> that do not).  Ideally a generic configuration would not issue accesses to 
> random MMIO locations for port I/O accesses via `inb'/`outb', etc. for 
> systems that do not support port I/O (which it now does, or at least used 
> to until recently).

It would seem weird to me that a module would build and run on a
generic kernel running on POWER9 (with some safe way of handling
inb/outb that don't actually work), but not on a kernel built
specifically for POWER9_CPU.

It sounds like inb/outb in a generic kernel on POWER9 may not
currently do something sensible, but that's fixable, e.g., make inb()
return 0xff and outb() a no-op.  I would naively expect the same
behavior in a POWER9_CPU kernel.

Bjorn
