Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F727B085
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1PIH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1PIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Sep 2020 11:08:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF68AC061755;
        Mon, 28 Sep 2020 08:08:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so1530643wmi.0;
        Mon, 28 Sep 2020 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FXLhKYSWU/M1fd9MJuFy2+oKcbRHytB3lb3XoxsRGQs=;
        b=dvDAoZ7WCYZ1ogO3zg4WvzNFS0WjYAH1ZHeo6qgZIzcTG/0QGchSs9u42gOKTVFVjm
         Y93vm1Br97WyTt1/wl05iOzkkWca2FuIlXQcE3uiqb4bBP7eh7ABEdTasPuY/1VV2qSx
         dz71BgGogHAqaEwGHlAM+fuxZrrRKFsFSw4aeAg6WF347xZHqrnRY+vrnZOZeczTdQvU
         hYfVdYM3LyBiCNEgIQ9oVsH9v16OBILG4lnKoMIciT5AOF+3cgdbulradJzkNtgz9HmU
         1CTxrnh72o6XGGKNWV/bRCqZrSsuxnm9eJnTBHZsjbQ49FHF2LXKHw8A1AEvOLEAhZOn
         E02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXLhKYSWU/M1fd9MJuFy2+oKcbRHytB3lb3XoxsRGQs=;
        b=aYYRTbe8ruvzYUAwJ4liwUrvk80NfX23AXUXZNzOtpX5kqmznuxhbCjz/yKL6XynEg
         bogunBnt39XxKdP0bgsCkM899ffc5wLat8b7X+58PD6jcTtlaUY+XO85QLoo0acz9Sqw
         z7Zy9Dz0Ecy3VW3jgBlonh2MKnn+3xTtry7fK2BgJHQd68m4QL8R4lcwCxE4NQNA3NCZ
         M+zboQTfizyd+z4kFHVG+aSgc/JLpfw8B3l4k/QPelKc/ZxV1ev2xYYcT8A3QfV3v7Cd
         hXFKTaOKuXzEBOL4m20AFCTtN4TsTVDzUqK5e1WH7kFcHSAxSvmfhZ0ggNv9O98BFu4e
         4tEA==
X-Gm-Message-State: AOAM533XVzMWcXg0zvAcAZYIgUAfk/cAE7b4U9hHkP3a91yVl6wRmU1K
        rS5LEtbMf9GORv23h+XMmZc=
X-Google-Smtp-Source: ABdhPJwMqkizpfBHet4wCWb7GnvT4E/YNIH70bH6x5YTVoHc7ARnloVVYrAp/weuNGJZwyWj4yxKaw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr2173398wmn.41.1601305685437;
        Mon, 28 Sep 2020 08:08:05 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 189sm1622730wmb.3.2020.09.28.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 08:08:04 -0700 (PDT)
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
 <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au> <20200921112638.GC2139@willie-the-truck>
 <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <542145eb-7d90-0444-867e-c9cbb6bdd8e3@gmail.com>
Date:   Mon, 28 Sep 2020 16:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/27/20 8:43 AM, Christophe Leroy wrote:
> 
> 
> Le 21/09/2020 à 13:26, Will Deacon a écrit :
>> On Fri, Aug 28, 2020 at 12:14:28PM +1000, Michael Ellerman wrote:
>>> Dmitry Safonov <0x7f454c46@gmail.com> writes:
[..]
>>>> I'll cook a patch for vm_special_mapping if you don't mind :-)
>>>
>>> That would be great, thanks!
>>
>> I lost track of this one. Is there a patch kicking around to resolve
>> this,
>> or is the segfault expected behaviour?
>>
> 
> IIUC dmitry said he will cook a patch. I have not seen any patch yet.

Yes, sorry about the delay - I was a bit busy with xfrm patches.

I'll send patches for .close() this week, working on them now.

> AFAIKS, among the architectures having VDSO sigreturn trampolines, only
> SH, X86 and POWERPC provide alternative trampoline on stack when VDSO is
> not there.
> 
> All other architectures just having a VDSO don't expect VDSO to not be
> mapped.
> 
> As far as nowadays stacks are mapped non-executable, getting a segfaut
> is expected behaviour. However, I think we should really make it
> cleaner. Today it segfaults because it is still pointing to the VDSO
> trampoline that has been unmapped. But should the user map some other
> code at the same address, we'll run in the weed on signal return instead
> of segfaulting.

+1.

> So VDSO unmapping should really be properly managed, the reference
> should be properly cleared in order to segfault in a controllable manner.
> 
> Only powerpc has a hook to properly clear the VDSO pointer when VDSO is
> unmapped.

Thanks,
         Dmitry
