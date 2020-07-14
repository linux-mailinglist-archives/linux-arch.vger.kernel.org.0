Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00C421ED1C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGNJoY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 05:44:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E32BC061755;
        Tue, 14 Jul 2020 02:44:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so13704797ilh.2;
        Tue, 14 Jul 2020 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Tgm0OYoDMREUwKgBzALPWRuGGwcOUHZ7yNd5VzH1jD8=;
        b=jM+qX4Ti315cOlTJ+VUcYkhq8TZ1sJD7ftmO0JD5IpsN8kCQahF698aWFTAOXFdT0Q
         HcDziCsqjsfy5XRD7ebTVvXA0N4xNmaGvq6fOOT6qMPZuI73C8jaNL3mnrBCo8bsbQN9
         HCbT6Xj3sLKNEa/9227nfI3t6zFXABnX5mVasdpVha9E7WNX6tAQZtRxmEi2BGCPKpNx
         oJegoUqWcsUe9furKYA2lgMTtioEX3+qFXCIAf+97ygpi9aM5MLPr/JnMwXeBTizXXtU
         waO68KXJ9Wgaxb4YyPuCWZUOe+nXpxyILWdmdz9StZGYXG14HxqClZ9yJXs6EAp9KNMK
         YRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Tgm0OYoDMREUwKgBzALPWRuGGwcOUHZ7yNd5VzH1jD8=;
        b=YzelWiUbzRv3bK4uEDSkP8Om1KGXG6c0cPzxRe62M9vE9S2cSdDN71KprFJtUadlNP
         msdlpNIHJ8nehFaLsCLMK2kzQvSkk3puKeafGIeKOlDSHHnNUsvvE4/ZYuoXFdOevbC2
         5Cfhwq4xW0SpzAfVb24QvQJVuvVHplQ/Gd3huSFZSOCnPR7MbO3xR7kXDQSoeaYl787r
         MbzlPT64c6BvVXcENq6wvllhebgOqvlDucy3AhBEgIknTWJ3Byh9ENDl7Wlxpjfl2Fka
         B27lioTqg7MuJXndAv7c7SFNHmdDsdeG3Evvj7jIWcldZSweIsg75t1Av9a9GelaPeNZ
         oDdA==
X-Gm-Message-State: AOAM530ZrGExbNgcQ8CmW9f2KTNVU0TYYoT00o09TPj+GbW5t7Xi8Vn/
        E4DcWPSek/Yj2zew1pmL5WQRsSsqUam/wO8Nm6ymd+A7snE=
X-Google-Smtp-Source: ABdhPJz+ivIV1Co3GNe6TDuCaK8ew/gDSSyhbGfaADNu+YjF9UfRP+y0tlFcRKz3l9JpO1zT8YmnCV67sZd69ABTNZc=
X-Received: by 2002:a92:290a:: with SMTP id l10mr4174366ilg.204.1594719861754;
 Tue, 14 Jul 2020 02:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de> <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
 <20200712184041.GA1838@Ryzen-9-3900X.localdomain>
In-Reply-To: <20200712184041.GA1838@Ryzen-9-3900X.localdomain>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 11:44:10 +0200
Message-ID: <CA+icZUWyqb8jdzTAophvBKuX3e2NvG7vQPnMW+SRW5v0PmU7TA@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Sami Tolvanen <samitolvanen@google.com>,
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

On Sun, Jul 12, 2020 at 8:40 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sun, Jul 12, 2020 at 10:59:17AM +0200, Sedat Dilek wrote:
> > On Sat, Jul 11, 2020 at 6:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wro=
te:
> > >
> > > Dear Sami,
> > >
> > >
> > > Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> > > > This patch series adds support for building x86_64 and arm64 kernel=
s
> > > > with Clang's Link Time Optimization (LTO).
> > > >
> > > > In addition to performance, the primary motivation for LTO is to al=
low
> > > > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Goog=
le's
> > > > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM bitc=
ode,
> > > > which Clang produces with LTO instead of ELF object files, postponi=
ng
> > > > ELF processing until a later stage, and ensuring initcall ordering.
> > > >
> > > > Note that first objtool patch in the series is already in linux-nex=
t,
> > > > but as it's needed with LTO, I'm including it also here to make tes=
ting
> > > > easier.
> > >
> > > [=E2=80=A6]
> > >
> > > Thank you very much for sending these changes.
> > >
> > > Do you have a branch, where your current work can be pulled from? You=
r
> > > branch on GitHub [1] seems 15 months old.
> > >
> >
> > Agreed it's easier to git-pull.
> > I have seen [1] - not sure if this is the latest version.
> > Alternatively, you can check patchwork LKML by searching for $submitter=
.
> > ( You can open patch 01/22 and download the whole patch-series by
> > following the link "series", see [3]. )
> >
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbu=
ild.git/log/?h=3Dlto
> > [2] https://lore.kernel.org/patchwork/project/lkml/list/?series=3D&subm=
itter=3D19676
> > [3] https://lore.kernel.org/patchwork/series/450026/mbox/
> >
>
> Sami tagged this series on his GitHub:
>
> https://github.com/samitolvanen/linux/releases/tag/lto-v1
>
> git pull https://github.com/samitolvanen/linux lto-v1
>
> Otherwise, he is updating the clang-cfi branch that includes both the
> LTO and CFI patchsets. You can pull that and just turn on
> CONFIG_LTO_CLANG.
>
> Lastly, for the future, I would recommend grabbing b4 to easily apply
> patches (specifically full series) from lore.kernel.org.
>
> https://git.kernel.org/pub/scm/utils/b4/b4.git/
> https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst
>
> You could grab this series and apply it easily by either downloading the
> mbox file and following the instructions it gives for applying the mbox
> file:
>
> $ b4 am 20200624203200.78870-1-samitolvanen@google.com
>
> or I prefer piping so that I don't have to clean up later:
>
> $ b4 am -o - 20200624203200.78870-1-samitolvanen@google.com | git am
>

It is always a pleasure to read your replies and enrich my know-how
beyond Linux-kernel hacking :-).

Thanks for the tip with "b4" tool.
Might add this to our ClangBuiltLinux wiki "Command line tips and tricks"?

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tri=
cks
