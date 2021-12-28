Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59AA48084C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhL1KOU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:14:20 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:34371 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhL1KOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:14:20 -0500
Received: by mail-vk1-f175.google.com with SMTP id h67so10049983vkh.1;
        Tue, 28 Dec 2021 02:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W24YzS7gvKwvztwIMu0FSg1RWOYoxzVo3HaBbi+k4Wo=;
        b=nOFMSXbm01ddbE396exefqk3FZB4s2dDhAssINXA5+u6A/aJAz+BU69zkN8MBqQPC+
         AQKIokl4/e4Te6qgGHgvwz3E+IziTUFOrZS7bhu1KWCJTtFycBu4sWG8waD8coank5rS
         PfJbpxLSiMNgWe8vBWtIn3S5ix5L26PsnNhDm25qtLR7Pl1pYb5Ris7AKZ9xNAou87YM
         e4QWnrqxuzMjyyhXfsDZ+Aam8lFhHvRX+OmqGnT7p7/QsJBnAuVZ1xoPxcxfVd+V3Caz
         tEY9tFkILBq7OVJjKZ+L4r66DajRGU+/DD2cNfn8oRmQnOWAsvje0zV65HXV2bqLKykS
         4Rpw==
X-Gm-Message-State: AOAM530mFtZZyajSTmdWwemps/mDsuawiYNUD+z7ya3PuUG6QdOcjTk6
        7sa6Fex2H/xPl/ClMiyASiBOse6yGTsy/w==
X-Google-Smtp-Source: ABdhPJxzE+erAcnry/fMrmjYh38ppvAj1LQCEuQxjX8rALN3cIPvWQGnrZzLNwSysz3O+EvcfbD7BA==
X-Received: by 2002:a05:6122:e12:: with SMTP id bk18mr6645433vkb.40.1640686459203;
        Tue, 28 Dec 2021 02:14:19 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id m25sm3513077vsl.34.2021.12.28.02.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:14:18 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id c10so9871312vkn.2;
        Tue, 28 Dec 2021 02:14:18 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr6390863vka.0.1640686458447;
 Tue, 28 Dec 2021 02:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-5-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-5-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:14:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
Message-ID: <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
Subject: Re: [RFC 04/32] parport: PC style parport depends on HAS_IOPORT
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
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:48 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As PC style parport uses these functions we need to
> handle this dependency for HAS_IOPORT.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
>
>  menuconfig PARPORT
>         tristate "Parallel port support"
> -       depends on HAS_IOMEM

Why drop this?
Don't all other parport drivers depend on it?

>         help
>           If you want to use devices connected to your machine's parallel port
>           (the connector at the computer with 25 holes), e.g. printer, ZIP

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
