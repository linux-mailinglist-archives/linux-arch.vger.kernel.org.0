Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894E39CB3C
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfHZIDo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 04:03:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37813 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHZIDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 04:03:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so13370893qkm.4;
        Mon, 26 Aug 2019 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9WmdFRMJa7sCCIgAvCuC7Y0ayc92RRMOTHf0AFVOsB4=;
        b=hjLmh1l0PH6+OCtiZukj8qCTTPxtcbyQLCoRj3PDuhnLg7LMEKoUv25sj+qHt99CA8
         /9FAvgY31UpiNH4zmhPFTcLiC1i4mXin976/S46Ls3ct/UINT+pkYhr756uf6b0+mvCT
         gCYPaoFTk1/+hq9ZN7GzLptaA1C1OqEIVxzNYZhzePyPAdo03jhq5MUrW+lQo7G1y3k2
         SFVbYHyzm5Sr+j2xVZeeN6vaTy2Mo/kdtrp72LJmXrukKdlR2CH8dCra+z7EgeFWIoWM
         BFw6opkCP9fkWadA2dDXgOjsKKIgypPknsMYBC2Yqgdc/cSWYNzGJ5hCDe2WLQy3dyOg
         qxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9WmdFRMJa7sCCIgAvCuC7Y0ayc92RRMOTHf0AFVOsB4=;
        b=CaJR+5mM4udKKn4mt06O0joNAiBFBSFwgvDRKEpc7iFCTJj20XdcGk5k5CwVMyFQCK
         HuUMVoPQYx7SB3HHo/hRHvw6mdyK+kR6j4/cylXxw/16TZaSdITktXZ9fyweSeekvdsO
         lsRGVa1OtuuZOoRjsEKjT5uJe8AMQfZhrhQQPFxyX9W/ZbTlXmW6Oe/b9//7zbYT1qjy
         rpA/DjT+AzXv6qF3Gi9k/DmMTCf+dTCihKTg7nzigOPqHh+chnABmqvttTMP54oFvkXL
         54uAKzP/EeXk1l83kaKmmkqLpBRKLgKt2ToXGYcZcWmDIscHOBj3x63ppKerYVlhPGFX
         5tlw==
X-Gm-Message-State: APjAAAVLaTiqbPRD+EWLtfB4BtUg1hQNsSeSX6t2JrCATIEWrcEjHnU/
        gVfEWNc7ppktYyPclmAIXCcrb7KJC1EJQoRAKvXvLEeXinY=
X-Google-Smtp-Source: APXvYqzAIrFcrQO5fBz+71rvYvLaxrpVM5bDSjpPpNr3XWFmfg1dE/uBhtyJb3PBjFZdbejw2RPeUafB4LJIAT54Bxc=
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr15005145qkh.232.1566806622322;
 Mon, 26 Aug 2019 01:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566540652.git.han_mao@c-sky.com> <820d80272fc5627b8d00e684663a614470217606.1566540652.git.han_mao@c-sky.com>
 <CAEbi=3fbe9zbsLyfA=s9gHtAFJrp5Ox0jWoAqcZudQ_xODicgA@mail.gmail.com> <CAJF2gTS80XU=4z-_=N=oGV6GH-+8KXCa74DyhVMcRxJRBq5g4A@mail.gmail.com>
In-Reply-To: <CAJF2gTS80XU=4z-_=N=oGV6GH-+8KXCa74DyhVMcRxJRBq5g4A@mail.gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 26 Aug 2019 16:03:07 +0800
Message-ID: <CAEbi=3dtDy=CMRagVrj0ihtpYqS+4NkK7eYmn6Gn=2bV9khWVg@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] riscv: Add perf callchain support
To:     Guo Ren <guoren@kernel.org>, greentime.hu@sifive.com
Cc:     Mao Han <han_mao@c-sky.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

Guo Ren <guoren@kernel.org> =E6=96=BC 2019=E5=B9=B48=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Please check CONFIG_FRAME_POINTER
>
> 1 *frame =3D *((struct stackframe *)frame->fp - 1);
> This code is origionally from riscv/kernel/stacktrace.c: walk_stackframe
>
> In linux/Makefile it'll involve the options for gcc to definitely
> store ra & prev_fp in fp pointer.
> ifdef CONFIG_FRAME_POINTER
> KBUILD_CFLAGS +=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
>
> So --call-graph fp need depends on CONFIG_FRAME_POINTER.
>

I am pretty sure CONFIG_FRAME_POINTER is Y
# zcat /proc/config.gz |grep CONFIG_FRAME_POINTER
CONFIG_FRAME_POINTER=3Dy

