Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5546951CB91
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386081AbiEEVru (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 17:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386089AbiEEVrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 17:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A05EDC2;
        Thu,  5 May 2022 14:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB2C61F0F;
        Thu,  5 May 2022 21:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E1C385A8;
        Thu,  5 May 2022 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651787046;
        bh=epemp84j4xj21AKIY1Y6/uEGtGWjrK9bsJzhHmU8nk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YdViTLUMWWNFhptNqUPe/CDvcg3vJPSAhcTKuwkx6pGLKcQFoYIUujs5zIPtxeVPz
         fiMoQgcUqHqa6NogLYfdihJti1NmWbx9CEk6LAr34SJ3Skkqz1Qa8iXagSjg3XGTTJ
         ZdsVnmc9OMjPsNnmf3+SS/AV8vhLxS0+MTqjAcuxBALQx2F4eXkCARE6L/A7ASQeWo
         cADc0aj0Tc/0rwOklZ4R/XpNmNIvyUwQlKC5QmQgimQEYjMvdiDh+zY/kh4rdSiwjR
         09OW5+b+NGJC9Ucj2KuLNRSx/jKdpAOgoiIxG2H5yhXSQ5nCcv/ARPEzKT5oksMTrF
         NCpl59yv+xf2A==
Date:   Thu, 5 May 2022 16:44:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 33/37] PCI: make quirk using inw() depend on HAS_IOPORT
Message-ID: <20220505214403.GA517655@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-60-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:57PM +0200, Niklas Schnelle wrote:
> In the future inw() and friends will not be compiled on architectures
> without I/O port support.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

After capitalizing "Make" in the subject,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
