Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3059F322454
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 03:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBWC7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Feb 2021 21:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhBWC7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Feb 2021 21:59:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA8C06178A
        for <linux-arch@vger.kernel.org>; Mon, 22 Feb 2021 18:58:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o22so882030pjs.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Feb 2021 18:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=69faGMiqKu3nPyYAESPRzQr/N8GaW/xblPmvz3UTUyk=;
        b=p3c4YUSBMWjuo9w902cfnr7CT3hEXcNms1mFbon5F1U4TssdL5MH7X50J1wGMCJ8li
         d28LUYz6P2KU/NyJUWsJaq5EUDpW8oEAk4JRuhj23pfWvYy7b5gdE6C0S82N7J525n9G
         HY2CJOy0xhfaYM5IfmcY2BKDU6zMO4eXE1kVn6Qttf6itw4RiG3W+ApjLUMmHy37eySm
         OaRGz37uppx7ZW4Y2ot6xYcaMrUZ4I/IhPVaI4O/nyokzhFHi9qMreSJKRILUKu+qIZH
         gqkOWDGG9YfD35F2+/gABqF7LBM4fyWefYQDvQXqgzUWv+jooLva/7Sq6WOlvR9xcNeU
         DTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=69faGMiqKu3nPyYAESPRzQr/N8GaW/xblPmvz3UTUyk=;
        b=tBRHFMiPrqwrJQVhGDucxDzD/TYbvePbiioS+D2Dh9b3T5TNOg6GdfR4LQ3RMjj2fP
         sw/kmfEdy52cHcbQ24ov1OymU4gYpMWigB/H3Wqi9M+JPznHEAXcqKz1wzZQklWAC9Yl
         5OLZ80ZMaa0BkUKCa0E/igx5OjKuxzMAzoi/dzAmYT9oI7Iak8o4yhORm5lFClcolN/R
         bjk7g7M+eDzyzZ8EcQN+tDPXhDKYXDk/Ipi1LdaTj4Bg3C6WVZ4RCViW0MHMpLnrymUu
         cZ2NUpnNJMJbS1GYa2LiMW9iDO/iuLVaJILG0MwYlxUyLREbQVe5U5rHXskaajDF3Q4Y
         olcQ==
X-Gm-Message-State: AOAM532I4sxjWWDdjZalxEakfe7I78SmcvfKIG4ulFjBCShAFbFcx2QE
        qRBT4eEQIdl4KqquIy58xazWhg==
X-Google-Smtp-Source: ABdhPJzmV8wZkxXCgdmngyaKJBYUFNgz01I8ZxSK+X8E0TEjxI4BBcoVuj8o0nNcOYFNN9Tp6UocWg==
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr17662033pji.26.1614049103146;
        Mon, 22 Feb 2021 18:58:23 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z28sm8702512pfr.38.2021.02.22.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:58:22 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:58:22 -0800 (PST)
X-Google-Original-Date: Mon, 22 Feb 2021 18:58:14 PST (-0800)
Subject:     Re: [PATCH 0/4] Kasan improvements and fixes
In-Reply-To: <24d45989-4f4e-281c-3f58-d492f0b582e9@ghiti.fr>
CC:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-a99773ba-c614-46dc-820a-4119dbc32ff5@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 21 Feb 2021 05:42:08 PST (-0800), alex@ghiti.fr wrote:
> Hi,
>
> Le 2/8/21 à 2:30 PM, Alexandre Ghiti a écrit :
>> This small series contains some improvements for the riscv KASAN code:
>>
>> - it brings a better readability of the code (patch 1/2)
>> - it fixes oversight regarding page table population which I uncovered
>>    while working on my sv48 patchset (patch 3)
>> - it helps to have better performance by using hugepages when possible
>>    (patch 4)
>>
>> Alexandre Ghiti (4):
>>    riscv: Improve kasan definitions
>>    riscv: Use KASAN_SHADOW_INIT define for kasan memory initialization
>>    riscv: Improve kasan population function
>>    riscv: Improve kasan population by using hugepages when possible
>>
>>   arch/riscv/include/asm/kasan.h |  22 +++++-
>>   arch/riscv/mm/kasan_init.c     | 119 ++++++++++++++++++++++++---------
>>   2 files changed, 108 insertions(+), 33 deletions(-)
>>
>
> I'm cc-ing linux-arch and linux-mm to get more chance to have reviewers
> on this series.

Sorry about that, I must have missed these.  For some reason I remember having
read the big one, so I'm not sure what happened.  They're on for-next.

Thanks!
