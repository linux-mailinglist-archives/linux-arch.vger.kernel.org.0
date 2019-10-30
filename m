Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4295E9876
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 09:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJ3Ivw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 04:51:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33636 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3Ivw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 04:51:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id m193so1318164oig.0;
        Wed, 30 Oct 2019 01:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mziza5J/MoDupcgI0RkmxCcsKm60Et3F2KLUw+t1RqQ=;
        b=FX0Qpi9u4CqeUqqDJRv0OaUj52bbx/Xh9cSzN35AEx14RwvvFwdQiK/IxsR0X0gpIs
         031snMs2K2ONh1aaFaDHcq8MCbuBVmJ5j1udrklDhi0pOVTbxJqEbHaJrqb7VdFsQXN/
         Iy+R7kgA2dayPFHDNWCDgZ9OZNdEMTTLhUw49+Y2UGaUo8xvlARX+zUVqvdkHEfavtka
         NdWKua2VdXBo0oypW7XJf3zNiPJ1tqYYp/EQwfG5wkTZpaTvVv13wo7K5tyOU9TkVHSF
         UUdrcjbCwDnqWNKkIqSxlQHYkVbFVRkxs8xfzQf30Ia8GoP2VNwp4kTCh4uILnKkxi5r
         3CbQ==
X-Gm-Message-State: APjAAAVNjlNUyoh7BjJ+GtO+jgaxq2nfplYG4A5K6TAApapog6KVoq3n
        UhCB7TPT5Ly5/F1KpOXj/5lWbazf5e5lxNztH2M=
X-Google-Smtp-Source: APXvYqywm9C+CpnmelJ6SWQKVIah4mda9qPmB6OrDMq707nGOy+7YzCdX2/qccGqz5HinY9G/c8lSRqxbZE+WID7kSw=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr4822487oia.148.1572425510897;
 Wed, 30 Oct 2019 01:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-14-hch@lst.de>
In-Reply-To: <20191029064834.23438-14-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Oct 2019 09:51:39 +0100
Message-ID: <CAMuHMdWGiHhSv=xCqnsUXok7wYG7Wr1EQh+yuPOZBxPCskUFVw@mail.gmail.com>
Subject: Re: [PATCH 13/21] m68k: rename __iounmap and mark it static
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:56 AM Christoph Hellwig <hch@lst.de> wrote:
> m68k uses __iounmap as the name for an internal helper that is only
> used for some CPU types.  Mark it static, give it a better name
> and move it around a bit to avoid a forward declaration.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
