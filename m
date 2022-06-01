Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CA53A490
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiFAMKF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFAMKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:10:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE656764;
        Wed,  1 Jun 2022 05:10:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CAF6B5C0306;
        Wed,  1 Jun 2022 08:10:01 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654085401; x=
        1654171801; bh=0XjGKcz50nGenmNIxdLNy27/3re77DIlIrd7gqENl9Q=; b=K
        +f1gsDRS2FFGo+XYiLO+0BBPFOLGEZcpmDqlfxkmk1ZAhgk7xLU7itci/jDjoZL1
        ZlXHsJmPlFPPMLsZpVOGAOJWl0a3LUleA0Rm6mBLVwy9n1T3whkFJzP2VlaycL+V
        e35baOTglilbBImQxAYieqe3HQOr3075DG0+AiDtJTKasZt8yDCBGqevupUr3r8v
        8Y33VuJX2Emw7DaKARqqK8qUT3dNis6O9TDF5kL7KyT6GkStVUXYz63bU1tvmLRd
        9qxfugES228HOQ2T9Dgni8DYG/bhPfLOxjtFsvpdIqIeaoU3Z3+7f3zUjeI1Hlm/
        QufLDAoJW73/MkohZgzMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654085401; x=
        1654171801; bh=0XjGKcz50nGenmNIxdLNy27/3re77DIlIrd7gqENl9Q=; b=l
        KE1BQVeIJAOygcswiLzC4glM/fnK86lZBAINK/64dDInPezpQb3YqN6chLRQpCAI
        OvW14214k6LiATSdGAzMKwqXc0Wcr/uV2E9IM0mOFtKY5D1yz8XMbJ82qFhcUoKV
        Ktz49SdOsfDjZsX8xvx11ZCtP9ZnNujTOIQu8TSBBlCo9vy3zrQgFlmEn1F1pxex
        as+SLxiIhUcEKkFfGJuqYETktBCg2aJJ4X/mo/A3znV2pdT84H7uAG0/322jbuPR
        s5gY8iy10o3TUkXvfw26ZZU/bUfGlhu4ABLX+pwHfV7j/O50w7e+T5v0JSO0ZIQf
        4m+NuSX7rvCGhQSnjnwWw==
X-ME-Sender: <xms:GFeXYs0-EnzBaXr_jJYoQk0HRUz-jHm2bA8VqxrKHEs6VdmC2BKKOQ>
    <xme:GFeXYnEHIytksbRJPXbfWI9_SJUxFYHPIHaqdyphB4Jid46CJoPXRDYPsDM5O1slY
    Vt_zD_Arw2Qz9JA4UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:GFeXYk4JJqhaXTMPn50RFMQVobU6X1BIYG5hTskRt2fvYAu5rtOhcw>
    <xmx:GFeXYl12WUGEznga2ex0RKYdzZsQsEB6_Ybn4V_M8Tmpacl8weeiaA>
    <xmx:GFeXYvG3bjNVk9OL4kOvsSNnzXfc9MyD3-K1o14MJaFDE1Oz-DvwmQ>
    <xmx:GVeXYpGMfma9kY5Yvetoy4Gu_rkwUk4HxKlXnKjHpTzRbhxFywkS8Q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D84B536A006D; Wed,  1 Jun 2022 08:10:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <6e7da218-be6c-449d-92ea-be416ed12da5@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-3-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-3-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:09:40 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH V12 02/24] irqchip/loongson-liointc: Fix build error for LoongArch
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> liointc driver is shared by MIPS and LoongArch, this patch adjust the
> code to fix build error for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  drivers/irqchip/irq-loongson-liointc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c=20
> b/drivers/irqchip/irq-loongson-liointc.c
> index 649c58391618..aed88857d90f 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -16,7 +16,11 @@
>  #include <linux/smp.h>
>  #include <linux/irqchip/chained_irq.h>
>=20
> +#ifdef CONFIG_MIPS
>  #include <loongson.h>
> +#else
> +#include <asm/loongson.h>
> +#endif
>=20
>  #define LIOINTC_CHIP_IRQ	32
>  #define LIOINTC_NUM_PARENT 4
> @@ -53,7 +57,7 @@ static void liointc_chained_handle_irq(struct irq_de=
sc *desc)
>  	struct liointc_handler_data *handler =3D irq_desc_get_handler_data(d=
esc);
>  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
>  	struct irq_chip_generic *gc =3D handler->priv->gc;
> -	int core =3D get_ebase_cpunum() % LIOINTC_NUM_CORES;
> +	int core =3D cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>  	u32 pending;
>=20
>  	chained_irq_enter(chip, desc);
> --=20
> 2.27.0

--=20
- Jiaxun
