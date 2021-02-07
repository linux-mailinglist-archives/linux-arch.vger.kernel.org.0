Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4195312148
	for <lists+linux-arch@lfdr.de>; Sun,  7 Feb 2021 05:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGET3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 6 Feb 2021 23:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBGETI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Feb 2021 23:19:08 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C76C061756;
        Sat,  6 Feb 2021 20:18:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id a16so9743459ilq.5;
        Sat, 06 Feb 2021 20:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0nh6s6iVQifHimFBlt9HsSWgh0AuZfoaMEvFjIFmTw=;
        b=PXVstjrRPiSBUJHkTotsW1+xZIPbMhPQV5Z/9ECzLJcj9omaRFj/6zfj3OX82+S3ih
         4w/Fs8HvInZDyln13YIVs84TWEv20e5JlM+hLuUBkx8JhC+7Ya2FeH6egJn9Gvj/uC0w
         zmaw7JsHrGrkAVN7gBbG8l2NnPrGdoz7q/0vSzJgTZFRmUSKNdKu6zWNr/AuPlc06Pya
         TADXJLoXyT+V0vCtPflXWT9WBl+pAbThonZAQRg0gMAt+PKYDU1+v8lZUy6X44QWMYPs
         TdIlqmiX6q3jpt7L0LjxaceE+yaPwJzomfd4YU22pqHsqHjrDwDcBbt9DvoCfKx6hOs3
         OOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0nh6s6iVQifHimFBlt9HsSWgh0AuZfoaMEvFjIFmTw=;
        b=kmLw1bKaObUE+SvZzVJolTu1s/EVyMXQYyVTm/2W0/SRQUf4ehb1hRe5plP+2i6LRv
         2hRfdCspqU5h9vFAVgzLRkVVDJkXCCMAUj1U6U6i4AOoeMFCLtsTd8dnPPkGVTKt68YP
         ZaeNWsPhsyHQgfpVKKMZDkvspAuSdZgPBXlMqEVARgrhirSOuF35/Cgha0ddRJlxPbJm
         UhOXnOS+N3pf3RJuL3S9lUktyUxJhM2Zp4DWcPgSklzXuQySVegsMFZxUd9/wwb3nTJA
         6LMvzJZ3vmtNCzdPHUH5ZRp/mygGpORk4aw8BNv7ES5SbMzTcQPKcSXmUt8QFwaDPJWq
         FsZQ==
X-Gm-Message-State: AOAM533pEFQv5xru72vkZIqe4PUL5B8kaCtCtSStlMBnlpUNoKr1dwpc
        6VuWO+TujL5Osirf5erW+jZ/mBi/2V3Y+G2G33g=
X-Google-Smtp-Source: ABdhPJwuh8pvYd3UmzNgZcDRU1W1DbwxMv0Vdth/wCvy0cjMA/poeLmKteZhRQv890ip+9TXKH+FH3gDJI/8VK32ieo=
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr10135604ilu.164.1612671507292;
 Sat, 06 Feb 2021 20:18:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <da4eaafa84f32375319014f6e9af5c104a6153fd.1608963095.git.syednwaris@gmail.com>
 <CAHp75VcSsfDKY3w4ufZktXzRB=GiObAV6voPfmeAHcbdwX0uqg@mail.gmail.com> <CACG_h5otB5hhAX0z9YzN8bT6Nz5WVRUQWbhENF+u8Z3WsCp_8A@mail.gmail.com>
In-Reply-To: <CACG_h5otB5hhAX0z9YzN8bT6Nz5WVRUQWbhENF+u8Z3WsCp_8A@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Feb 2021 09:48:17 +0530
Message-ID: <CACG_h5rLzpo-oz9uPe4d66-e088Y8YXiUhkLwEEf7MVyLDcJRg@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 2:25 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> On Sat, Dec 26, 2020 at 8:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> >
> >
> > On Saturday, December 26, 2020, Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >>
> >> The introduction of the generic for_each_set_clump macro need test
> >> cases to verify the implementation. This patch adds test cases for
> >> scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> >> The cases contain situations where clump is getting split at the word
> >> boundary and also when zeroes are present in the start and middle of
> >> bitmap.
> >
> >
> > You have to split it to a separate test under drivers/gpio, because now it has no sense to be like this.
>
> Hi Andy,
>
> How do I split it into separate test under drivers/gpio ? I have
> thought of making a test_clump_bits.c file in drivers/gpio.
> But how do I integrate this test file so that tests are executed at
> runtime? Similar to tests in lib/test_bitmap.c ?
>
> I believe I need to make changes in config files so that tests in
> test_clump_bits.c ( in drivers/gpio ) are executed at runtime. Could
> you please provide some steps on how to do that. Thank You !
>
> Regards
> Syed Nayyar Waris

Hi Andy, could you please help me on the above. Thanks !

Regards
Syed Nayyar Waris
