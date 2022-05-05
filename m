Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60D51C94E
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiEETkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETkY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 15:40:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2F5D5F0;
        Thu,  5 May 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D39A2B82F1F;
        Thu,  5 May 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB0C385A4;
        Thu,  5 May 2022 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651779401;
        bh=+uQJ0bW0qkeE3SZNF4X5sGRkQWAqu7ah627WCVYDnMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xe82v89SdPKM+B5/dZFGrGPugZyd8Avb/4vZXY9KREZS136ih/IfSrULHDoi+fkT0
         W2Mai2xTc0+8O0PI8aPHaN0Hu3Yr82+4oGtcpKMXs4y9afvaBKtK815/EZNb1Dz5jC
         ft4Wkr4TSHHPHmPUhq7/ptofwJqkHLiUqCsaPWKeyZ+tBQQEhMc1aV7g1Yd7OLYgyK
         weqVcWYsxlHhochBnLnzxpBHe54pjL9Jd8OUN1KK+gfaYHHgshEHKAPRhVc08BnG1s
         w7LhW2wIcUt+xFe0ha1kJUbnTr/xNw3BFhRwB3XtL/iSQY5PJjtPF31aTih4yZLYip
         ilp6iHzs2g6Iw==
Date:   Thu, 5 May 2022 14:36:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC v2 02/39] ACPI: add dependency on HAS_IOPORT
Message-ID: <20220505193636.GA509562@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849f53a613b66991c1661799583714fa1883094c.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 05, 2022 at 10:20:28AM +0200, Niklas Schnelle wrote:
> On Wed, 2022-05-04 at 21:58 +0200, Arnd Bergmann wrote:
> > On Wed, May 4, 2022 at 7:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Apr 29, 2022 at 03:50:00PM +0200, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > not being declared. As ACPI always uses I/O port access we simply depend
> > > > on HAS_IOPORT.
> > > 
> > > CONFIG_ACPI depends on ARCH_SUPPORTS_ACPI, which is only set by arm64,
> > > ia64, and x86, all of which support I/O port access.  So does this
> > > actually solve a problem?  I wouldn't think you'd be able to build
> > > ACPI on s390 even without this patch.
> > > "ACPI always uses I/O port access" is a pretty broad brush, and it
> > > would be useful to know specifically what the dependencies are.
> > > 
> > > Many ACPI hardware accesses use acpi_hw_read()/acpi_hw_write(), which
> > > use either MMIO or I/O port accesses depending on what the firmware
> > > told us.
> > 
> > I think this came from my original prototype of the series where I tested it
> > out on arm64 with HAS_IOPORT disabled. I would like to hide the definition
> > of inb()/outb() from include/asm-generic/io.h whenever CONFIG_HAS_IOPORT
> > is not set, and I was prototyping this on arm64.
> > 
> > There are uses of inb()/outb() in drivers/acpi/ec.c and drivers/acpi/osl.c,
> > which in turn are not optional in ACPI, so it seems that those are
> > required.
> > 
> > If we want to allow building arm64 without HAS_IOPORT for some reason,
> > that means either force-disabling ACPI as well, or changin ACPI to not
> > rely on port I/O. I think it's fine to leave that as a problem for whoever
> > wants to make HAS_IOPORT optional in the future, and drop the
> > dependency here.
> 
> I'll improve the commit message to make the dependency on HAS_IOPORT
> more clear. I also agree with Arnd that since all architectures where
> ACPI is useful have I/O ports making it work without I/O port access
> compiled in is for another day.

I don't really see the point of including this patch at all.  It
doesn't solve any existing problem.
