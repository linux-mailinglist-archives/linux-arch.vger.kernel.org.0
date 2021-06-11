Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467823A40BF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKLDc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 07:03:32 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41781 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKLDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 07:03:30 -0400
Received: by mail-oi1-f180.google.com with SMTP id t40so5398869oiw.8;
        Fri, 11 Jun 2021 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QJ/vQZOVwDNIecKs4rsjKD7AQHx1NJ2yzEFPPDK+J9o=;
        b=Buh9x/rvJlBSIbMQ0zE7v3bcZij4O3E9JJdkW3tqQmI5JqNTnMAZcWJvs7vmuWVTFn
         Htbr/HY/hYikk5hZJNolCU4Qo1cOtl8NYOqaWaNdci28W5oTEVyYTT3IHJO8Q5v1MC7f
         YXrRO50UGWmBsOjmZ1mm1u0fM/24aJmJ1WPFHa2KFRP47wyonLYRi7m5H9flGM04AMr1
         mivLE9NqWgK9BYwn8Uu3ae5a7yaryLvMO4iXofDygDgIQJEvvTkKETWjbLvWcXwSaxgt
         jm6VxYYvkYEci2mhTsVcvpa1sbobwZjXcxqRH6xMY9x+oRjHYLBWmgVaPyZzXjZq+SF7
         BBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QJ/vQZOVwDNIecKs4rsjKD7AQHx1NJ2yzEFPPDK+J9o=;
        b=bwLFiUINBLNflWuzmb4PyNIMBubTP2XpKE6SAD4/eE42Z/Pbfh3I6ncuouuER5mMZg
         b1NBH7xxcbIPlztAN/fjBHurU92ENwyBYEBy9S80AfueFe9kjVIlZwvvgqGv5CHIuTWi
         mDyydJCSlwF2WLWyGiUlplx8ADYL8zdqmtEmD9FWEU/0B/jubVZINv1tBc73E7jrsZus
         /yLsNDcppc0Tx7CXlxotDz50AQ2KwJLUda5NJDaytoiAOLMDR3c4l0rjFqbVPH7r1Qol
         /ynuingU+qYTPU9sd6Pu2PbmoZtY2cpcKI4rP+OMEAvluic8h5I+HOceeG9x0vSyrILv
         0Zsg==
X-Gm-Message-State: AOAM533U1sMnbCX98WXhawCzYWTf4Scx1FMR/crwFUMmIzAiHkjpMQ63
        PYpbmR+SLBLjJmf8y1SvZjY=
X-Google-Smtp-Source: ABdhPJy1JDA7tpiIOi/hC6erHzFJVX3BV15RGKQ1aLuwDtD3eWsiOz/a3NhK02aokWP5to0aGTLXJg==
X-Received: by 2002:aca:c441:: with SMTP id u62mr12904876oif.31.1623409220901;
        Fri, 11 Jun 2021 04:00:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1sm1101652oog.46.2021.06.11.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:00:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 11 Jun 2021 04:00:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear
 mapping
Message-ID: <20210611110019.GA579376@roeck-us.net>
References: <mhng-90fff6bd-5a70-4927-98c1-a515a7448e71@palmerdabbelt-glaptop>
 <76353fc0-f734-db47-0d0c-f0f379763aa0@ghiti.fr>
 <a58c4616-572f-4a0b-2ce9-fd00735843be@ghiti.fr>
 <7b647da1-b3aa-287f-7ca8-3b44c5661cb8@ghiti.fr>
 <87fsxphdx0.fsf@igel.home>
 <20210610171025.GA3861769@roeck-us.net>
 <87bl8dhcfp.fsf@igel.home>
 <20210610172035.GA3862815@roeck-us.net>
 <877dj1hbmc.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dj1hbmc.fsf@igel.home>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 07:29:15PM +0200, Andreas Schwab wrote:
> On Jun 10 2021, Guenter Roeck wrote:
> 
> > On Thu, Jun 10, 2021 at 07:11:38PM +0200, Andreas Schwab wrote:
> >> On Jun 10 2021, Guenter Roeck wrote:
> >> 
> >> > On Thu, Jun 10, 2021 at 06:39:39PM +0200, Andreas Schwab wrote:
> >> >> On Apr 18 2021, Alex Ghiti wrote:
> >> >> 
> >> >> > To sum up, there are 3 patches that fix this series:
> >> >> >
> >> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210415110426.2238-1-alex@ghiti.fr/
> >> >> >
> >> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210417172159.32085-1-alex@ghiti.fr/
> >> >> >
> >> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210418112856.15078-1-alex@ghiti.fr/
> >> >> 
> >> >> Has this been fixed yet?  Booting is still broken here.
> >> >> 
> >> >
> >> > In -next ?
> >> 
> >> No, -rc5.
> >> 
> > Booting v5.13-rc5 in qemu works for me for riscv32 and riscv64,
> > but of course that doesn't mean much. Just wondering, not knowing
> > the context - did you provide details ?
> 
> Does that work for you:
> 
> https://github.com/openSUSE/kernel-source/blob/master/config/riscv64/default
> 

That isn't an upstream kernel configuration; it looks like includes suse
patches. But, yes, it does crash almost immediately if I build an upstream
kernel based on it and try to run that kernel in qemu. I did not try to
track it down further; after all, it might just be that the configuration
is inappropriate for use with qemu. But the configuration isn't really
what I had asked.

Guenter
