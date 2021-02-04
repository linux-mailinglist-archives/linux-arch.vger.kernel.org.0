Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26A30EA8A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhBDC6s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 21:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBDC6r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 21:58:47 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C995C061786;
        Wed,  3 Feb 2021 18:58:07 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i6so1749718ybq.5;
        Wed, 03 Feb 2021 18:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pV/dX7XqYEFbj7sI73k5lNUEukYihH5qvKxzPGQn08=;
        b=D3geB/+oDH743TIGdN48GjNuZiLQ8ZIHK+HtXzlHaRcozTeBKjcx7u3xXWatX+1up3
         /CKHkuswBLvfhnruIpsAM1XUs/n5CWEswJAHWkEo+cotPR5+GH3mwlTJlt1FB4cmzFZ5
         8QbQ60wCES1V4WvT1L/fC05+Q/9bUVcSE8gJQYNpFfuHfTLdUcWutPd3AyWvk55/QxaP
         8wEq6/d67glSwLYaIGRHuIFx1aA7xN9Xy/bZvrxxeuxjvZoRlOxVwOnggk/ZezsBpKmo
         ulxoEHMdtDvCOVLWy+GrYHUPHRdDlg6qvcncQevNKZn8L8oirTLQJTjNGqQh7DFHqKGE
         s5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pV/dX7XqYEFbj7sI73k5lNUEukYihH5qvKxzPGQn08=;
        b=nqCOXKB/FwwZy0DxNAUZun6t7QbmELKX6PR0Jc0eY/q305kq3G0yPZLnHfNq3Ipku6
         iNasXKLS8oOjObbdb0Nnn52eESEWQzhJGUxZ4sduISvflYFPbjyfaF7ZjZ4kXxtSjH4V
         GbCSxFGSrPkj5b/bvB1mlIJ9/MUCBMNpuXoMS18iuLVqB9d3VvtSjWZL8VjwgubB2/D8
         iHiK7i+4ryrVhPlsZeoDlGhHVCyQJoln6+AMLWMAAznvDh5qq2w4cvzXNdf7DD3cE7qL
         bpR7unE7BsgIADXMJAKUamp2m0gM7jV+yeaylVas54fcQKbG3YqzJGuBZ1tB0RNcfgZN
         CWJA==
X-Gm-Message-State: AOAM5301fA022VmkiIB4gUpbCb68DUnvEHjNBpIa/yNZh+j5/76H+mUu
        8igH+1OzysgQPkmflyR8J+KEooNbjP+o6baoJdA=
X-Google-Smtp-Source: ABdhPJxBnkk7SGwQ5sOUAcW+5HbNtkAp9F4b7Fi4C0HlHGimNjkiFHJZDCPYZk4vUWks0ToQPMANu/IFPYZSU7csVY4=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr9051760ybd.230.1612407486747;
 Wed, 03 Feb 2021 18:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com> <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
 <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com> <20210117201500.GO457607@kernel.org>
 <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
In-Reply-To: <CAKwvOdmniAMZD0LiFdr5N8eOwHqNFED2Pd=pwOFF2Y8eSRXUHA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 18:57:55 -0800
Message-ID: <CAEf4Bzbn1app3LZ1oah5ARn81j5RMNxRRHPVAkeY3h_0q7+7fg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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

On Wed, Feb 3, 2021 at 5:31 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sun, Jan 17, 2021 at 12:14 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Jan 15, 2021 at 03:43:06PM -0800, Yonghong Song escreveu:
> > >
> > >
> > > On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> > > > On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > > > > > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > > > > > CONFIG_DEBUG_INFO_DWARF4.
> > > > > > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> > > >
> > > > Can you privately send me your configs that repro? Maybe I can isolate
> > > > it to a set of configs?
> > > >
> > > > >
> > > > > I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> > > > > It is not there before and adding this may suddenly break some users.
> > > > >
> > > > > If certain combination of gcc/llvm does not work for
> > > > > CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> > > > > should fix.
> > > >
> > > > Is there a place I should report bugs?
> > >
> > > You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>,
> > > dwarves@vger.kernel.org and bpf@vger.kernel.org.
> >
> > I'm coming back from vacation, will try to read the messages and see if
> > I can fix this.
>
> IDK about DWARF v4; that seems to work for me.  I was previously observing
> https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> with DWARF v5.  I just re-pulled the latest pahole, rebuilt, and no
> longer see that warning.
>
> I now observe a different set.  I plan on attending "BPF office hours
> tomorrow morning," but if anyone wants a sneak peak of the errors and
> how to reproduce:
> https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
>

Is there another (easy) way to get your patch set without the b4 tool?
Is your patch set present in some patchworks instance, so that I can
download it in mbox format, for example?

>
> (FWIW: some other folks are hitting issues now with kernel's lack of
> DWARF v5 support: https://bugzilla.redhat.com/show_bug.cgi?id=1922707)
> --
> Thanks,
> ~Nick Desaulniers
