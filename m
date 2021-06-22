Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09A3AFA73
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 03:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFVBLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 21:11:37 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:19611 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFVBLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 21:11:36 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15M19JV0036070
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 04:09:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1624324154; x=1626916154;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EOqcGFuYtBWb7hk+r1SbucjBncFWjcMhcQi3y8BZY7g=;
        b=gNptt+jkmO7TyMLwKjxOlDW1FM4XhF2Vz9cP0Rc0/SnomfO1DkLuY3Vo2T8im9Q2
        Tx2oa/L1a9GiMfB0gYXJNXjq/CJYU+pBR+6uivP6IQfAT2oT2CE8J3hfyvm6g4fy
        DjYdpKOgN2VDB9fNiuyrDY8n5tn6dUf38OHt8+U4mo0tCP4pyePnQmtXeoVnnkfa
        7CHBRys2PX0Pf4b9XP1gycmAHmw1idsVdo42x0968/QO8ZTqK+VPtap5aUD///3L
        +9JjqOPTA3YKOTRVGe3FWp1c+cZAS9daeggKVTg5CA+wnkqgY5rGZZbiXNob4TDg
        b0gf+/uR+VMxiTqNdxZ4vQ==;
X-AuditID: 8b5b014d-96ef2700000067b6-7f-60d1383af649
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 50.70.26550.A3831D06; Tue, 22 Jun 2021 04:09:14 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Jun 2021 04:09:14 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH v3 0/3] riscv: optimized mem* functions
Organization: FORTH
In-Reply-To: <20210617152754.17960-1-mcroce@linux.microsoft.com>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
Message-ID: <e968312557f147af1e5efb341eeef0ad@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXSHT1dWdfK4mKCwYTpuhbb3l1lsdj6exa7
        xaIV31kspvbEW+xYupnJ4t6KZewWL/Y2slg8WTOT0aJj11cWi8u75rBZbPvcwmZx8dd8RouX
        l3uYLdpm8TvwefTPnsLm8e73MkaPNy9fsngc7vjC7tHR94/FY+esu+wem1Z1snn82n6UyWPz
        knqPS83X2T0+b5LzaD/QzRTAE8Vlk5Kak1mWWqRvl8CVsevWI/aC06wV1xv/sDcwnmDpYuTk
        kBAwkVixuYG9i5GLQ0jgKKPE2lmzGCESphKz93aC2bwCghInZz4Ba2AWsJCYemU/I4QtL9G8
        dTYziM0ioCpx/PphNhCbTUBTYv6lg2D1IgK6Ehc/HAZbwCwwnUXiV+9usCJhAWuJDz8/gg3i
        FxCW+HT3IiuIzSngIHGvcQlYjZCAvcT+bd9ZIY5wkTj7qJUJ4jgViQ+/HwAN5eAQBbI3z1Wa
        wCg4C8mps5CcOgvJqQsYmVcxCiSWGetlJhfrpeUXlWTopRdtYgRHHqPvDsbbm9/qHWJk4mA8
        xCjBwawkwnsz5UKCEG9KYmVValF+fFFpTmrxIUZpDhYlcV5evQnxQgLpiSWp2ampBalFMFkm
        Dk6pBqZ9m29Zv3HecHM/m1Zfw2yXbqslj7JOGm99eU+mK+7OzMuXP1fJhRSpSZwxmNaXU+fS
        taNpSkbGv4WX2N9ltbV9z1ef97pdacEe8TK3uZF9+df288yxyShZczPXzyXg6d/dNUf3bVh7
        62SyfcaLCzWn3Hb/2jqN79AzvcmGe3JECn9dmHdx4fZZjEZSorVSUyIPPd1tteMSy8apmzTz
        zc8s4hOb5NZvn3WaWbRGLpLDPazI8TTLlZad1+3Npn8Jr43h3rjYfaNAVdfmn/dklBOEXa1T
        pnyMvifkfN4puzBjgYlz6G3FVRsXL9y9//zXZN6wyMyX6X9X79skYbBI+DWv2HLuI8pzmX7x
        vb262X2FEktxRqKhFnNRcSIAoKyPdisDAAA=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Matteo,

Στις 2021-06-17 18:27, Matteo Croce έγραψε:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Replace the assembly mem{cpy,move,set} with C equivalent.
> 
> Try to access RAM with the largest bit width possible, but without
> doing unaligned accesses.
> 
> Tested on a BeagleV Starlight with a SiFive U74 core, where the
> improvement is noticeable.
> 

There are already generic C implementations for memcpy/memmove/memset at 
https://elixir.bootlin.com/linux/v5.13-rc7/source/lib/string.c#L871 but 
are doing one byte at a time, I suggest you update them to do 
word-by-word copy instead of introducing yet another memcpy/memmove C 
implementation on arch/riscv/.



