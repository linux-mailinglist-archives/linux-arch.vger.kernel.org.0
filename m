Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F64E2EBE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 18:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiCURHX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351585AbiCURHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 13:07:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358E652F1
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 10:05:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w25so18617582edi.11
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBQk8rHtEPTg6dv9p8Kge/KgK79GOS20rlTmW/7fX9Q=;
        b=bWURaSxEHcwi/MbE/WuU8Lye1Vi23YYhdUI+3MOmVNwDrY5PlMMtW6JuuZL/XPUuXM
         /xIA10lKeFvophAsWTdRVYSAaJzjOTQwuNZdK8oEQD45026nVACp1JOFN83h5QIaWZvB
         hwG7x5qxPqyG6eqPlvpG/oiOPNsZ5g9rTCBZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBQk8rHtEPTg6dv9p8Kge/KgK79GOS20rlTmW/7fX9Q=;
        b=wjxkJK4pFx9DWJANAfM0jmQiFcRx8tMkv85uLblesuhTlJ1dqqv7JUFYaH79Tm30TU
         mfCBm+vM2iM3AaXiAWYicaKT2Kmyxzu6/4TMbyLhBxkVBNlxmx1l7QQsfg4uv1vVYUBg
         xW5ld1kFr2zwXL2gecW0vMqNWZtZO1kTigvoXoJHWa+km6ern6uFvQg8RTV0YXA90Vow
         bsL3y7LCtvdHCBN1HWcaofo/+IDhoGDPNSFwCcvSol3ONZQeqB1j4kZgcIxPUccPSNz8
         uYOgqTfPoiND+j/Koa/rK3ruBqINIQKeTPiW5lbb6XG1BQm3Ue35xos7wMs2gCqqZntu
         oVPg==
X-Gm-Message-State: AOAM533VyPOlsru6NsYVg76KSWfmwxTRq5zMXnWH5UpFisMoJnTCQaIy
        z/Uq5oVw3uEdGnnD5M0tsGjVSJvK2N9d1D8Gim4=
X-Google-Smtp-Source: ABdhPJzIaOmWBjELNL1un4Fb7Vrl0o4NksWPG20j+b/E9CUKBwBR5RV+32n+zIljonayz1iGhCXX5g==
X-Received: by 2002:a05:6402:9:b0:419:3c6e:b0d5 with SMTP id d9-20020a056402000900b004193c6eb0d5mr6428181edu.216.1647882350605;
        Mon, 21 Mar 2022 10:05:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id j17-20020a05640211d100b00419357a2647sm2101440edw.25.2022.03.21.10.05.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 10:05:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id z92so17705743ede.13
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 10:05:50 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr15608242lfj.449.1647881973238; Mon, 21
 Mar 2022 09:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn> <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
In-Reply-To: <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 09:59:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
Message-ID: <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
Subject: Re: [PATCH V8 00/22] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 21, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This looks fine to me for the most part [...]

So it looks like this is getting there.. Do we have a way forward for
this to be merged?

I obviously can take the patches, but it would be even nicer to have a
pull request, and you'd be the obvious person since you are - whether
you like it or not - the "odd architecture guy".

Hint hint ;)

            Linus
