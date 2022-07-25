Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9922658035C
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jul 2022 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiGYRLE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jul 2022 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiGYRLC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2022 13:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8D13E16;
        Mon, 25 Jul 2022 10:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1DC361345;
        Mon, 25 Jul 2022 17:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D49C341C6;
        Mon, 25 Jul 2022 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658769061;
        bh=SKW2lL3RlrSi+/8Qu/3N2lRnWb6J3ulHowVphz7pQtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sPQ7nARImAwmj+nzuV8LmZgvN1dpsNBcLWMAICfr/sXPG+RikK6b14xwlJHc4Sr7H
         N++SSGKbS7ZkK8OchvHd1uKqqpW7mhSKuNxbelpGtgl9F5usierf+i3luVwrUzmpt9
         3aqirHSNSt3/X5McCYtntpw+USgiHiS0a/KT1U1m2HkajGK6Gey9TFfHOtiVDEejNX
         /xoU88ySj9oUikU3hP+hjcKgJL9l5rLMZIas4W5cbJmuopgK0V0U+CfdM+N2d3pevr
         QVSj5KZh125f9r/pPjQuLQwIslplYeZQwLfGydP1sJtSpPgy4DGme2vIolPHyG50Q8
         poIXnqWG5WbAg==
Date:   Mon, 25 Jul 2022 12:10:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/3] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Message-ID: <20220725171059.GA5779@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725020737.1221739-2-shorne@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 25, 2022 at 11:07:35AM +0900, Stafford Horne wrote:
> When building OpenRISC PCI which has no ioport_map we get the following build
> error.
> 
>     lib/pci_iomap.c: In function 'pci_iomap_range':
>       CC      drivers/i2c/i2c-core-base.o
>     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
>        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>           |                                         ^~~~~~~~~~
>     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
>        44 |                 return __pci_ioport_map(dev, start, len);
>           |                        ^~~~~~~~~~~~~~~~
> 
> This patch adds a NULL definition of __pci_ioport_map for architetures
> which do not support ioport_map.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will go via some other tree; let me know if otherwise.

> ---
>  include/asm-generic/pci_iomap.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index 5a2f9bf53384..8fbb0a55545d 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -25,6 +25,8 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  #ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
>  extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
>  				      unsigned int nr);
> +#elif !defined(CONFIG_HAS_IOPORT_MAP)
> +#define __pci_ioport_map(dev, port, nr) NULL
>  #else
>  #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>  #endif
> -- 
> 2.36.1
> 
