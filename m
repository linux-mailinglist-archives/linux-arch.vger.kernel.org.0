Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950BB5A0562
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 02:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiHYAww (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 20:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHYAwv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 20:52:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027F55094
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2022 17:52:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so24125038edc.11
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2022 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
        b=YpSDVkBcxWVnnXfQXF/M7AZGWY5x+V+c24wMO5zVR8RFtXivElwnk0FLNTXke/emLT
         oh8/MGX4jyRJc+YrZXh96+Jtsdh8UfgCE6n4YSYTOMmu4AtkTQJ7laVjSVHJm8+QclNG
         oVzUJs4I5lvMg1LyJ9KO0CmiPyQ9FIcsSPJtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
        b=CVZOMXatKRX5j0GqtPR0YM6Kyk/TqCqcel2Fna+hXjeIsvutIckj7zr3uS1L+ZpcyG
         2ge/uaqzgNXqMEESBf7JmkQOQa8kTolqbJ/ll2HBROx+aJozj6MHEnsXqEIFnDSzU1NK
         PJ4+6jxyLhWUszvXhKaD97zWNbsBwlLL7KN3D18r08kbr4aGDp0Sv1uipjYAW1wF6mGv
         8FPzWaB1f27uJnR/LFONh9XROSiNblEZCAbYOoN3mgWmKG/IVHvTIyPcbsKQJ3McxJiD
         ioMkH+pcsEIQ2Tw1HTkZKscTpB8IUyxuCd+qOuRAxcnLKo+Pd3Yx3iuGoFw0o4o7Htug
         7Xxg==
X-Gm-Message-State: ACgBeo0jSi3H9ovGJcLZg6ve4GhVATUDfBjrtl+FXiL2U/trTofvdrSM
        M9AGFpKL4X2YknQdx7O5svtJUc1p2jLQNp/g
X-Google-Smtp-Source: AA6agR6LRILRz+SLQeTDujRZI/P/AtC3uO34ja/zF7U6OX+oOFLxsX/yW3MltHlWZhCwHU378N3tMw==
X-Received: by 2002:a05:6402:2549:b0:447:1cd7:7537 with SMTP id l9-20020a056402254900b004471cd77537mr1221845edb.422.1661388768481;
        Wed, 24 Aug 2022 17:52:48 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906310300b0073d65a95161sm1717218ejx.222.2022.08.24.17.52.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:52:44 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id d16so17402369wrr.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Aug 2022 17:52:38 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr764111wrn.193.1661388757863; Wed, 24 Aug
 2022 17:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
In-Reply-To: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 17:52:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 24, 2022 at 4:36 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> I'm trying to be nice, and ask for review to make sure I'm not making
> some big mistake by accident, and I get disrespect?  No thanks.

You've been told multiple times that the kernel doesn't use the
"standard" names, and *cannot* use them for namespace reasons, and you
ignore all the feedback, and then you claim you are asking for review?

That's not "asking for review". That's "I think I know the answer, and
when people tell me otherwise I ignore them".

The fact is, kernel UAPI header files MUST NOT use the so-called standard names.

We cannot provide said names, because they are only provided by the
standard header files.

And since kernel header files cannot provide them, then kernel UAPI
header files cannot _use_ them.

End result: any kernel UAPI header file will continue to use __u32 etc
naming that doesn't have any namespace pollution issues.

Nothing else is even remotely acceptable.

Stop trying to make this something other than it is.

And if you cannot accept these simple technical reasons, why do you
expect respect?

Why are you so special that you think you can change the rules for
kernel uapi files over the *repeated* objections from maintainers who
know better?

                  Linus
