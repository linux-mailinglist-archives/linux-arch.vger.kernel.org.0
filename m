Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF99F6A975E
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCCMlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 07:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCMlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 07:41:19 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3525F501;
        Fri,  3 Mar 2023 04:41:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id EF03D5C00B5;
        Fri,  3 Mar 2023 07:41:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Mar 2023 07:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677847274; x=1677933674; bh=mi
        W7z/m1o3Z+JHrWEAUIQgA5k8V0IlAjl3B3oQaEa/8=; b=hhOAXcZA+/RUyzOHaZ
        T5ezvIZOpsKpWta+5rrs5rURKmZEvgPA6cw83GAsNk5jXNmWJNr/9JH0bGjrXp2V
        WH+LWyzvgh+Lmd4E1BP7NdQbPTUnbwYE6lsNzFqF6jiYIGm7T5+2Avki93acIgjk
        f9MAOtwpiiRYBRnujRdlHupSoNtrEjUG1Zk4z5/DevTsGYhYnGe9RFYZf8F5W537
        NeYcoSCLsfzCCNoZJBcvFV+X42im7M6vpQgJRK8gnRM4OKHB6JfskOzoovAMu5eN
        tTDriPdyV0XTLTJtZZn185F3N2o01MhpcOE9gK+BHgaLR4waa3wwNfma4dlQ8Cyn
        ZVZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677847274; x=1677933674; bh=miW7z/m1o3Z+J
        HrWEAUIQgA5k8V0IlAjl3B3oQaEa/8=; b=p+1grLR0ZatZ8NvlWEJIT2nBMwBaT
        JFJtPp4pdg9dZqck9YoxP5C4aMEZVQPW9OwIhuuJan0SIVnBAPm0atu/L5rBPctC
        JZPTRQevuPvq3TxG8iR2ts7EanRMNBbBpcBAuMIBWGc0Hu4MUUfNlqKH2zFWMqt5
        nxq3TezzlrAdE24np88ZQYJv3suX54SIYlhI7DPOfWKexOdBzmURa+3FKrsztG9c
        GuXOJHGjep6q4SYY9vMsFb7z5W2p36nywwTmZryx9RQ4CaiVfYBc5fJYtYHawrZC
        6E7bLbibTxM/arg414VxOX9I9r0LEICnX1UH7mhKm0NDsBWkm+nNd0psg==
X-ME-Sender: <xms:6uoBZEVQwp6OkhoBU01S8fGgNYB7fyNSR4GMzvEezBk5bR4IkkrX4g>
    <xme:6uoBZIlHbEpaBugk9eh7sWZ8iORnLfUKlz5r9Oa6HDgcw496BL7a_872ZWWVFXRjH
    6lQQaL0j7fobz_56ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6uoBZIbjC7Ao94WOmC3e9Cr3KWSWa4ymCPYLvQYGOF4k3DngGRZsAA>
    <xmx:6uoBZDWw5dsHJooqG79Be4AbeGx_3g3sWgw2hvSCg9hT_yhO7z8TIg>
    <xmx:6uoBZOloO6Bgm-tq5pjBSRwBaDm-JF7PUxLtpWoXf2JiNO8-UXuHwg>
    <xmx:6uoBZAcgJG7Ey3IgxXmgI3jZEVBLTl7rZaH63dIfEXc5jKsQPu-vyA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1679EB60089; Fri,  3 Mar 2023 07:41:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <a845b6b3-9f5f-4328-8c69-bbd4dd17caee@app.fastmail.com>
In-Reply-To: <20230303102817.212148-2-bhe@redhat.com>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-2-bhe@redhat.com>
Date:   Fri, 03 Mar 2023 13:40:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Helge Deller" <deller@gmx.de>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mips: add <asm-generic/io.h> including
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

On Fri, Mar 3, 2023, at 11:28, Baoquan He wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I think this is all good. I had look at what cleanups we could do as
follow-ups:

> +#define phys_to_virt phys_to_virt
>  static inline void * phys_to_virt(unsigned long address)
>  {
>  	return __va(address);

This is the same as the asm-generic version, so the mips definition
is no longer needed.

> @@ -359,6 +360,27 @@ __BUILD_MEMORY_PFX(__raw_, q, u64, 0)
>  __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
>  #endif
> 
> +#define readb readb
> +#define readw readw
> +#define readl readl
> +#define writeb writeb
> +#define writew writew
> +#define writel writel
> +
> +#ifdef CONFIG_64BIT
> +#define readq readq
> +#define writeq writeq
> +#define __raw_readq __raw_readq
> +#define __raw_writeq __raw_writeq
> +#endif
> +
> +#define __raw_readb __raw_readb
> +#define __raw_readw __raw_readw
> +#define __raw_readl __raw_readl
> +#define __raw_writeb __raw_writeb
> +#define __raw_writew __raw_writew
> +#define __raw_writel __raw_writel

The mips code defines the __raw variants with slightly different
semantics on both barriers and byteswap, which makes it impractical
to share any of the above.				

> +#define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned 
> char val, int count)
>  {
>  	memset((void __force *) addr, val, count);
>  }
> +#define memcpy_fromio memcpy_fromio
>  static inline void memcpy_fromio(void *dst, const volatile void 
> __iomem *src, int count)
>  {
>  	memcpy(dst, (void __force *) src, count);
>  }
> +#define memcpy_toio memcpy_toio

These are again the same as the generic version

    Arnd
