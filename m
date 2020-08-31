Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31A257D80
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHaPiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgHaPhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 11:37:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A48C061573;
        Mon, 31 Aug 2020 08:37:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g13so6372009ioo.9;
        Mon, 31 Aug 2020 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKhPg2peu0bzgNag4eCqNzrqsBROFucfPoSefuXeaw4=;
        b=s8V6n0xALCLBzggML/oL2yBo0b4sDJ8Fn3DqT0kDfs/UOSNjzu72iqpAcc/jOJMKfr
         A/X2ov0QZLPmxbLfzmr20VzbN4QpLVcB8/ifn3Hnv709YWR2nhhjTxPG24HCRl5kcDT/
         vk5JoQYRHzNAmuWsYm7HmliEhq5ubgdI3t/2C8Ogm/yL+V7S3MJLBZ323Oq5Vt2/D3DB
         OKh8Y2eauBBIl0MR/puj5LHTeekB602eHpsIHDKNxTijC2Ktrupnf9uOB+L0aFc+bCT8
         3JIMkJ1d0l9l6M/R9X1Keodws4gRxelxxxJlBKkosrBYvuZneLQIHkRn4f6Sx1K7ePq5
         lAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKhPg2peu0bzgNag4eCqNzrqsBROFucfPoSefuXeaw4=;
        b=n1hODbegBkoUw54XoTSBBzD8QeRjRpSzlSTgUW38Mf6oZqjwMEJ74kw1fIxS7vsUmx
         vP8XWMBisTR6kulnH6kj7xaQUEep2NHs3OI8PM008MxWbPpmuaXt44LfafJ8ycHQhWCW
         JMUOR1yWkJ29ewRsiEHNJbY16UnsRBuOHefZXMW1MGnfsJQo4U+zcGGTeKnNJwrCQDI+
         ajKoqwkV+mplbVqKxFZkhveLjcneOwhVaiSqMO7JWvfilR4XH/D3xa2G7usQmlKtRagx
         LqXkEsfivxDP4L6/UcJovCMZQgmtLumXt5kKaVmWomixFhDV/Z1YfG1d39XYwF1Q/HGV
         747A==
X-Gm-Message-State: AOAM531kkzl5xMwZTiz4q7MrG5DST0qLn5gcdRhvMGz/FcFeLAxMBmvy
        ziI5isq7HNOOO9E5nn9vqApOOTkD08i+BzmH3vM=
X-Google-Smtp-Source: ABdhPJwNBcqnCmmfCXu/qtgS8DcU6uT+FMOssh+c39rLoFbOIo6hVA6Vu3hW/p2ti6dlo5FyhXDcPgG1rpZIIDrEP2o=
X-Received: by 2002:a5d:80c6:: with SMTP id h6mr1735767ior.2.1598888272759;
 Mon, 31 Aug 2020 08:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593243079.git.syednwaris@gmail.com> <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
In-Reply-To: <CACRpkdYyCNEUSOtCJMTm7t1z15oK7nH3KcTe5LreJAzZ0KtQuw@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Mon, 31 Aug 2020 21:07:41 +0530
Message-ID: <CACG_h5oW1o9JTngqUi7X2u4mrfjcjA5D9Kz-r6TmBw3orRQ63A@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 16, 2020 at 6:19 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Syed,
>
> sorry for taking so long. I was on vacation and a bit snowed
> under by work.
>
> On Sat, Jun 27, 2020 at 10:10 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
>
> I have applied the patches to an immutable branch and pushed
> to kernelorg for testing (autobuilders will play with it I hope).
>
> If all works fine I will merge this into my devel branch for v5.9.
>
> It would be desirable if Andrew gave his explicit ACK on it too.
>
> Yours,
> Linus Walleij

Hi Linus,

As a reminder, I would like to point out about the
'for_each_set_clump' patchset. If it's alright and if anything is
needed to take it further so that it is finally accepted.

Regards
Syed Nayyar Waris
