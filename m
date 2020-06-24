Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05261207DC5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbgFXU50 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbgFXU5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:57:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F58EC061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:57:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so1775658pfn.7
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UVd4Vpuu4Hnm6XlHGR5cRrZnqXWEFfAzghKkxqA5PE=;
        b=BPMaWjSiHqVF8vi4hiTlzAVhVpOBnqRB11zTq0lEeedJqVV+du+PNZ4KmaMlIsirPC
         R928oKYPPNEK406mCXXrFo5ILeh9cKok03PTJz6JfAnRQKQCv1Rh1SMBWeCtT9nOL0oJ
         lryLagao4wnwA1qFmJ4sPzSNGD7lPYGa8eVmfocCRrLBf+dhWLYjqG85ZdT9LeohIlOb
         2EmJnnhlOHrRKj1PGL5sVH9SaXtWzsmYftW61LHVwvnNA7wui7tFGXqcFXutnYBMCItr
         GdL2Vo1Q7hX8hrKDrgkMAaZk/eo83KbXysC70mpN3P9EzjPp00OuZYiGpwRBnkB00cCL
         l6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UVd4Vpuu4Hnm6XlHGR5cRrZnqXWEFfAzghKkxqA5PE=;
        b=ZY10HKLFR6rHpkSigAtxLFLZEyypeJP4GKzoIn+xWZamJ5T3L1mDQSlNxQEajmTQTb
         1vix5YgVkm5+ScR8Z8adh8+Zc2jEvxtOci/dwF/POpMa6f4gn/k0dRlQT8vVokHtb95W
         RUUFE6y67yF+OD442vfFo57W0ieq3yMHAW/iitDo5ndxipXOIysJaqfX8WVNfuumffXH
         0+JIo4gq+WQbc5wsYlZAdWzWV0B9wC3bGL8lrU1hsiEMcGQ+Zn+yHObYdBPkp8uraWmG
         uPlnr7ZJx2XItkTxw3O7fdkdjSQZx4d1HD8mtm7fTdppCzT4nzt0xIRLkOGfVo3UjREX
         FCaA==
X-Gm-Message-State: AOAM533T98h3i0U1RFK4Y2jhL6Prs66jN18jY/g49aKjzwbjiCFsU9By
        B0Y86xQlSCp4iyneCWEUwIe/oT2DVCoyEjdCtkZ3Bw==
X-Google-Smtp-Source: ABdhPJwqdv1zjA72U6Y+yinTpL4jIF0WvT5OjmcvgBRWy2HcW+N17omaHs7u2Al3ueQuo5czHPS48NLDnn5YbwyPtt8=
X-Received: by 2002:a63:a119:: with SMTP id b25mr22841048pgf.10.1593032243514;
 Wed, 24 Jun 2020 13:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-14-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-14-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 13:57:11 -0700
Message-ID: <CAKwvOd=XxsGowjitcqDrw6g-cxB=kqAsvRS+PyaMrYWnPgjqbg@mail.gmail.com>
Subject: Re: [PATCH 13/22] scripts/mod: disable LTO for empty.c
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
> files. As empty.o is used for probing target properties, disable LTO
> for it to produce an object file instead.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/mod/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index 296b6a3878b2..b6e3b40c6eeb 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  OBJECT_FILES_NON_STANDARD := y
> +CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
>
>  hostprogs      := modpost mk_elfconfig
>  always-y       := $(hostprogs) empty.o
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
