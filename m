Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA46A109C
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 06:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfH2E4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 00:56:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11823 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfH2E4C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 00:56:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Jr0b5DHPz9v045;
        Thu, 29 Aug 2019 06:55:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Crh6iKQg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9z55-teS7QNT; Thu, 29 Aug 2019 06:55:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Jr0b47h8z9v044;
        Thu, 29 Aug 2019 06:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567054559; bh=C7KnBPSsTOCMKq6tZmmUIqyxDQCGRpUvQfY8hSe07iY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Crh6iKQgHzv0eO4Zt5E/aY5c04/+zsg8gPvFX0T3nRKRRU84j5EOOfjB6tpEcJeOK
         H6Xo/zcD5it730VdmybY59Uju+tQjAMjpN54UwPR9lXBav8DZ6aEZCYkd3lxHfTwyj
         rR7aR7Z6R1QPFOIsqIKXtCNlm/GF62ovxRTIBQEY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6339C8B79B;
        Thu, 29 Aug 2019 06:56:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XOufC6BwEjVn; Thu, 29 Aug 2019 06:56:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF89B8B761;
        Thu, 29 Aug 2019 06:55:59 +0200 (CEST)
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr> <201908241206.D223659@keescook>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
Date:   Thu, 29 Aug 2019 06:55:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908241206.D223659@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Le 24/08/2019 à 21:08, Kees Cook a écrit :

Euh ... only received this mail yesterday. Same for the other answer.


> On Fri, Aug 23, 2019 at 04:26:59PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 23/08/2019 à 00:56, Andrew Morton a écrit :
>>> On Tue, 20 Aug 2019 09:47:55 -0700 Kees Cook <keescook@chromium.org> wrote:
>>>
>>>> Reply-To: 20190819234111.9019-8-keescook@chromium.org
>>>
>>> Really?
>>
>> That seems correct, that's the "[PATCH 7/7] bug: Move WARN_ON() "cut here"
>> into exception handler" from the series at
>> https://lkml.org/lkml/2019/8/19/1155
>>
>>
>>>
>>>> Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler
>>>
>>> It's strange to receive a standalone [7/7] patch.
>>
>> Iaw the Reply_To, I understand it as an update of the 7th patch of the
>> series.
> 
> Was trying to avoid the churn of resending the identical 1-6 patches
> (which are all just refactoring to make 7/7 not a mess).

Yes but Reply-To: means the address we have to use to answer to this email.

I think you wanted to use In-reply-to:

> 
> I can resend the whole series, if that's preferred.

I guess not.

> 
>>>> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
>>>
>>> I'm seeing double.
> 
> Tracking down all these combinations has been tricky, which is why I did
> the patch 1-6 refactoring: it makes the call hierarchy much easier to
> examine (IMO).

But still, Andrew is seing double ... And me as well :)

Fixes: Fixes:

Christophe

> 
> -Kees
> 
