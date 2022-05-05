Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97851C4A3
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359711AbiEEQKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbiEEQKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 12:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555285BE71;
        Thu,  5 May 2022 09:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E319761DBE;
        Thu,  5 May 2022 16:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE36AC385A8;
        Thu,  5 May 2022 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766789;
        bh=HeJH7eF4ifDBiPTU4r/Co26qfblY+S0aMxiysioj064=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NXuJijrIDHeyZ5qA542t4gNgVMPVJEulBUsSYQlWOi77cPNmXDZjLDfRsPFK/g/B1
         /+au2UD/p4bh/ns+G4e7ax654TMkR94aOo46OjyfqPaMyr0YoqUxMmKDuaoeFgCWyj
         onBZpU+8UVKRQxMp18MK/UEqsE0xEZ/kqkedcHdN54tOnHOG05Cc/A5ERMWqufM3Cg
         8laVInD24Cqa5cwzgivzj6ZTcCbk+QIHGMz0mzhxYNr6/Z42q5l7z7ZF5m5D5pdo4o
         DjZc1BE4jvc/4VD+5td9du3Nn7Kn7a5atB26Im2xGW/cwDjiabku2IJIMR6KqBrE30
         7167R9bAtgLeg==
Date:   Thu, 5 May 2022 11:06:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:MEGARAID SCSI/SAS DRIVERS" 
        <megaraidlinux.pdl@broadcom.com>
Subject: Re: [RFC v2 30/39] scsi: add HAS_IOPORT dependencies
Message-ID: <20220505160626.GA492390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0=HgkkSJ2edZxMDbyuTyNZK98oSi4rc6CL_b6RHAQ-OQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 04, 2022 at 11:34:48PM +0200, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 10:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 29, 2022 at 03:50:51PM +0200, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> >
> > Some of these drivers support devices using either I/O ports or MMIO.
> > Adding the HAS_IOPORT dependency means MMIO devices that *could* work
> > on systems without I/O ports, won't work.
> >
> > Even the MMIO-only devices are probably old and not of much interest.
> > But if you want to disable them even though they *could* work, I think
> > that's worth mentioning in the commit log.
> 
> I think this would again make more sense with the original CONFIG_LEGACY_PCI
> conditional than the generic HAS_IOPORT one. I don't remember what the
> objection was to that symbol.

I didn't really like CONFIG_LEGACY_PCI because it wasn't clearly
defined.
