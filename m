Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D26A7BAC
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCBHNR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 02:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBHNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 02:13:16 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AEB13DE0;
        Wed,  1 Mar 2023 23:13:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C136332007E8;
        Thu,  2 Mar 2023 02:13:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Mar 2023 02:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677741189; x=1677827589; bh=kG
        Zk/ZSES0uDeincOVUYwzfC8LsnwfhTz4QhmBeE1uo=; b=rWuj+oY9nZyiLBlQ65
        Z2lbPD/6Wc+HW7YZdFLPmSGzFiz8EY7Pptdm4m+a1AW4IpaRxDjSHFLDhKolcqoK
        vZ5BcM5SczEOStXZ3ziqhulDfXeFmPZX3otZfxOBSbOMsqd6v/LXOutKDdQlMEhE
        5vtiRUCc1SGophm87H5r+iJWi0Hl8oC1QEgkd7DJALk9imESHMQWP9JwHnRuDvXP
        JOdJJw6+1nRL63ALo+U1bl9/RpQJJMVOTZ9PS2J5Khu5F9xM0FzZ7hVgWkhGpoHI
        Pz5UXm1g6oeFY2Wwu1Y94aCb+nWQG3PhhWuatKDwe/Q/Ue1cVJcJ0YNBKHRoS+fh
        jIYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677741189; x=1677827589; bh=kGZk/ZSES0uDe
        incOVUYwzfC8LsnwfhTz4QhmBeE1uo=; b=OZOSbFPBkowy8HYOohMIePdMYe0ca
        8pjqNX4CV6DtjahbMVk92ejsYszVZnC0GOR0EzjdWE44eMJg6Pa1umUBJDQeVVZJ
        B9XY1Y2iEDjrhnp3Xm3AuCjB4tH+MwREq2ibPretWPNSmQPuPDyVtBYqW31/N8h9
        GCJUHB+qA1XI5t631UweyWWOenWQ/gXGi1GZzw3eCuNSL5b7cspH3vUhTDjnmgT1
        IajsEiO6OmhFfyXd/ZUMMeunX/8B2wjVX5Ytbpjj6nt2yr3VYAU0/ZDAb3N/y72F
        maXPD1C5wFTBujLWAtJRpUTGmAhWgck6D2ukqoqDNDWBx24bJJZNGNHKw==
X-ME-Sender: <xms:hEwAZJNc38Zpde-_b15n9O3oFr--8ydU9f2_eUfeU3sgSTpZduBS6Q>
    <xme:hEwAZL-YwHOdGyv3FtelSboVvDuuURqoIl4JEKaibyQ5gPrYiiLCAIvB8mto9v4F2
    a6isMLBcc33y21YuqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeliedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hEwAZIT7sLujkcqDLLPgnZwb_onF8qMzKkdwSAnHP3AhsTdUrmjyqQ>
    <xmx:hEwAZFsb54avJmLxekcI23Uxl8BJorb4sBIGjEJG7XNt1PK2kG5SFg>
    <xmx:hEwAZBcsInGGJCDs4Um5xLDm8gO73R8xs1JZsGfzxid6FJCSjTYTHA>
    <xmx:hUwAZAzNZbkhsuWgnz7I82j3FVumflnhb9YrLhV4x0qvHNddwHq4rA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73253B60086; Thu,  2 Mar 2023 02:13:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <b2958824-786b-46d7-a880-17c948fbe2b0@app.fastmail.com>
In-Reply-To: <ZAAiJcx80RU0QuHw@MiWiFi-R3L-srv>
References: <20230301102208.148490-1-bhe@redhat.com>
 <20230301102208.148490-2-bhe@redhat.com>
 <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
 <ZAAiJcx80RU0QuHw@MiWiFi-R3L-srv>
Date:   Thu, 02 Mar 2023 08:12:48 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: add <asm-generic/io.h> including
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 2, 2023, at 05:12, Baoquan He wrote:
> On 03/01/23 at 03:06pm, Arnd Bergmann wrote:
>
> Yeah, defining mmiowb() to wmb() directly is also good to me. I tried
> to comb including sequence and find where asm/io.h is included, but
> failed. Mainly asm/mmiowb.h including asm/io.h will cause below
> compiling error, the asm/io.h need see mmiowb_set_pending which is
> defnined in asm-generic/mmiowb.h. Moving asm-generic/mmiowb.h to above
> asm/io.h can also fix the compiling error.
>
> =============
> diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
> index a40824e3ef8e..cae2745935bc 100644
> --- a/arch/mips/include/asm/mmiowb.h
> +++ b/arch/mips/include/asm/mmiowb.h
> @@ -2,10 +2,8 @@
>  #ifndef _ASM_MMIOWB_H
>  #define _ASM_MMIOWB_H
> 
> +#include <asm-generic/mmiowb.h>
>  #include <asm/io.h>
> 
>  #define mmiowb()       iobarrier_w()
> -
> -#include <asm-generic/mmiowb.h>
> -
>  #endif /* _ASM_MMIOWB_H */

According to the comment in asm-generic/mmiowb.h, the intention is
to have the mmiowb definition before the #include, though this would
only be necessary if there was an "#ifndef mmiowb" fallback in that
file. If the definition to wmb() works, I'd go for that one and
leave the include order unchanged.

       Arnd
