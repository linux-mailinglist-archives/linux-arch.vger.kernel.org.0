Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE592D3689
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 23:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgLHWzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 17:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbgLHWy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 17:54:59 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA2C061794;
        Tue,  8 Dec 2020 14:54:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so14823wmd.0;
        Tue, 08 Dec 2020 14:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l6v5eGqOum7wUjmDQNJGAFz828yznKEqu47GFykos8E=;
        b=LhH39ZJllmZgRfTf/stoFJUkdm/dcAq3xnEuGAp8Va6ittVOc4iIH8MTdfV7F3DXgY
         j3v5mJq/mSgfFDthJdNwlTUTwaCdcDGtJ9nyTJRCiBh7Bcz28jPFFincwK7yvmYqww+u
         DAKUE12Za6tSxJ7Rbe0zSQt5qrwj+HIt2wgsec2kNK5HLwOFFyLjlQsWs7zXeSE4c+qB
         CnxDu+nEbuB6rOAyoyuc9jUtZDFbOJxyqkE3eylvSJUrWtUSSw6hC2tAP4Uz/ne32UcK
         bbFq2NUfAMF+5bmOEe43HzoPU6V9+bYd7SP94MCjgLKDEkRjS+HLojKmjx+3QNpVvf7V
         GcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l6v5eGqOum7wUjmDQNJGAFz828yznKEqu47GFykos8E=;
        b=MY63rgHCCnisO9qVA1gf5tmemcitzdYr41OGqSFl6tN4reyZx7Zwwtbg8BJbqduaFf
         CP8rb8CYruDB2RUgfFKvnV+FVVnsnGgRSOxXkffhWQqzlIZfqKd49gfRBuP9AtW+K69B
         EoX5lHTl0NSMTZxO11RnPjgHVai45g+y3RPll8lr9edVJF8yE9puia4DdnGxWautqLQu
         22pnJECqT9wOMzmHaOpk0/6E9fOTZMoW9FOoNtt6t5dIj4zIyvksTwlEG6EFX7M6tXAY
         d1lFQNLVITAgJRKtkDVxkz7TWPKghugTTYy67Eoua5rBRxqTFds/q+ZQiDP4+1Bvwxqx
         t0Lw==
X-Gm-Message-State: AOAM530UdjG8ydEoaDtsBcYSrGAfo00kpvKML0Vz6kEq3TX+/klBe+zq
        3rvHBl8CIoHZiij7v0XYXEyP8ULgahwTqYCjoc0=
X-Google-Smtp-Source: ABdhPJw400Ws44xNLBD4ZTOJFxkw8sVbXemco2YVdG5lmPlUv7qXS9ndgp56DxsGieEi2wCieOAMSG4duQr34HnEoD0=
X-Received: by 2002:a1c:b742:: with SMTP id h63mr64902wmf.122.1607468057844;
 Tue, 08 Dec 2020 14:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <X8yWxe/9gzosFOam@kroah.com>
 <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
 <CAM7-yPQgkh=JnW_mtX9fXRin87sHQjh+58aY3asgBvHK+g3V_A@mail.gmail.com> <4e339fb4-adae-4c28-a40b-986b5e73fd0d@suse.com>
In-Reply-To: <4e339fb4-adae-4c28-a40b-986b5e73fd0d@suse.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 9 Dec 2020 07:54:06 +0900
Message-ID: <CAM7-yPQ_Ak+uzPadeuAUCjv-MP=aK1HuKXC=czzM_+=wWCvnLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, rdunlap@infradead.org,
        masahiroy@kernel.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>, broonie@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, mhiramat@kernel.org,
        jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        Alexander Potapenko <glider@google.com>, orson.zhai@unisoc.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        dushistov@mail.ru,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> btrfs' free space cache v1 is going to be removed some time in the
> future so introducing kernel-wide change just for its own sake is a bit
> premature

But, I think it's not quite a kernel-wide change just add the
correspondent function to find_last_bit.
So, if we add this feature, maybe some users will use it in near future.
As my fault, I sent this patch without cover in patch [0/8] to explain why
So, I will send this patch again to take some review...

Sorry to make a noise again and Thanks to advice.

On Sun, Dec 6, 2020 at 6:01 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 6.12.20 =D0=B3. 10:56 =D1=87., Yun Levi wrote:
> >> This, and the change above this, are not related to this patch so you
> >> might not want to include them.
> >
> >> Also, why is this patch series even needed?  I don't see a justificati=
on
> >> for it anywhere, only "what" this patch is, not "why".
> >
> > I think the find_last_zero_bit will help to improve in
> > 7th patch's change and It can be used in the future.
> > But if my thinking is bad.. Please let me know..
> >
> > Thanks.
> > Levi.
> >
>
> btrfs' free space cache v1 is going to be removed some time in the
> future so introducing kernel-wide change just for its own sake is a bit
> premature. Also do you have measurements showing it indeed improves
> performances?
