Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537F410E5E
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 04:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhITCiZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 22:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhITCiZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 22:38:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55166C061574;
        Sun, 19 Sep 2021 19:36:59 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id u8so15156889vsp.1;
        Sun, 19 Sep 2021 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KW0eAJoHEHsfgRpsIaeEBIptj7sPIMm58XFi25mu5Ww=;
        b=NImqRjRNDePB0tFmRl7BwxTTNnsE5u7K0cfoAMu1FrPmn/G/eb8aOA5z+twRIfC5fH
         3lZRWzf3zHTbP7AU5kZrQpGx3gy7bGCYHx513Y+qu3iUlG51WPb0iYiUMkodwwh7HcC1
         nCyDHq8GfPhL8aQqHZMD8lesYK3ZJvOd24wpwLvqTI3ZXtoOluZb3Y9AHMJCCaQlwlRO
         Bcrqn+Q/WhuCqBcvX0GJPITrR2xDFJmiGt7ILxafLH7yfImANuTmJAgIw8lNElijSJR/
         dLmF28F/YX7+Tc19Vrq5al/3ZxewL8F9TiMrZwAMsWqKhZ9vSyo5RE2GrCXcF3OCg0Zc
         6dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KW0eAJoHEHsfgRpsIaeEBIptj7sPIMm58XFi25mu5Ww=;
        b=kn+UDBEsWM3CVVx12L4+AFNvOqpZkvS7ULMSItrXNzruHSaEa6BSQ3FMuScGufMgG8
         yCK2cJ8i5KDbIpQh/530GDoot/8LCCQQ7f0gyFpkpg3mqO/Dif9YsqqTl9Bf+tqe6b+Q
         uF7gQsJ1EpKFFt2fqClgkM8YYhkI/vnx37YsKfkf7ITdu4bY/1y0GOFakA6bwpMT2SNB
         Yf3A1EI9Sef6AKc6bMijOO9zRzxxse06CucVUYzJHbsRTFxxXPd6q0Wp9oTad+DzvoOu
         O+CXWM3gKlRWX42VFJgypE4sJ5qGeVsd8kdcU6RSlgA5ALkIsGCHatEcwhG6dSspBCrU
         7ZEQ==
X-Gm-Message-State: AOAM532DljgGYyT0xiqrf+QSCA8yYnQowhGrzNZcdNYtm9g/EAXBAJCK
        0FzlbE++uxI4TuiZrHa+XCcFmyGB88MX6Cp+38eH0MnI
X-Google-Smtp-Source: ABdhPJwi/ObtWsm3iFluXwDHMGTKcvOZILhFCp0kPgBogbTHcslWK0e4+F/IjPuwahZtF3vW3XV7G1d/Pa7fHmfb2FM=
X-Received: by 2002:a67:441:: with SMTP id 62mr14681934vse.54.1632105418321;
 Sun, 19 Sep 2021 19:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-15-chenhuacai@loongson.cn> <87tuii52o2.fsf@disp2133>
 <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com> <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
In-Reply-To: <CAK8P3a0xghZKNBWbZ-qUWQVKyus4xqJMhSV_baQO7zKDoTtGQg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 20 Sep 2021 10:36:46 +0800
Message-ID: <CAAhV-H7A=C3Tujt2YNv1np9pEP_Hxc-chGnOdmDCzx5tUt7F5g@mail.gmail.com>
Subject: Re: [PATCH V3 14/22] LoongArch: Add signal handling support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

Hi, Arnd,

On Sun, Sep 19, 2021 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Sep 18, 2021 at 9:12 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Sat, Sep 18, 2021 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > For example does LoongArch have a version without built in floating
> > > point support?
> >
> > Some of these structures seems need rethinking, But we really have
> > LoongArch-based MCUs now (no FP, no SMP, and even no MMU).
>
> NOMMU Linux is kind-of on the way out as interest is fading, so I hope you
> don't plan on supporting this in the future.
>
> Do you expect to see future products with MMU but no FP or no SMP?
OK, we will not care no-MMU hardware in Linux, but no-FP and no-SMP
hardware will be supported.

Huacai
>
>         Arnd
