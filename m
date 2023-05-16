Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44CF704E69
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjEPM6v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjEPM6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 08:58:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA97659A
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 05:58:24 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-559debdedb5so207073747b3.0
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241887; x=1686833887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHRC6weTLhw4PKfvaEsFaJx4Z8s79q1wVgM5QEww9rc=;
        b=uQG7PwUPOQ5hfuvR0kTrO57jz63fmPJOitgL+AK2sz+D6seLd3Oi1fgDpXFy50kGAq
         M25n6EjEeS1lSM381gySZItDWqNzdPMRn4b4A5zvTERA3VYuyg8nnsmdeYrl6NXQ420N
         RGwtJO/TucT/juaBYXNinEl8/aGGbNH5MU5Sm74M3CHKnZe1Jq8+uXtFmcA3/grl9hyb
         SXwtfwctDaRWc1Vkm9E76/7Sof6STaoXxCuGswemRc4I2AH/RSHpVouxQG2XVInHMspd
         PYpcLCSnJI3iMfIiypwsp3+gx0DaRnh6tn1AQRMeN92xcphmV9w61SRO+AL51ClErkqH
         HLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241887; x=1686833887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHRC6weTLhw4PKfvaEsFaJx4Z8s79q1wVgM5QEww9rc=;
        b=WECZc7dWV6RVa5ZX9EjcjifP/0SRNPnVwRiBXfQ7woYnv9MuK25H/BQMb/uDhE3q08
         9p3RKf3nIVVuUszv/RU+Crz9CxVU0Yd1APKPowvPj9oddJZ4oruYfzOJuS05lcdiouc9
         jzNRDdLWHZpuNpJy0eSRH67SWG3d3lDwfkD39+V3bqQt9RFNKOF4ntqgOlhw5oxJ/29I
         iwRSfz5uNohej24RL0Ca9BKGolA4nzM1CBmn267yoXafKXEKRQlv0Bb2FTR+L9S/o1VN
         o/+QZDwpjoTIQ7on1X/lNlsyI5manL/qoF5m/oVjgBW+JjGYrhoPrOEUkOAXO8o9f3Pt
         96Bw==
X-Gm-Message-State: AC+VfDzUefKmkW55l5QHmskt5bXSJ++JcoPGSOKomw5o3AtohRuxrZgC
        5h7MuswpPCEJ9rLWvMEApErRoiuUugNeGeqkM0YoxA==
X-Google-Smtp-Source: ACHHUZ6uHbtZv4CBKm+nzoTPfWGzpxcB2dIyxctVe0c+O4bh8YD0NEGQDzstwCMIN8Z4y6J2a0dsXdEpce2HhPb9kUw=
X-Received: by 2002:a0d:d549:0:b0:54f:e6cb:fc68 with SMTP id
 x70-20020a0dd549000000b0054fe6cbfc68mr33470634ywd.38.1684241887136; Tue, 16
 May 2023 05:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230516110038.2413224-1-schnelle@linux.ibm.com> <20230516110038.2413224-10-schnelle@linux.ibm.com>
In-Reply-To: <20230516110038.2413224-10-schnelle@linux.ibm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:57:55 +0200
Message-ID: <CACRpkdadeYj=tJx-+agK8R8UKnvA-dtihUqGjni+ocW-0zUf2g@mail.gmail.com>
Subject: Re: [PATCH v4 09/41] gpio: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 1:01=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:

> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
