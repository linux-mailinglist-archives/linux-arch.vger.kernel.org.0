Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A81526EE7
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiENC4R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 May 2022 22:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiENCzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 May 2022 22:55:50 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCF30D651;
        Fri, 13 May 2022 19:27:31 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id e19so10147476vsu.12;
        Fri, 13 May 2022 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNRFHelHtxBF0rEo2GPFsA8KruY7+GZmvF5x2wLcg6c=;
        b=GRw4EkYAQBItrod987bW6HWwYi4wC/Q2rn4j1WkpUaozWALaqNs0fx7L3bhVgU5g/7
         suPSrlyvUV7JqhXrTW8orF6kteob+hoX1YJ78cE8fAg3ldRW+O1Pk3s0tuz4ZGceaPLU
         cxPc86dtmB74v09B7k1SC6vKuOSAzgSsUpuS61YrGhZRIENDnXidU+jHRCOX3GPD8Zvv
         6Jtcf4Z6esWCmzetzCr+xZOmsfQ05/YZDbDTim4OpkeHCbZBdbN0zPjMR4ukAa+0+owR
         nBAYAfMD7MedLHvRfkC6xHfPjMMhJwOM8DcqtsaW3UPIcuBXmzbj4rUqfXeMtgpCegdu
         BfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNRFHelHtxBF0rEo2GPFsA8KruY7+GZmvF5x2wLcg6c=;
        b=hPXn02UsQmV1YEuOlpqXaf2bsRAzPnLaDGlL4ofCtt3O6Tbi3HggGzo6/3tt7hxAGb
         d8wV794/1E0Yx/RPfzD4tqfKeEEk+G5kfzKnbvnte/mpdBKXdkujt+BVSB2kPU12P7tb
         z1/0AFwnPmrCox+/wJ+HpiVtngwZfq4rVC+KLqRqusb99IypCiaSfsNnf2aZ+sRhwXYk
         tH+ev9jaVK1ebYkLpBUCy/5fv4hqVRkGIs0/0OAClKYBlELayMaEyHsaggMSCr28lred
         y6hDULjDiSJ6kPlJWvYVcPiVnUPTWyimK+Cx4ukXmdlehWgWF6MYauMmP0W2FRY4HGPd
         S5Nw==
X-Gm-Message-State: AOAM530nPCJFPBcrmmu3Ayov8NPcp+qf7JZ+U2dDLjd8vFRLQiSWWxme
        1jP/U2sSocbUBZMLp0JOfkbgWY4cn3RvJXbP7kk=
X-Google-Smtp-Source: ABdhPJwvYdh0HeuLiLQIqp/LqnS3cAsusABUBRLf57i3qobF3an16riWMPT3SJmrkQJ22OEvpXxIRqNZ/L6aVAPh23M=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr3166447vso.20.1652495250714; Fri, 13
 May 2022 19:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
 <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
 <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
 <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name> <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
 <CAAhV-H5FbA5DJvPwygiUyBrzq9M5R=Fr06rHAHLR31uu6ZLmkQ@mail.gmail.com> <CAK8P3a1_2DJVjZtk9XGYvH0TSbNQwST0YXD4A+rfFELBOxpDEA@mail.gmail.com>
In-Reply-To: <CAK8P3a1_2DJVjZtk9XGYvH0TSbNQwST0YXD4A+rfFELBOxpDEA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 14 May 2022 10:27:21 +0800
Message-ID: <CAAhV-H7011Cq9-rS6mWLcr0zDX2D_5Hwtqmtb2BXAwOgqyXyag@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     WANG Xuerui <kernel@xen0n.name>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

Hi, Arnd,

On Sat, May 14, 2022 at 3:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 6, 2022 at 3:20 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Fri, May 6, 2022 at 7:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > Agreed. I think there can be limited compatibility support for old
> > > firmware though, at least to help with the migration: As long as
> > > the interface between grub and linux has a proper definition following
> > > the normal UEFI standard, there can be both a modern grub
> > > that is booted using the same protocol and a backwards-compatible
> > > grub that can be booted from existing firmware and that is able
> > > to boot the kernel.
> > >
> > > The compatibility version of grub can be retired after the firmware
> > > itself is able to speak the normal boot protocol.
> > After an internal discussion, we decide to use the generic stub, and
> > we have a draft version of generic stub now[1]. I hope V10 can solve
> > all problems. :)
> > [1] https://github.com/loongson/linux/tree/loongarch-next-generic-stub
>
> Can you post v19 to the list? As we have resolved the question on clone()
> now (I hope), and you have a prototype for the boot protocol, it sounds
> like this can make it into v5.19 after all, but we need to be sure that the
> remaining points that Xuerui Wang and Ard Biesheuvel raised are
> all addressed, and there is not much time before the merge window.
>
> I have built a gcc-12.1 based toochain at
> https://mirrors.edge.kernel.org/pub/tools/crosstool/ that now includes
> loongarch64 suport, please point to that in the cover letter for v10
> in case someone wants to start test building.
>
> I will be travelling next week, and won't be able to pull your tree
> into the asm-generic tree during that time, as I had originally planned.
>
OK, thanks, I will send a new version today.

Huacai

> However, you can ask Stephen Rothwell (added to Cc) to add your
> git tree to linux-next once you think that you have addressed all of the
> remaining review comments, and posted the same version to the
> list. This will allow others to more easily test your tree in combination
> with the other work that has been queued for the 5.19 release.
>
> If there are no new show-stoppers, I can help you coordinate
> the pull request during the merge window.
>
>          Arnd
