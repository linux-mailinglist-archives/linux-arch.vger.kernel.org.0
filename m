Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72A8543B86
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiFHSa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiFHSa5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 14:30:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A16371A9A;
        Wed,  8 Jun 2022 11:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5E9CCE2AB5;
        Wed,  8 Jun 2022 18:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCEEC34116;
        Wed,  8 Jun 2022 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654713052;
        bh=b9/kuuRQQRjEDP11Tq7tcmL9Mh2gUfgYbjzpa6WdSrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmmAYTA9PuNar1v31NXBSFYDEJA0kA20A8iYlUj2z07K+0UOJkLA/CZbuzBHZ6vsu
         S8C42PmLhQ76TfkCd89qmGUHz6GULFUCBNmaS/5Y+AWmiDj4nBm2p8C3ArL1QmuU/i
         Nh4U0izTFw5tBBZbuF6I8HZlyxoo4AJZIYdwAAIQnIUPiLujS9lI8FtZgYEGOsc97i
         WZ6rCZwYnKjjogI100alNR0f1ChfcmPDF+4KoMw+mi7Iln0vIIHb9VMl9wLEmDf2dz
         xaS2/bJd6t+vdinpU7ZR5W+XSIFJAmKySS/DdH6rZnKDwcScsP3kA94n4P+ztvFqu9
         4hzsWson2Ee2A==
Date:   Wed, 8 Jun 2022 13:30:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC v2 23/39] PCI: make quirk using inw() depend on HAS_IOPORT
Message-ID: <20220608183051.GA409319@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-40-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In subject, s/make quirk/Make quirk/

On Fri, Apr 29, 2022 at 03:50:37PM +0200, Niklas Schnelle wrote:
> In the future inw() and friends will not be compiled on architectures
> without I/O port support.

Commit log should say what the patch does.  Even if it's in the
subject, make the commit log stand alone.

With the above,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index da829274fc66..27db2810f034 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -265,6 +265,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_d
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs);
>  
> +#ifdef CONFIG_HAS_IOPORT
>  /*
>   * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
>   * for some HT machines to use C4 w/o hanging.
> @@ -284,6 +285,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk_tigerpoint_bm_sts);
> +#endif
>  
>  /* Chipsets where PCI->PCI transfers vanish or hang */
>  static void quirk_nopcipci(struct pci_dev *dev)
> -- 
> 2.32.0
> 
