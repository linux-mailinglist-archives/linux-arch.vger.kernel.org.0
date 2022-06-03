Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23E53CB3C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiFCOCE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiFCOCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 10:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFA10542;
        Fri,  3 Jun 2022 07:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 153556177A;
        Fri,  3 Jun 2022 14:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E7DC385A9;
        Fri,  3 Jun 2022 14:01:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FnGsu3AD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654264915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3AlnY3e9ROkgCCHACNvB1p24Fh7Aq+0ymhTrccZd+A=;
        b=FnGsu3ADiIdBu/1DDX/PYzV9xuZu7X4bROJ1HZ+YmTt7uquHiwenuOqBwk51QBO6C1CMMD
        qhMcm99VmhlclgwXyZphQqSFDuV4m0TkmSe2ZDSDN6zp+VGRce+hxd6Pz5Prdvxy0GQ9BS
        RB9Ts6Klcgj7icUsZJ3V8Gz3oPsx5iI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d17e220 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 3 Jun 2022 14:01:55 +0000 (UTC)
Date:   Fri, 3 Jun 2022 16:01:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
Subject: Re: [PATCH V15 10/24] LoongArch: Add other common headers
Message-ID: <YpoURwkAbqRlr7Yi@zx2c4.com>
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-11-chenhuacai@loongson.cn>
 <YpoPZjJ/Adfu3uH9@zx2c4.com>
 <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0iASLd768imA8pG32Cc2RsqG8-ZyN+Obcg+PksVj1FJg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Fri, Jun 03, 2022 at 03:55:27PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 3, 2022 at 3:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > On Fri, Jun 03, 2022 at 03:20:39PM +0800, Huacai Chen wrote:
> > > diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> >
> > "Currently only used on SMP for scheduling" isn't quite correct. It's
> > also used by random_get_entropy(). And anything else that uses
> > get_cycles() for, e.g., benchmarking, might use it too.
> >
> > You wrote also, "we know that all SMP capable CPUs have cycle counters",
> > so if I gather from this statement that some !SMP CPUs don't have a
> > cycle counter, though some do. If that's a correct supposition, then
> > you may need to rewrite this file to be something like:
> 
> The file is based on the mips version that deals with a variety of
> implementations
> and has the same comment.
> 
> I assume the loongarch chips all behave the same way here, and won't need
> a special case for non-SMP.

Oh good. In that case, the code is fine and I suppose the comment could
just be removed.

Jason
