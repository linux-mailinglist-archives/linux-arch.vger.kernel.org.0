Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05F22E73D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0IFI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 04:05:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgG0IFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 04:05:08 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MyKU6-1kj0fe0Ly0-00ykYi; Mon, 27 Jul 2020 10:05:06 +0200
Received: by mail-qt1-f182.google.com with SMTP id a32so11555223qtb.5;
        Mon, 27 Jul 2020 01:05:05 -0700 (PDT)
X-Gm-Message-State: AOAM533+FovHUCRXEqbpIWNVTVuRsVPhfKBGs0i4bG36nqwacykKFLHF
        SRiuqGmy6zPl0DvqoRii+CHIrd7wjKSeNArFhdg=
X-Google-Smtp-Source: ABdhPJwW7HBaQWs6CLgdTCVeXISCQaOIP+c3oTGIB10miF9DI5sJgMP6LjEsu2iAh52r0pKzuWEqUzrxFdj9FZB5XY0=
X-Received: by 2002:ac8:688e:: with SMTP id m14mr13917515qtq.7.1595837104846;
 Mon, 27 Jul 2020 01:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200726031154.1012044-1-shorne@gmail.com> <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
 <20200726125325.GC80756@lianli.shorne-pla.net>
In-Reply-To: <20200726125325.GC80756@lianli.shorne-pla.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 10:04:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
Message-ID: <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
To:     Stafford Horne <shorne@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PdHhCj7oiiqrJXYdq0ITMJFDMx5Lrek/Fal+pyeSGA1J+haBUJC
 fDbOujYyH+EZNKI1WWBaleyt/wQ/jlHsAmWzCXAatX2Bd307q0vrnIxNsMWhwmsWX59z6HV
 aJ8JFYATc+xNNcAyVgcLVgagzUfS1UBZw7tZ/gNgbeCAimoNwWWoUIW90X0ZgyouFl82yBM
 X88EohCnbhX5lHYyYFK0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dzVgJ0ItLgY=:3gVwWM0cahYnhz2ri1t6Qo
 zGSRiNeXw+Fvjv/TA8VXud7ceY6UX+E3lZ26yBnvvKpkDDuY9jS0/VIhyYrheVP8iOaRjPUCb
 j19fymZojz5UYqMS2aafBSC0rjKywyFWD8GBV4zoqxavYlXnXg+gKX3blrd+ioaP8FHP/ZbP6
 2JYWv3bUvKieUvexS6Ws7AkVhtHuaolnBBabl2O/lI1YPzayomPkPX0EUyyGpV/fJfE19UDVS
 KbMd1zEx7K6QiMOO524MUI41JseveSq8JtGyH6PI7wJb9eiYY+q6vxTte25Bv9J5p81QMUTkn
 5muNN3v+/0Ms+6w+a3IOB2St/TQfAuox60q6H8cAQb2LixRGIjOCdKwcZra2hhmYhkINvdkyk
 FRT+OUQiXnujHoguSjaMiKcpa9hZPwIhGYwMFWUAcPklHX+RWEdLVUh4V6320BM/AKJ5WXXky
 GmNOkCG3jqRllL+uV4dwHRoNk2qCzmR78WqBs03WQ/cONwd2fwx0ZXyoj2eLfgaXtVO1LYMqp
 9/4KafOuzE+uePi+xlZP8d9kiu7ZqZKGd80FZ+tINm2DvX/EBTjmGPjq4Ki6oxOnzgAQJIuGe
 DUEJLuejGHlhdsfcbT5pRkLh0tS11rfV40NLPZ2tee0btKu0RETYw1kCk/AljcAb50M964md2
 O92w1pR0xAdLYj0mZ7JM2EbJwq1/PZ0sn1Fa6vqFcQhURl2bmYUWg8wHLPC8kZQeO2jMvWX90
 dQgAi3ttGzgPazcudjqz2HZ4JpN9flzBTuUsjIsJba/4z5i21GqJAykh3PdEyfc1bPXHcnpz4
 7HiI7mMfdFVZaDuG4iknsh+jBhLYP07M2k0cfRMkCLUujmGI2Heyhahb6cc5KPDkgIsgfBZn/
 h/lQRD7kjkh+r/9JJF5jfso1UWgAqbXaMDsJ/FQXbjkOkjR9rvCjJYcqCV5jXy0ly/F4zAgbA
 wsZ6pRv0a3aCHscg0yAcFkmvY7PHIQ6VQs/74pPgdLFR+9Osq52YW
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 2:53 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
> > On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > The return type of functions _inb, _inw and _inl are all u16 which looks
> > > wrong.  This patch makes them u8, u16 and u32 respectively.
> > >
> > > The original commit text for these does not indicate that these should
> > > be all forced to u16.
> >
> > Is it in alight with all architectures? that support this interface natively?
> >
> > (Return value is arch-dependent AFAIU, so it might actually return
> > 16-bit for byte read, but I agree that this is weird for 32-bit value.
> > I think you have elaborate more in the commit message)
>
> Well, this is the generic io code,  at least these api's appear to not be different
> for each architecture.  The output read by the architecture dependant code i.e.
> __raw_readb() below is getting is placed into a u8.  So I think the output of
> the function will be u8.
>
> static inline u8 _inb(unsigned long addr)
> {
>         u8 val;
>
>         __io_pbr();
>         val = __raw_readb(PCI_IOBASE + addr);
>         __io_par(val);
>         return val;
> }
>
> I can expand the commit text, but I would like to get some comments from the
> original author to confirm if this is an issue.

I think your original version is fine, this was clearly just a typo and I've
applied your fix now and will forward it to Linus in the next few days,
giving John the chance to add his Ack or further comments.

Thanks a lot for spotting it and sending a fix.

      Arnd
