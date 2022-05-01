Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99794516345
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbiEAI7e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbiEAI73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 04:59:29 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650812F3B6;
        Sun,  1 May 2022 01:56:04 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id s68so5471530vke.6;
        Sun, 01 May 2022 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mu1yMR5dKezm+SKTIruAqlfPoYV6aEjk0Uo++5Bnha0=;
        b=c+mpNC4uvpgyJqOcd/Q6lrLbOoezDySUnYfSGyY/UZnChyX/Cvn9omVo4G6oUjSno1
         36Lh36Kts3bq1upbfHCrkAfWL5VCrdhqXFCF67mB9KJPgvdMBXzQwZQ+cuJwdTxTKzSI
         fOUlqqAlOQNcPOO2Y5XKzCb5ZIEEIvKpVf5bA/sKj6bsY2eefxOcNDdcQfvcxHMZIyaH
         7nY+OUwGCWTGMUv5AX+Baa0rFChXXxm0l1bD26XD2avGPgnvSkrI7iN4lQXUVw36hD9u
         5JbY6GUh3ulA5pD8O5Fbm3Buk8JS4ZKRmuzwRnTdJtzT/Ou92Q3+ep1WJXixf5ewp5L8
         Dgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mu1yMR5dKezm+SKTIruAqlfPoYV6aEjk0Uo++5Bnha0=;
        b=2gxuQJiztndFJTNCPk6+ZoJRbg7xIKpbl8iqDSY4zuR/oXdT53/BWPZNQ9IKL/DIP6
         fcBHB9iXxcpsDqDQhfP7Z+OAvcAct6IyWxAXtq9eTMyYxdL+tMG3UjvL/gZhQUcBSCRZ
         74PAyx7fSImGP4a7UZP0Is4NdQm00nl0gvy2SoUu71wuvt/WhWc58+S4zV7TRy71q1cl
         k6JLJRhF45CfE9taj+wzxdZNW6eLyrNr6fWd9f+D4ve9oFosFBOzUQHOCfDUgBO3AD/5
         fJsUydBBP5V974Y9YP0Xr1iWcBBFQgMTTRF5edfWw+ZkkW18wjyinfsDAj8undHy6+Px
         Bigw==
X-Gm-Message-State: AOAM53282N3Y3NKT3BZIEGXBMzX9eAEcx0tiWyLKQ3wQHtAOIIYx5nU5
        WwDR94vyEHDeLvTz7cawdXvdI9OFm3yYsCFQoiI=
X-Google-Smtp-Source: ABdhPJzoWtE2BCiuSncncKnQGWP4I41Igi6YVM7fen1KtzZckIuWMxzuda367cPmaVgUjz/U3RBPcviyYcfKPE9uK7c=
X-Received: by 2002:a1f:d102:0:b0:345:b1af:81a2 with SMTP id
 i2-20020a1fd102000000b00345b1af81a2mr1807669vkg.5.1651395363415; Sun, 01 May
 2022 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn> <Ym5ClK4vg4nodfYV@debian.me>
In-Reply-To: <Ym5ClK4vg4nodfYV@debian.me>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 16:55:52 +0800
Message-ID: <CAAhV-H71ovYt2F1nK5EtgV0oJQ8_PrjVL1v+1L5XCKJObARdLA@mail.gmail.com>
Subject: Re: [PATCH V9 00/22] arch: Add basic LoongArch support
To:     Bagas Sanjaya <bagasdotme@gmail.com>
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Bagas,

On Sun, May 1, 2022 at 4:19 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 05:04:54PM +0800, Huacai Chen wrote:
> > Huacai Chen(24):
> >  Documentation: LoongArch: Add basic documentations.
> >  Documentation/zh_CN: Add basic LoongArch documentations.
> >  LoongArch: Add elf-related definitions.
> >  LoongArch: Add writecombine support for drm.
> >  LoongArch: Add build infrastructure.
> >  LoongArch: Add CPU definition headers.
> >  LoongArch: Add atomic/locking headers.
> >  LoongArch: Add other common headers.
> >  LoongArch: Add boot and setup routines.
> >  LoongArch: Add exception/interrupt handling.
> >  LoongArch: Add process management.
> >  LoongArch: Add memory management.
> >  LoongArch: Add system call support.
> >  LoongArch: Add signal handling support.
> >  LoongArch: Add elf and module support.
> >  LoongArch: Add misc common routines.
> >  LoongArch: Add some library functions.
> >  LoongArch: Add PCI controller support.
> >  LoongArch: Add VDSO and VSYSCALL support.
> >  LoongArch: Add efistub booting support.
> >  LoongArch: Add zboot (compressed kernel) support.
> >  LoongArch: Add multi-processor (SMP) support.
> >  LoongArch: Add Non-Uniform Memory Access (NUMA) support.
> >  LoongArch: Add Loongson-3 default config file.
> >
>
> I have skimmed through patch descriptions, and I see patch 05-24/24 use
> descriptive mood (This patch adds what...). Please write them in
> imperative mood instead.
OK, thanks, let me try.

Huacai
>
> --
> An old man doll... just what I always wanted! - Clara
