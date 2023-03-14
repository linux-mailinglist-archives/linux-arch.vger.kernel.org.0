Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717A6B985F
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCNO5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCNO5X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 10:57:23 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A6A593C;
        Tue, 14 Mar 2023 07:57:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D021132006F5;
        Tue, 14 Mar 2023 10:57:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 10:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678805838; x=1678892238; bh=6z
        ZSL/E7gVS5gjraObogwzybH+u1BTfv3OspZHFfaKg=; b=RNZ7F5EwUKDhH4HBmz
        UelqlmaLHsd1/TaE0VGbUUbWVC15pfiy2nPv1+7ThLW5mTaD2Jl2f6skgawK/8Ba
        ZjVG/UutNBPqFQ9DfWnkm9QpAV1OoI/OwgtVYIZyUln3B2iyV292nMws80mEbBiP
        hRraei3acl2fgpdLMKUgIyfdNwzTHtJ3s9/igf/y6kK6FWNgfSD9Hj0dutd8zqZO
        os8lWL8AXSMuqK/Lk9X7wlTzAANzPHMytQfNuHzfD3yaDwsW5FWTc8WTNRdEldlf
        RL1fmG+CKZ4LTP8cR5vi+yRs7LvFkKNyjtQsivO/C6OiTfkXV6XIjbexIrF1YCLy
        v61A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678805838; x=1678892238; bh=6zZSL/E7gVS5g
        jraObogwzybH+u1BTfv3OspZHFfaKg=; b=Qk01aYskFyyWkYTrp9dXS04PR7r0H
        1Jy/cvzYCIJzAqmm52a79pwwj32q+ADkGMI47UptOh5GkX0KEXbDMqVABuGfW8xU
        Qw6IWE0X0InV0pZ46BBCrqdLr++7e2tiwKeyG904YhSKCdSgqi3chdNjmzbkwd1V
        lu4hLQ/xST2SVlDSAsUo6oJAoG2ZaeirWfRetGHspq5+emHWoBPvLP6WFUazZstQ
        MW4vxF+VWEj+mcJf2xHtDDF+v7lCjj8sbqcL4J4PnMG/PcGXgnl89/NumdZRLkmx
        rrqhN2i2hxEKFWkjUjdFttfep4H5j+fWSy7q6FH4OI/CSmqJ8aapfMDCQ==
X-ME-Sender: <xms:TIsQZBliAdgq_jXA_LMD9AW5ZE0Kft9twdb5nosdNulHATQjF-5_iQ>
    <xme:TIsQZM1Wu5tCOxEzol4aUigHAwgw71QCb96lctdtG9njtmgc1VLi1KXDFf9AF89cM
    B8quBVDa4OjnyYXcVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TYsQZHp7HGEPiyc-Sl0QJ9ezUOt1nIdGBzikbewDA01V_ch_ZtLnIQ>
    <xmx:TYsQZBmba9V3TT9jcXGy9ZgA85rM6WC8M6xtO-sCZe9NwXghqs8IQA>
    <xmx:TYsQZP1DeXEtth5ugrf8vRnAwAPWzGX3ssjOF8hacj9bX0WvnhZstg>
    <xmx:TosQZJMARat-h0WFyoloBvfL7bVnqH_Vv4zRmm2_hP5lf7DLaokuJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E0509B60086; Tue, 14 Mar 2023 10:57:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <9e89c4af-7682-4d30-93e7-703fde28180f@app.fastmail.com>
In-Reply-To: <20230314121216.413434-35-schnelle@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-35-schnelle@linux.ibm.com>
Date:   Tue, 14 Mar 2023 15:56:56 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        "Alan Stern" <stern@rowland.harvard.edu>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 34/38] usb: handle HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 13:12, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to guard sections of code calling them
> as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> drivers requiring these functions need to depend on HAS_IOPORT.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I would suggest splitting this patch up into separate bits for the AMD
quirks and the UHCI driver, possibly more if there are other parts
unrelated to that.

> +#ifdef CONFIG_HAS_IOPORT
>  /*
>   * Make sure the controller is completely inactive, unable to
>   * generate interrupts or do DMA.

Maybe check for both HAS_IOPORT and USB_UHCI_HCD ?

>  static inline int io_type_enabled(struct pci_dev *pdev, unsigned int 
> mask)
>  {
> @@ -725,6 +730,7 @@ static inline int io_type_enabled(struct pci_dev 
> *pdev, unsigned int mask)
> 
>  static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
>  {
> +#ifdef HAS_IOPORT
>  	unsigned long base = 0;
>  	int i;
> 
> @@ -739,6 +745,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
> 
>  	if (base)
>  		uhci_check_and_reset_hc(pdev, base);
> +#endif
>  }

> diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> index 0688c3e5bfe2..c77705d03ed0 100644
> --- a/drivers/usb/host/uhci-hcd.h
> +++ b/drivers/usb/host/uhci-hcd.h
> @@ -505,41 +505,49 @@ static inline bool uhci_is_aspeed(const struct 
> uhci_hcd *uhci)
>   * we use memory mapped registers.
>   */
> 
> +#ifdef CONFIG_HAS_IOPORT
> +#define UHCI_IN(x)	x
> +#define UHCI_OUT(x)	x
> +#else
> +#define UHCI_IN(x)	0
> +#define UHCI_OUT(x)
> +#endif
> +
>  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
>  /* Support PCI only */
>  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
>  {
> -	return inl(uhci->io_addr + reg);
> +	return UHCI_IN(inl(uhci->io_addr + reg));
>  }
> 

This looks a bit ugly, though I can't think of a version I
really like here though. Possibly merging this together with the
generic version would result in something better, like

#if defined(CONFIG_USB_UHCI_PCI) && defined(CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC)
/* Support PCI and non-PCI host controllers */
#define uhci_has_pci_registers(u)       ((u)->io_addr != 0)
#elif defined(CONFIG_USB_UHCI_PCI)
#define uhci_has_pci_registers(u)       1
#else           
/* Support non-PCI host controllers only */
#define uhci_has_pci_registers(u)       0
#endif 

static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
{
#ifdef CONfIG_USB_UHCI_PCI
        if (uhci_has_pci_registers(uhci))
                return inl(uhci->io_addr + reg);
        else
#endif
        if (uhci_is_aspeed(uhci))
                return readl(uhci->regs + uhci_aspeed_reg(reg));
        else
#ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
        if (uhci_big_endian_mmio(uhci))
                return readl_be(uhci->regs + reg);
        else
#endif
        return readl(uhci->regs + reg);
}

Obviously still ugly, not sure if anyone can come up with a better
version.

      Arnd
