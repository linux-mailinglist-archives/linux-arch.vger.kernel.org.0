Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B1430BF2
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhJQUSm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhJQUSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 16:18:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6410BC06161C;
        Sun, 17 Oct 2021 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=4XUukp+9b1viCm7WWWZGfVXYbKx7reWhMLUTlGTz/mY=; b=OiQ/T7qAoFzQ6AlGWgkM2KtzSU
        0pr+j+P4ClYOvS5GoS9zIPfR8gutFxP1w47+XD4OCqDP+x2a9Id26Y9moyD2NY2UvSzdsLBEM0sAx
        1S82gs1kBF/TyGCiK9r0+JGauWZ4UryYDfMlZo7vEdr1HgBchCVjaXiPuhsieqaroQebQnAUGZeQ0
        3HGPdf6aDDPwTfqoJHxP3r8Gh1a14TYJ/6ACdGOSX9nj/OLq/+mOmh7jqjkN93mJ6/Oy7B8+Hxn/m
        ZYLQcwr8jA2Gox3L/Xv03W0XiNF5cEgTc2i8MVHM4S7pMZqMdM+3B1KoPohusiqLxiulHPTbzuK0W
        spHlze4g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcCa7-00DH4c-4x; Sun, 17 Oct 2021 20:16:31 +0000
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211017174905.18943-1-rdunlap@infradead.org>
 <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
 <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org>
 <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
 <fec67616-f1d0-08da-f393-489233210cbd@infradead.org>
 <CAK8P3a2PuTe2h49n72Z-GHnn_wyq-naPm55LJJG+OnCdSLz5tw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0b1f21f5-fe78-2581-610b-5551679786a6@infradead.org>
Date:   Sun, 17 Oct 2021 13:16:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2PuTe2h49n72Z-GHnn_wyq-naPm55LJJG+OnCdSLz5tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/17/21 12:38 PM, Arnd Bergmann wrote:
> On Sun, Oct 17, 2021 at 9:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 10/17/21 12:24 PM, Arnd Bergmann wrote:
>>> On Sun, Oct 17, 2021 at 9:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>> On 10/17/21 12:09 PM, Arnd Bergmann wrote:
>>>>> On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>>> Did you see any other issues like this one on m68k, or the
>>>>> same one on another architecture?
>>>>
>>>> No and no.
>>>
>>> Ok, maybe before we waste too much time on it, just add an extra
>>> return statement to afs_dir_set_page_dirty()?
>>
>> I think that patch has already been rejected a few times...
> 
> Indeed, this is one I had looked at before:
> 
> https://lore.kernel.org/all/CAK8P3a3L6B9HXsOXSu9_c6pz1kN91Vig6EPsetLuYVW=M72XaQ@mail.gmail.com/
> 
> It seems that this version:
> 
> +#define BUG() do {                                             \
> +               do {} while (1);                                \
> +               unreachable();                                  \
> +       } while (0)
> 
> ended up being one that didn't see any objections.

Yes, I was just thinking of a change like that while eating lunch. :)

-- 
~Randy
