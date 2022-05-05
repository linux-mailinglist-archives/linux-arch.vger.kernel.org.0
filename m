Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C038151C956
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiEETmp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 15:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 15:42:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DE5D5F0;
        Thu,  5 May 2022 12:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FFBB82FAB;
        Thu,  5 May 2022 19:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BF1C385A4;
        Thu,  5 May 2022 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651779542;
        bh=nvJ0vKCyj+OxDQA4BLRRzvEtpD2Bij13dOiL8LL8YsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GCAXCFuH/hYZK9EncBIRU6MfSTdzmvcYVBiEkgukAJFyPch+57l6fM7K++h3l2ahh
         w8Wya2kzM9ZkI8cBsGkE0juf8uZt9tpiPAAY7FHcyNiixr7/8sbH2TRksQSaEkHSnh
         NSFqnE5jp1FrblYSSi0euVSGNBRFL7YApv7bpPPA47aC2oDo4TRc2bOA08+8FL1C3i
         TG1YWIhfbeu4EqAPOArqRNVSWpBeJiNJlqOxERmkXZG/ApBI243954L1v6uR2pWRkV
         rwaCj3TY/yBVdDPBd5tGIED3r9mzX3Uyf8l50hRScAGVvmWmbCZ2e2O1vexeqxKgIc
         pj2tFgc48frog==
Date:   Thu, 5 May 2022 14:38:59 -0500
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
Message-ID: <20220505193859.GA509737@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2205050917160.52331@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 05, 2022 at 09:45:14AM +0100, Maciej W. Rozycki wrote:
> On Wed, 4 May 2022, Bjorn Helgaas wrote:
> 
> > >  Well, yes, except I would expect POWER9_CPU (and any higher versions we 
> > > eventually get) to clear HAS_IOPORT.  Generic configurations (GENERIC_CPU) 
> > > would set HAS_IOPORT of course, as would any lower architecture variants 
> > > that do or may support port I/O (it's not clear to me if there are any 
> > > that do not).  Ideally a generic configuration would not issue accesses to 
> > > random MMIO locations for port I/O accesses via `inb'/`outb', etc. for 
> > > systems that do not support port I/O (which it now does, or at least used 
> > > to until recently).
> > 
> > It would seem weird to me that a module would build and run on a
> > generic kernel running on POWER9 (with some safe way of handling
> > inb/outb that don't actually work), but not on a kernel built
> > specifically for POWER9_CPU.
> 
>  Why?  If you say configure your Alpha kernel for ALPHA_JENSEN, a pure 
> EISA system, then you won't get PCI support nor any PCI drivers offered 
> even though a generic Alpha kernel will get them all and still run on a 
> Jensen system.  I find that no different from our case here.
> 
>  And if we do ever get TURBOchannel Alpha support, then a generic kernel 
> configuration will offer EISA, PCI and TURBOchannel drivers, while you 
> won't be offered TURBOchannel drivers for a PCI system and vice versa.  
> It would make no sense to me.
> 
>  Please mind that the main objective for system-specific configurations is 
> optimisation, including both size and speed, and a part of the solution is 
> discarding stuff that's irrelevant for the respective system.  So in our 
> case we do want any port I/O code not to be there at all in compiled code 
> and consequently any driver that absolutely requires port I/O code to work 
> will have to become a useless stub in its compiled form.  What would be 
> the point then of having it there in the first place except to spread 
> confusion?

Good points.
