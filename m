Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE5705446
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjEPQpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjEPQo7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 12:44:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB52D3;
        Tue, 16 May 2023 09:44:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AEB205C0136;
        Tue, 16 May 2023 12:44:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 12:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684255495; x=1684341895; bh=a0
        QSMgquVJjLt26wFDwRdzjQ08JBNc2KBuKLI/+RjAM=; b=N0PpyXwbn81UNs0mTk
        CK8vcJ+Ya3baLHBAwmINm2QXQwnvtL+ef3tXk9/d7LSS9V4jgE9g32pqFVFz9jCT
        VFFBs8v0y1FR1QktCwT29TJhsav97PVdzK4+jBqPQEOF3TtOCpsz8ViwOhTq3fqW
        zA0IlPPoGbXJAbHP25oxqfhfWrL7ri7GTLAQeQFgCJGJIr+mDKKlrsN2APYSLlnT
        KchPQ3F4BhgAU8IXZhkQp6aAisZkgvdEn4CwuwWyNHoxOIehtxzh/QeQGCEVHGuI
        KHacOtsTQYfB0mvoneFX8Nc7mJFrUEbVXPpterpGRDXRBE6fMdEEiwUTgmMH71Qc
        Em2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684255495; x=1684341895; bh=a0QSMgquVJjLt
        26wFDwRdzjQ08JBNc2KBuKLI/+RjAM=; b=YxffI1XPwbqKDUwGtvFhGU2qnv9ch
        1Vj0yHy8syP3p/peaebGufl83mFvuO9Si2On2q1vEgiPXLvur3b0nI+uWg5byPSf
        JfHpFDgzT+6Wau0o9DWX12V23xXM7WTLRB+qVo6Gesz6dnfNXLmQrLQ0EEJlJQ9E
        44fJwhQUtApdchK8Eph6dJHtkH1peBSpisPuEkGO6A6lu71M8LOHTzmgiIr8HfRc
        3yZhJXmn5QtqLoqxD2V4PuYYtgd0tlsq87ZPfjt/iUrWIUJfyvGUdc1adugh/Fwd
        NVheyAj1rOUTs3PE4sRIRizbGx2Eew+sO32fDi0+fawvsHLDlS8zKUZVA==
X-ME-Sender: <xms:BrNjZCSrrZwYMCL0d-loGJaPfBk9H2ag4M-K8es56hxd8mDchUBhiA>
    <xme:BrNjZHxS2gIf40mYzmi7Qwne77oIN9Ch_iqTXR7Ni7WHv2LOx7OorEmeK5_YKcc26
    YkEHV9eod_0eHY82jU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BrNjZP3ewObr83PLNkLP5EtAMz0Izu8Pr-GihzRz19WLhZ7WukCeEA>
    <xmx:BrNjZOCrlcQqOXKLSgIWE2nLEbUG_UlR_IjnRGCGJvMwQBt1-pdmbg>
    <xmx:BrNjZLgy6RqjNRC7t-XNuhh7wHuxW6FOljx_h3rFe0VJWuZ6zohlhw>
    <xmx:B7NjZGQB2OZD895s6d8jbrk3FyDUpdpGfLC1zeCxJqvOiLOcNppgew>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7EA51B60086; Tue, 16 May 2023 12:44:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <4e291030-99d9-4b8b-9389-9b8f2560b8e8@app.fastmail.com>
In-Reply-To: <2023051643-overtime-unbridle-7cdd@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-36-schnelle@linux.ibm.com>
 <2023051643-overtime-unbridle-7cdd@gregkh>
Date:   Tue, 16 May 2023 18:44:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Alan Stern" <stern@rowland.harvard.edu>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
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
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023, at 18:29, Greg Kroah-Hartman wrote:
> On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:

>>  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
>>  /* Support PCI only */
>>  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
>>  {
>> -	return inl(uhci->io_addr + reg);
>> +	return UHCI_IN(inl(uhci->io_addr + reg));
>>  }
>>  
>>  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
>>  {
>> -	outl(val, uhci->io_addr + reg);
>> +	UHCI_OUT(outl(val, uhci->io_addr + reg));
>
> I'm confused now.
>
> So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
>
> But if it isn't, then these are just no-ops that do nothing?  So then
> the driver will fail to work?  Why have these stubs at all?
>
> Why not just not build the driver at all if this option is not enabled?

If I remember correctly, the problem here is the lack of
abstractions in the uhci driver, it instead supports all
combinations of on-chip non-PCI devices using readb()/writeb()
and PCI devices using inb()/outb() in a shared codebase.

A particularly tricky combination is a kernel that supports on-chip
UHCI as well as CONFIG_USB_PCI (for EHCI/XHCI) but does not support
I/O ports because of platform limitations. The trick is to come up
with a set of changes that doesn't have to rewrite the entire logic
but also doesn't add an obscene number of #ifdef checks.

That said, there is a minor problem with the empty definition

+#define UHCI_OUT(x)

I think this should be "do { } while (0)" to avoid warnings
about empty if/else blocks.

    Arnd
