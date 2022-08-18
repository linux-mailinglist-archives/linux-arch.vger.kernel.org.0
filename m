Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82E598114
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiHRJsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 05:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbiHRJsP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 05:48:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A45F65C6;
        Thu, 18 Aug 2022 02:48:13 -0700 (PDT)
Received: from mail-ej1-f48.google.com ([209.85.218.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKsSj-1o43VZ0ZRt-00LFLV; Thu, 18 Aug 2022 11:48:12 +0200
Received: by mail-ej1-f48.google.com with SMTP id kb8so2256226ejc.4;
        Thu, 18 Aug 2022 02:48:12 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Y6LIhLufd6ui+RCDqzYDSpHbbfr09PKsC9WYrCdvpR02KjaS3
        2vsRxUW4YhXjwtr/mo7odY8hb52K/1AhiXsA1CI=
X-Google-Smtp-Source: AA6agR645rETuEE4VMhXAaKswHY7L5Q1Tk6UWcY1L316KwAlAp6lbpoTrasC+3YhaQ3U6q37ocvWef/Jh+4AqnpxUdA=
X-Received: by 2002:a17:907:28d6:b0:731:5d0:4401 with SMTP id
 en22-20020a17090728d600b0073105d04401mr1389787ejc.765.1660816091708; Thu, 18
 Aug 2022 02:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
In-Reply-To: <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 11:47:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
Message-ID: <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qu+gtjF6iRfgG51X3I8WKus/80sjc+ma+ip40I5uAgSgDb0BTGO
 TmFn0AU3ikFHSV4I9Ec3FQ9dAV0Z88se1kzFaPV08lpOg1XP5++JC1HfdsoScPzy7KITPvy
 NmPvyZ9GZGz5qgXyk8l4vyLeLBcGJIm80XSBI43QjAhGoBz0DfqSeGZG/tUnSxP+jsii0qp
 QG5mTzs0HgzuaGdF4ZLwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpH2Lv+xf5w=:aM/CNwGcX5Slxtx5waR3G4
 7Tpne+m8lwx2GQRxSnQiezYPR9OWTcCIW7FrDJoWRPYoyNRxBy1WaCywmApG+jHhFK+z+000s
 Se3f8j5GO70OjLQs6j2qFrB8jQ/MwvTpXKiHyNjfhX9PEBu3uYfzd7Djl1t/nQrQz2DpqwayM
 KBcEiiDysR5auhNB/3De0UbANOyeJhbNkaiyBPjKFc8y3J2zIAcFN8rwI0wcbf/nezOj6GBIo
 gLPjN3U3rcFqarARQHBKBFduwUJC47zl9aEGsFiZm0CUUtJxSvVsbw1mJwIPe7sUUuAJOn1Nk
 GEnFwRZ116/LKkToyI9XfyA8V9yQ4ODKGsjOyZ00oSQiprd11VwGT69JkMu7buwb8GTyqKW9+
 4K9SOUHpw1PEvCgiddEgfyH9oDouXKwFVxpXHl5xLLttjz8kf6gJSKiVunmlZ7Z5e1WO4hLvI
 7R7shfvl6CFaXcHF7yxQs0rmHR8aqprXugEc1iDWXqc/Tu36U+xh/txCpEEfU7CF8aM9nX3gA
 I/+L04K4h/Sj8U+smwSsOv2B54CVQLg1H1cTqgcYfr74qESpb3vWCB8YW2QuETz4JdfxSnn6m
 ncYQMrJB0zyeUviYI7GxVgS+I6khh8XfSxpINLcF7BDQgwWi2HrHFnMRR9cn6Xdiop/x6rzzv
 8RUQD/4SzoCuC8T81Q6G3dkum0mtZiq8wLqJMGTsVScIZOVuy/xOiF0Mq4v+62rXfwv90iq5i
 MYvvQRSdH8x9lZ5uI61N0xQZxZUyDdjpGpsUXTCK1ah4zZRBq/4qumNvbkbmMc3BKOzbksO2i
 l0RZfY6UdayMF2sg2w6kYiIHglc2osO6WF6GQVZD+DiAuzlTA0fnk5f2ptyy2qNEzZOkeOvkT
 Ttyhsg4PyEVe/OMd6Kig==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 11:33 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The per-arch GPIO number only exist for one reason: embedded
> GPIOs (think SoC:s) that refer to fixed numbers in numberspace in
> the board support code. This makes it necessary to allocate
> descriptors up front in some compiled-in GPIO chips.

As I understood, the problem that Christophe ran into is that the
dynamic registration of additional gpio chips is broken because
it unregisters the chip if the number space is exhausted:

                base = gpiochip_find_base(gc->ngpio);
                if (base < 0) {
                        ret = base;
                        spin_unlock_irqrestore(&gpio_lock, flags);
                        goto err_free_label;
                }

From the git history, it looks like this error was never handled gracefully
even if the intention was to keep going without a number assignment,
so there are probably other bugs one runs into after changing this.

        Arnd
