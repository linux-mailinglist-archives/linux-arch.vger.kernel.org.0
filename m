Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F00708CFB
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjESAiz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 20:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjESAiy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 20:38:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C141137
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 17:38:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c5570182bso8932439f.0
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1684456732; x=1687048732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/jPM0KnH+FwZjtmXcaKFjOjxDtUtKIRA4syAmgc008=;
        b=fmjVDjbt+kVlfJJwbXQK46gG++Iuw6KXHsivhDuvDS1k3OJpQOQpec2T2c0ma/iqQN
         9WeSajyeQsFTZLYH+IeZpzrbcJzTbvXie0lgLosHMSjhrMgYpvYY00G4EHMPgrvi/Iu7
         tenMCSZl7X6Sx3vKHFEsDse1sK6aOo9BlIjqXMsUfRbjFkGXnAzDm9lEdyUKq9mlWbah
         zASFPie7alKP0oNfedYyG7FvDteT1lmEtAWg4J3HHFpfWvz6xut2TzwAIjl2xAf9qhFd
         ud+gIUTwV59X4gLBAG8ikBAGXop4+zMT79TM2ItusYqCkJffT4YMR2Qhr2yOj532k4Uo
         p0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456732; x=1687048732;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/jPM0KnH+FwZjtmXcaKFjOjxDtUtKIRA4syAmgc008=;
        b=Nt3LMYFnXWHb0wWsYyalXq87+l3X92HMvQ061Dx38wXnHG+LbP6Sf1j6VlA3UZmt8C
         ggaheggoYCjfo+M5DQj4R0UPmmk7f5sVQG37qp1cOOa06mCb0PMWlUluzAF5CeDleA8C
         k8jK/pcoa2SExw3ZdxkwZNfwqcnxmT/8BYIzpePlgT9HaNToRfOq7OURDw9OusE1Ky1h
         xOMPRTzlfACAGzkBtEIflIOQIsV7FbJn8UnEbsxq7OHQnUFMOgd5JZh8yQCyd/fsvqzB
         Fyy/Vc2ADjS/8tw6mUnGrWNX1Bgol1XgxANSmqKYVQi3uREDdYZMS4PX3nlmEwG4OYmx
         kkLg==
X-Gm-Message-State: AC+VfDyLxQtorfrulJQlRariZgLHiCVsXZ0TXCxFJuUH+KmCoVnrdknA
        F7BsCcHpBxSm1I6WjDI6t7zBXA==
X-Google-Smtp-Source: ACHHUZ5LcaA26lj0MuLputKQFfYR1Y7nG2KPFDIiKERvOLPuxhn7bS0bUuvXzticQqEP+j2ZkW7d9w==
X-Received: by 2002:a92:c707:0:b0:335:8542:440c with SMTP id a7-20020a92c707000000b003358542440cmr530202ilp.12.1684456732398;
        Thu, 18 May 2023 17:38:52 -0700 (PDT)
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id m20-20020a92c534000000b00337b078ce44sm669216ili.0.2023.05.18.17.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:38:51 -0700 (PDT)
Date:   Thu, 18 May 2023 17:38:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Palmer Dabbelt <palmer@rivosinc.com>, guoren <guoren@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anup Patel <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel
 on 64-bit supervisor mode
In-Reply-To: <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
Message-ID: <454dede3-5f20-74fc-975a-e11e4d8b5648@sifive.com>
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9> <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 18 May 2023, Arnd Bergmann wrote:

> We have had long discussions about supporting ilp32 userspace on
> arm64, and I think almost everyone is glad we never merged it into
> the mainline kernel, so we don't have to worry about supporting it
> in the future. The cost of supporting an extra user space ABI
> is huge, and I'm sure you don't want to go there. The other two
> cited examples (mips-n32 and x86-x32) are pretty much unused now
> as well, but still have a maintenance burden until they can finally
> get removed.

There probably hasn't been much pressure to support Aarch64 ILP32 since 
ARM still has hardware support for Aarch32.  Will be interesting to see if 
that's still the case after ARM drops Aarch32 support for future designs.


- Paul
