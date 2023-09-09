Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26097996CF
	for <lists+linux-arch@lfdr.de>; Sat,  9 Sep 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjIIIGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Sep 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjIIIF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Sep 2023 04:05:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DD19BC;
        Sat,  9 Sep 2023 01:05:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6FDC433C7;
        Sat,  9 Sep 2023 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694246755;
        bh=FAl7QCcBEBmuLvmZgnqvXZHtyLfOeqGUElSXUm48ss8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mxiDnjRJL1emXGMPGtEXTuXekD/jV3lQGdCWyZEne8TW8wJQr0i4ixTGyOuDVeFiI
         p306iJPwMgX+b+cp3CaDPGpDt2IC6QphD9Kx5uHsocJUGmCMfv/Si5mYgAyl+w2Cw2
         EPRXQqUxqJcsAYM3wYsf/zbZhebqU3N+YuDieEbOoO5PC0FeEtLL8UwraVfLCQ4ht4
         X5fB630qfxkVF9JY5SihEw9FZpeVx8HnkHvVmoGcfcoGok9d/BOvvNsafoGRD8yttV
         ZxSzFwI19ry8hlXK3hPygQyDO28CgqJ7cr2Elioi4w/VUhDW28mlTE+H0xEjqwv+Es
         ERWasIBvKqlrg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9a603159f33so349890166b.0;
        Sat, 09 Sep 2023 01:05:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFbQDebPtMSHzPKN+n4yofybDwvKXx/Jt/CVeo/W8xtt+7T0n2
        37NDk1huobc/3Ac0/CgvNPyOl1LIhFwe2LgvTNM=
X-Google-Smtp-Source: AGHT+IFNPGlpu+8xmETkoFkPcqKPS03ejfP5dOQKlJQWvnRcJa/E/kzIOA4TpPs+PsPQB8ZoR/NAa/0CTqnNt8gfYBg=
X-Received: by 2002:a17:906:51c2:b0:9a1:beb2:1cb8 with SMTP id
 v2-20020a17090651c200b009a1beb21cb8mr4250702ejk.39.1694246754043; Sat, 09 Sep
 2023 01:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230908111053.1660033-1-chenhuacai@loongson.cn> <CAHk-=wh-uoZ_XsZ4fDodqjUY+rYJq=D3RVme3f=zBDB5neWhKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh-uoZ_XsZ4fDodqjUY+rYJq=D3RVme3f=zBDB5neWhKQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 9 Sep 2023 16:05:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H64=ZWBnzFmtS-FMB83nn21DSm20adrXdsrYkoka_oyjw@mail.gmail.com>
Message-ID: <CAAhV-H64=ZWBnzFmtS-FMB83nn21DSm20adrXdsrYkoka_oyjw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Linus,

On Sat, Sep 9, 2023 at 3:48=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 8 Sept 2023 at 04:11, Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > 7, Add KASAN (Kernel Address Sanitizer) support
>
> I have pulled this, but please at least consider
>
>  (a) don't use the stupid and random __HAVE_ARCH_xyz defines
>
> Yes, yes, we have historical uses of it. That doesn't make it good.
> Instead of making up new random symbol names, just *USE* the names you
> are defining per architecture.
>
> IOW, instead of doing
>
>   #define __HAVE_ARCH_SHADOW_MAP
>
> and defining your own helper replacement functions for
> kasan_mem_to_shadow() etc, just use those names as-is.
>
> So if you have an architecture that has its own version of
> "kasan_mem_to_shadow()", then use *THAT* name for the #ifdef too.
> Don't make up another name entirely of the form "__HAVE_ARCH_xyz".
>
> Example: architectures can override the default generic versions of
> "arch_atomic_xyz()" operations, and the way you do that is (for
> example)
>
>   static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
>   {
>         return i + xadd(&v->counter, i);
>   }
>   #define arch_atomic_add_return arch_atomic_add_return
>
> note how the define to let you know the name exists is the name itself
> (and because the implementation is an inline function, not the macro,
> the marker is then just a "define the name to itself").
>
> End result: no made-up secondary names for other things. When you grep
> for the thing that is used, you find both the implementation and the
> marker for "look, I am overriding it".
>
> And also
>
>  (b) do you really want to inline those kasan_mem_to_shadow() and
> kasan_shadow_to_mem() things?
>
> Yes, the caller is addr_has_metadata(), and that one is
> "__always_inline",. because otherwise objtool would complain about
> doing function calls in SMAP-enabled regions.
>
> HOWEVER:
>
>  - on LoongArch, I don't think you have that objtool / SMAP issue
>
>  - and if  you did, the function should be __always_inline, not just
> plain inline anyway
>
> so I get the feeling that the inline is simply wrong either way. Maybe
> that function should just be declared, with the implementation being
> out-of-line? It seems unnecessarily big to be an inline function, and
> it doesn't seem performance-critical?
>
> Neither of the above issues are critical, and the second one in
> particular really is just a "did you really mean to do that" kind of
> reaction, but since I was looking at this, I decided to write up my
> reactions.
Thank you for your suggestions, I will make cleanup patches for the
two issues before v6.6 is released.

Huacai
>
>               Linus
>
