Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97BA2DFAD2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Dec 2020 11:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLUKIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Dec 2020 05:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLUKIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Dec 2020 05:08:18 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6FC061793;
        Mon, 21 Dec 2020 02:07:38 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g1so8376138ilk.7;
        Mon, 21 Dec 2020 02:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMI1qb6jm5Lag9GLrKzNd8c/nLzIAunUnseb/Ze4wwk=;
        b=TNketNi86VoSW7yUCz1xJ0TySRbiCNnk6lgZVPNFHRq1Z0hYh2gKvfrjKM7LrvZdfw
         RQePP3CI0izt8okVH5i0MDqzLe17kJ+gYsfp1t+Ps8IwCEHGQkv7O3PSU8DKD3ZNNffG
         /JlM0O2eWxUHvRwz8qee/+LJwONqHO0lDu8V6J4W8M+AzN/jgGfMEfd8saM3jRp+ynNl
         yyNQ52YpnwxSo70pHdjSzvzY1s3U8IilByiBPR9JecD00QG9hEu5BbgRdRErCXzWs2gF
         45fFo4tr95q3qQ6Y+q0mxPqCFls3IDtt7iuwAPe+p0gTlRoSBsbkFCIhsAdHSkhvZ6+r
         94Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMI1qb6jm5Lag9GLrKzNd8c/nLzIAunUnseb/Ze4wwk=;
        b=YYKLvGl49Km5hp+Bhy6/FVGJ+0Bs1nfjCqWnTl+18srqAkzbUwoRONQZ8fc0oxqVtK
         K8zasPDI3EpqyiKJ7JGaqivlENoYT2EvhUaGwIeYGnvBldfIKZ4WQJDbI7dajvUJP+jU
         I2Z1a/71m7Mmmx+UdTauIar3o5BA8H5IUXbnuH2FBrriA58Guqh/yOAQDj9MElWGkHxV
         ls07dg3f9eF3pMIaOyGd9BmC0b5E3PzeeCtQoWQA/6vOiNpW6rUKLh15DgZa+/sCOyIs
         2Gv6B683vv1YoKiiU12qLhDmnX9ZndeEtAZqd3BbVx8/yMcn9MrIxPn7osbk0X//571l
         Mi3A==
X-Gm-Message-State: AOAM532IJrq3cD4UeWGwIHg1XDotXF8tOTmhme06aQyNCMZoSIRSLQAl
        SGAqA2+QLJQk0+1+TKBagaaq0zLivqz8H7DQHrQbPzj51EY=
X-Google-Smtp-Source: ABdhPJxBtvImbDXQFJZFiuLU9iSSxkb054vusc68KLoVKz7M+YJaEYxx6P2xuo8zwNE89O9MkgEk4eONGxpDIef9SqA=
X-Received: by 2002:a63:74b:: with SMTP id 72mr14619803pgh.4.1608542798518;
 Mon, 21 Dec 2020 01:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201218143122.19459-1-info@metux.net> <20201218143122.19459-2-info@metux.net>
 <CAHp75VfYz_K2BYOxqmSx0q+1F2F9Lp1eb70RrNYzJHs3FX+quQ@mail.gmail.com> <87ft3zyaqa.fsf@mpe.ellerman.id.au>
In-Reply-To: <87ft3zyaqa.fsf@mpe.ellerman.id.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 11:27:27 +0200
Message-ID: <CAHp75VeGs-x0-XgpLS0uB2oZmxKZREfUKM1ByUwmRquqFc2FPg@mail.gmail.com>
Subject: Re: [PATCH 01/23] kernel: irq: irqdescs: warn on spurious IRQ
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, msalter@redhat.com,
        jacquiot.aurelien@gmail.com, gerg@linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
        Linux-SH <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 21, 2020 at 7:44 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Fri, Dec 18, 2020 at 4:37 PM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >
> >> +               if (printk_ratelimit())
> >> +                       pr_warn("spurious IRQ: irq=%d hwirq=%d nr_irqs=%d\n",
> >> +                               irq, hwirq, nr_irqs);
> >
> > Perhaps you missed pr_warn_ratelimit() macro which is already in the
> > kernel for a long time.
>
> pr_warn_ratelimited() which calls printk_ratelimited().

I stand corrected.
Right, that's what I had in mind (actually didn't know that there are variants).

Thanks!

> And see the comment above printk_ratelimit():
>
> /*
>  * Please don't use printk_ratelimit(), because it shares ratelimiting state
>  * with all other unrelated printk_ratelimit() callsites.  Instead use
>  * printk_ratelimited() or plain old __ratelimit().
>  */


-- 
With Best Regards,
Andy Shevchenko
