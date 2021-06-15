Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6883A743C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 04:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFOCpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 22:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFOCpe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 22:45:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B08C061574;
        Mon, 14 Jun 2021 19:43:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so18366205ybe.2;
        Mon, 14 Jun 2021 19:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2z/FB/rbjsEGSE0I/ycIJryY05UbKzaovsaCJYEhAYk=;
        b=Sua5NxWx9NLlw/uglvDupK+TSkyTwadFlrZQ+x3SIb39Hvz120OaazzzCVuvxdjw/t
         JKF9rO/R4Qm5k/U9gBP+voLPLvHqGNv5LrDBA/0zOSP3Q5QmuksjkyF9ALJWHYelVvA7
         kGwR62diNY/EoCPAhvSkK60p9xnFm8FwYg6HfWZ75K+xzXaktYtg92oIER1ZSVt6ahGT
         jARBrVJb0WEaq8/1id1Gd5/p4uc6JWNcxmZBnO9RUSep8OusseUgFi2pksJ7kajcAWzk
         GNHLwzJp4WFS6izYlKl9JpnHaH6RgmYtRscuZTcK8liDnjfcysF9iW5Cm3+txcWOkC/L
         UCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2z/FB/rbjsEGSE0I/ycIJryY05UbKzaovsaCJYEhAYk=;
        b=rr/wTlg8LMZ32i9+les26RyuIfoWkDxJmZLZBDhPrBKcz62F0yfyrPXddtda54gnyD
         eDr7T9JLocvfg7IhQ2tZ1JFjRh5HvesO57U5jh1666NvoYqCRgaR3DBixiOPqd3CvHEv
         P+6qJZJy/L2M1cIEspqFhJZXX+OblTSSLvfrppeZkKKdSBO2PqMowCZPGyMHEEN+KHBC
         GCEFiMp7QuLCzWsBSNAV+cmOf6+R0rZrHrxbF5Uw7xcBJCtY6j29dDfTp0Ug4AAA8xTt
         Lppgv3AUsPzDbxHKu2+5dSzxM3nAwZBHXc6y6ikW6A5bYEeg/E8dndm2Zy49iK9d208u
         X48g==
X-Gm-Message-State: AOAM533F8x6JYMCp2CaEduyQjf+7SWqaXZx9b5U0oSYHwGRKfrrGcCft
        OAE52ecW5WN98Cr39SZoOIj7MRNlvl5sxFkLmbE=
X-Google-Smtp-Source: ABdhPJzeGuVkNdlonyK7Ip83AfkYuFQIGhXU4TjGQku/wU6+LaH/EGJEITgUSEDaUojptNwY4Xcfvk3Tx/0rAb1byEg=
X-Received: by 2002:a25:be09:: with SMTP id h9mr30040462ybk.239.1623725009832;
 Mon, 14 Jun 2021 19:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210615023812.50885-1-mcroce@linux.microsoft.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 15 Jun 2021 10:43:18 +0800
Message-ID: <CAEUhbmUjht1ss+Z0a-kWYdn_Lk6TCzQhvxcD1FgJb0svmvhg1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: optimized mem* functions
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matteo,

On Tue, Jun 15, 2021 at 10:39 AM Matteo Croce
<mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Replace the assembly mem{cpy,move,set} with C equivalent.
>
> Try to access RAM with the largest bit width possible, but without
> doing unaligned accesses.
>
> Tested on a BeagleV Starlight with a SiFive U74 core, where the
> improvement is noticeable.
>

There is already a patch on the ML for optimizing the assembly version.
https://patchwork.kernel.org/project/linux-riscv/patch/20210216225555.4976-1-gary@garyguo.net/

Would you please try that and compare the results?

Regards,
Bin
