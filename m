Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16FC4200FD
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 11:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhJCJLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Oct 2021 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhJCJLi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2021 05:11:38 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78228C0613EC;
        Sun,  3 Oct 2021 02:09:51 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id h132so6331357vke.8;
        Sun, 03 Oct 2021 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1a09NfC0dZaTGSyNXP7YpV6IMJS3eCI+qR6k57xC1hY=;
        b=SPtlNUxzyCGS8ZIu8rhhw9KsG+/NDyKz6hE/b0ZbISCL/NG8edbZLMHXbthMc6mH/J
         Fae7MBoMrKPw1r+8snn9bUlXnDbUhbpaIsO9Zc+s8A6aUx5YiVRApST1BAulUyC94uZD
         1iIPCjIc2SqQv5itQh471wEJbOZPpr8gU8fG8YMvHiwESRf590ghIJuQiullZNj52R96
         qzLXHXNZuGKyTJ7pOSEMqGuQa1Kv7fVb6Z6x2v9ogDxs5Y5/DtAELzE25wiIN3IgoM/w
         jdEvG2+Bb2Djr3ftoQQo7kwjB9sks/8BffUrFjYfz6kp2l2xku3Ux3Yy+AOO/Q4iFCdX
         QvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1a09NfC0dZaTGSyNXP7YpV6IMJS3eCI+qR6k57xC1hY=;
        b=1RM9mKOb8Nh67X+yRg/mN8oqhr8Y2lm6Um8cOyz1h2n/CGTF3l3/jSEYG2ncS4syaJ
         OEUhXT0Mo9MFWKAVTA3MKkdEeZOflboFtDd18j34BS/gr+TYQODXQRvWFFq2bC/pdnXu
         EfdOtbKTfYPshlI99Zu+r8HaS0GyPjcXv42apqWPlqjmYC+WbB/oMrESlJlRJATdVDEb
         oKUf0xnjVfR6CUUzzprdrnsUnKTHVoPWaNwxdlgDDzW+xo1OvO1TiOyr9AJw/nOT5hkg
         b9nsTCNDySmqJ3MRP7AzZAySHH1a6Uwtw9WYph2MxecL+71rPMKrOp4DZ51wTl9pdonk
         wuHw==
X-Gm-Message-State: AOAM533Utabsn9a6sc4g4HyNf0GvmQ6yMoXVpl+AvJwupBSBkg8/46V5
        XZE0M7JYa1g/UYTM3gtpCS+0h8rjJ8ynO4FYYW0=
X-Google-Smtp-Source: ABdhPJwlJdZUSdB2pmCEUkoCQ/2cdUAgQYYcNSqu8vU5hzyv9CRIwGm023JUFg3iO2qnuy1ja3T1Ba1mP0SbAJwcOKA=
X-Received: by 2002:a1f:b2d6:: with SMTP id b205mr12461416vkf.11.1633252190627;
 Sun, 03 Oct 2021 02:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-15-chenhuacai@loongson.cn> <YVkVeREEIy23yVFX@zeniv-ca.linux.org.uk>
In-Reply-To: <YVkVeREEIy23yVFX@zeniv-ca.linux.org.uk>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 3 Oct 2021 17:09:38 +0800
Message-ID: <CAAhV-H5oex-q_Pq4ibhXzvoQTQORmi+O8waJQwEm6jyDJ=xF4A@mail.gmail.com>
Subject: Re: [PATCH V4 14/22] LoongArch: Add signal handling support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Al,

On Sun, Oct 3, 2021 at 10:36 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 27, 2021 at 02:42:51PM +0800, Huacai Chen wrote:
> > This patch adds signal handling support for LoongArch.
>
> No matter what you get in regs[4] after sys_rt_sigreturn(),
> you should *NOT* treat it as restartable.  IOW, you need to set
> regs[0] to 0 in there (or in restore_sigcontext()).  See e.g.
> 653d48b22166 for details of similar bug on arm.
Thanks, regs[0] should be cleared here.

Huacai
