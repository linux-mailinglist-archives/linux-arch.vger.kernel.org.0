Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB525F0E8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIFWPT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Sep 2020 18:15:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIFWPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Sep 2020 18:15:19 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N95mL-1kaIZX3Pi3-0167Ln; Mon, 07 Sep 2020 00:15:17 +0200
Received: by mail-qt1-f177.google.com with SMTP id t20so8713697qtr.8;
        Sun, 06 Sep 2020 15:15:16 -0700 (PDT)
X-Gm-Message-State: AOAM531zFPZqXvtOSJWCj+LXMT/4OUNq4OkELI+I2sbbJ9P03mJug6Kt
        qT+oxKi41iA1XOCLUjv3OXDxS/FNluKkLqM0c6c=
X-Google-Smtp-Source: ABdhPJxwkpjvN/x7Qacu70mZjFWP8AmaMXUiYeZRlF/0mV8kkA+fzaouJtHyixrWIYKaJPrJakvGRGbLSRz/4O5f8dk=
X-Received: by 2002:ac8:5b47:: with SMTP id n7mr18419344qtw.7.1599430515531;
 Sun, 06 Sep 2020 15:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de> <CAK8P3a3t8a0gD2HsoPsMi7whtNb7BdzPN6-oo6ABnqkbQJoBfA@mail.gmail.com>
 <20200905071735.GB13228@lst.de>
In-Reply-To: <20200905071735.GB13228@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Sep 2020 00:14:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3BN-Afy4Gj+mGjxiKODUBZwjh+XRbXqQKV-uEhyhOTfA@mail.gmail.com>
Message-ID: <CAK8P3a3BN-Afy4Gj+mGjxiKODUBZwjh+XRbXqQKV-uEhyhOTfA@mail.gmail.com>
Subject: Re: remove set_fs for riscv
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RDVpx0wvlKS7kKQF356tU/RCwTwoxIjZ+Szm355OY9IiMxWZIq3
 dAkD/boYJ8a6aCGhtL3biL/FA0/0ov7bajOFOGn3QkiyKJVpKlgZ+D5FhPIDB0gbMNA2S3r
 uOLNXygocCY8Mw8SVNy2FolLvewuQW1WYLIBE7KesrlTcNnbiUkrNJRDD2m3mMHtlBTQ7QW
 GHKH0318/EFVqLblzGNZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wWPfBQ8ZQ2U=:1ix0XHpYN9n5pp6/SnQVOr
 JBW5xcyPJUker6yLdCXVd4KWJGeuPoMov/k6dA/or1qh+c+KOqdipwEWz7iNk5zix959lfMl8
 HMvlq7ZGY6betoqWcK+fbLyLKVInBCevfTthuBLszUtFxmQTmPT1rS6vgr7GVyw8Rg5TFPcVD
 JzpFR7qji5+M9zQPlP3NvM8OceZav+QYL452ihtnwG69Do4k9HtMs8s2Tt23wsTs2qM8Re3wR
 9W7sIdx4+MF69EuraKuV2VAnb6KP6wFGBzaOilWvrWwyMudXm/0pHrIa1MEqAseSS3YUT34g5
 WYk6TZfaefT2/s+6BZYKkcQ0/6zTzOSkLAQ1XNxwmXOAhWVaZZdomle9i3rliM8Nzajn25/pf
 KL/qd2gHPDiVDo5BYw+swLHKvI8P0SokJOvaq2q2LlTTr0u8VGWpkMHKGZgpGQiOtTzq0h631
 xfP4hV1x3W1Wz3wRF4QKckgDkZkBU86fo6Plg02Gud28zfGDzyzGd7NjTPMN7LnXdalFEpfhg
 3/1mmiASzv20qzlG92PbwHKJm40EUouUkrD0Ya6PTh8j4ezXyfF2fvfrk02dZRPB4F7Swit/Z
 VPaqgY+KbkLu0TfwKBE3ZYflLVji9yuiCSH1+3/jZ0tF0krocM1q8V41RhroLzsxn1IxKSsUD
 qtHENpaIt27+PrZZuicmkZRol5TCuuiHBEPsxiCw+llGzJQ0oA9e07pyAhtjhTjqKHhoxgKSP
 xpjVG5vAhHKklCq7v/yPrsaMRBFs21NlEIWZN9TBwneBRflZfKXo3ZDI+oofdLIC9uQSwr0oH
 IC4eDr6gWSetTtJo3KwccggxqUaIPrwH2hEPISW04IzH+RsG2vEtOsopeaT4zApHqlZGv5q
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 5, 2020 at 9:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Sep 04, 2020 at 08:15:03PM +0200, Arnd Bergmann wrote:
> > Is there a bigger plan for the rest? I can probably have a look at the Arm
> > OABI code if nobody else working on that yet.
>
> m68knommu seems mostly trivial and not interact much with m68k/mmu,
> so that woud be my next target.  All the other seems to share more
> code for the mmu and nommu case, so they'd have to be done per arch.
>
> arm would be my first target because it is used widespread, and its
> current set_fs implemenetation is very strange.  But given thar you
> help maintaining arm SOCs and probably know the arch code much better
> than I do I'd be more than happy to leave that to you.

I've had a first pass at this now, see

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=arm-kill-set_fs

There are a couple of things in there that ended up uglier than I was
hoping for, and it's completely untested beyond compilation. Is this
roughly what you had in mind? I can do some testing then and post
it to the Arm mailing list.

      Arnd
