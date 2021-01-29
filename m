Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC9308FC6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhA2WHC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhA2WHB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:07:01 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D16C06174A
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:06:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u67so7092813pfb.3
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbB83yQ/mNcv3yi7gTIvEjnZRAP51fOKghx1oZz8Us8=;
        b=lb4i2596PDrPRAeQdhV0FrDfmDCJ6RHfIjf6vJ4dYUVwihSdmGZ1EMdFDEDD6sOyHQ
         tgM9l9b0LJ392ggfalldUZrNZ/4aZZZBRgYtU5QuTwxMS9McVNwifc5ELo2rR65F6Owk
         1oqfBOzjazSQVKoNoNDtxVro1PgJ9v2SnOfkpYFKBqgYOG9lsnr7k8Vmj4LNLo+/r62D
         YHIntyqFdudv3wsHuHb2hYuC05F+OxGe1vqOntbgIgBeLhbnpblGGN+gyunDKgtDzC+W
         rWN8FqQhhojAxo8LKt+1HYsOXg8ql9EcBbpgDz3JK9c3u9WdMjKDIjui2K/GOGS/gpXG
         A95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbB83yQ/mNcv3yi7gTIvEjnZRAP51fOKghx1oZz8Us8=;
        b=Fx35Tm5iMEMk6subyHFF0zIHA8frYUUo3fgz5TQwrxMxciUA0esia9N/WXrupL+snR
         qGXs9drbhotfyO1/D/dYdbTwWPGMOEeinwAzkouXcQ+qmvElsM2j8CN+8XMDvJMjurEC
         vxg5HYiX8A44+XGZwZYs9Ox7E8ML/FTzhJX+LgyG0Zi/ORaZFsADXWhVTec/V/ohY+4l
         G0LbhDi7Q2aAfiuIfZ6jjWnq5YoyBmgi91NYRQdfn/bl09GydVoI5fpVjbNbmtmJs48j
         SWKp00MgE4qaeuVpKAUJkaozrNg6mYOxGarJJdM77FP/bUgb8j7VUU0QKEbez1bRDWEn
         24hw==
X-Gm-Message-State: AOAM530WBGG/x52HFzxdGUKPEQwU7hyl1G9rnG/Z/xt9/i3j/EkiC/qf
        xs7XNYr8bF9I0vOS7EDVHCyizFizK/+MBoAsDh7lqw==
X-Google-Smtp-Source: ABdhPJytq7XzFCmRnN8yphPqVvC/ApXOmEJsEeS5S3LKpeGohM6Xc5D0S8N0FTbhQeUPECvQOLLncHwS5YL0Gvqu1K8=
X-Received: by 2002:a65:4201:: with SMTP id c1mr6554563pgq.10.1611957969765;
 Fri, 29 Jan 2021 14:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak> <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
 <20210129211102.GT4020736@tucnak>
In-Reply-To: <20210129211102.GT4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:05:59 -0800
Message-ID: <CAKwvOdm-+xK=diSKKXXnS2m1+W6QZ70c7cRKTbtVF=dWi1_8_w@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 1:11 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Fri, Jan 29, 2021 at 01:05:56PM -0800, Nick Desaulniers wrote:
> > > Wasn't that fixed in GAS?
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=27195
> >
> > $ make LLVM=1 -j72 defconfig
> > $ ./scripts/config -e DEBUG_INFO -e DEBUG_INFO_DWARF5
> > $ make LLVM=1 -j72
> > ...
> > /tmp/init-d50d89.s: Assembler messages:
> > /tmp/init-d50d89.s:10: Error: file number less than one
> > /tmp/init-d50d89.s:11: Error: junk at end of line, first unrecognized
> > character is `m'
> >
> > which is https://sourceware.org/bugzilla/show_bug.cgi?id=25611.
> >
> > $ as --version | head -n1
> > GNU assembler (GNU Binutils for Debian) 2.35.1
> >
> > Maybe GAS should not need to be told -gdwarf-5 to parse these?  Then
> > we would not need to pass -Wa,-gdwarf-5 via clang with
> > -no-integrated-as.
>
> That is what sw#27195 is about, just try current binutils 2.35, 2.36 or
> trunk branches.

Ah, I see.  Then I should update the script I add
(scripts/test_dwarf5_support.sh) to feature detect that bug, since
it's the latest of the bunch.  Also, should update my comment to note
that this requires binutils greater than 2.35.1 (which is what I have,
which fails, since the backport landed in ... what?!)  How was this
backported to 2.35
(https://sourceware.org/bugzilla/show_bug.cgi?id=27195#c12, Jan 26
2021) when binutils-2_35_1 was tagged sept 19 2020?  Or will there be
a binutils 2.35.2 point release?
-- 
Thanks,
~Nick Desaulniers
