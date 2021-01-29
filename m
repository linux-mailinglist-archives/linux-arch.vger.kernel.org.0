Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4220C309035
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhA2Wln (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2Wlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:41:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1611C061573
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:40:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g3so6146652plp.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UeqBHRfeHjW15Sm624b1sYTdp/IVH05rFvVMr6lwzw=;
        b=XDPPMVweGFsPiqUYCdU0BDmKm9HJrsAxkWJhV6oiNOLzQqE+AcjzCOXKmC2hHVUl0Q
         tuV4pXeSe9wN16C92uURLv3+qULeweJxkF5TXe0xc7ZSWYPjDRtwUOnXeqxk4xTDLnBV
         IaCA0IS1PA13d6TVp3OZP/+4iOA2qnLkR0HY1EkWdcoql+6O4+pJla8zCg3jAfyM4+b5
         17gDhXMiIi55wo/piDuJ+ZFUdw3vvbleGTe/kQDrCDg3hGMjFLNJcnPA8VONTwndKlMq
         rtNJgSfyKZy4YmKedLsOgNp0MeTPFfmSIO86uyC2B38XkBjvsYNAk4e703cBvNBk4htq
         mFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UeqBHRfeHjW15Sm624b1sYTdp/IVH05rFvVMr6lwzw=;
        b=t2in6yOEU5qNqhI5VP1gfm6SE4fdeQW8/U7yWk1arvj2coNkVPjO0iVu4g15PRLaNr
         dtf3MT2mtwqwvdDJbnn/NZSBBJ6OzSwuj7aGNHMEtNCrHPgS3+nXRXhBxnSJnCfLp+x9
         GXkvlQQVKA4Nhd4RO9FuLo80uPIwVIE6ajPUbgySMdPkD7xq714o5kso1aseeTfhBG8o
         0O8vlnasgDGymdRvag0WBrjD801GQBxWoMAPEyR1ZkTrdgoJNe0ErHz5ZOsJ76FRLpJ8
         AvR/eWQYDTb8uxUo3PEqGhphiTXhesyvYlnPcW4gfnx7glXn8RSGR/eCpy3y6JHealCd
         LdwQ==
X-Gm-Message-State: AOAM5327bhqUbxDwAtNIMqdY1mzL4699Qs8OMu87TC96dVyOIc6WSh2v
        Yc7oNaby+13ST1wovBE0jjF/pSP9X4f6uNBXdO6HhA==
X-Google-Smtp-Source: ABdhPJxxqSWmcS2u0GdRlUBZpwrKoGLxA4dwIVSLbDnrhVI7puVsnxjoZIe1FiW6E1ctsbz3NZwyDgh7L6bez8tFCrg=
X-Received: by 2002:a17:902:ed94:b029:de:8844:a650 with SMTP id
 e20-20020a170902ed94b02900de8844a650mr6426596plj.56.1611960055108; Fri, 29
 Jan 2021 14:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-2-ndesaulniers@google.com> <20210129201712.GQ4020736@tucnak>
 <CAKwvOdkqcWOn6G7U6v37kc6gxZ=xbiZ1JtCd4XyCggMe=0v8iQ@mail.gmail.com>
 <CAKwvOdk0zxewEOaFuqK0aSMz3vKNzDOgmez=-Dae4+bodsSg5w@mail.gmail.com>
 <YBR+8KLWnjnMfP6i@rani.riverdale.lan> <20210129214137.GW4020736@tucnak>
In-Reply-To: <20210129214137.GW4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:40:44 -0800
Message-ID: <CAKwvOdmqHs6xra3gD27XzbJ4DP2PiTipigmboV712bRqdVoo2g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Kbuild: make DWARF version a choice
To:     Jakub Jelinek <jakub@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 1:41 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 04:32:32PM -0500, Arvind Sankar wrote:
> > Given what Jakub is saying, i.e. it was previously impossible to get
> > dwarf2 with gcc, and you get dwarf4 whether or not DEBUG_INFO_DWARF4 was
>
> It isn't impossible to get it, -gdwarf-2 works, it is just not a very good
> choice (at least unless one knows some debug info consumer is not DWARF3 or
> later ready).
> Though, even gcc -gdwarf-2 will use many extensions from DWARF3 and later,
> as long as there is no way to describe stuff in DWARF2.  -gstrict-dwarf
> option requests that no DWARF extensions are used.

Playing with this in godbolt, it looks like the implicit default dwarf
version changed from 2 to 4 in somewhere between the GCC 4.7.4 and
4.8.1 release. The precise version, and whether it was strictly that
version or not doesn't matter much; the minimum supported version of
GCC for building the kernel currently being 4.9 means that without
specifying DEBUG_INFO_DWARF4, that all kernel developers regardless of
toolchain and supported toolchain version have been building as DWARF
v4 (implicitly, or explicitly). DWARF v2 is quite irrelevant then.

Ok, so I think Arvind's suggestion of "make DEBUG_INFO_DWARF4 a menu
option, just don't add a DEBUG_INFO_DWARF2" makes a lot of sense.
Will drop DEBUG_INFO_DWARF2 in v7.
-- 
Thanks,
~Nick Desaulniers
