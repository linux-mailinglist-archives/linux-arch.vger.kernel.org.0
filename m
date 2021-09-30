Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF941DD78
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbhI3PcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 11:32:13 -0400
Received: from mengyan1223.wang ([89.208.246.23]:36276 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343650AbhI3PcM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 11:32:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 47B01659AF;
        Thu, 30 Sep 2021 11:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1633015829;
        bh=FQFXP6PYgAZVPfZp2BPwwytEvdhGuTkspFSQKYYvv+8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fmvl/HvKXqCmQkeoeslJjqXSgpeIk2ejsnu5NamFnIL+86jy1mNAMMbLB5vn+tGZf
         HXfubBZ9az18Ydrtet3Dwg/qY6emdId7Vqv5VUnb+efp14/nQdPv4o4bLvjhRLwP7T
         6zxGzlQXNfmQ9fzwWXdyTqGDZD+s/vGdyvZRLkYDtyoH7lqMn07E5EC+DOXSijymE0
         R4l8obpvuZx72LUADmX3VYXHtJ5CJPi4SNkXA9r1k8JBW2TDKxeBJoTLhQ+CZD8Q4F
         7ThcanSbLFbVRYNXy9PaXWaUjGarUraDyHX/afUETqD4PDqV1l/zhqf4bLmW2ZTuum
         H/VVpn6qdzUrA==
Message-ID: <91d12c483421cc7bd69d8ee7f28243d65877a7af.camel@mengyan1223.wang>
Subject: Re: [PATCH V4 06/22] LoongArch: Add CPU definition headers
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
Date:   Thu, 30 Sep 2021 23:30:24 +0800
In-Reply-To: <20210927064300.624279-7-chenhuacai@loongson.cn>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
         <20210927064300.624279-7-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:

> +#define t0     $r12    /* caller saved */
> +#define t1     $r13
> +#define t2     $r14
> +#define t3     $r15
> +#define t4     $r16
> +#define t5     $r17
> +#define t6     $r18
> +#define t7     $r19
> +#define t8     $r20
> +#define x0     $r21

In the doc it's said x0 will be used to name a 256-bit vector register.
Maybe it's better to rename this one?

