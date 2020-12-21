Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0A2DF8E6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Dec 2020 06:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLUFpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Dec 2020 00:45:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgLUFpJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Dec 2020 00:45:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CzpLk1qPgz9sVk;
        Mon, 21 Dec 2020 16:44:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1608529465;
        bh=8q8pjXmt3fb3/FcKFZZhBpNNcXsp66j8Isw1H4VoFss=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZnWF70NmUxyOGkj7ajnBegDo04rv8gH5Ux9NWJhGuiFgnNMVogs2qsK/JPPvTOxX3
         hzwMtUhjiDSqvHc4ZZWFFrTwkUdkYXJq/1ML2X0U5qamtbWBfarkCtNAXDelPjKyYu
         4R5GrwJUkFnZSYIfsBFzv3+C8RVv3a9uzsg9fDjFKnZkRtQDx75FnOmDIw99taeAnd
         QCskX9h/ngj+6oMYoBPKKaJh3wx/SkbDouSAAbUuPyGD0ebzLrrNquc0B/69DXdzQf
         fJmTp61f2fzdZls70bVcMCLTyxKnMkjf3NMjT+RK4eF560XOppbITSBixDl2QbJUdX
         VnJ3dZzhE+mIA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt\, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        "open list\:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
        Linux-SH <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 01/23] kernel: irq: irqdescs: warn on spurious IRQ
In-Reply-To: <CAHp75VfYz_K2BYOxqmSx0q+1F2F9Lp1eb70RrNYzJHs3FX+quQ@mail.gmail.com>
References: <20201218143122.19459-1-info@metux.net> <20201218143122.19459-2-info@metux.net> <CAHp75VfYz_K2BYOxqmSx0q+1F2F9Lp1eb70RrNYzJHs3FX+quQ@mail.gmail.com>
Date:   Mon, 21 Dec 2020 16:44:13 +1100
Message-ID: <87ft3zyaqa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> On Fri, Dec 18, 2020 at 4:37 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>
>> +               if (printk_ratelimit())
>> +                       pr_warn("spurious IRQ: irq=%d hwirq=%d nr_irqs=%d\n",
>> +                               irq, hwirq, nr_irqs);
>
> Perhaps you missed pr_warn_ratelimit() macro which is already in the
> kernel for a long time.

pr_warn_ratelimited() which calls printk_ratelimited().

And see the comment above printk_ratelimit():

/*
 * Please don't use printk_ratelimit(), because it shares ratelimiting state
 * with all other unrelated printk_ratelimit() callsites.  Instead use
 * printk_ratelimited() or plain old __ratelimit().
 */


cheers
