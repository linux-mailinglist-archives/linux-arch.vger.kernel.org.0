Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA93309092
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhA2X1U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 18:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhA2X1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 18:27:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5B3C061573
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 15:25:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so7179895pfg.11
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r64ZJaXzvIoi2lpGzoKBDTSTrPRQlB1BeO/ysm0s6kE=;
        b=vOhHlwRjKdOTj2PO7TxKwDQ+XwczSwfpnigCokMHozWxhol4MQOzL1JOrYfjB9AzJp
         MZu06wr84Wapt22qXHd7HCvZZ2cECLbb384g31tnX2htb4aipNfvPwJ5t4XHon4g9XBH
         ye6xhB1UZnz8vWRhjYgL8NFJ2xQXQzHirUcd1O0sB0gWsAPMYNTlbuyW1xT95jg45oxX
         YT9SMiSeyFJU+Kpn/s023TZm8rZ7nkSNefyGt1SsVydChFM/qTIYBY/Xvdrhevei0Dvc
         GcS48STKzykzMoxPoqYgsDKE1NknpcEhA04oKS4fhR01govWegGw+mEnQOI6+E3sTKWR
         fTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r64ZJaXzvIoi2lpGzoKBDTSTrPRQlB1BeO/ysm0s6kE=;
        b=RtnAiLyGRwQxqSLGROBeQIkavCM6v7dc9KGkmOFv3vVcoW4CcT/pWl/w+70wj6i1Xo
         S/Le2rkjgwWjadgYSsrjcWQSz9QygrZDZhz30o7WUrifusUIrTUB+Ze0pacmAnSXPqLD
         Vmn+hqGuQrtB2CWkWkrEWcjbWu3/htLqt2X17YxT2wDpp6+aavLmfbEKVihvfxQEGbkD
         faSyqf+rfTDaPnSclti1Zc1V4tpHX/GVojGRvIoYAvlgZFTpDQadKMRF2ZQSvKXWEroy
         dt5cZBWkcyfcx6FsogBMBw8RPTB9nHjjmQlx+G/Ks73001cvLAYrzMyDGlPW63wuScR/
         KsDg==
X-Gm-Message-State: AOAM531UmuwaznWhnkqT4uYDXASpZHdYx1D8Yk2DhExzdO+saXn6lSJF
        zutPqkbPJMD7hX5d6eV7QGzrE+Tf9wJGJbzl3SDuhA==
X-Google-Smtp-Source: ABdhPJytmqDY53zCUYqnQMu5Pgh7FETeQtOxjlADZp9f0n1DVbZnkBf9ZSqL4opuVySaj+6wK/IJh5XbnYxN46wlJnE=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr6576892pfy.15.1611962757517; Fri, 29
 Jan 2021 15:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak> <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
 <20210129211102.GT4020736@tucnak> <CAKwvOdm-+xK=diSKKXXnS2m1+W6QZ70c7cRKTbtVF=dWi1_8_w@mail.gmail.com>
 <20210129220939.GY4020736@tucnak>
In-Reply-To: <20210129220939.GY4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 15:25:46 -0800
Message-ID: <CAKwvOdnte8Ck1ywodbY7ED7U046j06C+D-ZcW6kS-fqyaJbmCQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Jakub Jelinek <jakub@redhat.com>, Nick Clifton <nickc@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 2:10 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:05:59PM -0800, Nick Desaulniers wrote:
> > Ah, I see.  Then I should update the script I add
> > (scripts/test_dwarf5_support.sh) to feature detect that bug, since
> > it's the latest of the bunch.  Also, should update my comment to note
> > that this requires binutils greater than 2.35.1 (which is what I have,
> > which fails, since the backport landed in ... what?!)  How was this
> > backported to 2.35
> > (https://sourceware.org/bugzilla/show_bug.cgi?id=27195#c12, Jan 26
> > 2021) when binutils-2_35_1 was tagged sept 19 2020?  Or will there be
> > a binutils 2.35.2 point release?
>
> AFAIK yes, soon.

Err...perhaps https://sourceware.org/bugzilla/show_bug.cgi?id=27195
was about `.file 0`, but it looks like `.file 1 "filename" md5
0x7a0b65214090b6693bd1dc24dd248245` without -gdwarf-5. Specifically
the md5 ... .

So https://sourceware.org/bugzilla/show_bug.cgi?id=25611 needs a rework perhaps?
-- 
Thanks,
~Nick Desaulniers
