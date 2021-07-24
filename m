Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFEE3D497F
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGXSn7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 14:43:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGXSn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 14:43:58 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MS4ab-1lfUZD3CQ7-00TSrH for <linux-arch@vger.kernel.org>; Sat, 24 Jul
 2021 21:24:28 +0200
Received: by mail-wr1-f54.google.com with SMTP id j2so5993005wrx.9
        for <linux-arch@vger.kernel.org>; Sat, 24 Jul 2021 12:24:28 -0700 (PDT)
X-Gm-Message-State: AOAM530ErJsv9SnkGKkYx68gRTriwqCpKFDmc4RATmIxBDExlw1DExZO
        F89Vv35aMMSEIdd9XoQozZ2I8pWFIu01ONMOdj8=
X-Google-Smtp-Source: ABdhPJyBSH8BNtz2Z2nrm5CaSL5bshvHAz2MY2baGyEycBv8w+fanEvIeL4suL/IR6VKhZ+LiFPRF23EnKh4CkNbfms=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr2000001wrr.286.1627154668456;
 Sat, 24 Jul 2021 12:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
In-Reply-To: <20210724123617.3525377-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 24 Jul 2021 21:24:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ZabB0cBR_SnOhi2=qxdQOYPGPEJeOqV0em1+bsvZKWw@mail.gmail.com>
Message-ID: <CAK8P3a0ZabB0cBR_SnOhi2=qxdQOYPGPEJeOqV0em1+bsvZKWw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LUcaR4q5yPJazH8VBvF/l/+9Ul5qh2yOexpPe7acKvsLWIdyOPx
 wvxvBubTm+UkmXZizwgHAfgMQibYL0j0mUcHIupZ2OV0IQ7BN2NtaF2KuMl8HbS1INhlz+e
 9BlBaxlucmhuOtls6PLwFCuocHkE1zCiwL+KMtpO03Oa9Qb05tsBQ1d0zbmGfuNpfopIlI3
 wev3tUeckICb4yOffI1aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/GDCyZoh9U=:hlXil2fqOpHpzc6pfQgt5U
 o6wZ+7sTgPp6fqJohhbBpObg1gr/lAAoHiWaEMEN2GIhilsFEHsY7DZm/w5brUV55RXUIGzxr
 UYWPoNpwarPxTArGo4NqepjuTsh3qnOGN9cYnUlc3MWj9r3NT7kPZMl0PXwrwaTGz2s8JC0YB
 v9ueEEoBtI/ghiKxTeY2BQWTUt6Za41ivWGPwOC6Tu7xXP0PvwPD0fqfAGHQXAXgJQ2DLaCB4
 YClRuvgZ/Z+EesUHXuB+M980g8waQ8WIbzR5ReNkLKTvbIIVD+tYfqTtZb8iy1jM+8/a1+kBf
 uqBYV2O2y3gBNsMLUVVFS3OBuSI7picHdaxmp/ikkZpFnxrsATgX4vyTgJpaJ5em30tN5SHD6
 HwzYqUqNwu9qJbLa1F0GGYxWjgT4ZPQ0BG1pH24URk2IQsYsk6JBg4i/S8pWQ0tIHRdaGTgGj
 dTHIfMI0cMpsl5wFqP6g2OhlpgoV717L5vMPZreAOfCUzoupDQomzHLwUJaVbnWZyEqSf7sj5
 u1l4l/iuyNGRPc6CfbOmP3gzAVuuD2Z7ptDypu52iU03SsQ4PrJ6pbfnK0zFiyUxD1/esXM0u
 zDi2dRlwTaqUdm8Jq+x2lQdMxHwqd/W3x1IHqDZROmuLDTDrQNbw+ByGdLyTltaVd+DijH5/g
 8W2BoD4kNqTcgo2WDF9JIrp9PmfliRKSRxr5pjohj2YLm8hGZ3krIpeyjkyx0Pv+8JZslGvF1
 3FZ/APe3Ggbfwv2cvUxxTJXOHbD/dnqbCqTkr0+WJPfPb/uaNE8GXPaeuwiCnXcJ45MxgQLZ5
 465W1s6ZV/WaUcYza4l4qWHWLrOqNCEwxtoy/jrPmV9vWz0HLoR4Wa2h75NSYhFJXkcTfR0kr
 fPpd+QRCGUA7zXdoBH0od8Yu2+ZIPq9fj/i6+TZHmEJ03KqI+ADjz5oUUVcBjqW70X2YxunMZ
 nhnU6iubCXxk6Tmfcnrr4ba3MDyHCnIlZPH91KhBaPyzSN6N1sj5k
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> has hardware sub-word xchg/cmpxchg support. This option will be used as
> an indicator to select the bit-field definition in the qspinlock data
> structure.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Adding a Kconfig conditional sounds like a good idea, but I have two
concerns about the specific implementation:

- I think we should have separate symbols for 8-bit, 16-bit and 64-bit
  cmpxchg(). I think every architecture needs to support at least 32-bit
  cmpxchg() and 64-bit architectures also need to support cmpxchg64().
  I actually have a prototype patch that introduces cmpxchg8() and
  cmpxchg16() helpers with the purpose of no longer supporting these
  width in the normal cmpxchg(), but that is mostly independent of
  whether we want a conditional or not.

- If I remember correctly, there were some concerns about whether using
  this information for picking the qspinlock implementation is a good idea.

         Arnd
