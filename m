Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0EF39D7D1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFGIrG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 04:47:06 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:46775 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhFGIrF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 04:47:05 -0400
Received: by mail-vs1-f54.google.com with SMTP id z15so8465015vsn.13;
        Mon, 07 Jun 2021 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMLFqpyinJNzmHBwsTXpi/IC86W5Z3EEdqUV4Gadqtw=;
        b=YUbC/hYOqslL6/ObJ+SXGcYz04AW2Bl5kv0FBQfpyjrL1K7dEe9Jz1aEp2NiZngjqB
         pSImytQZbfunCF1nFrabAKZEPGMM8ewN2IRHchhEzV/nYh5y/alwS+udHY3OPsnOON1Y
         4Xwm5ojYKx5hdJ/T6P8utxYGmz+IB4ppUWd+eM4j3CE47XU/UZuL/SkA2kOa7aActou/
         OyC8obJD+2c2fOb8kD2ODUnnj5MrNeFGYuxC4XCfTihVUNbSMFCrHtfOzqlzF4HAMjsY
         zkC762tdDvl6yJw6YGJIOcrTOsfhDtYPbkxFw4S89QDbSQG7rzDaI9BEZr52j2ZolYrn
         CNsA==
X-Gm-Message-State: AOAM531A7/q0k6XkJa7PviYZZbEnu+lu+QtUCrpCSqXAlKUzqzKPQ0SS
        EDUmHfNsLJQSXn4b+SrfpeNLxqy6IQ/7I1ozums=
X-Google-Smtp-Source: ABdhPJwMLHirwEQ4tJUPI7qaplUDz3bp0fsmhod8P88K7RhBRU2njU8TgCywfoM2VwxcEnVDrH/bezsBM2ie2giEJTc=
X-Received: by 2002:a05:6102:c4c:: with SMTP id y12mr3863270vss.18.1623055497041;
 Mon, 07 Jun 2021 01:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210604064916.26580-1-rppt@kernel.org>
In-Reply-To: <20210604064916.26580-1-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 10:44:45 +0200
Message-ID: <CAMuHMdWuOk2LBJunCsCjzjYnBDs1rZh_x=ez7N=gjYv_ETMAcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Remove DISCINTIGMEM memory model
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

You may want to fix the DISCINTIGMEM typo in the subject for v3, unless
you think that makes tracking series versions more complicated ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
