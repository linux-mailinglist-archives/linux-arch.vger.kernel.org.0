Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A633A5109
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFLVmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 17:42:20 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45037 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVmU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 17:42:20 -0400
Received: by mail-pf1-f181.google.com with SMTP id u18so7433063pfk.11;
        Sat, 12 Jun 2021 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epMHjnPhbNNlT6Qw4ItgSYLiUlQgXsV+IiGQEE2nlc8=;
        b=l66IJcNglArpOxWXoB+BLSXBEUKRmWftbpOZsqpk/Y5vB0ZjjYIcpuZSYc+m/mysjb
         F+D13P7dPAWaURph7SUKPIHgyho8JRfEI4SrdN7yE4+jkly5Lb3N+GWoISiTtOl3Yb+F
         d3TpGJcq4CWXGq7QtN6WAWJ5DobKZyNLYHHssdgqdVgWJ54JyECO4cSTqF4++jUTCm5t
         uzSVbA0BF6D83NR+AmVPEECCzTLkuGwF0/y7xOXVlZD9E1ZDjxD99pcDqSpb5EZzwyuI
         z/WezFkonHwaMMQ1gE/xWPB3CtrdHCRESZHobp5OkwAp2SCUn47quU/CBD9qHYTbppgv
         NozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epMHjnPhbNNlT6Qw4ItgSYLiUlQgXsV+IiGQEE2nlc8=;
        b=Wpnf8p1QBIbEhSPqvLFArPVms9FSFJTXV2mCqlk/+XvcjQIXREAxwQgCYxUH/Fbmc/
         2wcKT0/CYfAMbeP7hh4NDzK6jBR++Q5xMfSd8+6ZOc+70LnA0CA6vY+9tuilKgMFm6LN
         wlJjiTdARq+WecVK9EEWyZ59c+nroQYmF/tlHQe9XKQ6Q510YYgV9aaR2rw3WP5XP0Ip
         AhAyV0pvG/nQLJ/rla1jcMA2071r1qNh8twDeUS29boI4r2xhokqVoifGPDW6Ypj6W+x
         WnUV7uiNJIPaCPIbP9EjJPPraFyCaJHgkIHxRUYQ/HNnWGO9N671KraW3ucQylsTWap8
         HsPg==
X-Gm-Message-State: AOAM530Lo6DObHM1wFwOSm3XaZ2O42rO2a7Gps/TgldyPPLFxJCP4a/o
        sG7WVuxj+OihPSP3qSfgnBLG6XbCrR5Ufqvmx9M=
X-Google-Smtp-Source: ABdhPJxfD1D+qTKWopXSDHqGrm7Vt+8P4foDxF9sJm9/aQlPk8kCLVvI1AYum+VfEO2AwSpfkVox0MEJrky3qP+qEfA=
X-Received: by 2002:a05:6a00:139c:b029:2f7:102c:5393 with SMTP id
 t28-20020a056a00139cb02902f7102c5393mr7941129pfg.40.1623533949479; Sat, 12
 Jun 2021 14:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210612123639.329047-1-yury.norov@gmail.com> <20210612123639.329047-2-yury.norov@gmail.com>
In-Reply-To: <20210612123639.329047-2-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Jun 2021 00:38:52 +0300
Message-ID: <CAHp75VcfX4X5w7yeheostadvfTjhnnzgsTyhMM-9wgS9Lgfn1g@mail.gmail.com>
Subject: Re: [PATCH 1/8] bitops: protect find_first_{,zero}_bit properly
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 12, 2021 at 3:38 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> find_first_bit() and find_first_zero_bit() are not protected with
> ifdefs as other functions in find.h. It causes build errors on some
> platforms if CONFIG_GENERIC_FIND_FIRST_BIT is enabled.

Fixes?

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
