Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6557052C1
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjEPPtV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjEPPsZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 11:48:25 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C9D7D82;
        Tue, 16 May 2023 08:48:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D22EA92009E; Tue, 16 May 2023 17:48:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CDA8492009D;
        Tue, 16 May 2023 16:48:02 +0100 (BST)
Date:   Tue, 16 May 2023 16:48:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-hams@vger.kernel.org
Subject: Re: [PATCH v4 20/41] net: handle HAS_IOPORT dependencies
In-Reply-To: <20230516110038.2413224-21-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2305161644060.50034@angie.orcam.me.uk>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com> <20230516110038.2413224-21-schnelle@linux.ibm.com>
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

On Tue, 16 May 2023, Niklas Schnelle wrote:

> diff --git a/drivers/net/fddi/defxx.c b/drivers/net/fddi/defxx.c
> index 1fef8a9b1a0f..0fbbb7286008 100644
> --- a/drivers/net/fddi/defxx.c
> +++ b/drivers/net/fddi/defxx.c
> @@ -254,7 +254,7 @@ static const char version[] =
>  #define DFX_BUS_TC(dev) 0
>  #endif
>  
> -#if defined(CONFIG_EISA) || defined(CONFIG_PCI)
> +#ifdef CONFIG_HAS_IOPORT
>  #define dfx_use_mmio bp->mmio
>  #else
>  #define dfx_use_mmio true

 For this part:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
