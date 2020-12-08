Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFA2D1F4F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 01:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgLHArr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 19:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgLHArr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2020 19:47:47 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D16C061749;
        Mon,  7 Dec 2020 16:47:03 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id c14so1308207qtn.0;
        Mon, 07 Dec 2020 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZHUufd0g6UdJFDVTYdblkgbgMRwbf0Y/fHI7mLRtWU=;
        b=l8tTsbTg21o1/hkJDil01QyPt1S+hNNQArxmXVMWZl+14KG3cwUPD9yhA9zz5er/OS
         WYmStLyhnHG81FxqOu7c5y430buEHIvhm1Kow/NQKRBzNLmEZELihteVRg5vdXuLfAHG
         rCoL22aDgnYFYdg61Z5cuWrNOH2SbjzbnuSM9xLI1c/BWw55NcLnaGoD4ziICgb+XXXK
         ZeF6QVt5WjFDXfuParnupBwgMVJIt4Nk49/ME1JGFmKbptXtgpSroyIdGE0tbGMqLfhi
         B0JM0p8wI/gGSE0p8C1IQpscG2TL91p7V58n7vS9habhu8GuNnQ8wlQktv+vR8fmUA6f
         4RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZHUufd0g6UdJFDVTYdblkgbgMRwbf0Y/fHI7mLRtWU=;
        b=SRGbrW0SIzqsr+RLBdHk1qe54LmJtlZUTuSdDq32ZhX/qSt382FeH7cHaDOVR2ULIO
         +9QC52fS5tcfJGXO5NuaRAssTgmN9qGBaL/F1fVw64O0FWphC68EkgkZ2yFW3wGnYyMh
         5k7o4p/3DTyZ9oOUbPrnr4iEjXbySPqI+v29gBCxAonPmfLKv5AoK/bA8qh8oprUZEBj
         3jhaYSjR6qdL8euMWpQwY47CDVOURDoOsyt6GcpBBJDIR61c5zMWQNVsTp1e2zG+tFLC
         RA+q7LewQCZuoOmb1oSgW4HC2NBUP7uev7QO0MNd85qT6c23uzAwUiZs0lDr9fS1SnwA
         x8Hw==
X-Gm-Message-State: AOAM532JHV4ENlJKXhyq/SwsONxn00CgplUokizYTLOmhWKGZ5fHQcAO
        L9/NG0yViZHvZ9yBSoq6LyM=
X-Google-Smtp-Source: ABdhPJxkqh2BZJT/hzS1hsNzGm89wAIBgMDItnp0jBYXVFcXuYuBQBr+FGcdnMvIwDpLuGTDZMUazw==
X-Received: by 2002:ac8:51d8:: with SMTP id d24mr14423965qtn.73.1607388422238;
        Mon, 07 Dec 2020 16:47:02 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id x28sm11544785qtv.8.2020.12.07.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:47:01 -0800 (PST)
Date:   Mon, 7 Dec 2020 17:46:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
Message-ID: <20201208004659.GA587492@ubuntu-m3-large-x86>
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck>
 <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck>
 <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
 <CABCJKufgkq+k0DeYaXrzjXniy=T_N4sN1bxoK9=cUxTZN5xSVQ@mail.gmail.com>
 <20201206065028.GA2819096@ubuntu-m3-large-x86>
 <CABCJKue9TJnhge6TVPj9vfZXPGD4RW2JYiN3kNwVKNovTCq8ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKue9TJnhge6TVPj9vfZXPGD4RW2JYiN3kNwVKNovTCq8ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 06, 2020 at 12:09:31PM -0800, Sami Tolvanen wrote:
> Sure, looks good to me. However, I think we should also test for
> LLVM=1 to avoid possible further issues with mismatched toolchains
> instead of only checking for llvm-nm and llvm-ar.

It might still be worth testing for $(AR) and $(NM) because in theory, a
user could say 'make AR=ar LLVM=1'. Highly unlikely I suppose but worth
considering.

Cheers,
Nathan
