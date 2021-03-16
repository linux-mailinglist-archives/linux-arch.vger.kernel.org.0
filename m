Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99D33DF7A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCPUr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCPUpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 16:45:01 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF69C061765
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id z65so18953024vsz.12
        for <linux-arch@vger.kernel.org>; Tue, 16 Mar 2021 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=e+TXEaCKvma4VGpnwpOaaFkLknHBGuDmEKybhDxTF83sGcUnhvMjnyd4FKoakznEV3
         L+49y3mjg3y9zPjYOau5jDdMUzS1QeQc8EZHIuCnYCEvlu/U3MIphrqZ/uP5UmkwxxeL
         +/myGc8pDphpzzZ7FTh/9hJKxPT9p26Ia2eDhTGk6iETFEiye/52lqU41RoUHrn74DWh
         Z9MX2qar1Tdy5UlVzs8F5VgOHw+sA5zNyUhbhgEJg7yulcKmANZ/MdTHXU3HQZNR3/3z
         jprq7sQ3GQvcxl+Y7QEUl59VHWT5WD2/UpeliEvsAr6IQyyxoheHA9cHYYw051xuDx5U
         BC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=KcR7ZU0p7sol6G2vmFi+26KNuPGk9L5PXj2r2iExGSiqu6j5d8J+vQcYN7toF7YKDD
         492UIe5g5/nBBsxgKTLRkhzBYH95mxF/lNcG+BeXJAw8KCKycXr8TSnvW2DsI6VCUSuI
         mrtNbpGzVxO/F6Pn+wrVE9QZ9ykLqEQWsoJrWeo/0zj7y9yWMWJJ5ThVP1YB91D88XFN
         qvvUVGH4qAZuA1LE56hReFCWrYQcsGpvaKbiz3XB/c2a2JYd46003WGTQBIJSzanABMT
         V4gWgTeEpNb2+McTKRyNGlic7tXgwpwLLzoTrNu0tRZ/rW+IjOLosPYjdC0wRA/ZUgMb
         FtAQ==
X-Gm-Message-State: AOAM533GxfMo6IYN7qmYBEwhAfnn82dqBfP2i0vc3INezzpIWJXNPw6q
        wQra8L7uEcJ3kVZZj1Z6ulmLrOdQRizrEAsOtVSq9Q==
X-Google-Smtp-Source: ABdhPJwQSd1vGWBZTCJlQRmCK62EXrLyrNMXIW37KTTCmpBtYEbzwPtXhGB1KcQUzWMwYntm7fopfaHU36IppUu0V+Q=
X-Received: by 2002:a67:db98:: with SMTP id f24mr1241866vsk.13.1615927484959;
 Tue, 16 Mar 2021 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com> <202103111851.69AA6E59@keescook>
In-Reply-To: <202103111851.69AA6E59@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:44:33 -0700
Message-ID: <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 6:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Random thought: the vDSO doesn't need special handling because it
> doesn't make any indirect calls, yes?

That might be true, but we also filter out CC_FLAGS_LTO for the vDSO,
which disables CFI as well.

Sami
