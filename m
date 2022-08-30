Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C85A6E3D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 22:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiH3UPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiH3UPV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 16:15:21 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265534BD35;
        Tue, 30 Aug 2022 13:15:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w18so9340810qki.8;
        Tue, 30 Aug 2022 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2oDd4h4DIBnRzhIpmRumeZRBdYqPGMhcxb8F+vf+ris=;
        b=lwss9vL6GllnCxaHvs4pYtqqhUN7BrEe4V3MmAXKcl6i1DaXRxWL0skx/d+4D9ksnP
         I6CIOi6VO6bkNyoyiFxtQKxKLPwIniJKzbipVdi/hGmIRRGoJ6Nxq1k5l1TJK23ibTjf
         9eOlgFNsH681eBlNFuV7PwWGdFzuMYdWdQvSKnlVJ5cklWC7zcGOeA3WvpFP8laaI+KJ
         kVFwrigBSb3fLyUzg1/6OqYe23YchC9AlQpnsf1H+hzXGp/mLf7Ol1g01GS3e4Ddvb5F
         dkg5i2LasV9wX6/TrwNX2np8JbyBLRPqlzfs2FGUZGckcPX8lfvMA6N2p2bk67azscKu
         XiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2oDd4h4DIBnRzhIpmRumeZRBdYqPGMhcxb8F+vf+ris=;
        b=2JCwt3uibh9vqLXdRDOp3Q0zcFt1OI6h+HqNf2PWNPz5WbPXIIm5Pv7FryE92xIGDV
         4nvwAJbdFzqn+sknq7dQvqQxfOlhDiPtcbKurqxMuf2kpNqxQ0XeZjO5pTIlHT6Nvc/J
         YYE4A1xUi04lexLQDNkheq9ffiTbwNfzLrwsJH9IkLisq8l2M2l20gc7XT1l89OAb09S
         8ZvemqF0ttMgMkYlxIpY24DEju6Cx+BOc+nyb00Wl5iQgQn6HG41dXTXXs7X1qCO0iT1
         hU3YyHfsYLuJH/VamxuhXbtiLUjXS0BvHxCnlteJGas4oEUjvYEuWU8wG6ci8kklAH3D
         lcEQ==
X-Gm-Message-State: ACgBeo1oZI3NDE+h3Wm1A7rPTqjhn/3HFmpdES3QBjoqFmtocyyhWQ/5
        6rqQujtOQnjz3RcvgO64HmO4gz2a1q732r0EIUo=
X-Google-Smtp-Source: AA6agR6O4Vv/0R5f18LYPXgfFhwGqAtXLJh1ykyDbE9pyRXNnOnW7iUz6oqdlDeQ7hL6kJTplp8QJkFfSAbvnuYJA0k=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr13208392qkp.748.1661890515093; Tue, 30
 Aug 2022 13:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu> <92aaf098d7039fd4040015b07ba1f99daf674f50.1661789204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <92aaf098d7039fd4040015b07ba1f99daf674f50.1661789204.git.christophe.leroy@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:14:39 +0300
Message-ID: <CAHp75VesQgR9arwnvsBZKwm6-skOJQCc9xex5NZsE8cQG_1CwQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] gpiolib: Warn on drivers still using static
 gpiobase allocation
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 29, 2022 at 7:18 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> In the preparation of getting completely rid of static gpiobase
> allocation in the future, emit a warning in drivers still doing so.

...

> +               dev_warn(&gdev->dev, "Static allocation of GPIO base is "
> +                                    "deprecated, use dynamic allocation.");

First of all, do not split string literals. Second, you forgot '\n'.

-- 
With Best Regards,
Andy Shevchenko
