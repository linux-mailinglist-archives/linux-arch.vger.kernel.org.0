Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0413BD9F5
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 17:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhGFPUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhGFPUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 11:20:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C6C061768
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vodS0GYG9U+aXbQ03KOG+hJY9dpu9Fhs8KgbyaghQRQ=; b=cJ6aYQ/+2P/YLO6yhXdXdacEXj
        LYvqOxFGSajIPxFWcs5digTe2QK+JJNiIzt+Dl6F+eK4i8oy5K2troVE95Qchi1przF8qTq6tD5JY
        G+mVMnabSul1Nwf5cngjx/U6BbtVyztPmsw0gN15FTUyHWsX6ezfUHOtOIxpq6qnbl6ZBBcZ/lsvp
        EdgNPXxgXi2qY4wfZB2jntSfJG5DiTpt93hisagStPSso65X3Wvjk/46mXduRFWfKhb3qOCTZcdkQ
        ln7gUvPlZ/CHWdFTxZQ4w9o+BusfTu8ijEcjLUtHYsdDxaAchZs8NNOoJ9CpSLTpUp2be29L5rjvO
        ZgODuC6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0lRG-00F3Vj-Sk; Tue, 06 Jul 2021 13:48:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3745F300056;
        Tue,  6 Jul 2021 15:48:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 218AE200E16C1; Tue,  6 Jul 2021 15:48:37 +0200 (CEST)
Date:   Tue, 6 Jul 2021 15:48:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
Message-ID: <YORfNeAKG8tvOvjm@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706041820.1536502-18-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:18:18PM +0800, Huacai Chen wrote:
> +/*
> + * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely when a
> + * tight read loop is executed, because reads take priority over writes & the
> + * hardware (incorrectly) doesn't ensure that writes will eventually occur.
> + *
> + * Since spin loops of any kind should have a cpu_relax() in them, force an SFB
> + * flush from cpu_relax() such that any pending writes will become visible as
> + * expected.
> + */
> +#define cpu_relax()	smp_mb()

Guys! You've not fixed that utter trainwreck ?!? You've taped out a
whole new architecture and you're keeping this?
