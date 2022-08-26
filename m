Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBECE5A318B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 23:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiHZVyg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZVyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 17:54:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE178FD3D
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 14:54:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-33dbbf69b3dso68553847b3.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=iD+oDgmA+uqkgZAjiZVwNKXzpAuCVIysHt0xaw4YizU=;
        b=Ca+dkdvTTZAOLDvgw3Z9TkaUnMZcEWn4NTxm5+zjenuU2n7vyLOc9KPh6+KdZ5gwBJ
         tn/9thf3hXLJO9QmMCTrPu9UeA9bqXKkdHcD3t26KAQo8P0j/mO2Wsp3546vXy2g5DVe
         7hsSOEj3K89mu/jqNLHDZpbjrvMfyUGLE++bdQHX7CDFGQhtlU3YxsNnf8kvVYpVHf5L
         lxVu/SLHlqgK0HT7NNi6O08XfosRfNiRI1W7yI7n62C0LRD+iwPjN2kz2hv3wdQVmP8E
         SrxuPd7hPHS0iDGfnSjx5LwMaLY9kxqbUtS5dWAWogDi+uOzyJWbWoS9ExFdkez6KFbW
         ThmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=iD+oDgmA+uqkgZAjiZVwNKXzpAuCVIysHt0xaw4YizU=;
        b=xGnrpRHd1yYuOePe3LLRMPqWFW51RhuDIYNMeD8ZTj3voXsf5a66dzLjbInuwC0hj+
         rwop30dx14JW6LKOd8273xbqxqPOPEwtqLk5mwgqCTiBaht4dUji1/e1gWJ4wazreC1b
         unmNCrwMW4n3t5lvI3P/3/loyfGkL37mSpmUHAr3qjw0NXWshKiSfLkbs8DQTR1fPCEn
         sL0/3w3FVuiuQ6uEKy1FVtO6g1eQtZVPUy8o8g7Emyv7evbQJdyJlg/YfFW0TVrPj1lD
         krs8d8z9G6FfYLms69ufp2tsHcWin3UXY8iwKvs29f/4qFZVsqHAiV6bpk5WNAKnsHrQ
         7OEg==
X-Gm-Message-State: ACgBeo1fwpdTG1F8lFmACq+mN/wJnhbe6ihmIBUkGO2blj27nWxycFdM
        B12bKMnKP+LK94tIkhiN3aS1/7rsVYSedvj653p0rAod1iQ=
X-Google-Smtp-Source: AA6agR6/Js/n7u8uAt+Vs5/9brwPzqXD8oV9j9u5xOFLL3KiwQvGzqQugDWZuWB0GKL5dR3cPMdqCyb0gjesC5DDHLQ=
X-Received: by 2002:a25:7902:0:b0:67b:d842:1184 with SMTP id
 u2-20020a257902000000b0067bd8421184mr1609196ybc.374.1661550874022; Fri, 26
 Aug 2022 14:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu> <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
In-Reply-To: <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 23:54:22 +0200
Message-ID: <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 5:08 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 26/08/2022 =C3=A0 15:49, Linus Walleij a =C3=A9crit :
> > On Thu, Aug 25, 2022 at 4:00 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >
> >>> Christophe? Will you take a stab at it?
> >>
> >> Which patch should I write ?
> >
> > One that removes CONFIG_ARCH_HAS_NR_GPIO entirely, then
> > allocate bases for new GPIO chips from 0 and upward instead.
> > And then see what happens.
> >
>
> Ok, I can give it a try.

Nice!

> But what do I do with:
>
> drivers/gpio/gpio-aggregator.c: bitmap =3D bitmap_alloc(ARCH_NR_GPIOS,
> GFP_KERNEL);

That's just used locally in that driver to loop over the arguments to the
aggregator (from the file in sysfs). I would set some arbitrary root
like
#define AGGREGATOR_MAX_GPIOS 512
and just search/replace with that.

Yours,
Linus Walleij
