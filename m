Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD276D599
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjHBRix (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjHBRic (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 13:38:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B283F198B
        for <linux-arch@vger.kernel.org>; Wed,  2 Aug 2023 10:38:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe1344b707so130431e87.1
        for <linux-arch@vger.kernel.org>; Wed, 02 Aug 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690997882; x=1691602682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyQdxgtNMG4RTFo6glKNGilpjeAOgHu/v44MBJ5lr6g=;
        b=FdGjw6HXHhZ6+Vw2hxfQAMrStQiiadvB/SsztWB+Hfj84Tz9a8e6TDptPNV8ihiSnl
         yZIQWFAs0/daQGqP59TJy+VoE7dMwfj3h/DxzVCR8pbqJY9pllhuUbq/kjebn38H5GAv
         zuFWmAEuAcogVpDQ4n1F3tMwwoQYRfOQzigX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997882; x=1691602682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyQdxgtNMG4RTFo6glKNGilpjeAOgHu/v44MBJ5lr6g=;
        b=kF3kIU4xVx9l8L9w6d1IqqQRxRkNLahD300q7jYrE091/ezadIa1O4uys0Bv5Yh2kO
         YMYGV5pAevuS75lWUnml6sOJtAFRW6/twfI1u4g5gLg+uVLj2kYwNIiIHBR+XWJGUSmP
         pF1m8sy9RG0Pe50UVolaxHLWrrfbGOadfm7/AjC+a0I7+/MRiczFzjtf06sjgCRlQoMt
         gKU1Amhxxi/GD04IS99hnxfcUwOUwP/8nUYund2F6hg7NNOclktkUF/OoAeYeTKbJLgq
         SjjkGFCCLoy1frBMJaoGghokoSSEqbUo1MjWVyLNna/OlWq38/mv5YyU6VTr/A6KwrGT
         Vuig==
X-Gm-Message-State: ABy/qLZy/1lH1ClUs+9pYXeYD4XDkMBrAr1a8P+uxwWuzuLLfsWaJkUl
        u0scAc1hb/UteA1eqb1T3zwddacw4LT2cBf8IxxHBETJ
X-Google-Smtp-Source: APBJJlHaaBmZIgcMTsTca/yyPjnecF4TH4PkGe13ws2heOjkIrXtj7y/Lnn0FsRUI2oQnyMmoLYUmg==
X-Received: by 2002:a05:6512:104b:b0:4f9:92c7:401d with SMTP id c11-20020a056512104b00b004f992c7401dmr5831792lfb.30.1690997881964;
        Wed, 02 Aug 2023 10:38:01 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7d58d000000b005227b065a78sm8984207edq.70.2023.08.02.10.38.01
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:38:01 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-317744867a6so57930f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 02 Aug 2023 10:38:01 -0700 (PDT)
X-Received: by 2002:a5d:608c:0:b0:315:9021:6dc3 with SMTP id
 w12-20020a5d608c000000b0031590216dc3mr4961506wrt.27.1690997880674; Wed, 02
 Aug 2023 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com> <20230802161553.GA2108867@dev-arch.thelio-3990X>
In-Reply-To: <20230802161553.GA2108867@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:37:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
Message-ID: <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
To:     Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     ndesaulniers@google.com, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2 Aug 2023 at 09:16, Nathan Chancellor <nathan@kernel.org> wrote:
>
> We see this warning with ARCH=arm64 defconfig + CONFIG_CPU_BIG_ENDIAN=y.

Oh Christ. I didn't even realize that arm64 allowed a BE config.

The config option goes back to 2013 - are there actually BE user space
implementations around?

People, why do we do that? That's positively crazy. BE is dead and
should be relegated to legacy platforms. There are no advantages to
being different just for the sake of being different - any "security
by obscurity" argument would be far outweighed by the inconvenience to
actual users.

Yes, yes, I know the aarch64 architecture technically allows BE
implementations - and apparently you can even do it by exception
level, which I had to look up. But do any actually exist?

Does the kernel even work right in BE mode? It's really easy to miss
some endianness check when all the actual hardware and use is LE, and
when (for example) instruction encoding and IO is then always LE
anyway.

> With both clang 18.0.0 (tip of tree) and GCC 13.1.0, I don't see any
> actual code generation changes in fs/namei.o with this configuration.

Ok, since the main legacy platform confirmed that, I'll just apply
that patch directly.

I'll also do the powerpc version that Arnd pointed to at the same
time, since it seems silly to pick these off one at a time. It too
should just be 'unsigned long', so that the two values can be bitwise
or'ed together without any questions.

              Linus
