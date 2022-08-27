Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F055A3966
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiH0SLp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0SLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 14:11:45 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94CF8F4B;
        Sat, 27 Aug 2022 11:11:44 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3321c2a8d4cso108047157b3.5;
        Sat, 27 Aug 2022 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8s1IGyq3lvzGB+LMioCLVSGKADxF8UNHbOANIWo/QeM=;
        b=WHt2SwSJyN66kr9BpqHWMpkgs1pk6uDma4828MRQgC5e7zT3gDxqqIFONTXx38S6UK
         a9FLPyF+877CAemw+wHkkYU6uBfTjI5OAJhOI6VIQvy2ker0y7+aYGSvH9Yk41jy92+d
         mc7Qtg6q1zY8iLjB02j07ZkraManZSTQZjDVxLQeqb8sREAefYuJHw5RGaxp5yu3lQ4h
         7ZMZA319iKon9vaAj0m1VfNm/Ud34M1vh9b9xzZuL1UKpESumBkLg5ptAIgDYK39D9h+
         DbePgKyuqoShM1aDVcao9Ph72+qnG+DBf+CMOralEOOO4sRiMD+7z3uWz6hZNxAm6vYv
         ThqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8s1IGyq3lvzGB+LMioCLVSGKADxF8UNHbOANIWo/QeM=;
        b=PTSoikc5aAn4rD05yCwx9WAU/UfYadjyh+VDvPII+rJAep2DW0Z8RpPOWVPOAbU/WO
         1Mjuyn2a1Qo2GV/d5tf1whvg/y3Ys5CxIKigI6XR0oA26DC9x2sa/HK1//ZT8Zurw+hB
         3hBNIy7h/wCn2ffQnIRe1BXoZcQWUHCjjguY3Rw9fGpnhlUs65YvMy0p8XcT/bU5+rEe
         3STnRJVHV+IPV3a4mXS4v9Ak09PnytpXhuoA2qpYex6ImDyc3YOU3mrhzDKTsKlxVtik
         A1XPTwcB5CBSj/MO10Wvil/pyW92zhdPljeqpFLJJviwm2ctHpM0nYfAV2CvBo0Y/M3C
         qIpg==
X-Gm-Message-State: ACgBeo2tFHZtskkmE8Wv7rLIJUl2Nsbgs8hKWdhJfiWn+ynumjpdvUhl
        g4DjnAoYcCFjEb45gkPgRy5TXctmmP/XQbnDXrg=
X-Google-Smtp-Source: AA6agR5rbN2m9Z0cK03uJz+yVOqEgi680/70IyMizErQXdO9SJGVBxn/aFOYrBJAD+xtuRhNjesCKNg8TIAYY7w+1Ek=
X-Received: by 2002:a81:a008:0:b0:33d:8599:f7a with SMTP id
 x8-20020a81a008000000b0033d85990f7amr4513236ywg.478.1661623903578; Sat, 27
 Aug 2022 11:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <YwniL0M7Rxz8lua+@debian> <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
In-Reply-To: <CAHk-=wjY6WuwQ3CSP1GDutLQ4GiQNE1FBms3hBO1PZDB_uwOcg@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 27 Aug 2022 19:11:07 +0100
Message-ID: <CADVatmMYgAvDUQSpE7X3rxZ-T2vTbDRLJe+v9M0krG5DB0i=0g@mail.gmail.com>
Subject: Re: mainline build failure due to 8238b4579866 ("wait_on_bit: add an
 acquire memory barrier")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Aug 27, 2022 at 6:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Aug 27, 2022 at 2:21 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > I will be happy to test any patch or provide any extra log if needed.
>
> This should now be fixed by commit d6ffe6067a54 ("provide
> arch_test_bit_acquire for architectures that define test_bit").

Yeah, it has. Just now tested s390 build with 89b749d8552d ("Merge tag
'fbdev-for-6.0-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev").


-- 
Regards
Sudip
