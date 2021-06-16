Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A963A8D84
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 02:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFPAfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 20:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhFPAfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 20:35:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83847C061574;
        Tue, 15 Jun 2021 17:33:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d7so362905edx.0;
        Tue, 15 Jun 2021 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsSNYVIozB9ftiPAfUMSru47aMNYHPLKEsM4T0oQcRY=;
        b=LG+tI/+5s00/IZs+iLkyZfcF/Px7Xc90vcaaxylci9OBEgbg7hXT091ejP96knZxDg
         U+ZFY8qCwsixshXHnzEt7/eTGh+vHO3LIxv3xvlZ+0V9Fgdt3NkaqSg1enuDfzmZvPdi
         tlYFm0hfGI0nqBodCt7kZ0yuC3RIsvX1oLBQCq9vnIU9xXIFMKXea0ezU4Ksv4yFhMOe
         VgnWSyqNIh3vtiYkBJ/2MrJOTrZl7GLi3WGb+s/PmJLbr4v1MUWpU+tv4wOM92DksV7V
         XzU59GR2t+HHTc8UxRTdrJMldU7rTTta6m58oOA8aDczTPgmJc/DZs10u50PU1C+ZlCw
         SPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsSNYVIozB9ftiPAfUMSru47aMNYHPLKEsM4T0oQcRY=;
        b=nQ2voLhPQOOB0G/TQiexjWsr5UbTRl/qfkZktHW7e3PiCZ7nNjNrpPzSHjN0ySaTwC
         pJa1TRAdsd1IcSrzixRkUriQmFWK2JLLQlqEbg11SGbR1lNRxI4xmLQdEcvA7lZpMHzt
         2lt3CDbT3P0hhw+LFBc2Ub4VnnGDoPvbC1i+QGXFmtEIVpJCQTUjuWJoYlThWRq9YSyg
         jB53bT+VW30pp+1/T9akdc1b2l2ksNTjJuD5hMmkN80ArE96rUZYLIJ3aOic142tcop8
         3s80XVoO7Im1b/FvCxVhXxwf4O0KK82kUCuKUWAF6kjOwZHijguI0W4yoLxXLhiWWDcq
         lHbQ==
X-Gm-Message-State: AOAM53103Wc0DtM0oV60wlmIZRTyQM/bvEgubZDAssGktlTHmW31qBrP
        7Uh8ICxUQ2vI+Xy7BWcmh9xYTFXAQZ9pfFedeKA=
X-Google-Smtp-Source: ABdhPJxp8c+7fCJGxOWx1AGZi8f4Stfs5QV8Zrs1O3zUnOCyQIW92wTOm+Xpq7nUzLcWUqzeTT4Np55x3Nv7aEI1g2c=
X-Received: by 2002:a50:9345:: with SMTP id n5mr898254eda.289.1623803613192;
 Tue, 15 Jun 2021 17:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
 <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com> <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
 <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
In-Reply-To: <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 16 Jun 2021 08:33:21 +0800
Message-ID: <CAEUhbmX_wsfU9FfRJoOPE0gjUX=Bp7OZWOZDyMNfO6=M-fX_0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     David Laight <David.Laight@aculab.com>,
        Gary Guo <gary@garyguo.net>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 12:12 AM Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> On Tue, 15 Jun 2021 at 15:29, Bin Meng <bmeng.cn@gmail.com> wrote:
> > ...
> > Yes, Gary Guo sent one patch long time ago against the broken assembly
> > version, but that patch was still not applied as of today.
> > https://patchwork.kernel.org/project/linux-riscv/patch/20210216225555.4976-1-gary@garyguo.net/
> >
> > I suggest Matteo re-test using Gary's version.
>
> That's a good idea, but if you read the replies to Gary's original patch
> https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/
> .. both Gary, Palmer and David would rather like a C-based version.
> This is one attempt at providing that.

Yep, I prefer C as well :)

But if you check commit 04091d6, the assembly version was introduced
for KASAN. So if we are to change it back to C, please make sure KASAN
is not broken.

Regards,
Bin
