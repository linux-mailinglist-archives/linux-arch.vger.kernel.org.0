Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A221AFEB5
	for <lists+linux-arch@lfdr.de>; Mon, 20 Apr 2020 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDSWoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Apr 2020 18:44:25 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57963 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSWoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Apr 2020 18:44:25 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03JMhwJB009257;
        Mon, 20 Apr 2020 07:43:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03JMhwJB009257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587336239;
        bh=gV/58YzON11th09Ti+Q8EbO1d/yan4JpxqInk2QGwes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgiQUpEnZCCVaIVWx/unrd1QG7sa9rq24slnHk0eFwMxg1QdlLrIjfH/SpHuWWCT5
         ByafFrn4UMsGC5LRT59KG15IAFnUk6ok1l66FmrHu741j05+dv9Cxbrh3EHJT2wiw/
         9UtixbBdOUORKCDFJj8ONXAtkO3k4EdtoRwZdbXzqaIdaBGlqdVj0ETACR89kuuLXn
         1leWcw9phhOWGYISjDoJVjQD3T90V+7ftx8rSrz0gtz+645fhPhOU1y+qiJKFmPk9l
         Z19jEmSzS7Y3mZkkyDOOVJFBqj3PMJlDStTC2hwOFu3Uy+zD3Z90inxZPeJ0F2CCNs
         sdjP6Tv+tjlUw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id z1so4816150vsn.11;
        Sun, 19 Apr 2020 15:43:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuaQCcQPIs8oHn7TeOVbbxkGH40jkE4x+oMYFK/uCImTCF9AmKku
        rd/n1UbXIpFsuxUPWjrYM/psdaFF4otMHFIBKvs=
X-Google-Smtp-Source: APiQypL18FhGmx9Srecmi4TdYq4Vj1H09SIbwKmnMxjZzAe5yiIXkku5jzH7VBRLIM/hcElDA0yKpv6VkHkLWl34k4c=
X-Received: by 2002:a67:fa11:: with SMTP id i17mr9772277vsq.155.1587336237833;
 Sun, 19 Apr 2020 15:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200419222804.483191-1-masahiroy@kernel.org>
In-Reply-To: <20200419222804.483191-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Apr 2020 07:43:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmdxmk7_fxo0v6T92GwXpXbmukcMBD_4Dp+L89ymM7=A@mail.gmail.com>
Message-ID: <CAK7LNAQmdxmk7_fxo0v6T92GwXpXbmukcMBD_4Dp+L89ymM7=A@mail.gmail.com>
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 20, 2020 at 7:28 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As the bug report [1] pointed out, <linux/vermagic.h> must be included
> after <linux/module.h>.
>
> I believe we should be able to include headers in any order. We often
> sort include directives alphabetically, but it is just coding style
> convention. Technically, we can get rid of the include order restriction
> by making every header self-contained.
>
> Currently, arch-specific MODULE_ARCH_VERMAGIC is defined in
> <asm/module.h>, but it is not included from <linux/vermagic.h>.
>
> Hence, the straight-forward fix-up would be as follows:
>
> |--- a/include/linux/vermagic.h
> |+++ b/include/linux/vermagic.h
> |@@ -1,5 +1,6 @@
> | /* SPDX-License-Identifier: GPL-2.0 */
> | #include <generated/utsrelease.h>
> |+#include <linux/module.h>
> |
> | /* Simply sanity version stamp for modules. */
> | #ifdef CONFIG_SMP
>
> This works enough, but for further cleanups, I split MODULE_ARCH_VERMAGIC
> definitions into <asm/vermagic.h>.
>
> With this, <linux/module.h> and <linux/vermagic.h> will be orthogonal,
> and the location of MODULE_ARCH_VERMAGIC definitions will be consistent.
>
> For arc and ia64, MODULE_PROC_FAMILY is only used for defining
> MODULE_ARCH_VERMAGIC. I squashed it.
>
> FOR hexagon, nds32, and xtensa, I removed <asm/modules.h> entirely
> because they contained nothing but MODULE_ARCH_VERMAGIC definition.
> Kbuild will automatically generate <asm/modules.h> at build-time,
> wrapping <asm-generic/module.h>.
>
> [1] https://lore.kernel.org/lkml/20200411155623.GA22175@zn.tnic
>

I forgot to add this:

Reported-by: Borislav Petkov <bp@suse.de>



> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I do not mean to replace the work by Leon Romanovsky:
> https://lkml.org/lkml/2020/4/19/201
>
> His work intends to hide <linux/vermagic.h> from driver writers.
> It is solving a different problem.
> It does not solve the include order restriction reported by [1].
> It still relies on kernel/module.c and *.mod.c
> include <linux/vermagic.h> after <linux/module.h>.
>
> I believe we should not impose any restriction about the include order.
> So, this patch is the direct answer to the bug report [1].
>
> BTW, I think commit f58dd03b1157bdf3b64c36e9525f8d7f69c25df2
> was a bad way to suppress the problem, but that is another story.
>


-- 
Best Regards
Masahiro Yamada