This is not going to go wrong every time, the probability of error is
about one tenth or one quarter. randomly
There may be some conditions that we have not considered.

I add one more condition to check if it is a valid virtual address and
it( ./perf record -e cpu-clock --call-graph fp ls) passes 1000 times
without failure in Unleashed board based on 5.3-rc5.
Here is my patch. Please have  a look at it. I am not sure if it is a
good solution.

diff --git a/arch/riscv/kernel/perf_callchain.c
b/arch/riscv/kernel/perf_callchain.c
index d75d15c13dc7..4717942435df 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -18,6 +18,8 @@ static int unwind_frame_kernel(struct stackframe *frame)
                return -EPERM;
        if (frame->fp < CONFIG_PAGE_OFFSET)
                return -EPERM;
+       if (!virt_addr_valid(frame->fp))
+               return -EPERM;

        *frame =3D *((struct stackframe *)frame->fp - 1);
        if (__kernel_text_address(frame->ra)) {

It could catch cases called in this way.

[ 1381.936586] frame->fp=3D:ffffffff00547550
[ 1382.038542] CPU: 1 PID: 135 Comm: ls Not tainted
5.3.0-rc5-00003-gb008f6bcd67c-dirty #14
[ 1382.307440] Call Trace:
[ 1382.388947] [<ffffffe0002a2d8e>] walk_stackframe+0x0/0x9a
[ 1382.568053] [<ffffffe0002a2f5a>] show_stack+0x2a/0x34
[ 1382.735960] [<ffffffe00083dcd6>] dump_stack+0x62/0x7c
[ 1382.903863] [<ffffffe0002a49e0>] perf_callchain_kernel+0xd8/0x102
[ 1383.106558] [<ffffffe000340a6e>] get_perf_callchain+0x136/0x1f2
[ 1383.303128] [<ffffffe00033d480>] perf_callchain+0x52/0x6e
[ 1383.482553] [<ffffffe00033d50a>] perf_prepare_sample+0x6e/0x476
[ 1383.679357] [<ffffffe00033d92e>] perf_event_output_forward+0x1c/0x50
[ 1383.890633] [<ffffffe000338b4c>] __perf_event_overflow+0x6a/0xa4
[ 1384.090279] [<ffffffe000338c40>] perf_swevent_hrtimer+0xba/0x106
[ 1384.290094] [<ffffffe0002f307c>] __hrtimer_run_queues+0x84/0x108
[ 1384.489694] [<ffffffe0002f36b8>] hrtimer_interrupt+0xca/0x1ce
[ 1384.680974] [<ffffffe00072f572>] riscv_timer_interrupt+0x32/0x3a
[ 1384.880449] [<ffffffe000854b34>] do_IRQ+0x64/0xbe
[ 1385.036698] [<ffffffe0002a1c5c>] ret_from_exception+0x0/0xc

[13915.697989] frame->fp=3D:fffffffffffff000
[13915.799937] CPU: 2 PID: 663 Comm: ls Not tainted
5.3.0-rc5-00003-gb008f6bcd67c-dirty #14
[13916.068832] Call Trace:
[13916.150380] [<ffffffe0002a2d8e>] walk_stackframe+0x0/0x9a
[13916.329450] [<ffffffe0002a2f5a>] show_stack+0x2a/0x34
[13916.497360] [<ffffffe00083dcd6>] dump_stack+0x62/0x7c
[13916.665265] [<ffffffe0002a49e0>] perf_callchain_kernel+0xd8/0x102
[13916.867949] [<ffffffe000340a6e>] get_perf_callchain+0x136/0x1f2
[13917.064526] [<ffffffe00033d480>] perf_callchain+0x52/0x6e
[13917.243950] [<ffffffe00033d50a>] perf_prepare_sample+0x6e/0x476
[13917.440759] [<ffffffe00033d92e>] perf_event_output_forward+0x1c/0x50
[13917.652021] [<ffffffe000338b4c>] __perf_event_overflow+0x6a/0xa4
[13917.851683] [<ffffffe000338c40>] perf_swevent_hrtimer+0xba/0x106
[13918.051494] [<ffffffe0002f307c>] __hrtimer_run_queues+0x84/0x108
[13918.251094] [<ffffffe0002f36b8>] hrtimer_interrupt+0xca/0x1ce
[13918.442379] [<ffffffe00072f572>] riscv_timer_interrupt+0x32/0x3a
[13918.641840] [<ffffffe000854b34>] do_IRQ+0x64/0xbe
[13918.798082] [<ffffffe0002a1c5c>] ret_from_exception+0x0/0xc
