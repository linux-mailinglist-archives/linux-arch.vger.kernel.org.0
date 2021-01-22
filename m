Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92E1300A3F
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jan 2021 18:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbhAVRuW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jan 2021 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbhAVR3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jan 2021 12:29:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D1C061793
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 09:28:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u67so4231839pfb.3
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBLvAtiLnkJxVcSWz7GN207iPLSO/HZW/o+U4RMk0/Q=;
        b=AhQAUJf/Huc7Sx9+gasWnXOK6+fmxnX9ZZPnoNJr0P8zj1jjZ8j6NviU51a/jJDLI0
         YYAgX6p4vVFTKbEe7j1Cuy0hx8f3JOzBoIDcnpZQJo8RNRFiUqTNm+nFuGEegaWwxIIO
         927eWIiQGv8sVLtbI0b+ZIiAejeh0WmWsr/qAiV1R/25Oh4FO5iP/Y6t0tpVTeBuaqPI
         5ItVhmzTeOAAnOP2FZSF60y7ZsZ7MPzbH7FyQqzhQqKPVsdngyO67qrGDu2re1QZp5KQ
         w2JQoh/KwiEeZ1M681+56UgXGktKSIkLp2oYQcEKSzFgIdOoPxtKCmSZCnTI+MyCSd4n
         wgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBLvAtiLnkJxVcSWz7GN207iPLSO/HZW/o+U4RMk0/Q=;
        b=Lx0qcuR5R+ajTZtsCgw/9qpa7gdxDgcxpmAgfUbVxtAr0Bwuk2qQEEl8lsealKJkl7
         HTwQtTvXBQe5hgtHuAHKnnWLX2l3zRLXD320UaTZjpzt/lWQ7T7dOAP7VXawS70ekb1j
         I1dM5UTABumUxFpFD2NpdIJ2SBASIz6D7qS9w7KV+Ww7NB0PvAB2/0hyGv9anCqtxvFa
         9zqATZYUxun/+Va7XgbdIVD/b6dMmcS1pUuiLcbFqLS3WDDYw1lRRFLoRIEGdAAm3eJQ
         5Y7DedjPCKKylpp1xih3zH/rq1S+ZaUv8sPLCKViH86V47Ocm6MR9K+SXZ4ju2y8xtJW
         FdZA==
X-Gm-Message-State: AOAM533cnGmTchuNt1pJbTE13TK76IHPPjXzNKs95/6mZbJ8U1dOEhsv
        2miHOyISCpZwDUYe9ai4U9p7pbXCQaQJDM8sj8H9fg==
X-Google-Smtp-Source: ABdhPJwu3Q+PW1QbrMHrU/9LmbGy0PCk43sALtPXsfqy7+jivTLvg+MYDWCQHK9E0YmC/swAXF67stsqdj2Udk9aU+8=
X-Received: by 2002:a62:5c4:0:b029:1ba:9b0a:3166 with SMTP id
 187-20020a6205c40000b02901ba9b0a3166mr5766157pff.55.1611336509247; Fri, 22
 Jan 2021 09:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com> <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
 <20210122144141.GE8567@gaia>
In-Reply-To: <20210122144141.GE8567@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 22 Jan 2021 18:28:18 +0100
Message-ID: <CAAeHK+y0hsm_syQuyU8rv0=NxesoB41fsz+DLi4FjjBke0t-pw@mail.gmail.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable MTE support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 22, 2021 at 3:41 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> > While this patch didn't land upstream, we need an MTE kill-switch for
> > Android GKI. Is this patch OK to take as is? Is it still valid?
>
> As you noticed, this code no longer exists. The CPUID is checked early
> during boot in proc.S, before the MMU is enabled, as you need to set up
> the MAIR register.
>
> Now, what do you mean by kill switch? There are multiple levels at which
> one can disable MTE or some of its effects: memory type (MAIR) level,
> tag allocation (TCR_EL1.ATA), tag checking (SCTLR_EL1.TCF). Apart from
> the latter, all the other bits are cached in the TLB which make them
> more problematic to toggle at run-time.
>
> For the kernel, we can currently disable tag checking via the kasan
> command line options. For user-space, we don't have a kill switch
> specific to MTE, however one can disable the tagged addr ABI and
> presumably the C library will avoid generating tagged heap pointers.

Just FTR: As discussed off-the-list, there won't be any need for a
kill-switch for userspace MTE.

Thanks!
