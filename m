Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F504F116B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbiDDIy1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 4 Apr 2022 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbiDDIyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:54:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B223BA43;
        Mon,  4 Apr 2022 01:52:26 -0700 (PDT)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJV9M-1nHZhY1gZk-00JnaK; Mon, 04 Apr 2022 10:52:24 +0200
Received: by mail-wm1-f51.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so7255708wmb.4;
        Mon, 04 Apr 2022 01:52:24 -0700 (PDT)
X-Gm-Message-State: AOAM532qJb0i+4+Gx6sh2JDPgK+jTYEZHUDBO5ZWz5fh/vHAfTB2r8Ir
        cSDyZFKDj6AujcKGDi4Iouwu9fM29zX1I0CcbKQ=
X-Google-Smtp-Source: ABdhPJwjS3X9LrxfK3xOsCc8eYR0REQjLgLBdtWx850NJg3BCGgrM8fXkYWc4oZfb4QmCDEI6/0d51mdMIrhvJmU1j0=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr19168624wmj.20.1649062343942; Mon, 04
 Apr 2022 01:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com> <20220404082912.6885-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220404082912.6885-8-ilpo.jarvinen@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 10:52:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0iP79RQWr6-YDf=xQZvonZchYN-Rn7HN2pkNihZ=anAw@mail.gmail.com>
Message-ID: <CAK8P3a0iP79RQWr6-YDf=xQZvonZchYN-Rn7HN2pkNihZ=anAw@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] serial: termbits: ADDRB to indicate 9th bit
 addressing mode
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:zuga77kgzGu4eOgy+Q96heNPwwGLSwUSj4T9VkKxjnqCOBydr4z
 LLlqN+CSV+ktxKMUj0A1pImem0Uaqls3bbEohnthTZDFcYpVNmwAqkhhe6n7JWAXTNNLYgu
 +hlBr22SNAO1Etql54irhD4sxJHYtpoaVc2IWzDFo2a0I/t4gaSBmCH+IEmJVCd5GBneMM5
 x16Xi2qAt4T8gz+dq/eBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHNLQ1A/a+c=:C1v2GAELLLcKOfQSeWEZr0
 A5i9NByPMPtdDn2tKOr7ktfaQpLjTHSA0wTkqFtUXGtt71nL8ZsysHmxx8jFcjeuKIecp3NP/
 VB1Il09275W/uvUcu/Twbd4mmC0TcCZuIdgyaWhzXBWfO8Khiu4Fcyw9vQgxhfzLFJ+9XlTtU
 inGyFA4ZukwZdLOgg9p1XebOO3/T43zIvVnXWoy5RPftsutxFAfuU3CormB2m2kEUt6V3Ek05
 djjPvjN1QW4a84npXp4WJGxzmEWybDI0b7iljn7F07YlGhLbMSsQeO5xIyKqfMwxd9H0Wg0D+
 mvycrwEQ5mno+rh3dNjsU7RIwN26pL9E0QYmcAWi9jIAM9oZxuIyv4pdWFUI381JJ5lQQrbxD
 CfD+eP1Po0e0fSNvxRv2xsYxLwUmFDsUrbx4Gy92jAgGmq4xWIKG2msO2y0BzGMt/HWyoxVvQ
 w1xjnDzcwhVyWDimVKp6xrsjn3Pc4qofirHZUYySavUGHSWUGfj6VMQEpxyvFbjikTJr/2eMh
 kQNpv4RqJPPoqrwvFfe+phrG5SdNYEKwSfeAqO1iXsyeL4hq9dEjMeKjfBgLtF1p1h6cYyYSE
 ekajX+znj4WgqB3x5/VJ8xQbEHDEZaq5iu2tLFV2jevBWiPY0G/Ta+5ssiaJNnRL0f3XtVsvN
 PSGmyHNgyZ6C9Ifbl+dhd2g1SKkbcrk5BrdF0XIKloKFRRp+40LM/KlQHLfieXJg+vtzn7W7M
 H/o2IenVfwgH19n3ouPRKlJfYjEmuGAeAEoje2Zdb54pSfQWEF0ukIww/aiESZKIxCw3VCykW
 2ldDc3yn8LFnyPdT6aiObioQf2nNiXBEvBxFL5ma4ZntZS/bqU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 10:29 AM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:

>
>  #define CLOCAL 00100000
> +#define ADDRB  010000000               /* address bit */
>  #define CMSPAR   010000000000          /* mark or space (stick) parity */
>  #define CRTSCTS          020000000000          /* flow control */
>
> diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
> index dfeffba729b7..e7ea31cfec78 100644
> --- a/arch/mips/include/uapi/asm/termbits.h
> +++ b/arch/mips/include/uapi/asm/termbits.h
> @@ -181,6 +181,7 @@ struct ktermios {
>  #define         B3000000 0010015
>  #define         B3500000 0010016
>  #define         B4000000 0010017
> +#define ADDRB    0020000       /* address bit */
>  #define CIBAUD   002003600000  /* input baud rate */
>  #define CMSPAR   010000000000  /* mark or space (stick) parity */
>  #define CRTSCTS          020000000000  /* flow control */

It looks like the top bits are used the same way on all architectures
already, while the bottom bits of the flag differ. Could you pick
the next free bit from the top to use the same value 04000000000
everywhere?

        Arnd
