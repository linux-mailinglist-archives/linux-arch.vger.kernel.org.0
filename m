Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C95295CC0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfHTK6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 06:58:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12038 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfHTK6w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 06:58:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46CSTQ0Zgxz9txp2;
        Tue, 20 Aug 2019 12:58:50 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=py++hLu3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZCMVk9dK4XBO; Tue, 20 Aug 2019 12:58:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46CSTP6W6Qz9txp1;
        Tue, 20 Aug 2019 12:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566298729; bh=93S6Dka44nxQx5aZdH+CWdQtCJ9cdu687LVNRtGXjjE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=py++hLu3TbllQP+C39mWQA8ivu5kzam28poShnKkxaKoF/4JBT4G2NBKunuzJE0UN
         SK8dhqVgXiM+5fxOzDkLhdhWkHoCOHR6HivQA718hGagmRpBgtXW3oj6072HDluSNR
         cx9564rnMjZd6vW4HETSds0qskue/a12GuhvlYpk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 04A378B7C5;
        Tue, 20 Aug 2019 12:58:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qOLzVHvVWXrT; Tue, 20 Aug 2019 12:58:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E51B8B756;
        Tue, 20 Aug 2019 12:58:49 +0200 (CEST)
Subject: Re: [PATCH 7/7] bug: Move WARN_ON() "cut here" into exception handler
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190819234111.9019-1-keescook@chromium.org>
 <20190819234111.9019-8-keescook@chromium.org>
 <20190820100638.GK2332@hirez.programming.kicks-ass.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <06ba33fd-27cc-3816-1cdf-70616b1782dd@c-s.fr>
Date:   Tue, 20 Aug 2019 12:58:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820100638.GK2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 20/08/2019 à 12:06, Peter Zijlstra a écrit :
> On Mon, Aug 19, 2019 at 04:41:11PM -0700, Kees Cook wrote:
> 
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index 588dd59a5b72..da471fcc5487 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -10,6 +10,7 @@
>>   #define BUGFLAG_WARNING		(1 << 0)
>>   #define BUGFLAG_ONCE		(1 << 1)
>>   #define BUGFLAG_DONE		(1 << 2)
>> +#define BUGFLAG_PRINTK		(1 << 3)
>>   #define BUGFLAG_TAINT(taint)	((taint) << 8)
>>   #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
>>   #endif
> 
>> diff --git a/lib/bug.c b/lib/bug.c
>> index 1077366f496b..6c22e8a6f9de 100644
>> --- a/lib/bug.c
>> +++ b/lib/bug.c
>> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * BUG() and WARN_ON() families don't print a custom debug message
>> +	 * before triggering the exception handler, so we must add the
>> +	 * "cut here" line now. WARN() issues its own "cut here" before the
>> +	 * extra debugging message it writes before triggering the handler.
>> +	 */
>> +	if ((bug->flags & BUGFLAG_PRINTK) == 0)
>> +		printk(KERN_DEFAULT CUT_HERE);
> 
> I'm not loving that BUGFLAG_PRINTK name, BUGFLAG_CUT_HERE makes more
> sense to me.
> 

Actually it would be BUGFLAG_NO_CUT_HERE then, otherwise all arches not 
using the generic macros will have to add the flag to get the "cut here" 
line.

Christophe
