Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B721C82A
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jul 2020 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGLI7b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jul 2020 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgGLI7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 04:59:30 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E66C061794;
        Sun, 12 Jul 2020 01:59:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v8so10415484iox.2;
        Sun, 12 Jul 2020 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+Dl8Q1XzZiYA4GO8ZZtoY/mYTNvNLG4yL/TSgXjOVXM=;
        b=et8c4srf7jKz/ghq6ldgJw1wpsajAh/iicKsgGLSk5HCxGZ5CQ86IFUST3G/dAZS9R
         BK+JEehQthnnir07FeiPcL/qpVUZ2NGCyUjND9byzvK8PnixOnaWkF96m/M5kUymOL2C
         LII6vqDG01OkywVTUDEiMrt1QcYjd+y6es/0VA01BLEP3VrfKh/wxRZhab4S/+5xDWOB
         xe88vsXrHJ2oYLtwubG993g1CAsa5aM8/V0M7++JN1XNtMqDZiEmh7FXGrho8fAIGKiT
         KJW0LpTSPQuedYjKrMO8KvYmRECOyDbXavBRUCJEaU4kO1PGAriZ+FRdd/Me8DIzlfab
         p9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+Dl8Q1XzZiYA4GO8ZZtoY/mYTNvNLG4yL/TSgXjOVXM=;
        b=CafyuPnaQWggO8PEixrRbkVAkgjZD8f+UkmoKcWcFsIIRaq3RLpP5cwWOhMKEYh4g8
         7WxtNI9ca8lHQjl1ja7ble2ASNCYrAXjbMY4EDJhmkYKvfYZ+opVMil8K3MAJ4AUxtp1
         ThSji8sFkAuCrCmuoI8SKYA/MUZ2lYLZJbG3fCmkC6CJnX22aAki8TujsHHuyKuqXE1c
         JGVxO18dDrfMHjtyX9YzEM/x6A0CS15REVPqzvxL5SpXT2NINXroaR5kuuPEZs3Ssa+8
         O7GUgeZZ30hY3jNuXo92vW3anwL6vy/EqoGatulaOuTz3X2ABz27nuyd2vdbcj1sbCZT
         HGQg==
X-Gm-Message-State: AOAM5327tf9z0the4zjHMjxdw8A4JgjbiCsSC1ieJkvlNQ9WMeswB739
        cjSsXZ8h9jX9FML4QC/xNOGhWU2wnuT4JxOdrLw=
X-Google-Smtp-Source: ABdhPJz6yajbht8v21aUb5AqbeseJZbW7WiEMt9+Xzj6unIHhgR9p8E/p5dg9MyRRh3U33wQNCR5IYqWyZHeGZXnsKY=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr6773338iow.163.1594544369052;
 Sun, 12 Jul 2020 01:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
In-Reply-To: <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 12 Jul 2020 10:59:17 +0200
Message-ID: <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 11, 2020 at 6:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Sami,
>
>
> Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
>
> [=E2=80=A6]
>
> Thank you very much for sending these changes.
>
> Do you have a branch, where your current work can be pulled from? Your
> branch on GitHub [1] seems 15 months old.
>

Agreed it's easier to git-pull.
I have seen [1] - not sure if this is the latest version.
Alternatively, you can check patchwork LKML by searching for $submitter.
( You can open patch 01/22 and download the whole patch-series by
following the link "series", see [3]. )

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.=
git/log/?h=3Dlto
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=3D&submitte=
r=3D19676
[3] https://lore.kernel.org/patchwork/series/450026/mbox/
