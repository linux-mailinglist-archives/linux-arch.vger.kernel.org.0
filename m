Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AF56A128
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiGGLkt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiGGLks (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 07:40:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD04F1A1;
        Thu,  7 Jul 2022 04:40:47 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31c89111f23so116824687b3.0;
        Thu, 07 Jul 2022 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYBPqS4xY3Iy/t1wJ0RdNMmpzpw8+/2pWaPNwwQsS0k=;
        b=NHANB1zb7QW09jcvhMhHqZ1vX+OHZF2oNO9oEeZoL9D0QuxrC7CSh8ps8YDiMjstUi
         oG3E2WinJqR1Nwvf3AzASdEqVgO5UBLmKe+otVgFvAPmQQi7LIbpteG2atULmpr29yGQ
         /blSer7nVC0TSb8ms8lYN0vYbQ+6GzQrOdNPPZ9r1lOE6GcjLUUv1GAu3bdlaSMiz3MO
         Ks5UavL5VLiFdw3VTFaBH8PUjEqq4klxaXmzv9QJwYY4hUrIFOqrFr0ttbp4ku5g6ryZ
         VhNmEBv4od4gFgKVAP0EJ8WED2u4z6IPuy95QIevTjbh5J708fKC7MJzgjX333DO55gh
         p36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYBPqS4xY3Iy/t1wJ0RdNMmpzpw8+/2pWaPNwwQsS0k=;
        b=kepodHVgZQ9OU3jKMsM0+H9SBlPbD9UQWRDVxugZE6tszAOow4RAtPYcCed1hUobZR
         NWqHhEugKubuUXch6ZGUl5CQJXt1p/zu7OP1o4PhRhe3E555ubfaFbOnd8vhshd9g8Om
         hDslkr3sNhaX/5rY5hCFvL/ml4r3Ab15plArQygJetqOd02fDgh+4rA45qPyeY9dhtKx
         AhicvZfFN2SAyICOtXqgyy+WDpAMI0GG5seuLE5o6qtA/UhplYgFIs3y0xp5Ic9vVn/Q
         em1nSXiH6SkQ77iof75IhAOv35UHvkeGleFQ/0bmxUTI7xKG4pnnLKws9DQedTabCD5O
         Yj4g==
X-Gm-Message-State: AJIora+ZCDgk2Jy23eBY5dYWuCFpGw2KpjEHz5lyXmumajk0VlIjcW93
        ao9R4F41O/oCfmD29aSy68G8qeM/vOmpOURLtyISzny8BfY=
X-Google-Smtp-Source: AGRyM1v8pkh1WCxZyLS5NpCQgpNIQQxFyxGl9Kmab697g5gxlfPnLIs2hr7Ou7DItJjkbPIUuG+2JKOfOjNVSw7prWo=
X-Received: by 2002:a0d:dec2:0:b0:31c:a9dc:b372 with SMTP id
 h185-20020a0ddec2000000b0031ca9dcb372mr21129907ywe.481.1657194046634; Thu, 07
 Jul 2022 04:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
In-Reply-To: <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 7 Jul 2022 13:40:36 +0200
Message-ID: <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Oct 6, 2021 at 6:52 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 06 Oct 2021 08:17:38 PDT (-0700), Arnd Bergmann wrote:
> > On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >>
> >> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> >> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> >> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> >> in the reference) in ./include/asm-generic/io.h.
> >>
> >> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> >>
> >> GENERIC_DEVMEM_IS_ALLOWED
> >> Referencing files: include/asm-generic/io.h
> >>
> >> Correct the name of the config to the intended one.
> >>
> >> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Thanks.  I'm going to assume this is going in through some other tree,
> but IIUC I sent the buggy patch up so LMK if you're expecting it to go
> through mine.

Palmer, Arnd,

the patch in this mail thread got lost and was not picked up yet.

MAINTAINERS suggests that Arnd takes patches to include/asm-generic/,
since commit 1527aab617af ("asm-generic: list Arnd as asm-generic
maintainer") in 2009, but maybe the responsibility for those files has
actually moved on to somebody (or nobody) else and we just did not
record that yet in MAINTAINERS.

Arnd, will you pick this patch and provide it further to Linus Torvalds?

Otherwise, Palmer already suggested picking it up himself.

Thanks and best regards,

Lukas
