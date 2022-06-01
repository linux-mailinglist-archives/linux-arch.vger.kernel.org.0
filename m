Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0867553A526
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352921AbiFAMf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352972AbiFAMfd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:35:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB7C9EB5E;
        Wed,  1 Jun 2022 05:35:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DBA85C02F8;
        Wed,  1 Jun 2022 08:35:29 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086929; x=
        1654173329; bh=2a8pKPW+nkv2UZ6bzda9FwWLuXVnpZrZrLslzYOhsNw=; b=l
        XnfcTUWzcR8/xbuqkfBno/q+KEyUeIwVdWDzV6QhEmVfAvK6a2uTS/AwP7HDpSRb
        85uxMzfdcsE3lt/rZTpI+/f3j43rKpEIxcEyUhS+TywXpoqYmYSMnzgkeTLzZmyg
        l2xVb4U6cLZOP11brWhNRbZNX5qMkVEl0wxpOvkeSKs+k71YcSj+6v0i9nMIZ3gS
        7ohe+1ST7DXlc8gvsbKU7+aGXuOYqYIaPkqNcwWcAVmYGRN4ZfA0FLNYHpWzJoki
        PS8ahohhlHDio8JvVIli3Q3AOv35uBSBxg8Q0QTqkmVnilhSX368DbrqXvdECLbt
        QTaawN+xJXwr7ZfvBUYzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086929; x=
        1654173329; bh=2a8pKPW+nkv2UZ6bzda9FwWLuXVnpZrZrLslzYOhsNw=; b=Y
        yNWUzNn9hG1vIwLoX1hM0zrrjQ5zJEldzCeXMVmnDd41WGZNu2D7yUf23yXVfA4p
        E5EFi53JjnBZGBeWPMA+OGl26Qb9A2jnXynftLLTmqYhhgvvBDg6CG4aJWeD3M0U
        XRZLVzKcNjJesyM4UG17oqNUmmIKSbB//wUDtsvUOj9iiuDsWUVD2i5+rrf3NBUC
        NUd/HC+21HtXqXcuBMN5eL/ZDl34t+yzVnDbcNdEurpNQMk82GipA+EYK0n+dBkj
        s4lizswZpaD+8PSrOehpDGPE6NnRjqOBwUKrcX5a72BforpWdX5Cs4JqpcfkD8F1
        HDvKa4VqfvdvV0OEfWGyA==
X-ME-Sender: <xms:EF2XYnoQZvr7pANQTYh7OCvOAjWqtBEKSCTgoMLw033B44BULITvZA>
    <xme:EF2XYhq8sJTrSqHY0st5vbbvRg1UdD5747ElKMSVWsAdcXrnsHIitu78afGu58S5j
    3kNzHrhRV620LPmHLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
    ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:EF2XYkPLlwNKlfsv3pxWo1bReZ3s8lr0wMIC_MUriAXFnNtjgsbB0w>
    <xmx:EF2XYq4p56i_Z-ePFJioSmxLnoSUYRp6qlg0OCT9gdOAhhRdf6o2vw>
    <xmx:EF2XYm7XiiYpLC2bYpxcDeYIMHpGBwVWi7gyw7_OJR3kovfaelUdYQ>
    <xmx:EV2XYiob94ca2VS70opfE8lVV5tz30BnJjScRpQcjr4ixZSF8sXbVw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6526736A006D; Wed,  1 Jun 2022 08:35:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <cc1bae30-ff29-48c0-90c5-817b2320cbb6@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-25-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-25-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:35:07 +0100
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
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 24/24] MAINTAINERS: Add maintainer information for LoongArch
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
=8D=8811:00=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Add the maintainer information for the LoongArch (LA or LArch for shor=
t)
> architecture.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

You guys deserve it.

Thanks.

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1b4b77daa5f..3e592ea84557 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11544,6 +11544,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.y=
aml
>  F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
>=20
> +LOONGARCH
> +M:	Huacai Chen <chenhuacai@kernel.org>
> +R:	WANG Xuerui <kernel@xen0n.name>
> +S:	Maintained
> +T:	git=20
> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongso=
n.git
> +F:	arch/loongarch/
> +F:	drivers/*/*loongarch*
> +F:	Documentation/loongarch/
> +F:	Documentation/translations/zh_CN/loongarch/
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
>  M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> --=20
> 2.27.0

--=20
- Jiaxun
