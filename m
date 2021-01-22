Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB2D300CA5
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jan 2021 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbhAVTTk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jan 2021 14:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbhAVTE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jan 2021 14:04:57 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A55C0613D6
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 11:04:17 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id g5so2158433uak.10
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 11:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFbt9Q9FleVVeCUdG8Si9d40jYAPeifwLGkQip6/tp8=;
        b=bwkqMmtPpa0+udzg9ETiNx73TRyndCyCrlakaQuOQthA2L6u5Glut8WN0ctvVCZioq
         TVN/8anvwUYb7z5zcqkACTfECL8PLOxixSmHvOdoNmLOsMQETDnhQVmXgRcPUJ/VS9Lj
         3wI8/WchMgWlIT0ZTvUgWaLO3iyoiSVdUeeYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFbt9Q9FleVVeCUdG8Si9d40jYAPeifwLGkQip6/tp8=;
        b=it7xRiPG1aN8MJ4tpCFGZGLWvSNKhB37g1uvaLSYKgPivxl0z3FvtSHCYHG/ujEHyl
         DyAB3g5PDzciFOaXsDvE3YpWEPNPC8oVH5eDxrlX4XzyURzf7qzXTAeiZJrLv86sCrvS
         xzT2iiZ6c4P62ORStNyKP1OcRP2rzri5YktuMAWUs1zm61TVCMZ1iShDPlDH5uWFr7zB
         FQmBbCYVbkfn2A+CeRhLgBixx0EsY+cCkdFAOGDdzyY/IKVQA+tYGKxT5Jy5tJnEtIbu
         aXTFX8aW7lLvWDIub9BnsRXn/tirU6hZNJV4A27vqPbUQnt/2NJty/IY0plmVcAYGj9a
         fU/w==
X-Gm-Message-State: AOAM532AfT5ENHytSeGIYdYQ7a5I0VcJePivwNc/Q3TUYwv0RuXZDldy
        wj/fuRUG2uS+FcwemFEKlbQZ4mvgS2xTrQ==
X-Google-Smtp-Source: ABdhPJwf1VVdznDcEtHKa+/cdBU4xCk/FzYw0lSRVEhp6EZJF4jNTG4OklxNP2gediav3nB6GWPq1g==
X-Received: by 2002:ab0:7848:: with SMTP id y8mr1791672uaq.143.1611342256267;
        Fri, 22 Jan 2021 11:04:16 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id v189sm1457334vkg.9.2021.01.22.11.04.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 11:04:15 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id n18so3569117vsa.12
        for <linux-arch@vger.kernel.org>; Fri, 22 Jan 2021 11:04:14 -0800 (PST)
X-Received: by 2002:a67:ed09:: with SMTP id l9mr237347vsp.4.1611342254067;
 Fri, 22 Jan 2021 11:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
 <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com> <CAKwvOdkFpqEDvJ5b9wpwEhnOdh-YJ8GxCc33JcHXqNRDnO=RfQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkFpqEDvJ5b9wpwEhnOdh-YJ8GxCc33JcHXqNRDnO=RfQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jan 2021 11:04:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XUuo3OaDVOnFiczUTeyKt1moX7nQ+XEX_HiDpv2f3k8A@mail.gmail.com>
Message-ID: <CAD=FV=XUuo3OaDVOnFiczUTeyKt1moX7nQ+XEX_HiDpv2f3k8A@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Jan 5, 2021 at 11:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 9:45 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Dec 7, 2020 at 9:49 PM Fangrui Song <maskray@google.com> wrote:
> > >
> > > arm64 references the start address of .builtin_fw (__start_builtin_fw)
> > > with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> > > relocations. The compiler is allowed to emit the
> > > R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> > > include/linux/firmware.h is 8-byte aligned.
> > >
> > > The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> > > multiple of 8, which may not be the case if .builtin_fw is empty.
> > > Unconditionally align .builtin_fw to fix the linker error. 32-bit
> > > architectures could use ALIGN(4) but that would add unnecessary
> > > complexity, so just use ALIGN(8).
> > >
> > > Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > ---
> > > Change in v2:
> > > * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> >
> > For whatever reason this is hitting developers on Chrome OS a whole
> > lot suddenly.  Any chance it could be landed?  Which tree should it go
> > through?
>
> Andrew,
> Would you mind picking up this patch for us, please?
> https://lore.kernel.org/lkml/20201208054646.2913063-1-maskray@google.com/

I just synced today and I'm still hitting this error when building
mainline.  Perhaps Andrew is busy and someone else can pick it up?
It'd be nice to get this into v5.11

-Doug
