Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C754CA5C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiFONx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355278AbiFONxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 09:53:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F4065F8;
        Wed, 15 Jun 2022 06:53:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so16274033edf.5;
        Wed, 15 Jun 2022 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HAwNdI/HLgYUFqFkwLp3tbG9Q5FUzi13aLInTGzpSNg=;
        b=BUQotWXSPBypOQsI5HWXPn2wQh5HMwLx0LNE7FM6vN+3VoigZ1JCwbyRjgLv2xVeSu
         eMpP4O4MR/nUmkonY1fnVqLU/c9wDtzZJkBhyWcgJCsCmaFRcf59HLHALaHNpEAXPbGo
         VXw5SbxoFTa4x+An3kTLq3IzUgxaBaYymdExORgM1p4VA7odZ4J8OE8vMMtx16lgZ88A
         PXPVzBhO+ElwZ6LazOBUy2sIY8B7VvqbPlxYR4jcp8hJSXQZpht8u8jA8lMUzvHP703v
         pFDf6hBT/RYz4rtbZWrDKdPODiT9kw3xa9RHrfqUuFq1MozznmawDHSTtiUkxl2+51We
         Brgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HAwNdI/HLgYUFqFkwLp3tbG9Q5FUzi13aLInTGzpSNg=;
        b=7BO/egDOzjAPsaJSxn++kXWPFQTTKVxIc1oxtPtpUyEvQHlBNNh4tJpdVHPsS9nqH+
         55QqlSRoHayh2cZRC26ekGaU7kVj6/xxRgwdMH6n3YTldJyzPYtA+v9y9fWCYwG8Dzbk
         EoWvMLFfQBlVAQA7bsYL0fooCLumN7wy0Lk/xUhzhr97L6bvfVL1JF5D41WKDpAtrYvr
         4905ELKcimA0X3pvyo6hC6EPZLiQcLKUGhQUUUUf88cLP6biDIXm50aId31GsRhQ6xW0
         bu39acUG+ViC+S/JFgsyL7oVhj/KG8nWkITYqRukgE/fWWgvzo1YNF89Q54TpKqu7zxa
         Pq7Q==
X-Gm-Message-State: AOAM531BqBhNEA4Ix7nzaAmd/x2yrYUYKI2mpRQ3R4F41JrVghSgDkWi
        QBONZRPtKACv0nDV4hyuTEuahZju9kdHBSImxi0=
X-Google-Smtp-Source: ABdhPJw6beu1XgW7zZjneKwFqagHeiozjlaixPXxUkvWD+Bf3rn1xseyVyKO7ljDE5GjVTD+7Q8tqo99e9XMnuiRE+4=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr12921817edr.209.1655301228521; Wed, 15
 Jun 2022 06:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 15:53:11 +0200
Message-ID: <CAHp75VfmEmXifk0F2+JPLMOF0i=Xs+t5_y9Tyfo3airF2E=ZPA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Add RS485 9th bit addressing mode support to DW UART
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 15, 2022 at 2:52 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> This patchset adds RS-485 9th bit addressing mode support to the DW
> UART driver and the necessary serial core bits to handle it. The
> addressing mode is configured through .rs485_config() as was requested
> during the review of the earlier versions. The line configuration
> related ADDRB is still kept in ktermios->c_cflag to be able to take
> account the extra addressing bit while calculating timing, etc. but it
> is set/cleared by .rs485_config().
>
> PLEASE CHECK that the serial_rs485 .padding change looks OK (mainly
> that it won't add hole under some odd condition which would alter
> serial_rs485's sizeof)!

Have you had a chance to run `pahole` [1][2]?

[1]: https://linux.die.net/man/1/pahole
[2]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git

--=20
With Best Regards,
Andy Shevchenko
