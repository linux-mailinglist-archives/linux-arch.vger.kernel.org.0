Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE657788CD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjHKIOH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjHKIOF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 04:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3552E40;
        Fri, 11 Aug 2023 01:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3980566C38;
        Fri, 11 Aug 2023 08:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7A8C433C7;
        Fri, 11 Aug 2023 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691741644;
        bh=u6fedBM9agpcTxzP58hu43k6kTnun9wA5e3PHON/06Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BlW8bUif/oTaTotkaTHv2LA1YzD/ucVAjurIWVqPezwywEibD/bOhL58GIRiXa84G
         A2C+V8bRr8zekOtjT33dUnJC8aCCNvYRsKnMfv/Q7Df1JAbHFya5pxWTfEG04CpYsg
         HRjT1d4VscxPh6Xw/bJfujvLfhIq7nHmXocMzlMNG6eb7/7mXZVK87LPLmzQHc08M5
         mpy8KuSBeC8Z4z037/7gMesnmHe5bi9ZKrjpGqAw/5MhwCovpQJa2suvjd2WBcJEcs
         OgAvGhdm4VCerYeggtiA9gi828ewo9joMUxzwu7Dfq6O0bwdJxzLVoC4GMb1HS90Iq
         CViP/coKGmVOw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so2124858a12.1;
        Fri, 11 Aug 2023 01:14:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyv2OxvAQGOxZme7J2DN6gaJ0tUCt5t3rSA7Z24VDgvexBa0vEu
        Kp3VBg8zOsnksHIhz00fbdkhrJTqCH9JBbeLsAg=
X-Google-Smtp-Source: AGHT+IGAmP3sn0k5vf+8I24TmrkwhkhrAuPpXvWjZxe9a0CQ/MrG2MfyK6uVRzN32dMmeomcNvtwIlvxsyqit1ZiJ2M=
X-Received: by 2002:a05:6402:8d3:b0:523:38eb:395d with SMTP id
 d19-20020a05640208d300b0052338eb395dmr1091985edz.9.1691741641195; Fri, 11 Aug
 2023 01:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230811030750.1335526-1-guoren@kernel.org> <cf25b0f4-ee4b-40bd-a928-afdc4cad5c2e@app.fastmail.com>
In-Reply-To: <cf25b0f4-ee4b-40bd-a928-afdc4cad5c2e@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 11 Aug 2023 16:13:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ9vJZrDJ32nzq67XmYOqtXjYdsx=L2ob9yGP94fM-G5w@mail.gmail.com>
Message-ID: <CAJF2gTQ9vJZrDJ32nzq67XmYOqtXjYdsx=L2ob9yGP94fM-G5w@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup -Wmissing-prototypes warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
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

On Fri, Aug 11, 2023 at 3:33=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Aug 11, 2023, at 05:07, guoren@kernel.org wrote:
> >
> > Link: https://lore.kernel.org/lkml/20230810141947.1236730-17-arnd@kerne=
l.org/
> > Reported-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> Thanks for addressing these!
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> > --- a/arch/csky/kernel/vdso/vgettimeofday.c
> > +++ b/arch/csky/kernel/vdso/vgettimeofday.c
> > @@ -3,24 +3,35 @@
> >  #include <linux/time.h>
> >  #include <linux/types.h>
> >
> > +extern
> > +int __vdso_clock_gettime(clockid_t clock,
> > +                      struct old_timespec32 *ts);
> >  int __vdso_clock_gettime(clockid_t clock,
> >                        struct old_timespec32 *ts)
> >  {
> >       return __cvdso_clock_gettime32(clock, ts);
> >  }
> >
>
> This works, but it would be a bit nicer to move the
> declarations into a header. I see that we already handle
I know you concern, but I didn't find a proper header file. So I
copied riscv solution, let's solve that in riscv first, then csky
would follow up. Thx.

> this in three different ways across x86, arm and arm64,
> and you picked method from x86 (and loongarch) here, so
> I can't really complain.
>
> What we should probably have instead is a new header
> in include/vdso/ that  declares the functions for
> every architecture.
>
>       Arnd



--=20
Best Regards
 Guo Ren
