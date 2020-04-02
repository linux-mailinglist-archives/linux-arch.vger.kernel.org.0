Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5771619BD2F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgDBH7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 03:59:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15715 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbgDBH7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 03:59:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48tFpP4VCTz9txn7;
        Thu,  2 Apr 2020 09:59:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=K2qSbeVr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tbdPKUFxzZ1c; Thu,  2 Apr 2020 09:59:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48tFpP32Vdz9txn5;
        Thu,  2 Apr 2020 09:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585814381; bh=43GKGI0k75m1jMuar17d+4+DhdGR59q9yzVFw5zV0xg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K2qSbeVrPsfu8z1CMpXAlEYM1yWe37c7NfFevmx7ryqhDzQfVQRDRs32WIX5yp+TZ
         ywtDBo55GNAC5LEHXK38csaNzIV+L8t0pry8KwAfr0f5yZHSbG5+18iTKc2PfJjSN8
         A62kH9kShZs4OS9xtLYqVd9modYuFioAzsIKVvQM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 582B18B776;
        Thu,  2 Apr 2020 09:59:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y1pqTqStopDu; Thu,  2 Apr 2020 09:59:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 076088B75E;
        Thu,  2 Apr 2020 09:59:39 +0200 (CEST)
Subject: Re: [PATCH RESEND 3/4] drm/i915/gem: Replace user_access_begin by
 user_write_access_begin
To:     Kees Cook <keescook@chromium.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
 <202004020051.649C6B8@keescook>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e5e1ad22-e3b2-5779-2662-1bd464eae175@c-s.fr>
Date:   Thu, 2 Apr 2020 09:59:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202004020051.649C6B8@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 02/04/2020 à 09:52, Kees Cook a écrit :
> On Thu, Apr 02, 2020 at 07:34:18AM +0000, Christophe Leroy wrote:
>> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
>> that's only to perform unsafe_put_user() so use
>> user_write_access_begin() in order to only open write access.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Why is this split from the other conversions?


I split it from the other because this one is in drivers while other 
ones are in core part of the kernel.

Is it better to squash it in the previous patch ?

Christophe

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> 
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> index 7643a30ba4cd..4be8205a70b6 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
>> @@ -1611,14 +1611,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>>   		 * happened we would make the mistake of assuming that the
>>   		 * relocations were valid.
>>   		 */
>> -		if (!user_access_begin(urelocs, size))
>> +		if (!user_write_access_begin(urelocs, size))
>>   			goto end;
>>   
>>   		for (copied = 0; copied < nreloc; copied++)
>>   			unsafe_put_user(-1,
>>   					&urelocs[copied].presumed_offset,
>>   					end_user);
>> -		user_access_end();
>> +		user_write_access_end();
>>   
>>   		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
>>   	}
>> @@ -1626,7 +1626,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>>   	return 0;
>>   
>>   end_user:
>> -	user_access_end();
>> +	user_write_access_end();
>>   end:
>>   	kvfree(relocs);
>>   	err = -EFAULT;
>> @@ -2991,7 +2991,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>>   		 * And this range already got effectively checked earlier
>>   		 * when we did the "copy_from_user()" above.
>>   		 */
>> -		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
>> +		if (!user_write_access_begin(user_exec_list,
>> +					     count * sizeof(*user_exec_list)))
>>   			goto end;
>>   
>>   		for (i = 0; i < args->buffer_count; i++) {
>> @@ -3005,7 +3006,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>>   					end_user);
>>   		}
>>   end_user:
>> -		user_access_end();
>> +		user_write_access_end();
>>   end:;
>>   	}
>>   
>> -- 
>> 2.25.0
>>
> 
