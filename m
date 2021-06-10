Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524CF3A3214
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 19:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJRbS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 13:31:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58901 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFJRbQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 13:31:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G19vK6D7Jz1qt3l;
        Thu, 10 Jun 2021 19:29:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G19vK4RQLz1qr46;
        Thu, 10 Jun 2021 19:29:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id vO5Y0XBKtwZ2; Thu, 10 Jun 2021 19:29:16 +0200 (CEST)
X-Auth-Info: 2HRiD3r3sBASgyEoh1SHqVlhb3EFoSQZduKD2H4uGNLGPC7SubTmYAn+NLEyWCf+
Received: from igel.home (ppp-46-244-161-203.dynamic.mnet-online.de [46.244.161.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 10 Jun 2021 19:29:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 83A702C36A1; Thu, 10 Jun 2021 19:29:15 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear
 mapping
References: <mhng-90fff6bd-5a70-4927-98c1-a515a7448e71@palmerdabbelt-glaptop>
        <76353fc0-f734-db47-0d0c-f0f379763aa0@ghiti.fr>
        <a58c4616-572f-4a0b-2ce9-fd00735843be@ghiti.fr>
        <7b647da1-b3aa-287f-7ca8-3b44c5661cb8@ghiti.fr>
        <87fsxphdx0.fsf@igel.home> <20210610171025.GA3861769@roeck-us.net>
        <87bl8dhcfp.fsf@igel.home> <20210610172035.GA3862815@roeck-us.net>
X-Yow:  A shapely CATHOLIC SCHOOLGIRL is FIDGETING inside my costume..
Date:   Thu, 10 Jun 2021 19:29:15 +0200
In-Reply-To: <20210610172035.GA3862815@roeck-us.net> (Guenter Roeck's message
        of "Thu, 10 Jun 2021 10:20:35 -0700")
Message-ID: <877dj1hbmc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jun 10 2021, Guenter Roeck wrote:

> On Thu, Jun 10, 2021 at 07:11:38PM +0200, Andreas Schwab wrote:
>> On Jun 10 2021, Guenter Roeck wrote:
>> 
>> > On Thu, Jun 10, 2021 at 06:39:39PM +0200, Andreas Schwab wrote:
>> >> On Apr 18 2021, Alex Ghiti wrote:
>> >> 
>> >> > To sum up, there are 3 patches that fix this series:
>> >> >
>> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210415110426.2238-1-alex@ghiti.fr/
>> >> >
>> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210417172159.32085-1-alex@ghiti.fr/
>> >> >
>> >> > https://patchwork.kernel.org/project/linux-riscv/patch/20210418112856.15078-1-alex@ghiti.fr/
>> >> 
>> >> Has this been fixed yet?  Booting is still broken here.
>> >> 
>> >
>> > In -next ?
>> 
>> No, -rc5.
>> 
> Booting v5.13-rc5 in qemu works for me for riscv32 and riscv64,
> but of course that doesn't mean much. Just wondering, not knowing
> the context - did you provide details ?

Does that work for you:

https://github.com/openSUSE/kernel-source/blob/master/config/riscv64/default

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
