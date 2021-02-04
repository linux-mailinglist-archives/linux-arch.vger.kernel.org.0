Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3269730EEAE
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhBDInH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 03:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhBDInF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 03:43:05 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D45C061573;
        Thu,  4 Feb 2021 00:42:25 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z18so1836504ile.9;
        Thu, 04 Feb 2021 00:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oQO+dQVEX2nOVug2QIeMZE1dpbuWM/CVbjcmZ9bpCUE=;
        b=Z7Xo2oAA5nuPR5Cu+jm+MS1yDW+liykjtfrBoJkHljt4zOURA9hxqGB7s/5x+14a73
         I5xL09vs/4So6S3YzS4GPbBLYbtg+gpHiPTRz9HFfI9QkyEr6VayNEnIwQCsarRuIl9Y
         CeMlk8lY8vg/l88Dg/hGuh2DY/qY9IzQgDBODHRhqAsFpAvTqRKFDFPO2ksd/0hY41LX
         HBzgCYxxBuxs9lcBpV66kaufKBYNtLWGBls9ayUivCeGfZWsQeJKOXpXd1umrSvt2oFF
         LoxGX5OQpM2OJysfobtG+nm7qVLAwdY1NVplB5rwZ4ObOgIYvM5u27aQ0Fv1KkvWTLzN
         D+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oQO+dQVEX2nOVug2QIeMZE1dpbuWM/CVbjcmZ9bpCUE=;
        b=ImvTsKq35TLHJ8xzt29CDHhennv5DBQbOTgWPXMq14AhPJ1GDfQA2IIxHV9qKiKJil
         CgbuMd8aKecXnIH/M9ssQFMid1dElqunfpIZ5W2Mi2GZU3EUTUKrKvBimKohmZQI6njC
         lbX7GmC+br5CLDRzWw6520zWcaUfcMLZ1SH4rU0xVIjV1RZUTYsz/QzK80exfE/1+qCr
         zcyhVS9Bsx8yeSYquxec4jiDfzFKtJF6J+tk9w3GKD7qTeD3MCF4q3MFTXjFTPfx8l/d
         N9DkxGyOklRruanObHDOogp+IGVdt5xaLlJf4Gg65vnesx0LZ9vSq+RV9sjzeMJpBS4j
         xIpg==
X-Gm-Message-State: AOAM532MGE0v+MUS6jlQ+SuASduQ13GTI5ykFOWp151hQFwRFipuEJko
        SjmLosv6x3ALmVKY+pBuIm02/ZPdTSEkHChRTIM=
X-Google-Smtp-Source: ABdhPJwPjBdke0BPHIreGsISS0Ms+a10HPCcQOSFItEwDHcq+us+v49rU7LGR1/qqkmMz9riZmCipmR/HBsTC7PWCS8=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr6059065ilq.112.1612428144646;
 Thu, 04 Feb 2021 00:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com> <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 09:42:13 +0100
Message-ID: <CA+icZUW2omV581KN0Qv=nGsk=6a-GG2Cm2OYeRxETrZP_obwEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 3:58 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
...
>
> Is there another (easy) way to get your patch set without the b4 tool?
> Is your patch set present in some patchworks instance, so that I can
> download it in mbox format, for example?
>

Just to promote the b4 tool - we have some cool wiki in [1].

Personally, I got in touch with b4 when dealing with the
ClangBuiltLinux project.

Note: Sometimes it takes a bit for the patch(set) to be available from
the LORE link.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks#fetching-a-single-patch-or-series-from-lkml
