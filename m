Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A77619244
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDH7D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDH7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 03:59:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E12DA;
        Fri,  4 Nov 2022 00:59:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E5D875C0096;
        Fri,  4 Nov 2022 03:58:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 03:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667548737; x=1667635137; bh=WLsXF8VSMf
        rCKRyOeBPs8DaU3UDGa1qmblIda8xJdq0=; b=L7RezY3WEtGld8lvkB/qzxrxoC
        r29N5C90Dpdj9jxpi5jYjA4ZvF6aP/Jhc8/kewGRDjccxpbTGJHXfY4OqL0zpwD8
        C+g8WDhQMDAXN9TwI6dGvAkNigBYCkIlnGNreIj6bynK1oomGuoAkY21BZuYRAob
        29AhDu9R9UBTuwhKrL5eWQrMAa9bWtbIb6pMGxujiug6QsPAfeAXYS8tRKFqrgF6
        tPDLyUp6wEx0a4l9xqNJGST+Cdq4F4rdkklX7D6RqiZvcSvUu6kIBx0CFWgq1YBG
        Q49CupBi8sHm+wopdvdxxDyuWk6uyTKP8pTEPqdhlco+haQvAbgnKyiktDUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667548737; x=1667635137; bh=WLsXF8VSMfrCKRyOeBPs8DaU3UDG
        a1qmblIda8xJdq0=; b=BU9oJrQ5G7/T+gkA14HjtyRy8pUpEQFxhEZOESPF5Enz
        Sf4VFwXyOCs4arzBsVjC/oLN8lB23h33tyo9R9dF9QDI557b/+p/GMu1yeqKVLYH
        MWLbm1GEkKzQNGC257Yq06xU3m9QrJUFK39oEiGqwqmmqrSqxz5+51VhHdUNazVD
        IP9lStzvuzrr+ZGaHYSJPfy4JFoPHfhRGrwIHmgytrqZhjMNJPcYFtsgirZ+W48H
        +YHIHbDrh3haEoQk7LdOHXuisD6T0ePwTq4DI6qDDPQAJJeklOhyKVAyjq1M6zop
        ukYrEKQBbDVGGCDR+FwOi6H0ZKTfrJ0rDZHhH3Aj0A==
X-ME-Sender: <xms:QcZkY4lVTl2SdhcFA8krnB-r0uH5Y8XCIj7c5_C_Rmqihds7Y-wKtA>
    <xme:QcZkY32ddQvQUJqJmSdsdnAVVMcqJi7osl3vBt2xh_JU0ncFmyPNOTCcACzz2aQ2B
    tYG8i2XE4IPNdrtZG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddtgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QcZkY2q0Lhle1ylZnJyXKl4Xx_wB2Gve9j7cPNDmWWelIIWV1EE1Cw>
    <xmx:QcZkY0l5lTHtKCdQFOGM3NFDFldX5lbp6Z5JHmYquwT6BueiqV-LEw>
    <xmx:QcZkY23-K8HVfS2NWOsXehaSlU86o1HcI4t4j-R4BD8aes8zMGAJxw>
    <xmx:QcZkY780slJfalZkalyjGKhgdrw11yOWWhepuiSvLo454NFIq-60Tg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ABF88B603ED; Fri,  4 Nov 2022 03:58:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <7383e5a2-5583-4d35-8a19-40a8c6f977ad@app.fastmail.com>
In-Reply-To: <20221104032808.24565-1-hanzj.it@gmail.com>
References: <20221104032808.24565-1-hanzj.it@gmail.com>
Date:   Fri, 04 Nov 2022 08:58:39 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "zhijun.han" <hanzj.it@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap the definition of CONFIG_SPARSEMEM_VMEMMAP and
 CONFIG_SPARSEMEM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 4, 2022, at 04:28, zhijun.han wrote:
> CONFIG_SPARSEMEM_VMEMMAP depends on CONFIG_SPARSEMEM
> When CONFIG_SPARSEMEM_VMEMMAP is enabled,
> CONFIG_SPARSEMEM will be enabled too.
> Causes __pfn_to_page and __page_to_pfn to be overwritten
>
> Signed-off-by: zhijun.han <hanzj.it@gmail.com>

I'm sorry, but I don't follow the logic here. Your explanation
makes sense, but from your patch it appears that your are
introducing the problem that you explain, instead of fixing it.

> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -19,12 +19,6 @@
>  #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
>  				 ARCH_PFN_OFFSET)
> 
> -#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
> -
> -/* memmap is virtually contiguous.  */
> -#define __pfn_to_page(pfn)	(vmemmap + (pfn))
> -#define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
> -
>  #elif defined(CONFIG_SPARSEMEM)
>  /*
>   * Note: section's mem_map is encoded to reflect its start_pfn.

What I see in the existing code is that checking
CONFIG_SPARSEMEM_VMEMMAP first catches only the case where
both SPARSEMEM and SPARSEMEM_VMEMMAP are set, so the third
elseif case is not used. When you swap them around, we
always get the definition for the SPARSEMEM case, since the
third elseif is never reached.

     Arnd
