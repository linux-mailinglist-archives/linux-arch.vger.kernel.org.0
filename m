Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D86B94F9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCNM4F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 14 Mar 2023 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjCNMzb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:55:31 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EFBA676D;
        Tue, 14 Mar 2023 05:51:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h7so8570179ila.5;
        Tue, 14 Mar 2023 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBpmO88aubLNx5ds9k4LYpaw6LJjHZV6232nWb27C40=;
        b=F/kw06fa4E2Ncy3YZWjTpozsk/uEjpPYL+2is5cIZC+P58OegEkgDGz8ouVWG/Q1xE
         Et8D+rcrK0xMif92M6dEqkmX6yfko55xNYaRa/dbni5K4hnMg2kJbS4/8N5mQY5HTF7Q
         BuNVrYExTJQKj0m847hrRMjI5hL/at2PTpDev6MFju/5YmkoW25rySdsU0UD+4d5UkNo
         jXBkpw5/9i7PCHGZNLOZEH415wd3DX5XJX3ItX9HWYdCiie0ZC/MqygGX6ds/8v08Pbm
         yaXtFFKw61YpJpp/62dKUu7jdJfUxdSx37XPUWZuUUVoXqX6fT4tmKAD2dnnb8j9ZqBS
         cfHQ==
X-Gm-Message-State: AO0yUKV7FGwu8G54frPgXfvRFHivRRVu38Rlppr/9khy6TUcYSyIfRZ9
        eGWLIfvbg58oegOwmWkvWHM1NlT5zYRypg==
X-Google-Smtp-Source: AK7set9uaU9BS2YJ7QMbWwxTVXrP8kR0ag9yvjORrw/DCh/YZzKu/5KzWRtQ0EXzIfXazCdoYGSwVA==
X-Received: by 2002:a05:6e02:df2:b0:316:e39f:13f2 with SMTP id m18-20020a056e020df200b00316e39f13f2mr2007150ilj.12.1678798136649;
        Tue, 14 Mar 2023 05:48:56 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id z22-20020a029f16000000b003c4920e7c74sm750704jal.57.2023.03.14.05.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:48:56 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id i19so8550137ila.10;
        Tue, 14 Mar 2023 05:48:55 -0700 (PDT)
X-Received: by 2002:a05:6902:1002:b0:b48:1359:4e28 with SMTP id
 w2-20020a056902100200b00b4813594e28mr461087ybt.12.1678798114483; Tue, 14 Mar
 2023 05:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-2-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-2-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Mar 2023 13:48:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV9ZoB5XNiiVEG-zBzB9eN5RJSC42WMDD-RZfcg=2tr4g@mail.gmail.com>
Message-ID: <CAMuHMdV9ZoB5XNiiVEG-zBzB9eN5RJSC42WMDD-RZfcg=2tr4g@mail.gmail.com>
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> We introduce a new HAS_IOPORT Kconfig option to indicate support for I/O
> Port access. In a future patch HAS_IOPORT=n will disable compilation of
> the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces such as s390. Also
> add dependencies on HAS_IOPORT for the ISA and HAVE_EISA config options
> as these busses always go along with HAS_IOPORT.
>
> The "depends on" relations on HAS_IOPORT in drivers as well as ifdefs
> for HAS_IOPORT specific sections will be added in subsequent patches on
> a per subsystem basis.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

>  arch/m68k/Kconfig       | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
