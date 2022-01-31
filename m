Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8E4A523B
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiAaWTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 17:19:54 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:44207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiAaWTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 17:19:53 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8QFi-1nAHJO2u12-004S46; Mon, 31 Jan 2022 23:19:50 +0100
Received: by mail-ot1-f47.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so14447815otp.4;
        Mon, 31 Jan 2022 14:19:49 -0800 (PST)
X-Gm-Message-State: AOAM5300s7H3HiZT7/ALZlbQL4+XMBMcpcRCqxXse+CMwLgyREt7CTVh
        ReWIzABKLRLNgXPntwPlS7C6QAO1JxlT/LE6Q+o=
X-Google-Smtp-Source: ABdhPJzNvIQa/ifQ4mpIl/LfU521F5G6KLcdIXkWgKV/jA7MRG2n/k6e84fLlMfFqeGk7bXCvjxkFnVtwxdt/dBnQNc=
X-Received: by 2002:a9d:654f:: with SMTP id q15mr12902241otl.119.1643667588784;
 Mon, 31 Jan 2022 14:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20220131064933.3780271-1-hch@lst.de>
In-Reply-To: <20220131064933.3780271-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 23:19:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
Message-ID: <CAK8P3a1YzdC1ev0FP-Pe0YyjsY+H3dNWErPGtB=zfcs3kVmkyw@mail.gmail.com>
Subject: Re: consolidate the compat fcntl definitions v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Oz3mvogPccg/7xXrnVYc1t/5reQ5uLC3I9ySHFqCfH22nktDZk2
 GiO2dxDqCqyaYLIVwvk51XQiOo3ffvYcODm+qVyNbWffBolCk5kBCIdNwuJYUoz/U0M04P7
 YHPXOhWvKBhmn7zB1/uVYYlbhSUZG2fW6bmi32+wpXkhigUNfqpwvyzTmUcex77PxItycdN
 hIkWF+6OjrEKXlrkvjnAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aSNwj6GN85Q=:6u43FVFakJeCUyjujdXZAJ
 nH1Eb1BCXn0p06iSS1ZrO055xSbokdvwGcAVA5hsWPMSsXvKy87UdhVhRzrdb9Uqf8TSfGHWg
 m/rTBm4dsO9IxFqzCZBXGSz1a8FeujW//AujuH47pp41pjzE/CXFAukbGKA2gMs1idFSIbP4N
 YUuRhRON1JoIpyXjxfwSoBqeBH6Iw/7yHika7VEJf8kTLTt288ET8b+Y/3/dHdqYLqTJIpiby
 u+GSgygb0FARlJqqStxb7IbhwpPBW/F28dNddp/A5ETdLGn2UeGS5ILnDIEZpFwh3D5sYa3vw
 KvkxeMQD5RHL0RU6ABF3VwKCNoh+HbLQ1shYXxgqr/vVkCzEcEDvbMps/iCVjzlB1av/EiLMO
 3bZ7FjR4cmvVVEGsCy3pkZJodILX2o5u3fFzoRb3sUZHXtl0KrRCE5Y1KpSjEQ6yhhXBZpdI8
 wopTxBWbnQoinQjtRjMcROObLew2B4rJ6dBqJ7uAPiKXBPp031Kv0jbqAphCyfpS0pgEROnJr
 X70gzHhsnbhgAENY3wlEN5xEOuwVOU0PPuTptiZATzOYBUagezvXWz1RAYR+5/RMRhpQ2OJrA
 W1kH50NLO2Ar7eKx23ya8N8jQDQgb3PUHIOYVOeD1YQAl870H1Mosoh94GYKTaeieLlnKv0fj
 uurqEyb9ilCd/OB27VlNBel/Xj8IJKutEccZMwF+6plyO69uWSiaMhkEs9Zxhfskzk/E=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currenty the compat fcnt definitions are duplicate for all compat
> architectures, and the native fcntl64 definitions aren't even usable
> from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
> to sort out all that.
>
> Changes since v1:
>  - only make the F*64 defines uapi visible for 32-bit architectures

Looks all good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I think it would be best to merge this through the risc-v tree along
with the coming compat support
that depends on it. Alternatively, I can put it into my asm-generic
tree for 5.18.

         Arnd
