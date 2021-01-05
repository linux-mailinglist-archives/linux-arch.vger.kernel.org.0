Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668702EB1AF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jan 2021 18:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbhAERpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jan 2021 12:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbhAERpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2021 12:45:43 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C02C061574
        for <linux-arch@vger.kernel.org>; Tue,  5 Jan 2021 09:45:02 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id j140so368974vsd.4
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2poEGmb5do8w/L6iPewO1Yp5f3/JnzeKXCH38sWzZXQ=;
        b=P43/otfzyF8OEXWYSnLBvAtrZ8jU3DHL6R45ivbEW8I5pdnDwPh8ALa5giu9uAZCK/
         ERGWMImbG89Mm1Wt1Lx6Z/5EjiCTz1zarkfuQ49MExOHD15U2cp/XDQpbED0Bspnh5ZB
         Uh+WDCyai/MDfxDcbNdgi8FxHwP9AtULTe8Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2poEGmb5do8w/L6iPewO1Yp5f3/JnzeKXCH38sWzZXQ=;
        b=Tjip7doL3JWi4XGTdn/OnV4hFjZ2xZqTiwEYgC1rYjQO5ppcQMpAsdUQE0hlBC/spY
         EK09052KfspnAz1817CrozRkKa8FHF03Zs+Fot7+xt3oc/fOzIZ6tJFzRAGwe2dzN3We
         da58wr1AOybTuKt4RWnLwTSBg8GdTdhJ5FZQ21GcKnx/XGxLb07ckX2FWKj/FRXgzR2U
         v9rRLSanTQLg1B43vjFNhl3inht3UJ40HS6GrPChTk2rJ1enBqAmhoyvD8UhyYVEZU4W
         WiwO4EeN6m3bDFHVwaJvoANEYawyHmwHzSooM2O+Im7yVLtgavrUzB0qH4XPURfgF0Qj
         YVGQ==
X-Gm-Message-State: AOAM530I/iuxcUvQQZePJPg1tFX9vRQwGuNMitQTEc5/E7UE8TZwFGEN
        sIPvGyy5s3uOt6MCiGUQQPWWG4FNe4cx7g==
X-Google-Smtp-Source: ABdhPJybRDFeREAC06lfQozPgBZIs1y+453ThD5/0hzcDWG7mhqUypbf+1ri8vA11RE24SuzALfbbQ==
X-Received: by 2002:a05:6102:3195:: with SMTP id c21mr383316vsh.19.1609868701188;
        Tue, 05 Jan 2021 09:45:01 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id g23sm48455uan.7.2021.01.05.09.44.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 09:45:00 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id u7so341012vsg.11
        for <linux-arch@vger.kernel.org>; Tue, 05 Jan 2021 09:44:59 -0800 (PST)
X-Received: by 2002:a05:6102:21c4:: with SMTP id r4mr461281vsg.37.1609868699223;
 Tue, 05 Jan 2021 09:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
In-Reply-To: <20201208054646.2913063-1-maskray@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Jan 2021 09:44:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
Message-ID: <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
To:     Fangrui Song <maskray@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Mon, Dec 7, 2020 at 9:49 PM Fangrui Song <maskray@google.com> wrote:
>
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
>
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error. 32-bit
> architectures could use ALIGN(4) but that would add unnecessary
> complexity, so just use ALIGN(8).
>
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> ---
> Change in v2:
> * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Douglas Anderson <dianders@chromium.org>

For whatever reason this is hitting developers on Chrome OS a whole
lot suddenly.  Any chance it could be landed?  Which tree should it go
through?

-Doug
