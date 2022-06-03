Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA953CAF5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiFCNzt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiFCNzt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 09:55:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A313669D;
        Fri,  3 Jun 2022 06:55:47 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8hMt-1nsz323eld-004kMR; Fri, 03 Jun 2022 15:55:46 +0200
Received: by mail-yb1-f178.google.com with SMTP id w2so13840330ybi.7;
        Fri, 03 Jun 2022 06:55:45 -0700 (PDT)
X-Gm-Message-State: AOAM530pf02CCr0QLw3WcR88Z0E0BMzDVYXtSHMHIAQehWBwP7AkUVGH
        M7irxo9WlelxqK2AHaQQYKkPee1xTKYsQWKH9kg=
X-Google-Smtp-Source: ABdhPJxC8a//jZpW+Tqe40AHnrETDojO094jZBSMvfs2ZNCmTZdORB+VaBKeVWh3MSJ3f/9h4RRWtfj7GfdzA2eU+Zg=
X-Received: by 2002:a25:4f0a:0:b0:64f:6a76:3d8f with SMTP id
 d10-20020a254f0a000000b0064f6a763d8fmr10766571ybb.134.1654264543473; Fri, 03
 Jun 2022 06:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn> <YpoPZjJ/Adfu3uH9@zx2c4.com>
In-Reply-To: <YpoPZjJ/Adfu3uH9@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jun 2022 15:55:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
Message-ID: <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lLHJzLctb2egr0VusWGTbq4CmsQ2HTI4qMVu6c67kDAuoMT2upg
 s2zgQy9mKqadmMklt0KFb8nSDGgH9WEs9/GOV6CSiu2eTt2W54mnkmGrebbICvtirMmnoAQ
 c03JDtbqpUxF+Wtf0ps+FJJ35XG5X9zVGoNf018hrbyx2iZ0i1/Rr63EnR4tmd+3xP7mRCi
 fSLsB2R+5hnyRjNjYlgLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kOqhl7dYphY=:6PlfajxeB0rRAamELaOPGI
 7kpWipVMTE6vXC1rvOglyjMMRP3MVrF1M624HNbvMMLEFY+OVOi82Ts21RnCpBB4i3wbT3BJW
 JzJb/xM8X8StT+d/tyFhkFjUyX/HXhlrGpPICnFsW+3sGkGDo9ZwPNHE0oQN1Tir8In/A79qS
 jwZ2WOyzdNa/y2UUrNnAr228H6LJKtHihJ4i5ncUhGfN09d9+XwOfmV6lQFFj2ZToltvoeaoL
 gzfEkQysaXVcC37hLZrG1CKC0+SonOHQ88aAUrOFjTosNvbu14QozHLRP5U7RSiyOO9mw++N5
 zZNnh4MIBlG/nU2DDLPbDjFB5K6BXuerZtluMxXkeMK+vlmtIXszhDpOeHU0Jvd058TwSymvu
 Rm+ojAKg0RaUh7eXwqdDXM+wyAC9JmutPsb2m1w/+1QdYrN3my1UowQVIYm7QP3TfaFFp3HkW
 /pl+e1rvBG1qvK3v//RyIqprk1MkOZH82/4a5OmBjxQYC3MGrfNOAiAPHsMAQpfM6Gh6wdrw3
 GgEGVhH/FMc0xgw3oZBiGVTX01Jhyf63RoRl9hL1XehJjyoLE4rhVPr6IHC3lz3RYPddpwaAE
 FdPkWd0/4rpWv00T7NOeTYIPxJOCOFDaU5RwYlO9y+2gnsD+jWkx+tRvk7YXIYs6fP8clJ5/8
 QJ3l6Bk2gOTmLVk/GZos6UPaKgXaL4AV8i7ckj0rBYXTNnMEuYj1Da4hJwRFyuVHun0XTYjou
 k4a67id8HYMXHe00AD5mcQIuOjbbLAKWJXdn/c3LU2Qk+1Q+ArmzFpjAMZt/m2PtMrKHX9TCV
 UPThzvS82c4TeouYNRGnBW4ILeS58YVcCJA7N5qjDZkUhbl78wwkCBOE8RA3j9r2rlNeO5Er3
 m875alid2YF1G5qVfs2w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 3, 2022 at 3:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Jun 03, 2022 at 03:20:39PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
>
> "Currently only used on SMP for scheduling" isn't quite correct. It's
> also used by random_get_entropy(). And anything else that uses
> get_cycles() for, e.g., benchmarking, might use it too.
>
> You wrote also, "we know that all SMP capable CPUs have cycle counters",
> so if I gather from this statement that some !SMP CPUs don't have a
> cycle counter, though some do. If that's a correct supposition, then
> you may need to rewrite this file to be something like:

The file is based on the mips version that deals with a variety of
implementations
and has the same comment.

I assume the loongarch chips all behave the same way here, and won't need
a special case for non-SMP.

       Arnd
