Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4051BEC4
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356733AbiEEMHB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbiEEMHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 08:07:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F063D2AC7F;
        Thu,  5 May 2022 05:03:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8C73B92009C; Thu,  5 May 2022 14:03:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8024592009B;
        Thu,  5 May 2022 13:03:19 +0100 (BST)
Date:   Thu, 5 May 2022 13:03:19 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Arnd Bergmann' <arnd@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: RE: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
In-Reply-To: <145b4021c7b14ada95ba0acf6f294b96@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2205051254010.52331@angie.orcam.me.uk>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com> <20220503233802.GA420374@bhelgaas> <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com> <145b4021c7b14ada95ba0acf6f294b96@AcuMS.aculab.com>
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

On Wed, 4 May 2022, David Laight wrote:

> I think you can find cardbus cards that have a pci bridge and a cable
> link to an expansion chassis into which you can insert standard PCI cards.
> If you are really lucky the initial enumeration allocates the
> 'high field' bus numbers, io addresses and plenty of memory
> space to the bridge - otherwise you lose.

 No need to rely on luck as (given that no single size fits all) we have 
the `hpbussize', `hpiosize', `hpmemsize', `hpmmioprefsize', `hpmmiosize', 
options to the `pci=...' kernel parameter for people to tune the settings 
according to their needs.  I don't have such a CardBus option, but I do 
have a couple of such ExpressCard devices, and mixed PCIe/PCI expansion 
backplanes for them.

  Maciej
