Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3019C792
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgDBRDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 13:03:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58988 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgDBRDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 13:03:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48tTsr5rRRz9vBmV;
        Thu,  2 Apr 2020 19:03:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ACiTytRZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AvlDP2sR7zTb; Thu,  2 Apr 2020 19:03:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48tTsr4JmWz9vBmS;
        Thu,  2 Apr 2020 19:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585847008; bh=JzGfy64woJ08evugoWBAVtqz/vtq+HHi55dh1/1+x5A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ACiTytRZC+Xj1EuNnjHaWbbYCnJ8CD46NNiCXRQXdSw8VyzeFkJ2iXIguFAur/WXP
         cGiaTz0jzh4b++Xtfz3FYdDzGi39XWjPpP47djmAbDbgW6+Qcumeu76BQzwby7Kadg
         qsGptG6uO/KhtseD57NVkod6GcuUBabHLVYA7YLY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDF298B93A;
        Thu,  2 Apr 2020 19:03:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IdlgMSKFOZLT; Thu,  2 Apr 2020 19:03:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C52AF8B925;
        Thu,  2 Apr 2020 19:03:28 +0200 (CEST)
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
Date:   Thu, 2 Apr 2020 19:03:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402162942.GG23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 02/04/2020 à 18:29, Al Viro a écrit :
> On Thu, Apr 02, 2020 at 07:34:16AM +0000, Christophe Leroy wrote:
>> Some architectures like powerpc64 have the capability to separate
>> read access and write access protection.
>> For get_user() and copy_from_user(), powerpc64 only open read access.
>> For put_user() and copy_to_user(), powerpc64 only open write access.
>> But when using unsafe_get_user() or unsafe_put_user(),
>> user_access_begin open both read and write.
>>
>> Other architectures like powerpc book3s 32 bits only allow write
>> access protection. And on this architecture protection is an heavy
>> operation as it requires locking/unlocking per segment of 256Mbytes.
>> On those architecture it is therefore desirable to do the unlocking
>> only for write access. (Note that book3s/32 ranges from very old
>> powermac from the 90's with powerpc 601 processor, till modern
>> ADSL boxes with PowerQuicc II modern processors for instance so it
>> is still worth considering)
>>
>> In order to avoid any risk based of hacking some variable parameters
>> passed to user_access_begin/end that would allow hacking and
>> leaving user access open or opening too much, it is preferable to
>> use dedicated static functions that can't be overridden.
>>
>> Add a user_read_access_begin and user_read_access_end to only open
>> read access.
>>
>> Add a user_write_access_begin and user_write_access_end to only open
>> write access.
>>
>> By default, when undefined, those new access helpers default on the
>> existing user_access_begin and user_access_end.
> 
> The only problem I have is that we'd better choose the calling
> conventions that work for other architectures as well.
> 
> AFAICS, aside of ppc and x86 we have (at least) this:
> arm:
> 	unsigned int __ua_flags = uaccess_save_and_enable();
> 	...
> 	uaccess_restore(__ua_flags);
> arm64:
> 	uaccess_enable_not_uao();
> 	...
> 	uaccess_disable_not_uao();
> riscv:
> 	__enable_user_access();
> 	...
> 	__disable_user_access();
> s390/mvc:
> 	old_fs = enable_sacf_uaccess();
> 	...
>          disable_sacf_uaccess(old_fs);
> 
> arm64 and riscv are easy - they map well on what we have now.
> The interesting ones are ppc, arm and s390.
> 
> You wants to specify the kind of access; OK, but...  it's not just read
> vs. write - there's read-write as well.  AFAICS, there are 3 users of
> that:
> 	* copy_in_user()
> 	* arch_futex_atomic_op_inuser()
> 	* futex_atomic_cmpxchg_inatomic()
> The former is of dubious utility (all users outside of arch are in
> the badly done compat code), but the other two are not going to go
> away.

user_access_begin() grants both read and write.

This patch adds user_read_access_begin() and user_write_access_begin() 
but it doesn't remove user_access_begin()

> 
> What should we do about that?  Do we prohibit such blocks outside
> of arch?
> 
> What should we do about arm and s390?  There we want a cookie passed
> from beginning of block to its end; should that be a return value?

That was the way I implemented it in January, see 
https://patchwork.ozlabs.org/patch/1227926/

There was some discussion around that and most noticeable was:

H. Peter (hpa) said about it: "I have *deep* concern with carrying state 
in a "key" variable: it's a direct attack vector for a crowbar attack, 
especially since it is by definition live inside a user access region."

> 
> And at least on arm that thing nests (see e.g. __clear_user_memset()
> there), so "stash that cookie in current->something" is not a solution...
> 
> Folks, let's sort that out while we still have few users of that
> interface; changing the calling conventions later will be much harder.
> Comments?
> 

This patch minimises the change by just adding user_read_access_begin() 
and user_write_access_begin() keeping the same parameters as the 
existing user_access_begin().

So I can come back to a mix of this patch and the January version if it 
corresponds to everyone's view, it will also be a bit easier for powerpc 
(especially book3s/32). But that didn't seem to be the expected 
direction back when we discussed it in January.

Christophe
