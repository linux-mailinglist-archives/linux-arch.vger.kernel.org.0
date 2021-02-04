Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770830EF25
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhBDJAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhBDJAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 04:00:47 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3EC0613D6;
        Thu,  4 Feb 2021 01:00:07 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u8so2337588ior.13;
        Thu, 04 Feb 2021 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DKhv9NF2UmnAO56AelLaqcZWNnODX+nZTlqSUT21pa0=;
        b=E25oz5qwcF6KOmf3fgAISjxsTmW5LdAMjmOoD/PbFlXMcZpd496dtOrNrtbVjtIFiX
         YuvF2Y/AAXmmVLKl+TRI94MNxS6MqF7KC9nOAIJ4hL1e0Mkd3aRF0WcUSh6mFLtIzNyp
         mXynfFPVILFdpDNbTGlQDIAyJELfKGw/e2KHUOzMPEnrF/eAex5khxD/oSV5gLYYzbO0
         +B+ModsFT0L8CfiUW0+5H4vHH8PbN85Vj6Dk1f1oURWyPQOSBLm24i2omzh3ZvIK0G3h
         E2H+SIFilzzTklSlLySl/nKniKQoOO3AFfLNqC2/MA+QlI6ZNMIRszhygkRjvNCnMOk9
         71kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DKhv9NF2UmnAO56AelLaqcZWNnODX+nZTlqSUT21pa0=;
        b=AzslEqI4PSNnf9ywTqky9jNK3gymDravMJl3cS4dIl7JUJN6N3tM/i1QMeMFPeUEo+
         ab6Phfl1HDwB/0AjCJTnn9Gsggw6sMkbY+uwQdH/7Tsfz17FuE5AHOi9bap9mFVcmpIr
         qapqEqanRpeaJZGOWkB3p1neoTQk0CMNAEN+KzJXEHv/RPD5hdAmiY0RPAdfXbH/22JL
         JJErOJaHgioiXthGYam9uFZYP1lupkzSm5dl5R/94/UirNtV55KxEFO15SPOtVmfHDY2
         2ccRpiZAaAAD6GqXVJzMGKDBMDicYeoL88M+DU38/opyFSuNWQujlgcHNnx0Wcv1CET4
         3XNQ==
X-Gm-Message-State: AOAM5319TmKZKW4I0l39JKWtze6aDeA5+qKCFE3UYp6P6PS4pvaPhsp1
        2ytWQEPm+EAqzDF27US6ZNWZGg2XpHjj4IaCYNA=
X-Google-Smtp-Source: ABdhPJyX59d6m2BlHhqPgcB/inYd3R2sbvAArSwzrPdLzkZYgbF/hmpLKY4z6BeKxPSpcRFOcc8Mnyt6XOxtQZVGbzI=
X-Received: by 2002:a05:6602:1541:: with SMTP id h1mr5821865iow.171.1612429206784;
 Thu, 04 Feb 2021 01:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
 <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com> <CA+icZUW2omV581KN0Qv=nGsk=6a-GG2Cm2OYeRxETrZP_obwEQ@mail.gmail.com>
In-Reply-To: <CA+icZUW2omV581KN0Qv=nGsk=6a-GG2Cm2OYeRxETrZP_obwEQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 4 Feb 2021 09:59:55 +0100
Message-ID: <CA+icZUU=p9SP+xFh=RP3d39DTWG-6BsETOucJ7OMJtSbqOO-CA@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 9:42 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Feb 4, 2021 at 3:58 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> ...
> >
> > Is there another (easy) way to get your patch set without the b4 tool?
> > Is your patch set present in some patchworks instance, so that I can
> > download it in mbox format, for example?
> >
>
> Just to promote the b4 tool - we have some cool wiki in [1].
>
> Personally, I got in touch with b4 when dealing with the
> ClangBuiltLinux project.
>
> Note: Sometimes it takes a bit for the patch(set) to be available from
> the LORE link.
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks#fetching-a-single-patch-or-series-from-lkml

Honestly, when behind a proxy-server I did not find a trick to use b4
here (DNS resolution problems).
I tried with proxychains-ng - NOPE.

In the meantime I updated the CBL-wiki page and added v8 as an example :-).

- Sedat -
