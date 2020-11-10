Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81FE2ACEA3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 05:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgKJEsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 23:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJEsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Nov 2020 23:48:14 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D7C0613CF
        for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2020 20:48:14 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id v9so150715uar.11
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2020 20:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LG6AI05ymINBvkr43QJrWhW6+Oh0OuOMO1LRwJumoQ=;
        b=efHLQUtVvktbFbKV0dRhcMiDZ6CiF/nI8yogKkQkXNzkMFEKE5odhT1f13Q4gPJXAu
         wN0hB9BkQq58Ja7rNMPt1NZVdynEexfdbYBnP6P1V9zpSI+DJlZlVHIYRtDLOuDybsKK
         SBxayzR/8WM3Q2prP7nQi2dCRyo/MR20sOg6N/LmD6SDjillgAvfoYjFLd2lgcKBMzWH
         STTrkAhehecfpfomXSDFfie9rZLcKj9V2nN+Xx5m1srFv2/b/ayMzlhJB+vG6YJrW6md
         +YUyQc+RbXeRLi4+1JZo48a5U5H0fYHqd3kOi7vj283pPMdGH774liDFv7DcOCzqsBmW
         a6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LG6AI05ymINBvkr43QJrWhW6+Oh0OuOMO1LRwJumoQ=;
        b=uPYzZLitV+bTMFseXw2quxQVTndBfJ1AmFVGmSvdGG6r6gG4lUPOfuM/OtT00EzM2e
         Nl6NDnthwtWAV9YQDexW46kW6EFQL6YhGLG3iKM576rdKQLbZZe0x7Qx9h5k0UHEa0Yg
         i0v4W6okStZn6WXlgN4AGHbV6WNWqh+US5tLCTM4t5+yanx9Tg1s6dTQDqz6qVaez+Dk
         vPt0IDJf4s8I0yxUYngSBZPkOF2dXSHIBIyT3OfA4reSTo26lRSakaFvSfCdI397GZ8e
         NGh+wUcgusYIIyaOkRMbE05dF4eSnaQ2O06IwAqYAtmGrZ9xmac/u4j3yDiYCSFrAvuv
         D4Lg==
X-Gm-Message-State: AOAM530mZu1gn/6mDBpbi0HcCO8E1xTiaN45fWOC0J5CIplD6THOBdBa
        7flkVlW1d6jIlm1lVSZDHTkpOSKrO8XExQB7QmfkEg==
X-Google-Smtp-Source: ABdhPJxkDi0IYzwTD9/NuW8drJgZEjV2OxRwIJgfYZxoJw/2It4YGoA7cCSoDZ10V3gQPihhY7p+XtZ3gEYyqR4paw4=
X-Received: by 2002:ab0:424:: with SMTP id 33mr8354135uav.33.1604983692991;
 Mon, 09 Nov 2020 20:48:12 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com> <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble>
In-Reply-To: <20201110022924.tekltjo25wtrao7z@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 9 Nov 2020 20:48:01 -0800
Message-ID: <CABCJKuc_-Sxj8HLajx4pKuBpU3AUdBtPv4uzQfMWqVHWwHS1iQ@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 9, 2020 at 6:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> How would I recreate all these warnings?

You can reproduce all of these using a normal gcc build without any of
the LTO patches by running objtool check -arfld vmlinux.o. However,
with gcc you'll see even more warnings due to duplicate symbol names,
as Peter pointed out elsewhere in the thread, so I looked at only the
warnings that objtool also prints with LTO.

Note that the LTO series contains a patch to split noinstr validation
from --vmlinux, as we need to run objtool here even if
CONFIG_VMLINUX_VALIDATION isn't selected, so I have not looked at the
noinstr warnings. The latest LTO tree is available here:

https://github.com/samitolvanen/linux/commits/clang-lto

> Here's the patch for hopefully making the warnings more helpful:

Thanks, I'll give it a try.

Sami
