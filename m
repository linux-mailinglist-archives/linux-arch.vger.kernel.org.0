Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081E48085E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhL1KYH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:24:07 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:44994 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhL1KYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:24:07 -0500
Received: by mail-ua1-f49.google.com with SMTP id p2so31041240uad.11;
        Tue, 28 Dec 2021 02:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBBZo0qKjA88eh+fXv3guzm1j2BWXycw5/mkSY/OQtw=;
        b=Gq4t7ylNq8H4PI2LDeax/+t4fsr1a6M169Hb9IkRUGX0976oVWqlcookBLJtoH2O1R
         eMvbtP14zqMyiqXHNXiFE6IedApj50Hh/KmpKFHhdKvwfkjr9sKqxzC2TnZ90d04FB0f
         ZOMcFXC6JFB0s5eWREjE1rFqpr0DQk8IfqOouz16XJ9X9qsVygGMi2/DXNOEvsZQIWNA
         CUMTMhbF4BHsDjqnMo6tphL1DuVgnxDO+gPVb53+JV5emUdKwIkvxaHne577E3/y3ufw
         oqDlXJ7HMRKJry9kBA64bLwsDRJwdjvtZX9gTYaecllnziaUW/RJTy1N553SUrQSWNWa
         ALbA==
X-Gm-Message-State: AOAM530USRwSZygDhs8kTtahMKmEkfsuDHGNaVFyzZVkU0v+Zxq6exPh
        0UEn9pw1bKqW8oep0+lQDbuthtqGILEcVQ==
X-Google-Smtp-Source: ABdhPJxoWkaAiDanm1UYsFZ8bs7fkBkgwKVj7TqNAvzXy3ud/T98SZK+nIOTANWJv7rYBMkZ7MmyYg==
X-Received: by 2002:a67:e0de:: with SMTP id m30mr5965381vsl.19.1640687045990;
        Tue, 28 Dec 2021 02:24:05 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id w22sm1165221vsk.33.2021.12.28.02.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:24:05 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id p37so31036874uae.8;
        Tue, 28 Dec 2021 02:24:05 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr5686268vsg.68.1640687044914;
 Tue, 28 Dec 2021 02:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-12-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-12-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:23:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMLSbahgG6BzTmv0GYM82bWPaHR2B9BfziTMqbauqiZA@mail.gmail.com>
Message-ID: <CAMuHMdXMLSbahgG6BzTmv0GYM82bWPaHR2B9BfziTMqbauqiZA@mail.gmail.com>
Subject: Re: [RFC 11/32] Input: Kconfig: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:50 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -75,6 +75,7 @@ config SERIO_Q40KBD
>  config SERIO_PARKBD
>         tristate "Parallel port keyboard adapter"
>         depends on PARPORT
> +       depends on HAS_IOPORT

Same as PRINTER: shouldn't this work with all parport drivers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
