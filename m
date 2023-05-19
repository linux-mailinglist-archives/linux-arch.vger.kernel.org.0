Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B578708CB2
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjESAOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 20:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESAOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 20:14:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D810C6
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 17:14:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76e5fbb1c89so203685539f.0
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 17:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1684455278; x=1687047278;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPErhkDQ1KrXKdVSH67+TyFJqg0zBYRQSIsMhyp6Xp8=;
        b=GyNWfCWn4Qnut/p6Uxof5m2Hm68molu1vAPWfUBZGoTmgiVHQEQATRVY5iku1wK0//
         IUEl4JQhJ8A4NAVQR4/kYgj3dVdvD+vboyN/fvP67sTlnf4WEgz9Usg96l4bmOWtt1BD
         jIN7dgs6+AKA9m09k5UUHgvZKhKr+EXUc4wIiHiEmzDlgpn/mPtDPBTiVA7bau4p1U6q
         C7jtns0MiIGiInh1U6RbBnUCNtWtkHVQuGEl5DHall6JTIF0tTgoVH7CHDiP/DAUWfmm
         RekhD2B93xCznSkU320tmvwltZDoa3k/CR/uL43GMFSyumUWlD1WnoLtnVbSQwTuG3kF
         HQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455278; x=1687047278;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPErhkDQ1KrXKdVSH67+TyFJqg0zBYRQSIsMhyp6Xp8=;
        b=Y/hZZzLAWlqboPMp1dwj+7rSzQSNIEPr97RyMmO86OWLjx5CIH651OBoEXiVufU0tX
         AkpJvZtsSSgJfFUlXPyu82gqE+fANJR/D/wB03qEjXg1H+Yzf/EidSOtodK3EdD4CzoF
         3ZNpKwiOTXlU5+4WcZI+erd/ZyO/R+a7HBRZq9iYdX0k0R6reaPwWm2qBpMhSm8C4zqg
         VTdofXGvXPFY1JOedJvA8lT8Kd7w+BBphJlw+lmpDHfFDIs7Bua4kdXiA9ERV3aABc8g
         p7bDMEut478PElyaRA5QqloKsuke8zfm8OfWa3TrdVeRdNh9qjA1wOq++ErnG5SwliCT
         iuAg==
X-Gm-Message-State: AC+VfDyhd9yn9rtb8EuW2g7ovU9I7/NxwgjwYn+TaPQlisF5PxfmLqCP
        d5jSo4WwlXV1MN7Z6ZpFSjR3RQ==
X-Google-Smtp-Source: ACHHUZ65b+K+N7lMkdk80CRK5W5Q/kNy6pdIIJ+ihecbfBJsXSAKnKfg44MotaAJlp9SUoGP3mW66w==
X-Received: by 2002:a05:6602:3311:b0:76c:779c:7ebe with SMTP id b17-20020a056602331100b0076c779c7ebemr75255ioz.14.1684455278089;
        Thu, 18 May 2023 17:14:38 -0700 (PDT)
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id r22-20020a5e9516000000b0076c872823b7sm710613ioj.22.2023.05.18.17.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:14:37 -0700 (PDT)
Date:   Thu, 18 May 2023 17:14:36 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
cc:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, Mark Rutland <mark.rutland@arm.com>,
        bjorn@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, rppt@kernel.org,
        anup@brainfault.org, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn, chunyu@iscas.ac.cn,
        tsu.yubo@gmail.com, wefu@redhat.com, wangjunqiang@iscas.ac.cn,
        kito.cheng@sifive.com, andy.chiu@sifive.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com, corbet@lwn.net,
        wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel
 on 64-bit supervisor mode
In-Reply-To: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
Message-ID: <668be661-728d-b87f-b827-4345ad07cc61@sifive.com>
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
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

On Thu, 18 May 2023, Palmer Dabbelt wrote:

> On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
>
> > This patch series adds s64ilp32 support to riscv. The term s64ilp32
> > means smode-xlen=64 and -mabi=ilp32 (ints, longs, and pointers are all
> > 32-bit), i.e., running 32-bit Linux kernel on pure 64-bit supervisor
> > mode. There have been many 64ilp32 abis existing, such as mips-n32 [1],
> > arm-aarch64ilp32 [2], and x86-x32 [3], but they are all about userspace.
> > Thus, this should be the first time running a 32-bit Linux kernel with
> > the 64ilp32 ABI at supervisor mode (If not, correct me).
> 
> Does anyone actually want this?  At a bare minimum we'd need to add it to the
> psABI, which would presumably also be required on the compiler side of things.
> 
> It's not even clear anyone wants rv64/ilp32 in userspace, the kernel seems
> like it'd be even less widely used.

We've certainly talked to folks who are interested in RV64 ILP32 userspace 
with an LP64 kernel.  The motivation is the usual one: to reduce data size 
and therefore (ideally) BOM cost.  I think this work, if it goes forward, 
would need to go hand in hand with the RVIA psABI group.

The RV64 ILP32 kernel and ILP32 userspace approach implemented by this 
patch is intriguing, but I guess for me, the question is whether it's 
worth the extra hassle vs. a pure RV32 kernel & userspace.  


- Paul
