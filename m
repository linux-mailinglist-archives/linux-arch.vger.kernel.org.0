Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB3E3A31CD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhFJRNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 13:13:46 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38489 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhFJRNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 13:13:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G19W10RlZz1s3pn;
        Thu, 10 Jun 2021 19:11:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G19W05vXlz1qr46;
        Thu, 10 Jun 2021 19:11:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id jeCLGjcaYHdm; Thu, 10 Jun 2021 19:11:39 +0200 (CEST)
X-Auth-Info: tTD/jRVROUkeu+CRr/dYNOPU0H88WKfaxb3K8PZ1hjL42mqxsQYgvXW0pSyHF28S
Received: from igel.home (ppp-46-244-161-203.dynamic.mnet-online.de [46.244.161.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 10 Jun 2021 19:11:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8C8602C36A1; Thu, 10 Jun 2021 19:11:38 +0200 (CEST)
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
X-Yow:  There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
Date:   Thu, 10 Jun 2021 19:11:38 +0200
In-Reply-To: <20210610171025.GA3861769@roeck-us.net> (Guenter Roeck's message
        of "Thu, 10 Jun 2021 10:10:25 -0700")
Message-ID: <87bl8dhcfp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Jun 10 2021, Guenter Roeck wrote:

> On Thu, Jun 10, 2021 at 06:39:39PM +0200, Andreas Schwab wrote:
>> On Apr 18 2021, Alex Ghiti wrote:
>> 
>> > To sum up, there are 3 patches that fix this series:
>> >
>> > https://patchwork.kernel.org/project/linux-riscv/patch/20210415110426.2238-1-alex@ghiti.fr/
>> >
>> > https://patchwork.kernel.org/project/linux-riscv/patch/20210417172159.32085-1-alex@ghiti.fr/
>> >
>> > https://patchwork.kernel.org/project/linux-riscv/patch/20210418112856.15078-1-alex@ghiti.fr/
>> 
>> Has this been fixed yet?  Booting is still broken here.
>> 
>
> In -next ?

No, -rc5.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
