Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146D630E897
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 01:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBDAfi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 19:35:38 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23509 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhBDAfh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 19:35:37 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1140YYJq030064;
        Thu, 4 Feb 2021 09:34:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1140YYJq030064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612398875;
        bh=d0o4oX2TkUWeKmRsE9flKYZWBAGhmf97FwyHDWzgr/A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ShGXNxreLHQW5f1+twhsUG4wSBHBsa/ay1IzNed0iCRMnz7dA9cFTrFDH4GyrnLpv
         o2cP7haRc+ONN82gcuMreWFb1BJKMHA6TM3McDG84BwImnAD7p4Yq15cFdcmg95yBg
         oeXfLROr1ngDb6N26lYTbm8nE9NzjC4ys8Kn/Zc9XQ5E09iAE7tunl6v8muo1VrS10
         eNXq3xu1T/6pLHaLadl9wqHrThWmQSbRZh/KDYwxLBZy5azuikmnZD4TT6pgMq4bvq
         0cb73QI3RQTb4UXUR2eR25Gy/5gNcWBChoMH6KAWQdupdYCbk4nmFhaG9PGT7VQXsC
         uAIDcJmNbApMA==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id e9so811056plh.3;
        Wed, 03 Feb 2021 16:34:34 -0800 (PST)
X-Gm-Message-State: AOAM5314TvDG6rRnYiLhWKehrRtAPa+oPB+VH5XN+QBOkbHiVgIQJmrY
        Dd+pWvyji5x41Ri9pjoYXXR+4PnmhQbfu7SM4ro=
X-Google-Smtp-Source: ABdhPJywLXWIXwRxXn00ckjTNurhyTCKD83iX+A98c9Nnl0vw8rLbVicidnRxkOw8CKW1IXlEYC6riMa9VCf6TSxhh4=
X-Received: by 2002:a17:90a:184:: with SMTP id 4mr5642894pjc.87.1612398873991;
 Wed, 03 Feb 2021 16:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-3-ndesaulniers@google.com> <CAK7LNAQW3XtBGAg6u+86wGc0tizDyezZ_f61JjkT15QH5BtGjA@mail.gmail.com>
 <20210203233607.GI4020736@tucnak>
In-Reply-To: <20210203233607.GI4020736@tucnak>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Feb 2021 09:33:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQH==pU73=tF+wHNKPn4J1WvGoxo3trZ9pBU7d-qFK6Yw@mail.gmail.com>
Message-ID: <CAK7LNAQH==pU73=tF+wHNKPn4J1WvGoxo3trZ9pBU7d-qFK6Yw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Kbuild: implement support for DWARF v5
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 4, 2021 at 8:36 AM Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Thu, Feb 04, 2021 at 08:06:12AM +0900, Masahiro Yamada wrote:
> > GCC never outputs '.file 0', which is why
> > this test is only needed for Clang, correct?
>
> No, GCC outputs .file 0 if it during configure time detected assembler that
> supports it and doesn't have any of the known bugs related to it.
> But that means kernel doesn't need to care because GCC already took care of
> that.


OK, then I am fine with the current code.

Thanks for the clarification.







--
Best Regards
Masahiro Yamada
