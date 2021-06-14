Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525953A6ACD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhFNPrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 11:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233560AbhFNPrr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 11:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623685544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41vHZWdRm3PEdn+fE/Pjl4Zp1BFWR3ixLX62Tshij1E=;
        b=TPuDrTDGDtLRsUEv8/PWIki9Xi7zbaVEAMOtjt8U6zgSG/24yQ+yLTYdVLI/0OFLz/WBID
        Bij8q+RpbB6JCok9BMIyo4coG50FfI3zfCLb+UHs4qMUvrT8hLvnXS5LgV38dmfmXabgFf
        98dYWgpcHuQ63UrwFgOOGQUscxaStSY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-AF_dWAauPtyL-ZFLqcVSFQ-1; Mon, 14 Jun 2021 11:45:42 -0400
X-MC-Unique: AF_dWAauPtyL-ZFLqcVSFQ-1
Received: by mail-lf1-f69.google.com with SMTP id d20-20020a0565123214b02902ee335ffed2so5370940lfe.16
        for <linux-arch@vger.kernel.org>; Mon, 14 Jun 2021 08:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41vHZWdRm3PEdn+fE/Pjl4Zp1BFWR3ixLX62Tshij1E=;
        b=YT7jtNHhgyOIOulYheaqRI31q9Ch04Yw5P+TX5VjbbeWU/cduEo9ayN8F6nUbrUFR3
         LGKbYZPy2avAIhUZoJL2aDXlukd5C5SsrgpJB+LTf4fGRQBxAyo7gzT+GNiTYKuc81KQ
         nM6ZHRw6akPZzQgigH6NkF3FIklsgWwXBaB/HHDN8Ffp6TN/nJ6l7w2Yv2BkXIKtcDpo
         BRlZQGVVfHo1FdVZkkLs1F7VsEPgs/xiz+YzWMNaacQuB3l1wlJ7HE1xxWZ60vy9xu16
         7AchjI2K+E62TzTpDRQ0Tp7reXsYmjOFVgAHgMOa1zUAdpmp8mUsvh39gxiny3vk3j7h
         oLVg==
X-Gm-Message-State: AOAM533CY0F4TPMFQrzUK6sYEshSu+nO6gubpYzxHIMjVldOcw07b9be
        oWcDHshGy3u3RCAddB+MzXp2/mPrioeVllHQo/DPojhpxu98bZtos55YAX40+RfEwBrvYT46ri2
        UF/4SFeKw7w4w1so9Hr/L+tyUdDDjyHOp8lS9RA==
X-Received: by 2002:a2e:a410:: with SMTP id p16mr14088495ljn.426.1623685539847;
        Mon, 14 Jun 2021 08:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGMuwpF19PlaoWXsZvplQQb+P5uJB/sEiVQPqQHZoCGniIsXd7N2HvGw6qvXxWaTZCh/d42gq62iQqvhtU9dU=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr14088490ljn.426.1623685539700;
 Mon, 14 Jun 2021 08:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210612123639.329047-1-yury.norov@gmail.com> <20210612123639.329047-6-yury.norov@gmail.com>
In-Reply-To: <20210612123639.329047-6-yury.norov@gmail.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Mon, 14 Jun 2021 16:45:29 +0100
Message-ID: <CAFBcO+9+kiqo-5RXqVuFGdA4yAV0o=zeJaenLZ5zryP-CQfAQQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] lib: add find_first_and_bit()
To:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 12, 2021 at 1:36 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Currently find_first_and_bit() is an alias to find_next_and_bit(). However,
> it is widely used in cpumask, so it worth to optimize it. This patch adds
> its own implementation for find_first_and_bit().
>
> On x86_64 find_bit_benchmark says:
>
> Before (#define find_first_and_bit(...) find_next_and_bit(..., 0):
> Start testing find_bit() with random-filled bitmap
> [  140.291468] find_first_and_bit:           46890919 ns,  32671 iterations
> Start testing find_bit() with sparse bitmap
> [  140.295028] find_first_and_bit:               7103 ns,      1 iterations
>
> After:
> Start testing find_bit() with random-filled bitmap
> [  162.574907] find_first_and_bit:           25045813 ns,  32846 iterations
> Start testing find_bit() with sparse bitmap
> [  162.578458] find_first_and_bit:               4900 ns,      1 iterations
>
> (Thanks to Alexey Klimov for thorough testing.)
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Tested-by: Alexey Klimov <aklimov@redhat.com>

[..]

Best regards,
Alexey

