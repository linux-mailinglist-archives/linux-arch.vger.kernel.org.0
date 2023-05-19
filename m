Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8339470A1E9
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 23:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjESVlr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESVlq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 17:41:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28108101;
        Fri, 19 May 2023 14:41:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2C1393200925;
        Fri, 19 May 2023 17:41:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 May 2023 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684532503; x=1684618903; bh=RL/RXnHOsyLosRtIdXJJbgFnaCebGNgTFt6
        bhDzi1tw=; b=UVCI25ZCCLSzG0WlYVUB6RdiUW4HCrfuX+gllhS3rc80NY4JoBR
        QBipnow5RCJaovtLU+GNVjAUJylzhijKT6BZeXmjuBaQUT36B7syrc7pTZA3V5Lu
        26vuIlMV8IkZ7PSSe+kvTdpKQTWzoD9mxouFHB190+QYpnqPuYnb/lCP9oxoa5Az
        0q6Wk0WKSRmPCKeEy//rS5tcQ8fUdxWqa3hatRLoZa2lymMtloG0L3nY0eFyNh2V
        9pYSBRvnNxRv8njue6AoCcOjSNxhObND1RR34hHv9N8ssAAWukJkABTWDtJcKqZn
        EyxocoyjwExT4vcWx1xW9tXIO5GBOubvhNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684532503; x=1684618903; bh=RL/RXnHOsyLosRtIdXJJbgFnaCebGNgTFt6
        bhDzi1tw=; b=XjvyU0F+bKWHfqo+oWA4q8Nl4u6R+k6Zq1sfusGFH2ilLeWjfDo
        mjwdzwT6udfdZgVWGFjSeKvrtIelAIU7ELePR9TEbv0KukuqzC9OjLT/0zCA7l2V
        VaPt/N48hQn0UxZSlE9rQ6EaUa816vsk0pKOT/wjC16RpF1hBFWcrp1DictGrXVf
        kxK1wVxd7xGEJpt6ZQhBuLbGG4QbVEd4oYZ6OLyd8jk1XoYgsY9XQuWl4wJxvLS7
        4uncQWNFvj9FUR7pIMNZdhdn2X6cVKCs8+6wUNRQ431OeK8BxW+p9F1Q/9F+yT0/
        WbHhSj/ndpXe43mrJr/Dq7vTHUYnaSmDs0Q==
X-ME-Sender: <xms:F-1nZGAXbigZcdekbzdHOwypQH91F2hFD6RovVULxbJBgbkK7rZx6A>
    <xme:F-1nZAhQVjTfvszqBEdNVEgjkRxtwIKQnCHMw8ezzMjFqWR0ke41uMsAdnPoLJ4-7
    fL-p5GHGNRcp7Mll3I>
X-ME-Received: <xmr:F-1nZJmbZ4MQsBPAdFCjKHF1UgugPmUlWuQZGxhfGt0mZ-Mr0hOb7-g5oXxirsG9ctgp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefhffelvdfg
    udeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:F-1nZEwi2GzK3b8VyOTgxLBZ9fQWl2aEiKXJqJySUE9TrpMqg0Wu2A>
    <xmx:F-1nZLSmKkmPWMmZvjbhRIH4kfW5LqcILMH5DOygqAe2WAFvcotGnQ>
    <xmx:F-1nZPZOxb9BsWVy_fqiLKKvSOpQfW9ZayviXdM9GJ9KR8aYVbvZZg>
    <xmx:F-1nZMLBc4uW_CK8-_a5VTw9_s8J--VDcea3_xnuXBmwLVHaYcxrBQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 17:41:42 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
Date:   Fri, 19 May 2023 22:41:31 +0100
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <07FC59A6-862A-41E3-A8A9-545A6D0A42FE@flygoat.com>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
 <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8819=E6=97=A5 22:05=EF=BC=8CArnd Bergmann =
<arnd@arndb.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, May 19, 2023, at 21:51, Jiaxun Yang wrote:
>> With the adding, some default ioremap_xx methods defined in
>> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
>> NULL.
>>=20
>> We also massaged various headers to avoid nested includes.
>>=20
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> [jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Cc: linux-mips@vger.kernel.org
>> ---
>> Tested against qemu malta 34Kf, boston I6500, Loongson64, hopefully
>> everything is fine now.
>=20
> Thanks a lot for figuring this out!
>>=20
>> @@ -44,6 +42,11 @@
>> # define __raw_ioswabq(a, x) (x)
>> # define ____raw_ioswabq(a, x) (x)
>>=20
>> +# define _ioswabb ioswabb
>> +# define _ioswabw ioswabw
>> +# define _ioswabl ioswabl
>> +# define _ioswabq ioswabq
>> +
>=20
> I'm missing something here, what are these macros used for in addition
> to the non-underscore versions?

Since now {in,out}{bwlq} have a `_` in prefix, it needs a corresponding
ioswab variant to work.

>=20
>> +#define memset_io memset_io
>> static inline void memset_io(volatile void __iomem *addr, unsigned=20
>> char val, int count)
>> {
>> memset((void __force *) addr, val, count);
>> }
>> +#define memcpy_fromio memcpy_fromio
>> static inline void memcpy_fromio(void *dst, const volatile void=20
>> __iomem *src, int count)
>> {
>> memcpy(dst, (void __force *) src, count);
>> }
>> +#define memcpy_toio memcpy_toio
>> static inline void memcpy_toio(volatile void __iomem *dst, const void=20=

>> *src, int count)
>> {
>> memcpy((void __force *) dst, src, count);
>=20
> These three could probably go away now, as they are identical
> to the asm-generic version. Not important though.

Will update in a follow-up patch, I=E2=80=99m planing to do some cleanup =
for those
headers later.

>=20
>> @@ -549,6 +555,47 @@ extern void (*_dma_cache_inv)(unsigned long =
start,=20
>> unsigned long size);
>> #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) +=20
>> __CSR_32_ADJUST) =3D (v))
>> #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) +=20
>> __CSR_32_ADJUST))
>>=20
>> +
>> +#define __raw_readb __raw_readb
>> +#define __raw_readw __raw_readw
>> +#define __raw_readl __raw_readl
>> +#define __raw_readq __raw_readq
>> +#define __raw_writeb __raw_writeb
>> +#define __raw_writew __raw_writew
>> +#define __raw_writel __raw_writel
>> +#define __raw_writeq __raw_writeq
>> +
>> +#define readb readb
>> +#define readw readw
>> +#define readl readl
>> +#define writeb writeb
>> +#define writew writew
>> +#define writel writel
>> +
>> +#define readsb readsb
>> +#define readsw readsw
>> +#define readsl readsl
>> +#define readsq readsq
>> +#define writesb writesb
>> +#define writesw writesw
>> +#define writesl writesl
>> +#define writesq writesq
>=20
> As far as I can tell, the readsq()/writesq() helpers are currently
> only defined on 64-bit, it's probably best to leave it that way.

Will opt-out them on 32 bit build.

>=20
> On most other architectures, we also don't define __raw_readq()
> and __raw_writeq() on 32-bit because they lose the atomicity that
> might be required for FIFO accesses, but the existing MIPS version
> has them, so changing those should be a separate patch after it
> can be shown to not break anything.

Current implementation of __raw_readq __raw_readq  will check for =
CPU=E2=80=99s
64bit support and do a 64bit access if possible, it=E2=80=99s helpful =
for running
32 bit kernel on 64 bit CPUs.

Thanks
- Jiaxun

>=20
>     Arnd


