Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17091A264
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfEJRfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 13:35:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52813 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfEJRfk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 13:35:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 450y6M3jtnz9v0v1;
        Fri, 10 May 2019 19:35:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kZKWCqAu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FMwJ20pNBoD4; Fri, 10 May 2019 19:35:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 450y6M2STLz9v0v0;
        Fri, 10 May 2019 19:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557509739; bh=ETIfNWdjheDxK6ulmt7rGhw92PhKDX8Ycxhn3WkzwA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kZKWCqAuMvyQxiML6fLhAw5/0pfXItFjQa/WP8HryQoMo2SaXCx5RD90E1v1VJeD7
         XtJInDqwjmZhGYl7KxtOiD84soq4bEeRxlsUH+Vmjaj/OOkkPD4puHedQLGBQsGrhT
         4k2ym7p54S2XNtZMmeViLG0TrwciZq81wTIhMXy8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A2788B95A;
        Fri, 10 May 2019 19:35:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DBYHnOZ0LvOs; Fri, 10 May 2019 19:35:39 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 777778B940;
        Fri, 10 May 2019 19:35:38 +0200 (CEST)
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
Date:   Fri, 10 May 2019 19:35:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510122401.21a598f6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190510-2, 10/05/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 10/05/2019 à 18:24, Steven Rostedt a écrit :
> On Fri, 10 May 2019 10:42:13 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
>>   static const char *check_pointer_msg(const void *ptr)
>>   {
>> -	char byte;
>> -
>>   	if (!ptr)
>>   		return "(null)";
>>   
>> -	if (probe_kernel_address(ptr, byte))
>> +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>>   		return "(efault)";
>>   
> 
> 
> 	< PAGE_SIZE ?
> 
> do you mean: < TASK_SIZE ?

I guess not.

Usually, < PAGE_SIZE means NULL pointer dereference (via the member of a 
struct)

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

