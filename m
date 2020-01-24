Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E191614788D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 07:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgAXGZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 01:25:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:15479 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXGZx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 01:25:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483pzz5cLxz9tyNG;
        Fri, 24 Jan 2020 07:25:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IXHw71jg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yJpettp7HOEK; Fri, 24 Jan 2020 07:25:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483pzz41gtz9tyNF;
        Fri, 24 Jan 2020 07:25:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579847151; bh=lJ1+jMnixtf3rj4GZ+pA1zFszDpc7oCJGloWFuxNhN4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IXHw71jg1Kvlg/eqqyrBnKWG+MaRC13Mt5rjRMQ3mQmCtHMJx3jAh4bGMaOQylu3A
         WP2KFyB+HuW+7qYPUSjWsATH0jxRMraKrBsbJoz46gaRjQ2eAxuwQCLVa6LdtPTl6h
         +UP2PeHULABqUHHnYUUFnFbXSIIKbBJilxOE0OXE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37B908B83D;
        Fri, 24 Jan 2020 07:25:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YWp1fOtM3W3N; Fri, 24 Jan 2020 07:25:52 +0100 (CET)
Received: from [172.25.230.111] (po15451.idsi0.si.c-s.fr [172.25.230.111])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F08338B768;
        Fri, 24 Jan 2020 07:25:51 +0100 (CET)
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>
References: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
 <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8de7ba48-7bf4-8d43-5dfc-dacf34f80537@c-s.fr>
Date:   Fri, 24 Jan 2020 07:25:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 23/01/2020 à 19:47, Linus Torvalds a écrit :
> On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> The range passed to user_access_begin() by strncpy_from_user() and
>> strnlen_user() starts at 'src' and goes up to the limit of userspace
>> allthough reads will be limited by the 'count' param.
>>
>> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
>> segment and the cost increases with the number of segments to unlock.
>>
>> Limit the range with 'count' param.
> 
> Ack. I'm tempted to take this for 5.5 too, just so that the
> unquestionably trivial fixes are in that baseline, and the
> infrastructure is ready for any architecture that has issues like
> this.

It would be nice, then the user_access_begin stuff for powerpc could go 
for 5.6 without worring about.

Thanks
Christophe
