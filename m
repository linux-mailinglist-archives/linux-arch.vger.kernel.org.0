Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3858C6F30E1
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjEAM35 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjEAM34 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 08:29:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DC1700
        for <linux-arch@vger.kernel.org>; Mon,  1 May 2023 05:29:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9dcd91a389so2589500276.2
        for <linux-arch@vger.kernel.org>; Mon, 01 May 2023 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682944186; x=1685536186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNAU33N+roe5U6IAkPOOSvsUX5CPin1Iei73lUukdn0=;
        b=OzBoO667tpOKcKnteYCoqmBbhm3gsae5un7Arjuq0FT8CtDy6n4eHaq+WXiCfIbSW+
         FVWi9j20O0r26vOZO2Cn3rWa4EQ+x6vS5FhJ/+7A6UhypygTqsFYcHKsNOr6a9CMHp2Q
         j7OT9/gIQyl5cOjkpML8zmr/ElU2wN89jyDlKGVt46+37XE+L+iE/o3zylA1r3M0MiU2
         TzwHUSTLPQqvfH6hZ0LWB+rWxH2TEFo9CoXuUZ3xgavsUc4Wn/r/KEDzbJRtj31ggbEh
         kFly4b6xcJ/xK5xaf53PxN95uglRMwFnHRYgTr17ZGAs8bUNpwFSJ11h9onaodAzzPuA
         i3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682944186; x=1685536186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNAU33N+roe5U6IAkPOOSvsUX5CPin1Iei73lUukdn0=;
        b=JeNpmhPGppvG5Pk2OUKtrSJHPECRPX6bQxY7JKpGManh84cSdjImHyhlVZwEw/83dg
         UDMJc60LZvgku8zYSs0M2hUaJo+T/7L9yqB1p1uvUS4B1hWdB9q3t0ekUvGD17Q8qxP1
         seqMaMKNamneoFymrMOk5wm8za3hUiSwI8aM0U4Hi1oqrQtxL+rLPKTEdyDdB5nui2l2
         lE9u1CAH9w7buHcrKXka8yVS7J89WJHSEAY2eH6W62khSj1mys2M2ZACYdzsHkyjnrCo
         XlppnWAf5AOri9P80LJipQYEJBhi5hfsNbJzIEPo6nGunBLuF7sp9C6DCYsFbdJ6dVEg
         8i9A==
X-Gm-Message-State: AC+VfDx0kKxscsiDjcS+MQmb32sxlo96VTNMPo9bHxOTvDAqXgxj+fkA
        69S03zT9d11pofJRjzFt1UtkGM3uduYwr6OinnN/XA==
X-Google-Smtp-Source: ACHHUZ4JWzJBoFVmVjKOt5uk/TX2V9yqXi7q2ye0IdtVGgzFFHtPnptZV32IyVAGJuUn9bkoviCUycIwRkhXHwfDQ5g=
X-Received: by 2002:a81:dd08:0:b0:54f:8f16:c8b5 with SMTP id
 e8-20020a81dd08000000b0054f8f16c8b5mr11598419ywn.34.1682944185780; Mon, 01
 May 2023 05:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-10-schnelle@linux.ibm.com> <CACRpkdbS1U8_qakdWV0YZq3bhr1NvFuL0Umv3QsXD0wYu7Hd9A@mail.gmail.com>
 <9a0feb128bc3b26ca444367ce4ee44e80aa9f469.camel@linux.ibm.com>
In-Reply-To: <9a0feb128bc3b26ca444367ce4ee44e80aa9f469.camel@linux.ibm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 May 2023 14:29:34 +0200
Message-ID: <CACRpkdYGWZSk+wSW7waFsY0wSS+CasEqm4N0CU6u6UKxe9WA6A@mail.gmail.com>
Subject: Re: [PATCH v3 09/38] gpio: add HAS_IOPORT dependencies
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 4:45=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:

> Makes sense I changed it to the above approach for v4. One thing this
> makes me wonder is if then one should change the X86 dependency to at
> least X86 || COMPILE_TEST or even remove it and rely on HAS_IOPORT.

Hm it makes sense I think. I don't know if there may be other
X86 deps in these drivers but we don't know until we tried.

Yours,
Linus Walleij
