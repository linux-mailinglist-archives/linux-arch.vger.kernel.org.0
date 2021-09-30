Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612AE41DDDD
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbhI3Ppa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 11:45:30 -0400
Received: from mengyan1223.wang ([89.208.246.23]:37122 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344638AbhI3Pp3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 11:45:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 17F2F659C3;
        Thu, 30 Sep 2021 11:43:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1633016626;
        bh=FMs1Fhsw2K98QlB0rPqFFGEgdRlNdvHCn8NhtpKTEws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yravmq85GEczVyiyS3kw3UN/+Os3oI44etkXNZCUyWBj1JxkGv8jPUO1MWKB6VW/e
         ba6Ld7lEMYQgXkoI63CEYMwmU06pRyRo+O32o3MrnBska6Dk71DgncIDjgtimFlUiG
         5ybkPVFjcJbvUi4LK3RuW9ykdPQLWmCeiFC2KlO5plwKpAZK0XpCUPHmXD5ke9XMFz
         EShRwWetuxhyWCyuGaoBtpUFoz+QrLAkp9WxhiU9LBm1Q3E4Upx75r2kIl8ojMQ3Vy
         CgZhLCA5S/iN5hi9r7x2L2qpozMnViR+tqMmheuWgdw8uQw0SlXNU9MtkEatYWUAB0
         B9rBoeWMRiZ2Q==
Message-ID: <f6fc1fa8bf4decf97d76900a64fe0bc2bf25576d.camel@mengyan1223.wang>
Subject: Re: [PATCH V4 19/22] LoongArch: Add VDSO and VSYSCALL support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Thu, 30 Sep 2021 23:43:41 +0800
In-Reply-To: <20210927064300.624279-20-chenhuacai@loongson.cn>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
         <20210927064300.624279-20-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/vdso/gen_vdso_offsets.sh
> b/arch/loongarch/vdso/gen_vdso_offsets.sh
> new file mode 100755
> index 000000000000..7da255fea213
> --- /dev/null
> +++ b/arch/loongarch/vdso/gen_vdso_offsets.sh
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#
> +# Derived from RISC-V and ARM64:
> +# Author: Will Deacon <will.deacon@arm.com>
> +#
> +# Match symbols in the DSO that look like VDSO_*; produce a header
> file
> +# of constant offsets into the shared object.
> +#
> +
> +LC_ALL=C

I'm wondering whether this line is really useful... There is no "export"
here so the variable won't be passed to the environment of the sed
command below.

> +sed -n -e 's/^00*/0/' -e \
> +'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define
> vdso_offset_\2\t0x\1/p'
