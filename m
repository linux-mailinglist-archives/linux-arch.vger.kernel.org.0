Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF75519FB3
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349821AbiEDMmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349822AbiEDMmS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 08:42:18 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4376233A3B;
        Wed,  4 May 2022 05:38:36 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6A2FD92009C; Wed,  4 May 2022 14:38:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5C9E092009B;
        Wed,  4 May 2022 13:38:35 +0100 (BST)
Date:   Wed, 4 May 2022 13:38:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
In-Reply-To: <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2205041311280.9548@angie.orcam.me.uk>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com> <20220503233802.GA420374@bhelgaas> <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
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

On Wed, 4 May 2022, Arnd Bergmann wrote:

> Almost all architectures that support CONFIG_PCI also provide
> HAS_IOPORT today (at least at compile time, if not at runtime),
> with s390 as a notable exception. Any machines that have legacy
> PCI device support will also have I/O ports because a lot of
> legacy PCI cards used it, and any machine with a pc-card slot
> should also support legacy PCI devices.
> 
> If we get new architectures without I/O space in the future, they
> would certainly not care about supporting old cardbus devices.

 POWER9 is another architecture with no port I/O space[1]:

Table 3-2. PCIe TLP command summary
-----------+-----------------------------+-------------------------------
  Class    |           Type Name         |           Notes
===========+=============================+===============================
Completion | Completion without Data     | For PCI CFG Writes (nonposted)
           |                             | or for error responses.
Completion | Completion with Data        | CI load responses.
Nonposted  | Configuration Read Request  | Outbound only.
Nonposted  | Configuration Write Request | Outbound only.
Posted     | Message Request             | Inbound only.
Nonposted  | Memory Read Request         |
Posted     | Memory Write Request        |
===========+=============================+===============================
 1. All other valid PCIe command types are ignored and dropped.
 2. Invalid PCIe request command types will result in a completion
    response of Unsupported Request.
------------------------------------+------------------------------------

that we do support -- I have such a system.  And I guess POWER10 is the 
same, as will be all future architecture updates.

References:

[1] "Power Systems Host Bridge 4 (PHB4) Specification", Version 1.0, 
    International Business Machines Corporation, 27 July 2018, Section 3.1 
    "PHB4 Command Details", p.29

  Maciej
