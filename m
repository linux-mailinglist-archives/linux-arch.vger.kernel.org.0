Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2070480519
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 23:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhL0Wdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 17:33:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhL0Wdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 17:33:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333A86117B;
        Mon, 27 Dec 2021 22:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58DC36AE7;
        Mon, 27 Dec 2021 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640644430;
        bh=/sJY7Kisz1PSOFfZV+hFs5yhBktmtLqFb2f5YxJeypg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qwgGSPvatgMe1CpNXXSX+vv/ERMiU7z545ZfOCpO+f1+4P8hhpXjl+Wdgtyyc9ufd
         eD7w2TB3tYdV6BYtgGkzURzDTm/j3KniZsvqSyNieblnbr1y6Nx1wyJe+l3GqeKXv3
         o+6TyuA9rfBpIzNRhulx//qhQDoQlej1bluDv9OUWVVb/EYOyMeAESrlR2uFi9Bmqo
         fLjgW5tmyq6w3LTfgb8n0DPvlOp2bmTBChMh9OmDnr7ipigWHnLCauzsvWBjlhMiTt
         nJ5NRRTogGH5opz9tvGIIdHy6e6Eux9NyWRjGhXlzV0GuBtCCUx4oP0SdLRUjCsiIO
         /L9526LATEFLQ==
Date:   Mon, 27 Dec 2021 16:33:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: Re: [RFC 28/32] PCI: make quirk using inw() depend on HAS_IOPORT
Message-ID: <20211227223348.GA1545446@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-29-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 05:43:13PM +0100, Niklas Schnelle wrote:
> In the future inw()/outw() and friends will not be compiled on
> architectures without I/O port support.

This commit log actually doesn't say what the patch does.

I'm pretty sure this particular quirk is x86 specific and could
probably be moved to arch/x86/pci/fixup.c, where the #ifdef probably
wouldn't be needed.

If we keep it in drivers/pci, please update the subject line to make
it more specific and match the convention, e.g.,

  PCI: Compile quirk_tigerpoint_bm_sts() only when HAS_IOPORT set

BTW, git complains about some whitespace errors in other patches:

  Applying: char: impi, tpm: depend on HAS_IOPORT
  .git/rebase-apply/patch:92: trailing whitespace.
	    If you have a TPM security chip from Atmel say Yes and it
  .git/rebase-apply/patch:93: trailing whitespace.
	    will be accessible from within Linux.  To compile this driver
  warning: 2 lines add whitespace errors.
  Applying: video: handle HAS_IOPORT dependencies
  .git/rebase-apply/patch:23: trailing whitespace.

  warning: 1 line adds whitespace errors.

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..8624c98c57b2 100644
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
