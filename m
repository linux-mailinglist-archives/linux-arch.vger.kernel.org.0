Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDFE3DBFC4
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhG3UZR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 16:25:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3UZQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 16:25:16 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MybbH-1n6EjQ1BVt-00yxAf; Fri, 30 Jul 2021 22:25:09 +0200
Received: by mail-wr1-f53.google.com with SMTP id h14so12753397wrx.10;
        Fri, 30 Jul 2021 13:25:09 -0700 (PDT)
X-Gm-Message-State: AOAM5315+rOt0KT0RFoRIqZvq6t91E8amaXdBcZtN6rWbeFkCm5IGtby
        FZkcotPGfV9eCpYfdaIZDIDyR2emDAYWJ7EhCzk=
X-Google-Smtp-Source: ABdhPJydjP+7odFyRa/w2F1ajXLQgnxb9It6F1g9WV5LDUJxgnSj2Epm5hz5bw27f5YBnQ21NajiiS14IFKwX0G87TA=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr5029131wrq.99.1627676708937;
 Fri, 30 Jul 2021 13:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <YQQr+twAYHk2jXs6@boqun-archlinux> <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
 <YQQ3KAXrPN1CuglL@boqun-archlinux>
In-Reply-To: <YQQ3KAXrPN1CuglL@boqun-archlinux>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Jul 2021 22:24:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_pgtUWrg-MpaVyVqhffeuvQECHCmSCLyudfSwuEcP_g@mail.gmail.com>
Message-ID: <CAK8P3a3_pgtUWrg-MpaVyVqhffeuvQECHCmSCLyudfSwuEcP_g@mail.gmail.com>
Subject: Re: [Question] Alignment requirement for readX() and writeX()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fzDyyLeWbcAxAmieJIsO2gKWi+iVo3SuUeVgP2Aw5YwZqkIn/CF
 hdjJelbJWEroTKziLrdJilr1/m6bI/VyAz71UqDbpSYConiJgu9e4Y2fka2AS4w59/0yioA
 OneuED3Scvy7mFJ0X6OcyNOZ7K9BBe6Qhw2fzpbl31Yfg2izO2TGVFIi76VRBpLnlTT33kw
 LHwkB6sqySMAWdPDhTSMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uYtGdo0JCuM=:eYOiOLqbHDJ1V665Pj5vX8
 E4jyj/oyr7GVQXGRgYjGyBDya4pZ1UjcRmWw4drs8PzN4qt1U9oQn8T2v2gUVjTuY1MW1XDsY
 TqgmUsff5H3rhFawLn1Ikl715mBIqqBFdN3dOD+tIKbfVwMYEJqF+Z/E/gV3GMcoqp+8YDXTA
 byXoyIUmND+Dm2sNjFNbnmxu5zQASKcdgX17OOxfcUAJdssTQ5p5rPrj3pqUMm/WwDlkndblx
 YHu2/ahsV/TrCCASGrkB89aWSK72c/XuECVwFpx06IKEeTtu1o3zOkMNMgn7iDJ2sKIsiVn/T
 20H9dvErjG54uFd6rpLild7mjbSC1T5viNclI0wLA4sIXfnZjrgrIsM/h8JO9xgXeBlJOsWC3
 jOMkaf4Ih9R/uixtnzWmwZO6Y5aO2nXwrdSM1dvowT+HP+1APPR/nomCDylBnGyJs95YtqINa
 0PhXc7ErzbX/EbOPSlYmcll7sIoo2XeeCATi8/JkrWwmtXtdteVRLHG2ME0qVx5qLzgmD6RLK
 CPw16TueaWrV20KNOLTeTBsC9qdkHk4LKh29RKSSlBV6kyNH1KIgM5xDfN6oAreC0jsF/o2lG
 m0f1JmczU3WMMHc2AazGLRFnw0IIxDPlSE9DQ/Neguz/8hie7Ft3rGyNOBEf1nvyRbnPjPsct
 uea1KxHHoVBYES+iyirv4ZFbMcgRXGkQbvn7bO7JCCtJ0xF8iZSy4YpqwDHmhSs0RpzhRjznc
 qaHQQN2FRhs5osVWPzQEKXuK3hqDSwvwGHlmnJlZrxe0UU+FcLWdOYbXTBKJCumxSsOflTlpP
 iJBRqb8CyEqxJU3kwjJ1E/Rd3ZGuaOFiLCVbSswRwrwqNg60bkWUDHVoZbBP4aUs1vRa3qG
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 7:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> On Fri, Jul 30, 2021 at 06:58:30PM +0200, Arnd Bergmann wrote:
>
> If we want to check, I'd expect we do the checks inside
> readX()/writeX(), for example, readl() could be implemented as:
>
>         #define readl(c)                                        \
>         ({                                                      \
>                 u32 __v;                                        \
>                                                                 \
>                 /* alignment checking */                        \
>                 BUG_ON(c & (sizeof(__v) - 1));                  \
>                 __v = readl_relaxed(c);                         \
>                 __iormb(__v);                                   \
>                 __v;                                            \
>         })
>
> It's a runtime check, so if anyone hates it I can understand ;-)

Right, I really don't think that adds any value, this just replaces one
oops message with a more different oops message, while adding
some overhead.

        Arnd
