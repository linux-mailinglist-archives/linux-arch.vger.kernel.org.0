Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA063AC5E8
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jun 2021 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhFRIYw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Jun 2021 04:24:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhFRIYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jun 2021 04:24:51 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTRhS-1li1kb0phs-00TkYm; Fri, 18 Jun 2021 10:22:41 +0200
Received: by mail-wm1-f41.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so3204243wmb.3;
        Fri, 18 Jun 2021 01:22:41 -0700 (PDT)
X-Gm-Message-State: AOAM533OlQGJGOd1gHf795WjtZMzMS7s5Is/1V7hBTWJCb8Jd4A+BBmU
        Zxekifoj6AbBmg3MWbIKWc6AQoZzK0xfR+7cm8Q=
X-Google-Smtp-Source: ABdhPJyCYIA5PdjR0ZYkSlDLLBjzTsysoVFilE9x2qwa8vmry115BTltuw5O/XQ7iogwiw1Uc+1BontaW5W+TOnUWcw=
X-Received: by 2002:a1c:a5ce:: with SMTP id o197mr8010276wme.84.1624004560775;
 Fri, 18 Jun 2021 01:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210617214328.3501174-1-trix@redhat.com> <20210617214328.3501174-3-trix@redhat.com>
In-Reply-To: <20210617214328.3501174-3-trix@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jun 2021 10:20:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
Message-ID: <CAK8P3a14uKvDZ4OevR5z2+AJervkepDcPjGWwstTo5antbQyXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] bug: mark generic BUG() as unreachable
To:     Tom Rix <trix@redhat.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lEB2IP4WGjlHm8AGz9kMO3d8UjkUPAfT5kuX0Z6DTd6C3c+ye5j
 KPaGELt46DzVhKygOAUJ9yZ2PASNk9DMOeyDNmrQ0bip48eRGKROq2ZdHY/wFgnHyNvlDBH
 D5ehZIq17q4pjXNS3cXOmXAZNdQHaH59HtGJHGUxd/17xNY+QedMpUrJhJFQnNYX2vM2580
 lmbeG5xCDvJd5O5u1TL+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yX+ohiNj+Mc=:7mD9RGBPvUA4+OHxX2Aoe9
 Ux/e2+I5bCGcOrvaXOuzLOTV1YXOyAlf6gbOc33fKY7ZBW7NK+lNl1Kiz8AA3/yiHlP3c9kFo
 gcVQiYAE42FqIHBb/5XpLPXmgr7Ngt1zlPAjMPvGfRD5ynGm4rRyqKimTAsJcdltSF+gcZ4kj
 SvNVvJuEAkVzQQ664PJvtIgc9JlgLCe8EktPEkzzFRs8QNFw2saLHEdjtQgiQNIFo59fcEoDI
 CWXqslAT8u2Gyp8CwW2t24CCCQh2EnFKZ+FGqIocyacLKcoflA28ayiZb1FJGIguJNNVsrDGZ
 vu059F2kSvKxpzAlLNyZ3FFpIC0KJSI3hZQ3KmpwxUCWzeZT0hppKPpl4kpQb3RLiFLOrQ8NM
 VGr638glMfblnDa3F3UfnqkaexVGn57xgsSooQIIgq+3yuvHEBLoZmyt55YuwXyfxpS10kp0A
 nfRrAHsV/RG584Ps+30ahYSbD4GtQr6W+oQTj4Uo5WNg3E78QFVTIl8QPo1tXVQZWcXoP0Tq7
 2LxQ7iV6vzzx0ahQ+nnlv0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 17, 2021 at 11:44 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> This spurious error is reported for powerpc64, CONFIG_BUG=n
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index f152b9bb916fc..b250e06d7de26 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>
>  #else /* !CONFIG_BUG */
>  #ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while (1)
> +#define BUG() do {                                             \
> +               do {} while (1);                                \
> +               unreachable();                                  \
> +       } while (0)
>  #endif

Please let's not go back to this version, we had good reasons to use
the infinite loop,
mostly to avoid undefined behavior that would lead to the compiler producing
completely random output in code paths that lead to a BUG() statement. Those
do cause other kinds of warnings from objtool and from other compilers.

The obvious workaround here would be to add a return statement locally, but
it may also help to figure out what exactly triggers the warning, as I don't see
it in my randconfig builds and it may be that there is a bug elsewhere.

I've tried a simple reproducer on https://godbolt.org/z/341P949bG that did not
show this warning in any of the compilers I tried. Can you try to narrow down
the exact compiler versions and commmand line options that produce the
warning? https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/ has
most of the supported gcc versions in case you need those.

      Arnd
