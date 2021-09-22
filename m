Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8585413FB9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Sep 2021 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhIVCov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Sep 2021 22:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhIVCov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Sep 2021 22:44:51 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82EC061574;
        Tue, 21 Sep 2021 19:43:22 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id b67so532395vkb.13;
        Tue, 21 Sep 2021 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7XWCRLPjasbFUjEZ4/PesuafkvYctGigM6PR8jA8qw=;
        b=SIZByzy3HwkCFWjz3NnCVwALKWHqHfi1PqlMrTZ68Ui6xualqU982XbxRXxNuXntu7
         CEToB9R4phsCVvTljaZGidDGqsDauncHnF1dXcy2ZZiFMWpRNFBUIrOpyhblP3qfF2Zr
         1iiNn6bWCEXMgKNzrkr83D8A0oIZyiaMKS/+/E9GD9PFfbO0qXIiDw6HvqBqsYNVoR3t
         vqqJAZ7b5KerV90DEzd4bZiJL6cEORMZYEzeTrN0mEuk0gOZnLtk1UUeRhBwc8c5yCOt
         oUUSxLRyOdHbqPT55+kzMqgcejPpGXiYHGLMr7Z3/2afergR13IlqKerUzOpOFploYsw
         Lz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7XWCRLPjasbFUjEZ4/PesuafkvYctGigM6PR8jA8qw=;
        b=1Rcy/XjN4Q1//Bla752u5f5Z2t/znd2b2NLR6caSBSADHgWyLYwRCj856BY9uMBhMN
         VevaCrydS3RB6eTaP9W/oBB67PRdlsHgjnOCxoS4TDMBgKy4/Yk4q0rb+gFAxRvZ2MYB
         +pekUNkGeDXPpWKfBk3PID1gSNILvg/P+xEidX7MfNH1YhtiF1SyNeNNvV1aAXQzY9Yw
         HnuGYCRyHglYGO/ISjjYgz8c5o2O56QwP5A6yUw1fA29pmdzzNYpGAb/q3ArnohK33aw
         Bm1a1W3QtUewrQRzxG7D/hzCV1OyvSpaPu1xf+2ra2bWgvfbgdMvrKaT8pJmOY/IkCGZ
         /M8Q==
X-Gm-Message-State: AOAM532swPai85FkOQzasr6Bth5+dzgO6Ggkgofcp0bW2B7AqnQpvLhB
        hYn4ub0Sj8PgYLCO/t6MxodDd6TlIGciXltLffQ=
X-Google-Smtp-Source: ABdhPJycEuEnNxLN1CdvRqU7yLzngAuE06/owJhp1YjUIJp4yTSHs+a0gjkaVCBc9d7A/1OBAJtQEGM88S50GfDltKE=
X-Received: by 2002:a1f:1283:: with SMTP id 125mr21948982vks.2.1632278601271;
 Tue, 21 Sep 2021 19:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-15-chenhuacai@loongson.cn> <87tuii52o2.fsf@disp2133>
 <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com>
 <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
 <CAAhV-H7A=C3Tujt2YNv1np9pEP_Hxc-chGnOdmDCzx5tUt7F5g@mail.gmail.com> <a0fb870d-3b79-ca77-305f-6178974729e4@twiddle.net>
In-Reply-To: <a0fb870d-3b79-ca77-305f-6178974729e4@twiddle.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 22 Sep 2021 10:43:09 +0800
Message-ID: <CAAhV-H5h9zNCmsOumR=_Bryj3-Qarbq7FH=uYbT_3++-8pwfPw@mail.gmail.com>
Subject: Re: [PATCH V3 14/22] LoongArch: Add signal handling support
To:     Richard Henderson <rth@twiddle.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Richard,

On Tue, Sep 21, 2021 at 5:14 AM Richard Henderson <rth@twiddle.net> wrote:
>
> On 9/19/21 7:36 PM, Huacai Chen wrote:
> > Hi, Arnd,
> >
> > On Sun, Sep 19, 2021 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Sat, Sep 18, 2021 at 9:12 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> >>> On Sat, Sep 18, 2021 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>>> For example does LoongArch have a version without built in floating
> >>>> point support?
> >>>
> >>> Some of these structures seems need rethinking, But we really have
> >>> LoongArch-based MCUs now (no FP, no SMP, and even no MMU).
> >>
> >> NOMMU Linux is kind-of on the way out as interest is fading, so I hope you
> >> don't plan on supporting this in the future.
> >>
> >> Do you expect to see future products with MMU but no FP or no SMP?
> > OK, we will not care no-MMU hardware in Linux, but no-FP and no-SMP
> > hardware will be supported.
>
> Please consider requiring the FP registers to be present even on no-FP hardware.
>
> With this plus the FP data movement instructions (FMOV, MOVGR2FR, MOVFR2GR, FLD, FST), it
> is possible to implement soft-float without requiring a separate soft-float ABI.  This can
> vastly simplify compatibility and deployment.
OK, I'll send an updated version.

>
>
> r~
