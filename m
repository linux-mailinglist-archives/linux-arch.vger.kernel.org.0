Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BAE53BC85
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiFBQ32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbiFBQ30 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 12:29:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F22612A0;
        Thu,  2 Jun 2022 09:29:24 -0700 (PDT)
Received: from mail-yb1-f172.google.com ([209.85.219.172]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKbwg-1oDEcg1mZQ-00L1f6; Thu, 02 Jun 2022 18:29:22 +0200
Received: by mail-yb1-f172.google.com with SMTP id p13so9233631ybm.1;
        Thu, 02 Jun 2022 09:29:21 -0700 (PDT)
X-Gm-Message-State: AOAM532a93TmUGNd6iIyeTE4VKNUwpbrxZQaW0d9h1CefBy4jB2M2hKr
        O/2URZAhT6BrzNvQD0HZAdFSKOuI7pbx1VdV/Co=
X-Google-Smtp-Source: ABdhPJwP5jTmDmnjC7cLxXQtoGkT8BZ75OYKH3xGYjmaKjlmC4WfmO4BaZj5D5FasDHcj719xc61DL7YDK73tV843fE=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr6098775ybf.106.1654187360931; Thu, 02
 Jun 2022 09:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-12-chenhuacai@loongson.cn> <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
 <CAMj1kXE1Gg+jN0yGZCi86HQBPrtX=-EHjMW9Z9XxsobH=RS0LA@mail.gmail.com>
In-Reply-To: <CAMj1kXE1Gg+jN0yGZCi86HQBPrtX=-EHjMW9Z9XxsobH=RS0LA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jun 2022 18:29:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2dv1_vtg2k8ifxD+XAJX6SZEYRsCt0W065yDA9gmssmg@mail.gmail.com>
Message-ID: <CAK8P3a2dv1_vtg2k8ifxD+XAJX6SZEYRsCt0W065yDA9gmssmg@mail.gmail.com>
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DnVKkGncdufV9sCWB9XsY0zExdcMqqK0gYhTR5Y7fqeqsS+pFHH
 vq9xR3UE4klYfFmK3lSqXaXobkAEYeZpUqf5YonXIQqVn3ZFniKWYfqM2kzdcgdEj277Jkp
 +y38opr7CQeSqSZ9ETMydpFdHjNLu8juY+904NNh5mP7rc1pnICHe77IIbcdwy1AUJd7AIb
 jBH+0JHFeLBrultUIFT9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:947M/0Jq/qc=:ybRHRJxH6J0Tk7+ohVyUHG
 uZLRrgz/vrj5ET6MPpMAy3+BVehxgj/HtRt4QnsMB7l5buEKitILKa9tqd62XSqkff6wdehSr
 LiypoYzjeq2K7ZPlixK0fcpLnojca4WtLZ0e13OeHQXSV+nD/MpSevejyoKnVM0xYRjAGy/mS
 PSAvoU5X71OxlQZuNO6ETJBU65LLbVxxSU9NS+ep3fn3ttLzDtPlHgZpd04vuT5gtWFOtZaLC
 o2zAAcgXBqY/TliRwdMQhEQ5UmpZnSlr1nhP7hJjLXGrF97/KxeMw47e+gpwyiCuOoIperF7i
 QrTFQ3ZN/RLIqZZAMeJpMSY5BNNCeQ46Oy8NVPd2YB0U7wdHFTk955NqC1q8kPwKHpoae8VN/
 LgZNgY3Fv/cMFUyqyfevdYKq8h0KuLAwOqORvy+fqvOiewabiFW09pS8t9+vm/RCeteu3r1wF
 X+BywKue3E3yNE5ojfcx/o9RqiBUVL4kaNZ4vwIP/pzDdIbDrc4tB2gf0our8PrPIerDILq+v
 Fhptk5hAH2wvrZCmLlgyRe8CPR5aZ7Ge2fFx/6IGByKEq8e2cKwvLp0u1KrRqoDTnZQQDTpym
 UfAh8/ndO0XZU8ObYkkl6AnadfLBYyKlb9kxUDlm32xmMboQuSz9xQs4BlEQdEIU+e86R04xs
 4JZkPxgxEcELEukJCAJJJgSG0d/BUj2r2LeeFkus+n+3VGsCRbCgHj0Bpms1k6zE3ke1w0RwB
 dlVXS/RBLYyR0iYvmFlRk60YtNK6I0leZxdiehpCafhr/3uMnYIT9JHzCs00hW1UU6Xqr1ekN
 FKwNXORm9wqhlffsmVMbqF3KiL+5O+vnmwaBUtIEwXAQVZKEKxP2S4mH45LiwAOP75VjvVqbK
 wY8mi3r/SLjdrUJiHMnw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 2, 2022 at 6:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 2 Jun 2022 at 16:09, WANG Xuerui <kernel@xen0n.name> wrote:
>
> > For this, I don't know if Huacai should really just leave those
> > modification in the downstream fork to keep the upstream Linux clean of
> > such hacks, because to some degree dealing with such notoriety is life,
> > it seems to me. I think at this point Huacai would cooperate and tweak
> > the patch to get rid of the SVAM and other nonstandard bits as much as
> > possible, and I'll help him where necessary too.
> >
>
> I don't want to be the one standing in your way, and I understand the
> desire to get this merged for the user space side of things. So
> perhaps it is better to merge this without the EFI support, and take
> another cycle to implement this properly across all the other
> components as well.

I think that's ok. As of today, there is still no working interrupt controller
driver because it hasn't passed review yet, so there is little value in
merging the boot support.

The main point of merging the port at all is of course to allow compile
testing and building userspace, and both can be done without being
able to boot it.

If Huacai is able to produce a tree by tomorrow that still builds and
leaves out the boot support, I can send a pull request to Linus and
let him make the final decision about it, but at this point I think there
is a good chance that he prefers to let it all sit for another release.

If the port doesn't make the cut for 5.19, we can still debate with the
libc maintainers whether they want to merge their side of it anyway,
given that the user ABI at least is now as stable as one plan for,
regardless of the upstream state.

      Arnd
