Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0A35651B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 09:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhDGHTe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 03:19:34 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:42569 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhDGHTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 03:19:34 -0400
Received: by mail-vk1-f169.google.com with SMTP id f11so3734559vkl.9;
        Wed, 07 Apr 2021 00:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7Kx3btHgz7ta84S98Pg8BsIYMvQVkxtEX2Vc+I1KDE=;
        b=pdULniQvaHJLvms5DYJXVm6q6vM6ohAuPQE9POsNCYX1Jshj5bmvoP6Bl9Ec8yO/fE
         gtqE7ZM7ozHZ7+UsAJtSDSU1E1OHODCn68WSTXLxE/9PLH5Ebcd2ivB0LXtoGPz4YM2t
         nZJHYEcMXIJeZb9nyJ13xr4zxU7M4j1ZiRXhpaRbaF7WbAUZoErsbMBIAYtFGlHQwf26
         DJUV68pesg22h/CS5FKvA0sUEyRhOCjKhBS6NewHI8rFRi/y2L0Jkp+lnkOrFKIsFsUR
         GNS75v9z8V9Rqfn+v2k17x27xNVft20oQbfbUq3LtviR1Z79RCt6w1KSqmYSlYH1PadG
         xEHQ==
X-Gm-Message-State: AOAM53048WbSW++AeTTbqYtJar+DwMPqpK+VsVYD+PsHttvGb26zkuKP
        rXliF1WUcO5FR4mOeak2bZLgnILa8f3yZgUUGsFHt2QS
X-Google-Smtp-Source: ABdhPJwSQIt0vRe/XPXraai5HlJT7pCQD6XwKdxiqkw/AiDw3l8QCTjw4hMZ46DTMUjbS5Q4AAwq3/pfH95+VvfIl+g=
X-Received: by 2002:a1f:b689:: with SMTP id g131mr1055576vkf.6.1617779964647;
 Wed, 07 Apr 2021 00:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-13-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-13-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Apr 2021 09:19:13 +0200
Message-ID: <CAMuHMdUP38rfMSFB87MCfJ0J_2JteKfJGYsdTnkkOcHViQL_OA@mail.gmail.com>
Subject: Re: [PATCH 12/20] kbuild: m68k: use common install script
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg,

On Wed, Apr 7, 2021 at 7:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> The common scripts/install.sh script will now work for m68k, all that
> is needed is to add it to the list of arches that do not put the version
> number in the installed file name.
>
> With that we can remove the m68k-only version of the install script.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for your patch!

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I guess it would "work" with the version number, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
