Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4A2D020F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 09:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLFI5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFI5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 03:57:25 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796BC0613D0;
        Sun,  6 Dec 2020 00:56:44 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so10815943wmb.2;
        Sun, 06 Dec 2020 00:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/p3AYF+CXwhw7AQUHpZf13qD/HqOAzGY2Ed7W/bdRM=;
        b=GqlRD3lQ/iDrLHrS36Cwy+ZVw0xNS1POBJcRAQ7AVkmUz+BmtXnRiJ0ZyEy7Snsuym
         Xwkdm1HvMum2dr0uXcbMS4zYMWfm7d/s9CPaC+sXDQW6//bNY/6ttl/hEFrQJUwguXK9
         s/OJV4okA7N4oew0FVvGGBz1hoRE6GgMnv3KM7OkiAVLy8DNoFu9ZPyDgNo6EmKNoZ6I
         maSdACer5z2BpwWIGnKaEA8AT7qY3+cGSHvpvYJte2MHusn0b6Gp3SvOahTXBpPYLoyg
         sO11l+vvAAt+qDVk37bJeWrgrCQuHV+ZToApb2ByWArtXOfTc4Zg/bcZG1ITjfFi7uBC
         1SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/p3AYF+CXwhw7AQUHpZf13qD/HqOAzGY2Ed7W/bdRM=;
        b=qsSvcwdpxsG5noZzWA7Xwt4QHvRTyx0c++KNuH+m9gYQaBipk+GzV3eMX9GhjUjtmo
         wWD3FGOjo6AwrH55/axMTbo2wh8JK6nJuMPdCEdRc3+AP33igoSdH2S+8S+PWYx+s8q6
         ZPa8uF4128/+yzGasdC/jclQJc/9VlpSg7Kbf0uQBAjDMtcewI3WfO06Vd9DNOmoSUZ7
         htXvauwplhCNrWVJTdKJ/fVsAdjVHgg7C2CgtYUV7wUKLfUh2fbRaKaTmtVFZSjBt+lr
         ghPa68tUuqIP/D9c6P9rEp10R0HYXOqPj8BVY3e0eUUuuwm5LynOnIZWoxREKbkpZWbH
         D1OA==
X-Gm-Message-State: AOAM533gkOvGWce5AaPUrlEe5/ytkKe4YUxMxtHgvzeR06EyfTEz8IO5
        EGfGqVW+kZXmnUqXHxBQv6NF8wMyLXj0GP+XwIc=
X-Google-Smtp-Source: ABdhPJwoEfXTWfSTLCjE7/KnmfaVOv7f6V/b9c28RRKbP3jppCmSNr384eJUbBBdET+1QJA+rIvvmbB2J/g32QIzG+4=
X-Received: by 2002:a1c:7dd8:: with SMTP id y207mr12943843wmc.181.1607245003243;
 Sun, 06 Dec 2020 00:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <X8yWxe/9gzosFOam@kroah.com> <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
In-Reply-To: <CAM7-yPSpqCUEJqJW+hzz9ccJbU5OnOZj1Vpyi8d5LG5=QbCTjA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 6 Dec 2020 17:56:30 +0900
Message-ID: <CAM7-yPQgkh=JnW_mtX9fXRin87sHQjh+58aY3asgBvHK+g3V_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> This, and the change above this, are not related to this patch so you
> might not want to include them.

> Also, why is this patch series even needed?  I don't see a justification
> for it anywhere, only "what" this patch is, not "why".

I think the find_last_zero_bit will help to improve in
7th patch's change and It can be used in the future.
But if my thinking is bad.. Please let me know..

Thanks.
Levi.
