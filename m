Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312525BC2AF
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiISGFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 02:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISGFD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 02:05:03 -0400
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AEE01A
        for <linux-arch@vger.kernel.org>; Sun, 18 Sep 2022 23:05:01 -0700 (PDT)
Received: from myt6-870ea81e6a0f.qloud-c.yandex.net (myt6-870ea81e6a0f.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2229:0:640:870e:a81e])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 8DDF794112C;
        Mon, 19 Sep 2022 09:04:59 +0300 (MSK)
Received: by myt6-870ea81e6a0f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ibsLEoVWKX-4whmEgi2;
        Mon, 19 Sep 2022 09:04:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=mail; t=1663567498;
        bh=ucqXuR/2KBbmfi8fpC1uXHOwRuSzxV/2yUtlgYAwFfM=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=dcnTehAnpxenH2ijLy+YEAxKtjCxxLsvpJTCgMCN83riqeqvMqaSRs/sLYe1Gugmb
         nUq5+hJaBU4XtBTSEkEg3psAS3BrAf77Qm2xqSO9jbRr+l+P8Hltiv67gkTiHy/km+
         REo1F1w/qvgT/spnPMotSBdN54dnDlkHBlGTih4U=
Authentication-Results: myt6-870ea81e6a0f.qloud-c.yandex.net; dkim=pass header.i=@syntacore.com
Message-ID: <699b8e78-94e9-1581-8285-4c6bcc9fc425@syntacore.com>
Date:   Mon, 19 Sep 2022 09:04:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] riscv: Fix permissions for all mm's during mm init
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        ajones@ventanamicro.com, conor.dooley@microchip.com
References: <mhng-16e91ca9-0ee8-4103-845e-56e9b394cae0@palmer-ri-x1c9>
Content-Language: ru-RU, en-US
From:   Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <mhng-16e91ca9-0ee8-4103-845e-56e9b394cae0@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

18.09.2022 13:05, Palmer Dabbelt wrote:
> On Sat, 17 Sep 2022 11:58:48 PDT (-0700), Linus Torvalds wrote:
>> Sorry for html crud, I'm afk right now.
>>
>> But no, this does not help at all.
>>
>> Now you're doing a blocking semaphore operation under a spinning rwlock
>> instead.
>>
>> Which also is completely invalid.
>>
>> Your can't do blocking locks in atomic context, and it doesn't matter
>> whether the atomic context is a rcu read section or a spin lock.
> 
> OK, sorry for screwing up a second time.  I'll go try and make sure we get this right before sending anything up.  Vladimir: I'll just take this one over and send a v5, I'll find some time this week to make sure I can get it right this time.
> 
> Sorry for the mess!
Hi Palmer,

I think we can avoid using full __set_memory_mm for processes here, because all non-pgd leafs were
fixed by __set_memory_mm(&init_mm).

So all we need here is to fix mm.pgd in case if this pgd is a leaf, because we copy only pgd for userspace.

Thank you,
Vladimir Isaev
> 
>> Stop making random locking changes like this. And enable lockdep and the
>> lock verification that would have told you all this immediately.
>>
>>        Linus
>>
>>
>> On Sat, Sep 17, 2022, 11:48 Vladimir Isaev <vladimir.isaev@syntacore.com>
>> wrote:
>>
>>> );
>>> +
>>> +       read_lock(&tasklist_lock);
>>> +       for_each_process(t) {
>>> +               if (t->flags & PF_KTHREAD)
>>> +                       continue;
>>> +               for_each_thread(t, s) {
>>> +                       if (s->mm) {
>>> +                               __set_memory_mm(s->mm, start, end,
>>> set_mask,
>>> +                                               clear_mask);
>>> +                       }
>>> +               }
>>> +       }
>>> +       read_unlock(&tasklist_lock);
>>>
