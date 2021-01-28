Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653B330708A
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 09:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhA1ICk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 03:02:40 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45872 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhA1IAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2021 03:00:09 -0500
Received: by mail-ot1-f51.google.com with SMTP id n42so4358238ota.12;
        Wed, 27 Jan 2021 23:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFvlavdQj3vCTWkwoAVwJZYrgCNBuE8sgIQdKiGhY+w=;
        b=V569t6Aun8zU7H8/nsKR/dXIhorUn/YIB/XD30A81SMdT3I+cIolhedJOzH30a+EZy
         G+VVkNtLZwPZs/1LQUKvKnq6fJx+vc2x5mx18R2ASbBwBw1tx2ub/pMB5NNPFMjqjNX7
         XnWxqIIbgMR5VpTDPZC3ASjpIx5LzkD2GKOlgEh+NHUvQwPxLPtdA2yAUfxIyTSGDjMd
         KUKVD+ZtqouxMAj/yasQFRpBnPPG5F2iaxyq4qIBYni37s+nBggNf9Q5BUAC5KWcMbC6
         ICcQzFFwKzyj/1065FUmexZPcuW3nOSNG0hh5sODdCgxvAd0D2IDZta7Q7JCBp/iTEz+
         EckQ==
X-Gm-Message-State: AOAM531enlXV19QvsrjOBYL6D9eIkEkaBZIbgI5JI4QvMYdtU82ON2Ai
        i75IwbUgF52l8bcP2NOp7xaCePuDyS+6PT5fW5l+Y4LO
X-Google-Smtp-Source: ABdhPJznIX8Ez5rT0eH2kPu8lo8LgYhmVvO6LoHIL5yF3kdkazjNHo5u99kdHiTbtJ4IH8g890LINaHfxGpj5ywaFPQ=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr10464911otr.107.1611820723093;
 Wed, 27 Jan 2021 23:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org> <20210128005110.2613902-12-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-12-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jan 2021 08:58:32 +0100
Message-ID: <CAMuHMdWTK7Xa-6E2yLHxv8sGkD-VYgDF2SMRCj4_tDTVS2Uw1A@mail.gmail.com>
Subject: Re: [PATCH 11/27] m68k: add missing FORCE and fix 'targets' to make
 if_changed work
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 28, 2021 at 1:54 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> The rules in this Makefile cannot detect the command line change because
> the prerequisite 'FORCE' is missing.
>
> Adding 'FORCE' will result in the headers being rebuilt every time
> because the 'targets' addition is also wrong; the file paths in
> 'targets' must be relative to the current Makefile.
>
> Fix all of them so the if_changed rules work correctly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
