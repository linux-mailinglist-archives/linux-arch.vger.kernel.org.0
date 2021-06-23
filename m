Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C53B1738
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 11:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWJu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 05:50:56 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:16257 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFWJuz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jun 2021 05:50:55 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15N9magR089297
        for <linux-arch@vger.kernel.org>; Wed, 23 Jun 2021 12:48:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1624441711; x=1627033711;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MISFftgg2hIKWcEtfdZHWCPZ3XpVUN6O8IsMWxh6AwY=;
        b=b/R6w9sFXlUiHNOh4jO8lZEfd0LyYx5EYOhxNLwH25n/oaVEJ6HxNyNzIm8IjZ5B
        d22Gw5m5dGemQDvC9folwTeWWlsdmdDIvGkpi3uVMtriocxYSohf3QJbUMd5gfT4
        rOP3w94LSTCaysDW0hx01zTbwlCdy66KGLfkyhaFK9qD2jpXo4g2y2utO3aZ2MkA
        MkRAHU07YP4ergQpl+7bxXTOiWOGZpcIWmTpBjgohV8DlvLQ8aTwuq6BezvSGkHc
        oPbWsoB5avF/211Yk9sTTPmIUz/4An0Ck22fAwV7dIoRjBNTcRsqj+IYgGbP5z4a
        UUU+GvulJgoH0/bCNQnTPw==;
X-AuditID: 8b5b014d-96ef2700000067b6-fe-60d3036faf83
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 34.3E.26550.F6303D06; Wed, 23 Jun 2021 12:48:31 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 23 Jun 2021 12:48:30 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: optimized memcpy
Organization: FORTH
In-Reply-To: <CAFnufp0JuAvrOA89KDbcbhMeMvovoS96STVV+r53PLGJV4r0aw@mail.gmail.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com>
 <87f2cf0e98c5c5560cfb591b4f4b29c8@mailhost.ics.forth.gr>
 <CAFnufp0JuAvrOA89KDbcbhMeMvovoS96STVV+r53PLGJV4r0aw@mail.gmail.com>
Message-ID: <6b35ec67ae580c64b4259e92ce21dc49@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXSHT1dWTef+XKCwYHZ6hbb3l1lsdj6exa7
        xaIV31kspvbEW+xYupnJ4t6KZewWL/Y2slg8WTOT0aJj11cWi8u75rBZbPvcwmZx8dd8Rovm
        d+fYLV5e7mG2aJvF78Dv0T97CpvHu9/LGD3evHzJ4nG44wu7R0ffPxaPnbPusns83HSJyWPT
        qk42j1/bjzJ5bF5S73Gp+Tq7x+dNch7tB7qZAnijuGxSUnMyy1KL9O0SuDL6pv5iK5jMUTHz
        0hqWBsZjbF2MnBwSAiYS51tOs3cxcnEICRxllHj2qJsVImEqMXtvJyOIzSsgKHFy5hMWEJtZ
        wEJi6pX9jBC2vETz1tnMIDaLgKrExX/3wWw2AU2J+ZcOgtWLCOhKXPxwGGwBs8AkVon599vB
        ioQFjCXOX2oEG8QvICzx6e5FsMWcAoESbfvfMUJc9J1RYu3zPVBXuEj0TGuBuk5F4sPvB0BT
        OThEgezNc5UmMArOQnLrLCS3zkJy6wJG5lWMAollxnqZycV6aflFJRl66UWbGMHxyOi7g/H2
        5rd6hxiZOBgPMUpwMCuJ8D5quZQgxJuSWFmVWpQfX1Sak1p8iFGag0VJnJdXb0K8kEB6Yklq
        dmpqQWoRTJaJg1OqgSkn6N6hWEPnmLqXAvdeKUkntC+s2n7j+O9SwUQDdbv1GxYoiS8VT61e
        WML7Kk0m8ktGgdDXNOX/osfZ5hxWWHK1T0HEjVksWekf35w793JfPeVPdNez8nSp8jjxhYO1
        zN7r0dd0B6U/LSvdH9qeWbLq9otz2kH3b+sxrWi8WeJ6wGPRuo97zC0yd3xbru72fZ2Pz6TD
        x9LcXb3zN2iF+r1/G7nl3d1prr6OZnmX7DZstGozP5wsv9l78oPDe+du7Ov/8epmefPUKouw
        TTPqpNcxLDk66/8uTsuJcjKHWwtvt5y2tz13XXabB6PgOqdPx6+or95b/GG5apXq9P9rZi7+
        Zy8aox1mf+bozpN2RteVWIozEg21mIuKEwEza0BxNgMAAA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Στις 2021-06-23 02:35, Matteo Croce έγραψε:
>> 
>> If you want to be compliant with memcpy you should check for 
>> overlapping
>> regions here since "The memory areas must not overlap", and do nothing
>> about it because according to POSIX this leads to undefined behavior.
>> That's why recent libc implementations use memmove in any case (memcpy
>> is an alias to memmove), which is the suggested approach.
>> 
> 
> Mmm which memcpy arch implementation does this check?
> I guess that noone is currently doing it.
> 

Yup because even if they did the wouldn't know what to do about it since 
POSIX leaves this as undefined behavior. So instead of using memcpy it's 
suggested that people use memmove that can handle overlapping regions, 
and because we can't patch the rest of the kernel to only use memmove 
(or the rest of the programs if we were a libc), the idea is to just 
alias memcpy to memmove (BTW Torvalds also thinks this is a good idea: 
https://bugzilla.redhat.com/show_bug.cgi?id=638477#c132).
