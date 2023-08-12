Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D1779FE3
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjHLMFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 08:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjHLMFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 08:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCA93;
        Sat, 12 Aug 2023 05:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C003618D1;
        Sat, 12 Aug 2023 12:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA47C433CD;
        Sat, 12 Aug 2023 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691841912;
        bh=SMUP+MK3xtF3YXZGKSEMQ9XcM9KfyYtk/JTYo544pNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WdiqiSbOqwaWwxPVdKynTNX3Y7LlJ9IhVJPvZATGIgywQmbKfRIZgVoHKIXG9hJzV
         316nqsifbqUMl21fwHiAwMLFJ9ecp54CIynOQw1OssslzGrpRKUeS8YQqWbwZPsh86
         MFM2lRd9hApnlR0wH9n4q6/C6sH6TY9mayCBCvGq1FwTtvdaZ6Q/+skb3XFldF5AEY
         IeDSpx42ucuz1JooE/GbXRWUS2hBCW7toYPN12VkIVra5lGzIAnvEfzdGSprBgq9Qw
         QZYlxCBukv1A18Z5qSt9pBXYyIaI40Mx3mXjYyWbPkJsW+Ej8FCMUi5vnfO943jaCd
         0gXX8sP0AemEQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56ce936f7c0so2195329eaf.3;
        Sat, 12 Aug 2023 05:05:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YzT5hAPA66+hoSkOb6xtu+vXc9Ror8FwqzBhwvRnHJ6GGfiYw5m
        /394MdJL3Qt84gUIdRvHnyt4AFEpxtIBU0OuEmg=
X-Google-Smtp-Source: AGHT+IGol+2y7f9YRu4c0bvYKKhR7ejSYGRxgORzf+/fWofgkROAxCPQxiOQ8o35BBnOMung8rhmeveaQl/+f1qtE1U=
X-Received: by 2002:a4a:275b:0:b0:56d:2d49:13c2 with SMTP id
 w27-20020a4a275b000000b0056d2d4913c2mr3100452oow.4.1691841911971; Sat, 12 Aug
 2023 05:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230811140327.3754597-1-arnd@kernel.org> <20230811140327.3754597-5-arnd@kernel.org>
In-Reply-To: <20230811140327.3754597-5-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 21:04:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfNM9D=U_SjG5FoOy-=rrGKCRUJS_RB-XFa7oTpEuy-g@mail.gmail.com>
Message-ID: <CAK7LNASfNM9D=U_SjG5FoOy-=rrGKCRUJS_RB-XFa7oTpEuy-g@mail.gmail.com>
Subject: Re: [PATCH 4/9] extrawarn: don't turn off -Wshift-negative-value for gcc-9
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023 at 5:00=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The warning does nothing for newer versions of gcc since -fno-strict-over=
flow
> is used, on old versions it warns about lines that would be undefined
> otherwise:
>
> fs/isofs/util.c: In function 'iso_date':
> fs/isofs/util.c:40:14: error: left shift of negative value [-Werror=3Dshi=
ft-negative-value]
>     tz |=3D (-1 << 8);
>               ^~
> drivers/video/fbdev/tdfxfb.c: In function 'tdfxfb_probe':
> drivers/video/fbdev/tdfxfb.c:1482:17: error: left shift of negative value=
 [-Werror=3Dshift-negative-value]
>       (PAGE_MASK << 1);
>                  ^~
> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_request_rsa_=
resource':
> drivers/tty/serial/8250/8250_core.c:350:38: error: left shift of negative=
 value [-Werror=3Dshift-negative-value]
>   unsigned long start =3D UART_RSA_BASE << up->port.regshift;
>                                       ^~
> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_release_rsa_=
resource':
> drivers/tty/serial/8250/8250_core.c:371:39: error: left shift of negative=
 value [-Werror=3Dshift-negative-value]
>   unsigned long offset =3D UART_RSA_BASE << up->port.regshift;
>                                        ^~
> drivers/clk/mvebu/dove-divider.c: In function 'dove_set_clock':
> drivers/clk/mvebu/dove-divider.c:145:14: error: left shift of negative va=
lue [-Werror=3Dshift-negative-value]
>   mask =3D ~(~0 << dc->div_bit_size) << dc->div_bit_start;
>               ^~
> drivers/block/drbd/drbd_main.c: In function 'dcbp_set_pad_bits':
> drivers/block/drbd/drbd_main.c:1098:37: error: left shift of negative val=
ue [-Werror=3Dshift-negative-value]
>   p->encoding =3D (p->encoding & (~0x7 << 4)) | (n << 4);
>
> Disable these conditionally to keep the command line a little shorter.



Just a nit for the commit subject and description.

It mentions only gcc, but also affects clang.




Is the following a better subject?

  extrawarn: don't turn off -Wshift-negative-value for gcc-9+ or clang

or

  extrawarn: turn off -Wshift-negative-value only for gcc < 9






--=20
Best Regards
Masahiro Yamada
