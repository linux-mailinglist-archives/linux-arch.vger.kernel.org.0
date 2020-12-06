Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C872D0233
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 10:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLFJQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 04:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFJQ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 04:16:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E3C0613D0;
        Sun,  6 Dec 2020 01:15:47 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x6so5698121wro.11;
        Sun, 06 Dec 2020 01:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWk/ZRFS7dLbnP3Icptxi63b/iAaHBAe2xX/prVRC2A=;
        b=MxvysfcbhTOE4RIcvS3qS2OJk1Fgl/BhBQaxSm7UWjZz3ysBvXMOSAiV1fQKEaOVuL
         aDNAJxI9uHerhcvjWtdkd3bOyJztzaW11B4siaY5kYTzxmSTsq9ZCLIcmLfpIr5av2N5
         DmdbbFUu7FvYRj2sDIBnK4sEt+YQStNNdhASmHA+02dAk6dAVcTFtloScu+FwT2p3IIA
         EPh1XpBCRLlE0Mo8bzUIrJNwdvtqRMFiaFrurkZErtgbmRrapN4jn+BJ8p8+3dhqR86J
         1b6FFSPAVoULwr1vlWKIyxxo0KUXlSbcTkHLRQV894VdJ3LSnWTt6nEUBv9rrnJMIfZs
         5DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWk/ZRFS7dLbnP3Icptxi63b/iAaHBAe2xX/prVRC2A=;
        b=gTtydRUcXQwDHSSzdIc/wVynu5/UD+Jt6Tn7SYNQVeqQPLQohRwQ2h8ObIeMH8WMvM
         iRlYEjBRiDqoTEgjoo6xl6/ewDn4shJFjquBmFUolIjRc8ZeNiiV4aGP10lHq/9SRXr7
         X7CCkwtz0tCBLMFaNFrqZzrgl1cMy5+HsJ7nnZOPbV3jqnyoZALpMlnh7KMFBKkR4B/b
         TPdNe0wRSC7ODf3avHUVjnebCNg668AesnEVo+Ln0YcQ3nWLVXfGZQZQ0wBNZnIag/84
         YKAQCwVWm8jqQPVHN56I67DSJUovdcb2Nig305XsGDNySnCFu/Bfv2fOBy6eKdKQwRAD
         KeFg==
X-Gm-Message-State: AOAM531HQ7ORlszDu2/azzjwZPYnN9M9zjxQr6rSsLidMJWwclujHeIZ
        jNAkKuTDlkJP10CDG4e6rBv5hGEXLwFdsEkU2fU=
X-Google-Smtp-Source: ABdhPJwQbJzPlTDsXYiB3k6eKX0CYvEclRLMe3MKl91cGQ7RKUqHdp44t3pqwREgZhP2ot07uZLeoy7Z2QC50kT+/Vk=
X-Received: by 2002:adf:f602:: with SMTP id t2mr14246671wrp.40.1607246146193;
 Sun, 06 Dec 2020 01:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <X8yWxe/9gzosFOam@kroah.com>
 <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
 <CAM7-yPQgkh=JnW_mtX9fXRin87sHQjh+58aY3asgBvHK+g3V_A@mail.gmail.com> <4e339fb4-adae-4c28-a40b-986b5e73fd0d@suse.com>
In-Reply-To: <4e339fb4-adae-4c28-a40b-986b5e73fd0d@suse.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 6 Dec 2020 18:15:32 +0900
Message-ID: <CAM7-yPRirVPsFDa37HC8shSwXhk=Bmb490z8=Bs2g0w=A9BhCw@mail.gmail.com>
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
> premature.

Sorry, I don't know about this fact Thanks..

> Also do you have measurements showing it indeed improves
> performances?

I'm not test btrfs' free space cache directly, But I used find_bit_benchmar=
k.c.

here is the result of find_bit_benchmark.

              Start testing find_bit() with random-filled bitmap
[  +0.001874] find_next_bit:                      816326 ns, 163323 iterati=
ons
[  +0.000822] find_next_zero_bit:             808977 ns, 164357 iterations
[  +0.000571] find_last_bit:                       561444 ns, 163323 iterat=
ions
[  +0.000619] find_last_zero_bit:              609533 ns, 164357 iterations
[  +0.002043] find_first_bit:                       2011390 ns,  16204
iterations
[  +0.000003] find_next_and_bit:                  59 ns,      0 iterations
[  +0.000001]
              Start testing find_bit() with sparse bitmap
[  +0.000068] find_next_bit:                      34573 ns,    653 iteratio=
ns
[  +0.001691] find_next_zero_bit:            1663556 ns, 327027 iterations
[  +0.000010] find_last_bit:                       7864 ns,    653 iteratio=
ns
[  +0.001235] find_last_zero_bit:             1216449 ns, 327027 iterations
[  +0.000664] find_first_bit:                 653148 ns,    653 iterations
[  +0.000002] find_next_and_bit:                  44 ns,      0 iterations

as this result, the find_last_zero_bit is a little fast, and logically,
because find_each_clear_bit is iterate till the specified index (i) times,
But find_last_zero_bit in that case call one time
(find_each_clear_bit call i times but find_last_zero_bit call only one time=
)

So, i think it has a slight improvement.

Thanks.
Levi.

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
