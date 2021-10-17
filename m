Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0523A430BB0
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJQTTo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhJQTTn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 15:19:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E637C06161C;
        Sun, 17 Oct 2021 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=amegNczcXWZqbV+pSNOZ0As1r+nqYhmZrOOa6o5Q754=; b=Fw+wrvfOgZNt1BlOzAIQshFKkb
        Ljau5J+pxoct50M3POpx8rZSHkUOznhNQyFhQ2UUdNhdlo7mXarrK0VhdVg244Av4gC+kClBcqaSS
        kjYuDR8Um9lOI1+n0owpTUX2H3JUQ+C8P+nnBgG0Exkcqj43FCt9TwMwRL4g86VWmCziTlN3oVhZa
        t+Pe+G1k2Udg3ehtt8qUrf8XJJIQ50CmhyIdXs268aTGrqbeRpFNLTB8ZMJbqVQXLGKSSlTA8nXnV
        mt/RcqXHDZl3vklCiuhZnxlovIGwfdZUnFbNw4jtB3vuWTXhxbpel7tMQvJngyZKNqzyfc9XqoyBo
        7EFd7YcQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcBf3-00DCdL-17; Sun, 17 Oct 2021 19:17:33 +0000
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211017174905.18943-1-rdunlap@infradead.org>
 <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org>
Date:   Sun, 17 Oct 2021 12:17:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/17/21 12:09 PM, Arnd Bergmann wrote:
> On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> When CONFIG_BUG is not set/enabled, there is a warning
>> on ARCH=m68k, gcc version 11.1.0-nolibc from Arnd's crosstools:
>>
>> ../fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
>> ../fs/afs/dir.c:51:1: error: no return statement in function returning non-void [-Werror=return-type]
>>
>> Adding "unreachable()" in the BUG() macro silences the warning.
> 
> No, I don't think this is the right solution:
> 
>> -#define BUG() do {} while (1)
>> +#define BUG() do {unreachable();} while (1)
> 
> Marking this code unreachable() means the compiler is free
> to assume any code path leading here will never be entered,
> which leads to additional undefined behavior and other warnings
> rather than just hanging reproducibly.
> 
> The endless loop here should normally be sufficient to tell the
> compiler that the function never returns, so it sounds like a
> problem in gcc for m68k.

Sounds likely.

> Did you see any other issues like this one on m68k, or the
> same one on another architecture?

No and no.

thanks.
-- 
~Randy
