Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E754FAE1
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383150AbiFQQLO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383187AbiFQQLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 12:11:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF753B3EB
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 09:11:10 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoOpq-1nMI2X1OtE-00ojfO for <linux-arch@vger.kernel.org>; Fri, 17 Jun
 2022 18:11:09 +0200
Received: by mail-yb1-f181.google.com with SMTP id u99so8004164ybi.11
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 09:11:09 -0700 (PDT)
X-Gm-Message-State: AJIora8B9zmaPmJyA9+7rqe5VRzRmJdCZ3qgl6h7XKGtx9X8kDtbjet1
        +8W5LVGpH0FsUdSUrN4RHH6/VHl3hS0bWuJmqak=
X-Google-Smtp-Source: AGRyM1sbbvu9586IFsDKfhRXyuh39sqCv/fj6t9J7hwRcICdNbr1TowZgPSHRclPKN99FLzQu3aGwMo5zUy9wxfXsRc=
X-Received: by 2002:a25:ab65:0:b0:668:b6e6:b2e6 with SMTP id
 u92-20020a25ab65000000b00668b6e6b2e6mr3862998ybi.394.1655482268119; Fri, 17
 Jun 2022 09:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
In-Reply-To: <20220617145705.581985-1-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jun 2022 18:10:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
Message-ID: <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bK+ZT51Dsrv76DxP+EEPoPNPbE27jgOzbZPSHJw8eSi371W98zr
 UTsgLO2+wMNSIMLHX1csICKft7MW1xuabFXWsr4WE2iSQfBEz9tAuYGnonF0cfCjkK7vC0L
 t7qQR+Z3WL3Y891IBGYrbRZLcl2UO+bHNZx96/+kTeEq5YJAuXwiHKs9qXwxVFjVdA5g1YR
 zo3cRoq/67/qy7kW/+EkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdb0WFG2ntc=:3jzuRl9dHoa65awIvo+cS7
 WZ51aipbZDd1ABunRpb8f8ansC8DqMoysesjevBb7ZMrPlIIuLJZEWii7BLaA1czZUS8vt8gG
 ZVzxxHVQwjHcO/dhj8qtHEE++WWb039Jm9ufn++Ofw3V4CFGOGIjq0WhjHPwKR7FwG5D3SafK
 /InAVwPOknNzxrGzRQ4Zgkc4m1vD8hyznwOPsSvOVinqNp5Am+XlXY91hQq5dTcdU3C8Y9zzZ
 Pv9sMQ41zD37wIfL9IUxUMIfHejHrSAVjcXZN62fjSzxajBtQxTqhvjOiptiMrCLiSFshppc8
 ywUTj21WUH88kXRlMikgQKCQH+AoD50E4zXrhoxBuxClva4Jiz8FVo+vMacMD2qK0oFSDyzsj
 Bd6rph2PNJTSHO92cy34AGp3TJLxa7uG/v7kq2IqV3ulCWYwlR8M8Up5rEoRj8J64QAQ8z5ll
 d08B3oN5rMLAYRzDzX8tVCI9+DSAvaV2NcMsCMFB5xDUq04W/04u6w/sAniPlYz0F1LkQ9sXg
 sdjv1D5oDp5jgPbE3IZLNsQn4XfroaEULUSCrb19EtFzstZSN4TJ3aQyBj0My53WnBC6JD2/2
 IPUQdKcOqFXtiAdf3vZQqPFNEGlzpCyXmdWh4gxGM6RWz8Y8t181J0QB7khiiUFmaVej14Csf
 LwgqdQgnVBgdnKoxjqaJ9zOM2bPfr+qOJV/nbh5hnD4mpGKrS3QpT4inST9rrAZLOg1HfSrHz
 B5r27X/TTko3vquaGjq90sEMXyeOw9Iqu7pNkCQlewoD/MyCgNrlYgmHAuYaxxHLpbKyLBAkg
 4xqYMEm06LZoffCXS8zfaUJgKeb1C/vPphjBXJyWV4dothqCdQIn7epVnObE2RqwaKwRzPDah
 eBHE/5f8WLcQCeZvNNelA2xa5KgohS+fliEOawGCY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 17, 2022 at 4:57 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> On NUMA system, the performance of qspinlock is better than generic
> spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> per node, 32 cores in total) machine.
>

The performance increase is nice, but this is only half the story we need here.

I think the more important bit is how you can guarantee that the xchg16()
implementation is correct and always allows forward progress.

>@@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
>                                                int size)
> {
>        switch (size) {
>+       case 1:
>+       case 2:
>+               return __xchg_small((volatile void *)ptr, val, size);
>+

Do you actually need the size 1 as well?

Generally speaking, I would like to rework the xchg()/cmpxchg() logic
to only cover the 32-bit and word-sized (possibly 64-bit) case, while
having separate optional 8-bit and 16-bit functions. I had a patch for
this in the past, and can try to dig that out, this may be the time to
finally do that.

I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
but you only implement the one with the full barrier. Is it possible to
directly provide a relaxed version that has something less than the
__WEAK_LLSC_MB?

       Arnd
