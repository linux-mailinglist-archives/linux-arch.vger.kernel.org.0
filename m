Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F7718BC0
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjEaVXt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaVXs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:23:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883B4B3;
        Wed, 31 May 2023 14:23:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so7703875e87.2;
        Wed, 31 May 2023 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568225; x=1688160225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o7KHBWZ+J55ZTx2wkCBeVpg6ewT4ab9Dk0YMh5VnVQ=;
        b=FLvgGKO/oMijXf1KYnSriKRqcF0Khz4UsHfadWLafI//gSZwBgh9OxypJBiBWgBA+l
         /gquV9B3z8AW0P35EYtkBK6LSBDgJRm3oH5zSsypekY4x0+a51FVxXSireeZE2kFZ/ym
         1tCMBT6WZG2i5WptFxX5yfTAiiR4CeV/oABWLsMbqu8wb2JWUs1WzndLDdjk0oIYhIjT
         MGA3J7kH9nUeAmM3pBT6w68gWIbr6Arq3TdCesdyAlTiwr7YuvVW40DpM4b4s9AsPsR6
         5ZiTRyg5Mc/mLF7m1i8aY6Miaa5PKp/FPb4YfoPJzWk4XBQ1wA8GbDiFjxaOAbXzAwNi
         z2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568225; x=1688160225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o7KHBWZ+J55ZTx2wkCBeVpg6ewT4ab9Dk0YMh5VnVQ=;
        b=R5GDIZzC4rKVrCRotqmHh86Pr8B2az1mISLC6c7LCvpeK4zuAn3Cgqnvi0jtBBOCMc
         g0bkdwFV/Og3gZnDiSsTCWwPQ2Z9zUbqoinYJDpyr0ex8qweQ4YbazMeeIBrGhUCKeWf
         ZZKTjMehaC1yT7v18kgbyjc8jT78Ti4a5rgG7H7mM/6+ywimA/wF0YXdSdukEfFj7Ndn
         ty/UoEfBws2JOpSS+Ldo6hIfJEg2OQgjGD1SVDRzT9d6EbU77y5WoIGo/iDK/QMLSYOS
         UdKx9OaqvIh/Z4WIic3LLYlvddHWKRfm5IiGGdHqAylprIKKrg+krvlkLNzliFQzuxWD
         p3VQ==
X-Gm-Message-State: AC+VfDylDacCf4hdCXdoxDHNFFY9v4aYIWRHSJ3v0nOEZ+bNWOSsNIre
        eOtxIzfMTKgOBrtWJaSxHR4GBvk80u4lkNNQ
X-Google-Smtp-Source: ACHHUZ4HSrzAKwWcEGlLlqcZKTHdB6wwjM/xqNb72tZZsHT76BgqQkER9rkEj+np4PSBiBEzo6O0Kg==
X-Received: by 2002:a19:a413:0:b0:4ef:ec94:9674 with SMTP id q19-20020a19a413000000b004efec949674mr188296lfc.32.1685568224666;
        Wed, 31 May 2023 14:23:44 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id f25-20020aa7d859000000b00514b3dd8638sm2015646eds.67.2023.05.31.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:23:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-input@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 6/7] docs: update some straggling Documentation/arm references
Date:   Wed, 31 May 2023 23:23:43 +0200
Message-ID: <1852730.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20230529144856.102755-7-corbet@lwn.net>
References: <20230529144856.102755-1-corbet@lwn.net>
 <20230529144856.102755-7-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dne ponedeljek, 29. maj 2023 ob 16:48:55 CEST je Jonathan Corbet napisal(a):
> The Arm documentation has moved to Documentation/arch/arm; update the
> last remaining references to match.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-input@vger.kernel.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  MAINTAINERS                          | 4 ++--
>  drivers/input/touchscreen/sun4i-ts.c | 2 +-

=46or sun4i-ts.c:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/pwm/pwm-atmel.c              | 2 +-
>  drivers/pwm/pwm-pxa.c                | 2 +-
>  drivers/tty/serial/Kconfig           | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)



