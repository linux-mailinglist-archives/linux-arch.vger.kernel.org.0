Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170430900F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 23:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhA2W2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 17:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhA2W2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 17:28:01 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881AC061573
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:27:20 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v19so7585044pgj.12
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 14:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9U4McTABtuqtNOqLAuCMtCG5shXKI8/Zm0sjdl2VjY=;
        b=FUWhIb9FG/USCOO4QZJ5Qrq0vYZm/TwgDTrDBUSJdTUUik+KQRz+nMV923YVEU58O4
         OtA8qDFn6GnX+cW9FR3ZXKzz9ZmtTt9e8AqCN3awjtAaFsrIsfx83fwH5ezyf1tlCsdr
         KPza42VJCugXMvuFQvUcl253ilKa/HSE3nxybsZ9Pg7t0JtvR5QJEyHFN/QzBwvcUEeT
         fgJWMnXSUmhcFcyDEJEBrMyhzaOgjvzwmbPDLQciQlMgF+oFttvTsJHY0FpN9w2rK/+H
         p85caq1P+P0Q24BosdcrnVH2MHmjRis3RopRcfCVXOMGXl/vT4e19QeG2HChK+L1wszX
         aUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9U4McTABtuqtNOqLAuCMtCG5shXKI8/Zm0sjdl2VjY=;
        b=k4FQfWcQuxl3riEDJoGTYXF2iV/ZZe0XcY3mv7njZ0GpP6iAmDLf+WxNxV0lUWlv+m
         izM6oQAQUB7/bpg9jQz2Mfj2/k6PpQz6KmwTAa3fHeaumQ1mu6uMFTetV2WC9p3Id7Mb
         2p45P5Atf5jOZ2LZzHebWALrSjJSJEk/mCxG589tevs60O5whT14z23fFd8VGvI30b4o
         iFdDtZmG0hTNzuC6jIy8z6xxoUqK8sD37+1J/5/stpSe69azf95zCHJwSX+KgKmWfrqP
         SwoSzCKeR9JBjphQZedmL+huVEjZL2sW5/kIANoq0Qmiw2bbtcbXl581WCVacxLK41eH
         2z9A==
X-Gm-Message-State: AOAM530vqzdbHqHLVbFZ0KB9wvW/n7tAJwePnxfC7BV9hqgynQxK72+a
        y2OYPcHlxlcEWxHVWvtSmodt6hCwZA9ysMfKKtOBXQ==
X-Google-Smtp-Source: ABdhPJwTCR93qGzhgDT4bimMP33GFgwbaaPci0RZWnEL3JJU3pGZd0Xr5JUgbTXOlHA04z28ZlPzCBNydXSDof9nlGs=
X-Received: by 2002:a63:7e10:: with SMTP id z16mr6729496pgc.263.1611959240285;
 Fri, 29 Jan 2021 14:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
 <20210129194318.2125748-3-ndesaulniers@google.com> <CA+icZUX4q-JhCo+UZ9T3FhbC_gso-oaB0OR9KdH5iEpoGZyqVw@mail.gmail.com>
 <CAKwvOdnj1Np62+eOiTOCRXSW6GLSv4hmvtWaz=0aTZEEot_dhw@mail.gmail.com>
 <20210129205702.GS4020736@tucnak> <CAKwvOdmuSaf28dOdP8Yo6+RyiviMNKcq8JY=-qgbwjbPVwHmLw@mail.gmail.com>
 <20210129211102.GT4020736@tucnak>
In-Reply-To: <20210129211102.GT4020736@tucnak>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Jan 2021 14:27:09 -0800
Message-ID: <CAKwvOdmrSNNkfFc7U3h2qWnNc+okxeBravE4Huun_LOv75_Bvw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] Kbuild: implement support for DWARF v5
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Nick Clifton <nickc@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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

Ok, yep, I can confirm.  I just built ToT binutils and I no longer
need to specify -Wa,-gdwarf-5 when building with clang with
-no-integrated-as.

I will update scripts/test_dwarf5_support.sh to check for that and
update the comments/documentation/commit messages to say binutils
2.35.2+, link to https://sourceware.org/bugzilla/show_bug.cgi?id=27195
instead, then drop hunk that was passing -Wa,-gdwarf-5.
-- 
Thanks,
~Nick Desaulniers
