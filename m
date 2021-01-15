Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716B2F896D
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jan 2021 00:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAOXf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 18:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbhAOXfZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 18:35:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598F7C061793
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 15:34:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x18so5496681pln.6
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M45X1uVUPkAgzVTV1F36XDTKyhVWjHkf+etFM5uHOJs=;
        b=aIx3Nub14MCK6Ayv85Qd7DS3NeDHqNI2lHEyU5eGrWUowDcvNuVy2/an4j5/+207q6
         EsHUAA/Et0cuJjYAOm8qIJY7n220NxZp0yp18RNKAXViuPN4lMtybmXLIJxmtwJqGDKR
         PNOvolEQRZKk/XmMe0BT9hmxXXfmzp0AbpVgJUja6M7QaSzKjKw0DFtTUBcAJ7s3FFA9
         zZ3oGphi2Rk3sLtncvFNTbA7+nH1X4HvgOc0d8r4kqIgnW3OwPdu2ik1PVVrCQy5sDEW
         y1NBbRTFTpCCrJGbxAltfxNi8HpVJpPJ1gloIBkn9Vt5DDmGg2lYfVpmu6VMWYEO2VKN
         2okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M45X1uVUPkAgzVTV1F36XDTKyhVWjHkf+etFM5uHOJs=;
        b=FumhAlA7cAJt+SceccnAq6puIjYyRy8sc8DOrN1zlpTGphRdYvK1O6R7HXI6P+Z7TU
         x+J5zjbUGyJPaWm/t9xghqT/iOaKemRVQcMU0tyM8+avwuou+EdeIAfHs9fJdYJ4cWjx
         CD4A89HBl99Ot5WWoHFC4NzEBNsSaUWNKi+Uny43VXl6diIVIf/O8UnjMpmep62ROKaF
         po505UDWYJX4nUxtMe6wnX0d81zhAXp+APO8TKL1Ulxlc0LR3QTykVc26EJO2jSZyd8I
         ZNepE1RyLyx+8j2XxIU2Hlr8PEf7dtoBuT50560fWGUxaB39Iz6Q5QLBIvBpA/KiGOPC
         4/8A==
X-Gm-Message-State: AOAM530JREuyl6EBtRtvk2JpUIP0YdrZaSGBv//dzpzN9y/0eCCBkwza
        tZiw0OzHasCqrbomV+ODf/7/5B1FgMim399F+Qc9hw==
X-Google-Smtp-Source: ABdhPJxkSxoT54fsPyvQtLqE50NgLGUdW+qfRdnn9mqxf/4hpJok+NnuJbRhl1zXuiY9UFXdTWTlniFEn3qoaGBjRss=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr15203377plc.10.1610753684580; Fri, 15
 Jan 2021 15:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com> <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
In-Reply-To: <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 15:34:33 -0800
Message-ID: <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > CONFIG_DEBUG_INFO_DWARF4.
> > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.

Can you privately send me your configs that repro? Maybe I can isolate
it to a set of configs?

>
> I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> It is not there before and adding this may suddenly break some users.
>
> If certain combination of gcc/llvm does not work for
> CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> should fix.

Is there a place I should report bugs?

>
> >
> > I had some other small nits commented in the single patches.
> >
> > As requested in your previous patch-series, feel free to add my:
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Yeah, I'll keep it if v6 is just commit message changes.

-- 
Thanks,
~Nick Desaulniers
