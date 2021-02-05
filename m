Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF60310E8C
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhBEPkR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 10:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhBEPiN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 10:38:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D6C06174A
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 09:19:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so5497586qte.9
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JI+1S8T48pFcr35wnbPxCUfOS4yHFzqI/JgwK92UMUE=;
        b=Y1KlXeRl60DhAGK1OMQ2+nZVwB9IvEW7Z9d1AmkglS4SBaMjBmSAxjSgSFsRCAHgN0
         vJVkxMhWbw5c4oq50K5uIjpwx0/gCXQqsO6PwDU3jVbEph1g/igusmAleN4F9FKli+pI
         SdBttc3jID0SkLTqmOCF+SOHXFKNIBv9/oqEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JI+1S8T48pFcr35wnbPxCUfOS4yHFzqI/JgwK92UMUE=;
        b=p8ADJX5u59RtRW6N8B0zKmmqI4v7s0bFMUyAajpeYso6LUx5Ibj6vcBAnDvaSHH8tN
         en0htPjzhDauFhrI5+oSOQaIE+QEtQvBa6w8IBinqoEshRNNrjFDUKMlCtqTA0005FFj
         TmGwPwiQzREtwHNQAn1MHfZt0LjFZYGkgzsM98PC3Cj054FUHms7BN8wI3JbXfAeXoDN
         GcOoLIpCLmpvew4/Pdwgpx60PxUrfp0/7Aqn2C/3JDYp+dK3IJa7LQeLtwT90mcpsqV0
         sR9Ymd95PqZhzkm2WE+TrsMt2VL4Ed+SC1nKiDcjkUKDP6xtbvwQ7JotF407C5moD8Ui
         QrWA==
X-Gm-Message-State: AOAM530JbqNL8JFFMZuA87FeDukvGxs1te2BFq6rEolK9o2YvNZ8kpDg
        4gP7Hy4WzCLKDFnRR8Qy6w8kMInghKDjzQ==
X-Google-Smtp-Source: ABdhPJxzc6Cbp1+0ZyCyQHHHxFdpZEM90HJMz7tC0cW4LoNlcj1yjNOXBiAr0VAAk53TN2x8WZAIFw==
X-Received: by 2002:ac8:4e55:: with SMTP id e21mr5098089qtw.159.1612545586947;
        Fri, 05 Feb 2021 09:19:46 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id k12sm9587424qkj.72.2021.02.05.09.19.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 09:19:45 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id s61so7477026ybi.4
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 09:19:45 -0800 (PST)
X-Received: by 2002:a25:60d6:: with SMTP id u205mr7882421ybb.276.1612545585241;
 Fri, 05 Feb 2021 09:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
 <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
 <CAKwvOdkFpqEDvJ5b9wpwEhnOdh-YJ8GxCc33JcHXqNRDnO=RfQ@mail.gmail.com> <CAD=FV=XUuo3OaDVOnFiczUTeyKt1moX7nQ+XEX_HiDpv2f3k8A@mail.gmail.com>
In-Reply-To: <CAD=FV=XUuo3OaDVOnFiczUTeyKt1moX7nQ+XEX_HiDpv2f3k8A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Feb 2021 09:19:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UTQCdd9dDG8W8fZZZhSPY3cwWgZk-3VYXZdz6pRbp8Ow@mail.gmail.com>
Message-ID: <CAD=FV=UTQCdd9dDG8W8fZZZhSPY3cwWgZk-3VYXZdz6pRbp8Ow@mail.gmail.com>
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

On Fri, Jan 22, 2021 at 11:04 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jan 5, 2021 at 11:20 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Jan 5, 2021 at 9:45 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Dec 7, 2020 at 9:49 PM Fangrui Song <maskray@google.com> wrote:
> > > >
> > > > arm64 references the start address of .builtin_fw (__start_builtin_fw)
> > > > with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> > > > relocations. The compiler is allowed to emit the
> > > > R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> > > > include/linux/firmware.h is 8-byte aligned.
> > > >
> > > > The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> > > > multiple of 8, which may not be the case if .builtin_fw is empty.
> > > > Unconditionally align .builtin_fw to fix the linker error. 32-bit
> > > > architectures could use ALIGN(4) but that would add unnecessary
> > > > complexity, so just use ALIGN(8).
> > > >
> > > > Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > ---
> > > > Change in v2:
> > > > * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> > > > ---
> > > >  include/asm-generic/vmlinux.lds.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Tested-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > For whatever reason this is hitting developers on Chrome OS a whole
> > > lot suddenly.  Any chance it could be landed?  Which tree should it go
> > > through?
> >
> > Andrew,
> > Would you mind picking up this patch for us, please?
> > https://lore.kernel.org/lkml/20201208054646.2913063-1-maskray@google.com/
>
> I just synced today and I'm still hitting this error when building
> mainline.  Perhaps Andrew is busy and someone else can pick it up?
> It'd be nice to get this into v5.11

I hate to be a broken record, but I synced and built mainline today
(v5.11-rc6-139-gdd86e7fa07a3) and I'm still hitting this.  It feels
like we need an alternate way to get this landed...

-Doug
