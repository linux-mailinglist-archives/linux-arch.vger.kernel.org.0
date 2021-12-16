Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869A6477ACC
	for <lists+linux-arch@lfdr.de>; Thu, 16 Dec 2021 18:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhLPRnD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Dec 2021 12:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhLPRnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Dec 2021 12:43:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B56C061574
        for <linux-arch@vger.kernel.org>; Thu, 16 Dec 2021 09:43:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so88860825eda.12
        for <linux-arch@vger.kernel.org>; Thu, 16 Dec 2021 09:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms/wuM8WAzRPY4WykXwi0/YehvvfoHEwDko5JETWgyY=;
        b=Yt6iQrPRR02VnMfhyQFLe4lPoyYi1LLJZh1EAgoFFL5odLJNrpYEgdV1gCmEQ/8Ebm
         vqyvFiXql5+DLQ9/AE42zzsnV8GD+7jyfxwfcG0fq/qlAeVI5VhSB0SiPNjhiYS6tgxi
         kvXLQUaOrvL+UE8xSz2YpOdT/AUCe9TuJhNKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms/wuM8WAzRPY4WykXwi0/YehvvfoHEwDko5JETWgyY=;
        b=H45wiKQlIRA2zbhtKTUiLYd5v8y3mODPPzb+VpZGc7wFCiHA/Xx2PMVsD6Ymc1IeFq
         oKXMmwChnHAwKCTp+ruSsaVvREXoP8jOATx0Bo7iLzntzCtfhtPmzBW4IY7+wZozpKPF
         hk8Xg/EBIcwp9Myrxku8AHpuOzEgQPcewFaYu1Jcrd8V1iarZDqbpC8zm5iQG0B+gwRW
         NoBoZkbXGkRG466w/MP7s9xvI1JkEnutKNNHJKNUqbLhaqchAk5h3JT0V7p5YwdeSeaX
         nCWlMlB2w7kLIfJ76Rq76ysnFmj0IKXbkhyvr0xgCNZL7dWPL5/GjTcDw+wNJP2JhWCK
         N+Mw==
X-Gm-Message-State: AOAM531MHW/Q6TPiY0f8B3PvF3r1NRsLc+3FXNoFPC5gL5cJASN6Q5ST
        mnHk24ukOeWWAmL1ShK44lb2kaOou4mutc99Ecw=
X-Google-Smtp-Source: ABdhPJwgX6N6OioES522vakD8oLE2wd++DlXFTzaIzRW82fencIVKdXWowMKHVOJQb0UxvegYhfk+w==
X-Received: by 2002:a50:e0c4:: with SMTP id j4mr22219051edl.239.1639676579834;
        Thu, 16 Dec 2021 09:42:59 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id sh30sm2057930ejc.117.2021.12.16.09.42.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 09:42:59 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id v11so45529358wrw.10
        for <linux-arch@vger.kernel.org>; Thu, 16 Dec 2021 09:42:57 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr9660488wra.281.1639676577218;
 Thu, 16 Dec 2021 09:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
In-Reply-To: <CAMj1kXG0CNomZ0aXxh_4094fT+g4bVWFCkrd7QwgTQgiqoxMWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 09:42:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKkdYLY0bv+nXrcJz3NH9mAqPAafX7PpW5EwVtxsEu7Q@mail.gmail.com>
Message-ID: <CAHk-=wiKkdYLY0bv+nXrcJz3NH9mAqPAafX7PpW5EwVtxsEu7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jens Axboe <axboe@kernel.dk>,
        John Johansen <john.johansen@canonical.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        openrisc@lists.librecores.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>, linux-ntfs-dev@lists.sourceforge.net,
        linux-block <linux-block@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 16, 2021 at 9:29 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is used in many places to
> conditionally emit code that violates C alignment rules. E.g., there
> is this example in Documentation/core-api/unaligned-memory-access.rst:
>
> bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
> {
> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>   u32 fold = ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
>              ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));
>   return fold == 0;
> #else

It probably works fine in practice - the one case we had was really
pretty special, and about the vectorizer doing odd things.

But I think we should strive to convert these to use
"get_unaligned()", since code generation is fine. It still often makes
sense to have that test for the config variable, simply because the
approach might be different if we know unaligned accesses are slow.

So I'll happily take patches that do obvious conversions to
get_unaligned() where they make sense, but I don't think we should
consider this some huge hard requirement.

                 Linus
