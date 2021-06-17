Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06B43AAF66
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFQJRC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Jun 2021 05:17:02 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34319 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhFQJRC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jun 2021 05:17:02 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G5GbZ5gHmz1r5TD;
        Thu, 17 Jun 2021 11:14:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G5GbZ3rnkz1qr3h;
        Thu, 17 Jun 2021 11:14:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BNoJzHI3K9ck; Thu, 17 Jun 2021 11:14:49 +0200 (CEST)
X-Auth-Info: +G38n7BK4v8zE2k4U0K1yd1apNmkNM93lb9wmBJEqzJxi4lUTiCAnYN6Jt0+IEcd
Received: from igel.home (ppp-46-244-187-91.dynamic.mnet-online.de [46.244.187.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 17 Jun 2021 11:14:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B037F2C3784; Thu, 17 Jun 2021 11:14:48 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux@roeck-us.net, alex@ghiti.fr, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear
 mapping
References: <20210611110019.GA579376@roeck-us.net>
        <mhng-569bbfda-00d0-4c1f-9a88-69021f258f7e@palmerdabbelt-glaptop>
X-Yow:  I will establish the first SHOPPING MALL in NUTLEY, New Jersey...
Date:   Thu, 17 Jun 2021 11:14:48 +0200
In-Reply-To: <mhng-569bbfda-00d0-4c1f-9a88-69021f258f7e@palmerdabbelt-glaptop>
        (Palmer Dabbelt's message of "Wed, 16 Jun 2021 19:58:41 -0700 (PDT)")
Message-ID: <87czskonsn.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jun 16 2021, Palmer Dabbelt wrote:

> This seems a long way off from defconfig.  It's entirly possible I'm
> missing something, but at least CONFIG_SOC_VIRT is jumping out as 
> something that's disabled in the SUSE config but enabled upstream.

None of the SOC configs are really needed, they are just convenience.
They can even be harmful, if they force a config to y if m is actually
wanted.  Which is what happens with SOC_VIRT, which forces
RTC_DRV_GOLDFISH to y.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
