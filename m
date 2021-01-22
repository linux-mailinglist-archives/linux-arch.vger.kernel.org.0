Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9002FFA49
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jan 2021 03:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAVCEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 21:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAVCEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 21:04:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AFC06174A
        for <linux-arch@vger.kernel.org>; Thu, 21 Jan 2021 18:04:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lw17so5708318pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Jan 2021 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ca93cJadUERqdaaRPfmfCnbqdAlVsxIg+FVYypBCZr8=;
        b=NMzz9+XyhRDY60HZWYX8GNcXkr5AVTkl/pu9k/K0M2IW1bS7/d+caNVlvYDpaRE5Xr
         qG47nKJDD0PMPWqoYxR5o4kt4tXjdgmr83T9ItF6Azfw0ykCjYLnL4/SablFKQ81b9wB
         Hv8zt5Ep26Ekz2rNLNK8CyuEbEgnS4recwkOkNsJdMTVPea2BG96Qsb/mMCcw1v08/dk
         P6AxPitvQ95Ht2K0CL6zS/+oX3BQUoEbNI/1m/NDhISzgv9Byco+z/U4bZx+oW7Vx3VC
         uRStHjBBxpS3uMOHT4V1ogvyGDayzUuI5cCjmvqCVKYMrDRHWCFJc5CFpyjSyApk6ZWV
         2Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca93cJadUERqdaaRPfmfCnbqdAlVsxIg+FVYypBCZr8=;
        b=fqG+KRJfWJIbsgziDfLfjzrjkjv0sQWxDRlwsC9M+r5SEyNEOrRCM2vaV4R155LLMr
         xJiDm/7Jr+uZnqplF+ZMB5bG0Gm0EuQX4HkuX/HUkFEyuFdjc8TiqHCnjY7yI/Irx0xM
         QIuQv93DqYrGJSq4Q+lsiZFHnyEwERUrRRI7O/H7YT4JoYIFJndKQy4Gloc8w3UqWu9r
         P1cWnlgqiNjELdwR/AED2ZqljgAgqLBnTgPVdD7NqSecw4QXH5v4hVhZaXiLGHDePrNY
         cYQuLGVYVZZdGDGlN+Tbpy/IDcoylocQ5/EC/W9jct0cS2gvfLDfr1DF2njjapCQ1QSx
         x/JA==
X-Gm-Message-State: AOAM532vXkXviZ4aEksSUTU8vKg8DAV3RPn8KmMcrgjvc4G55b73ckTY
        j29SgqUSyrySgqjlEbtUXxboyn37EWnCY/8BJ6piWFmLF/E=
X-Google-Smtp-Source: ABdhPJycp0vHcjRRAzZ6YVZuNW1dsYAqqfwOaIQhDawttR91hUzR+dWWH/9s4tBOBGtr1FdEBjNTvTV32ubp/VVOFc4=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr2127389plp.57.1611281044968; Thu, 21 Jan
 2021 18:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com> <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
In-Reply-To: <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 03:03:52 +0100
Message-ID: <CAAeHK+yPrzAp57qP9wT=3dWqA3O5efJa3BQeXDQg-jmYAm9UtA@mail.gmail.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 8:37 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, May 15, 2020 at 7:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > For performance analysis it may be desirable to disable MTE altogether
> > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > user.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >
> > Notes:
> >     New in v4.
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..7436e7462b85 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -373,6 +373,10 @@
> >         arcrimi=        [HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >                         Format: <io>,<irq>,<nodeID>
> >
> > +       arm64.mte_disable=
> > +                       [ARM64] Disable Linux support for the Memory
> > +                       Tagging Extension (both user and in-kernel).
> > +
> >         ataflop=        [HW,M68k]
> >
> >         atarimouse=     [HW,MOUSE] Atari Mouse
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index aaadc1cbc006..f7596830694f 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -126,12 +126,23 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
> >  static bool __system_matches_cap(unsigned int n);
> >
> >  #ifdef CONFIG_ARM64_MTE
> > +static bool mte_disable;
> > +
> > +static int __init arm64_mte_disable(char *buf)
> > +{
> > +       return strtobool(buf, &mte_disable);
> > +}
> > +early_param("arm64.mte_disable", arm64_mte_disable);
> > +
> >  s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
> >  {
> >         struct device_node *np;
> >         static bool memory_checked = false;
> >         static bool mte_capable = true;
> >
> > +       if (mte_disable)
> > +               return ID_AA64PFR1_MTE_NI;
> > +
> >         /* EL0-only MTE is not supported by Linux, don't expose it */
> >         if (val < ID_AA64PFR1_MTE)
> >                 return ID_AA64PFR1_MTE_NI;
>
> Hi Catalin,
>
> While this patch didn't land upstream, we need an MTE kill-switch for
> Android GKI. Is this patch OK to take as is? Is it still valid?

Looking at this more closely: looks like this code no longer exists.
What would be the approach to add this kind of switch now?

Thanks!
