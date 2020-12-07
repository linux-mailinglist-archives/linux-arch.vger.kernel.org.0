Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744C82D1586
	for <lists+linux-arch@lfdr.de>; Mon,  7 Dec 2020 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLGQFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGQFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2020 11:05:03 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24BC061793;
        Mon,  7 Dec 2020 08:04:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 91so9338021wrj.7;
        Mon, 07 Dec 2020 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z92GK4OXVwUQT79aqDBhQQ9NCRqwmmAZyVeWIp75xvo=;
        b=S11lgTV+a/yAV00TyeS8xdTeEIQZ4c2K41YLqYAZ5i4fcH2+TmCVDraLhCurj2ktna
         sL/86ZzKVsA6XV3oidwtoZaRpVKrT7Y5gzed8ABaiH1zT5drEKWykdz7GacQCVeOn1nC
         1bdlfSOBf6qTimpeKb7xxxUaLfltgdcId5rAkPYVFPHjeXTJxXpn982VHjpLoJICjp1Z
         TmSkkHesaXDiA5RkgTl/G1ZI5+cC9Pmfk9JH22G1NfcPqpU6C02j3pxzAZf7jywt1JmK
         NLmyVcw9x/3Za3CSVO8XGYsc8yRXdjjgC0N2cNdtwWcmMasd8voLwlkVZ6/C6Y4gNaW7
         QpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z92GK4OXVwUQT79aqDBhQQ9NCRqwmmAZyVeWIp75xvo=;
        b=BsCPtJ5LKj4Acqa/xUv5Rnb31bJ6gsSEcHkrMBR3L9RbtpTJTQVaV6BEJctxN1thTj
         dcW8/Q6kZ9y81EaPhNrjNJHZEiSKIoLHetLu0K+kIjD2qsU9R4MSuZsTqdYKics8UyKI
         H9tiRZOCV+ywqRqzysu7SUvJhU5ZjzgjeQ83wQpLTl9JjA9GQ+BpK9wBqZt3zggV88r0
         nhRy0EKvpYG6BauIPdyzHxtbwBpO5ZfuiEqr6fJnRTtJCArFIrTg6YnN4eY3MBpFSiZK
         AwhYKJqy75Nk7zHLRZwKqP7Frq6RyoNhSMcsTi3b2rSETwvc5+RL7fDRDvzPNoL14tvk
         FSjQ==
X-Gm-Message-State: AOAM531XURm2TB0acIlpBE/b+PVtSmRshcQJVHWgce1Z9ZkHpL6uFJQX
        9wxQzXY8qmdnM4csTTR69dwZxgxRziiyyCtFjh0=
X-Google-Smtp-Source: ABdhPJz9o+JDfjHpZuXCYw1mCEThGEyiejzyd/9TE/vXzxb6ycsAu7N/7g+/pbtMnaXRgY4RtaxwHUGX2cTCkWlKZLU=
X-Received: by 2002:adf:90f1:: with SMTP id i104mr17108405wri.348.1607357062109;
 Mon, 07 Dec 2020 08:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <20201207153314.GB4077@smile.fi.intel.com>
In-Reply-To: <20201207153314.GB4077@smile.fi.intel.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Tue, 8 Dec 2020 01:04:10 +0900
Message-ID: <CAM7-yPR5mEY3SZGoxPKM9CZOhyDOAFRha4=GwoxkA4SGk+z6qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, rdunlap@infradead.org,
        masahiroy@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        peterz@infradead.org, peter.enderborg@sony.com, krzk@kernel.org,
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

> Use `git format-patch ...` tool. When create a series, be sure you run it:
> - with -v<n>, where <n> is a version number (makes sense from v2)
> - with --thread (it will be properly formed in a thread)
> - with --cover-letter (don't forget to file the patch 0/n message)

Thanks for your advice. Then Should I submit this patch again>

On Tue, Dec 8, 2020 at 12:32 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Dec 06, 2020 at 03:46:24PM +0900, Levi Yun wrote:
> > Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
> > And add le support about find_last_bit and find_last_zero_bit.
>
> Use `git format-patch ...` tool. When create a series, be sure you run it:
> - with -v<n>, where <n> is a version number (makes sense from v2)
> - with --thread (it will be properly formed in a thread)
> - with --cover-letter (don't forget to file the patch 0/n message)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
