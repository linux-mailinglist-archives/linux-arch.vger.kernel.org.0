Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12A3B6C0B
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 03:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhF2BcB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 21:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhF2BcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 21:32:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924AAC061574;
        Mon, 28 Jun 2021 18:29:33 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j184so29562673qkd.6;
        Mon, 28 Jun 2021 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKTZeqsgZVd/xQQ0ZZ3e73fmxZPktDpaewy2pS7/C+8=;
        b=KW91ldLhmC4ClF1+sS8W9j06oMAkDW8v5QmirYo2T4OdNHvAOyQWIi6CIV1sSY6F2/
         BOIZYJTrJc058x5eP5T00udnX9cP37ySRmvC9+3AFP3GPEHDmWFZims0eLQDhHH6d7HJ
         IQKwslMoftASJY6rMAFmCGs4ublBmRZG6Eyr1uIyQLXGbbLt3vj94DAH5xjkM336BSXo
         FfuDIFzgGUwv2xHTd0mj25Vvp7F9IpKsTr9DSUAQ6qfHtyIPjL4FMlIOLjK+xyQMLQNv
         BGgLdaZK/MwuV8J8XKenSrTqx5W3WGjLchT4b+3SdmYpzZQ8W+mFDSRhl8wtv716WrvV
         yEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKTZeqsgZVd/xQQ0ZZ3e73fmxZPktDpaewy2pS7/C+8=;
        b=tHh1rH8FswP1uCcJocEyClOrEQ/mK0CPn8tn4EV4WXnpf3XkxhxQqUU0L72eAIcTZa
         9fFw7qYutYKfxKmk9ZpkWJmqyHHLimQEUp3lmfDw3Dw2Zgy21gxanTekIeQ7R1Z+MiWv
         t3x1JR2+twwTul2zXEqPvhzK5TxhXTDfOrKHsDb0fEiJrSfaWWFU5nqL6z2Rh3TsbXYn
         XqZhpKhII48feNDYFfXumZpFlDCGjy7WY5jsjLGZ4yRtZa7nOsLaOT1qdIa2dZtL8JmQ
         TZTTAvXkVs+4FXIUQGczXHEpzd/pwoBbZI4ttG5oAyoFEro8PiParqF1JIWt2l8gaQ2z
         3VJg==
X-Gm-Message-State: AOAM532W9NHVR+gTMvNQ4xFIFehAHzCvIUzL0ZLKLTQf0AFBD+bZsnok
        rR0Y6/A040ukrqA0NI/vhoM=
X-Google-Smtp-Source: ABdhPJwO8Vmgt1NAhu6hvjO2GodeuT35umtzmdqDUWPq31B85IDG1lO+iDbpoVT6frUSvOuQ1oX6eg==
X-Received: by 2002:a37:6149:: with SMTP id v70mr15760545qkb.76.1624930172596;
        Mon, 28 Jun 2021 18:29:32 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id i19sm2472552qkl.19.2021.06.28.18.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:29:32 -0700 (PDT)
Date:   Mon, 28 Jun 2021 18:29:31 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 1/8] bitops: protect find_first_{,zero}_bit properly
Message-ID: <YNp3extAkTY8Aocd@yury-ThinkPad>
References: <20210612123639.329047-1-yury.norov@gmail.com>
 <20210612123639.329047-2-yury.norov@gmail.com>
 <CAHp75VcfX4X5w7yeheostadvfTjhnnzgsTyhMM-9wgS9Lgfn1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcfX4X5w7yeheostadvfTjhnnzgsTyhMM-9wgS9Lgfn1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 13, 2021 at 12:38:52AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 12, 2021 at 3:38 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > find_first_bit() and find_first_zero_bit() are not protected with
> > ifdefs as other functions in find.h. It causes build errors on some
> > platforms if CONFIG_GENERIC_FIND_FIRST_BIT is enabled.
> 
> Fixes?

Fixes: 2cc7b6a44ac2 ("lib: add fast path for find_first_*_bit() and find_last_bit()")

> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
