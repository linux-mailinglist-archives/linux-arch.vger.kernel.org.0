Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA13D5FF474
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 22:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiJNUT2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiJNUT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 16:19:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD611D3E89
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2022 13:19:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m6so5954489pfb.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2022 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8IVK8k7k9gOGjXG9NHmvjgor4/KedW5P7/8L1lQGUs=;
        b=l7NuPTgKJF77glfTg5wUM0i6Q1IBcSYKNmIAmbVOrS58xzVMla3V3aoAS25ZQIUKQi
         dbJi/3AGnfBgfwfQsywObFaIUWAEy3rJ41PT8pwaNNaS4VLPsBVEdBrEi+z4af3TsPRS
         zR+hhvenq+Tzp4+/xhyTQDKDrx/rgaqXIoRHftUS6gljtbwBt3XwZulKmH4NCRZa4gc7
         8jsphkevXa52aYaPftluIg3M62is4x/ZdDMdi3WCNvxSnJcAIFBeAJsmERI0DKCykVQs
         3VIoXi58mU1wngSQkYfJiSMJMDjF67PPnEcfgW3X9Z7wWBv69C6cI6ipKt1pxq3JMo2+
         oSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8IVK8k7k9gOGjXG9NHmvjgor4/KedW5P7/8L1lQGUs=;
        b=kML+eJUpJq5vILQjaYsKP3BtvY/9xFM1GVbbCXh99kucR3a5rsLOrQSzDmNsQ3CGGC
         aEXJEe1/f6OXq1ncsfieiI1s108K/5ZdykNqgcgLDmHz+AsupzvnKB9iRvCgZR8nML3F
         I1IZm5BbIzal0GtuZQoEAsFfQueMy/mx37YhpnyHbG57ghMAkrfyngi7uINT0+55KQXa
         LE8aBzzyhMJ8IjRYIEPG5s9dGIH01UJPha7KiBPc0jyXE+Rfv2bSDHIfI9L9UeH60QF1
         H5xX9OalqzX97VCGCMTCvcg2L4cymbFDg3as5qGSYYX3Iu8RNDxt6stYq2sZ0eDCw/ND
         fCQg==
X-Gm-Message-State: ACrzQf02VyjE3rcFOWJE6k+YWFIAGTwuHvTJq53u+6WCCLDOqPGF2fTD
        YOY+POpgSlV2uPWH/G/U8Z8glkOsO9RW8igFGhTVPw==
X-Google-Smtp-Source: AMsMyM7RQNAQa92JkPff2Imw1hV4Xm/n13lNelqA2N++jhAukEo0EG4H91O/ZREacbcJ1MI4faUBQ8OOZaYb5XFCoFs=
X-Received: by 2002:a63:80c7:0:b0:46b:2ccb:ff93 with SMTP id
 j190-20020a6380c7000000b0046b2ccbff93mr3283676pgd.403.1665778765642; Fri, 14
 Oct 2022 13:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221012180118.331005-1-masahiroy@kernel.org> <Y0mIUW7Ozx9tseeG@dev-arch.thelio-3990X>
In-Reply-To: <Y0mIUW7Ozx9tseeG@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Oct 2022 13:19:13 -0700
Message-ID: <CAKwvOdmm9FsH2G76bZ2Qr5Bbnbdb55JwONP5WG7oa_iMZUycXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 14, 2022 at 9:03 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Oct 13, 2022 at 03:01:17AM +0900, Masahiro Yamada wrote:
> > CONFIG_WERROR turns warnings into errors, which  happens only for *.c
> > files because -Werror is added to KBUILD_CFLAGS.
> >
> > Adding it to KBUILD_CPPFLAGS makes more sense because preprocessors
> > understand the -Werror option.
> >
> For what it's worth, this is going to break 32-bit ARM builds with clang
> plus the integrated assembler due to
> https://github.com/ClangBuiltLinux/linux/issues/1315:
>
> clang-16: error: argument unused during compilation: '-march=armv7-a' [-Werror,-Wunused-command-line-argument]

Ah, sorry, I should have finished off that series back then. I've
rebased the series and sent a v4.
https://lore.kernel.org/llvm/20221014201354.3190007-1-ndesaulniers@google.com/

You mentioned to me on IRC
https://lore.kernel.org/linux-next/CAK7LNARg8OpqLR_71PJV3ZoLuDV8+mz9mphg=CzEeEEMY0G3rw@mail.gmail.com/
maybe will be a conflict.

>
> Ultimately, I want -Wunused-command-line-argument to be an error anyways
> (https://github.com/ClangBuiltLinux/linux/issues/1587) but it would be
> nice to get these cleaned up before this goes in.
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
