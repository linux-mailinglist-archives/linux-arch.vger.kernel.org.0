Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78C41EB57
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353361AbhJALG1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 07:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353235AbhJALG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 07:06:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8566C061775;
        Fri,  1 Oct 2021 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nAxGSz+sw/DtojqdX9FUJgt3bJ218IVOzIPvBEAJSXA=; b=DLSiRm/pWw1pc5DQf8PMkaLZka
        zz4NpjYwOMu1HdN3WHbPDdlmZ7eFmn2Ma4aTh+PHXwI28o2x0tFpUvNA1Qn4Spp49sHin+vOHO/kJ
        nOBBEayEr3SXhoZ/Km5A/dbishdpH8/ySu/q+CBwPqfS9kxHc3OEI795PNtADLi6VQ+1zdj1OUnI5
        AEtjiNy8WQ4RVOjlq0GzFwCEhZSs7ZDhccvki3xDdzqpMUrtjsA5h/xTQmTSdqHKbhhZI44WTey9C
        ankxqdb/S3YYh7FpKM1yLLceuiXwS72j4N2scmybEcefIZnHhuVlDdgKzlebX7zVB7EODYu7GTRMt
        TVIIgF1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWGL7-00790w-48; Fri, 01 Oct 2021 11:04:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8521A300299;
        Fri,  1 Oct 2021 13:04:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73A9526717AC7; Fri,  1 Oct 2021 13:04:28 +0200 (CEST)
Date:   Fri, 1 Oct 2021 13:04:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 07/22] LoongArch: Add atomic/locking headers
Message-ID: <YVbrPHsDkhTl4FTA@hirez.programming.kicks-ass.net>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-8-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927064300.624279-8-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 27, 2021 at 02:42:44PM +0800, Huacai Chen wrote:
> diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..2544ee546596
> --- /dev/null
> +++ b/arch/loongarch/include/asm/spinlock.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SPINLOCK_H
> +#define _ASM_SPINLOCK_H
> +
> +#include <asm/processor.h>
> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +
> +#endif /* _ASM_SPINLOCK_H */
> diff --git a/arch/loongarch/include/asm/spinlock_types.h b/arch/loongarch/include/asm/spinlock_types.h
> new file mode 100644
> index 000000000000..91f258401ef9
> --- /dev/null
> +++ b/arch/loongarch/include/asm/spinlock_types.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SPINLOCK_TYPES_H
> +#define _ASM_SPINLOCK_TYPES_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +#include <asm-generic/qrwlock_types.h>
> +
> +#endif

Also see the many lkml threads on this, is there big enough loongson to
justify qspinlock? Have you tried a ticket lock?
