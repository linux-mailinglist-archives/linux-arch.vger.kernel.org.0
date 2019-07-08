Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E179C61F16
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2019 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfGHM5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jul 2019 08:57:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50347 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfGHM5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jul 2019 08:57:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190708125716euoutp0221220be68333346b7729d7d1979eeb9b~vb_fGgwrk1882318823euoutp02a
        for <linux-arch@vger.kernel.org>; Mon,  8 Jul 2019 12:57:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190708125716euoutp0221220be68333346b7729d7d1979eeb9b~vb_fGgwrk1882318823euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562590637;
        bh=moH9FyJACg7taxt6hPEp6Gwj8L3RJFkHFSIW10SGh/8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l4dpUgn+xlSJfnhPtOE0y2zqA0uxPILyb+BAmfDWwP5P7IculB9vc1dJWYMNOduP1
         nAPUvD64tY1y0AzBt/dmFCWl2PWqhUkh+VayYV3XcglnJXDHUkiCCvG+1m8p6IV51r
         OR4ZaEpTeHblAaIZDvEhDMWuRqkHPG1tf1cpNAZc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190708125715eucas1p18070570968e5ad20755ba1e3578535aa~vb_d64wFK1523415234eucas1p1W;
        Mon,  8 Jul 2019 12:57:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 00.A7.04377.BAD332D5; Mon,  8
        Jul 2019 13:57:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190708125714eucas1p1f71616c08694fb91f20a664e59c339d0~vb_dNNfuL1523415234eucas1p1V;
        Mon,  8 Jul 2019 12:57:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190708125714eusmtrp1ef454f56758f1cc56e77b9357db5ea29~vb_c_6sdD1747017470eusmtrp11;
        Mon,  8 Jul 2019 12:57:14 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-41-5d233dabb673
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.1A.04140.AAD332D5; Mon,  8
        Jul 2019 13:57:14 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190708125713eusmtip29fd40a6e2195085cb1853b84d3ad8143~vb_bebL6c2121721217eusmtip2-;
        Mon,  8 Jul 2019 12:57:13 +0000 (GMT)
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <ed758c10-7260-bec3-caf1-08cae7e0968d@samsung.com>
Date:   Mon, 8 Jul 2019 14:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0wUVxjtt3N3ZiAuGRYNn4uVZIpNSqKIMfG2WKoNTSemPxpSG1NDy1An
        QISF7ABVa1Jaq+LKy0UFt3RdU1QYsZoBt7hImi4IKgbf6wsfBNJAEW0DWqmvsjs05d853znn
        fo9cnrEeY218rr1IcdjlPJGNJL7uyQsLj7z7RsbiI1ocrd47TGijZxLoC1c3Rx8dKgfqGX+d
        7mt8QGiZ/zGh+mDQTK/461la2/+IpTv0E0ADezqADro9LD3adYejlaPdDK3qv87Sy6cS6KQ+
        AHT3yM8c9TbdIrRF38PQjpeThI78dYasiJV87T6z1OxpBulK8BIjPfvHBdLEtW9N0kn3HU7y
        6sWSru1gpf7gKVZ62NfHSaebjpqkloZvpJoDU/7RrgEiXXSulypbNfg4+rPI5euUvNwSxZGU
        mhmZs7u52Vx4nNnQ/rQfSqHP5ASeR2EpBs9+5IRI3io0Au593MIaZAKw4dcKMMg44J9dzikl
        Ipy463QRQzgM+NzbyRlkDFB7UmcOuWKET7D1+x9JCM8WkvHk6Lbwu4zQwaJre2nYxE4JFacr
        IYQtQiq2De4P14mQgNeGBpkQniOswXNdHmJ4ovHsvqEwjhBS8F7NwXCWEWLxu4kms4Hj8Zex
        eibUDIUHPP4+3Goy5k5D35YKMHAM/tHTyhl4HvbWlBMjsAWwvP02Z5BqwHs93ulECnb2XDKH
        bsYIb+Exf5JRXok7q6qmTxmFN8aijSGi0OWrZYyyBcu2WQ13Aj7TaqfHseHOoVekGkT3jNXc
        M9Zxz1jH/X9fLxANYpViNT9bUZfYla8WqXK+WmzPXvRlQb4OU9+492XPRBv4n2cFQOBBnGXh
        54sZVrNcom7MDwDyjDjbIqfHZ1gt6+SNmxRHwReO4jxFDUAcT8RYy9ev3V9rFbLlImW9ohQq
        jv9UEx9hK4Vqy+U4/8X9vfd7tbmr3fH2RJr+w6efj0PMiQVtupiTtnLrO1vffFi4OXU8e9Ou
        5fOfnuHqkvXR7qwo8dXcsrr0YOnbNvigRn7v6uYbUUUBoSRXqk/LuEkSz4+UpxTczqI2LXg4
        qYNdtes3saFs8bK/1VWdHw5omZnvu39aezNpuEEkao6cnMg4VPlfv8cM1MIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0gTYRzHebzb7SbNzmX4ZPTHS4yiVue/PZZaEeERvoiKCNuqKy8NnZPd
        JhVhFhZ5lNrUrGFLIUVtC7vMNBXSzJJgpdmMsD8ywcyclEZZGW2OwHcf+H4+L37wIzFVpyyM
        PJ5t4o3ZXBZNBOLP/z59v74hcZVu46QUiUqufsJRnW0GoFlLjxxN1l4CyDa1DF2v+4Kjiw+/
        40hyu2To1cNKAlUMTRKoULoPUFd5B0Buq41Aju53clQ03oOh4qFBAvW3R6AZaRigsrE7clRV
        /xZH96RyDHX8ncHR2Ndn+NZQtrmtWcbabXbAvnL1YezvXxbATr8+G8C2Wt/J2SrJzEoNhQQ7
        5GonWI/TKWef1DsC2Hu3zrCl1V5/vHsYZ1+KmWxRUwPYFZyqTjAazCZ+ZYZBMCXSBxgUpWbi
        kToqJl7NRGt0m6Ji6Q1JCWl81vFc3rgh6bA6o8xul+U0Yifafg6BfOAMEIGChFQMfC9acBEE
        kiqqBsDejxUyEZDeIQzeLKD9ziL4xyUSfmccQE/1J9w3LKL2wqaCG3McQjGwdfzCnIRRnQR8
        0CLK/UUpBkunLst9FuG1Lj8pAj5WUkmwxX1T5mOcioCvR9yYjxdT+6HF1Yr7nWDYe31kjhXU
        ZvihtGauxajV8I+tH/NzKDw3XS/z8wr4YKISKwEq67zcOi+xzkus85IqgDeAEN4s6NP1QpRa
        4PSCOTtdfdSgl4D3fZp7ZppagOjZ0wUoEtALlORyWqeScbnCSX0XgCRGhyi53St0KmUad/IU
        bzQcMpqzeKELxHqPu4KFLT5q8D5jtukQE8toUDyjidZExyE6VHmR6tSqqHTOxGfyfA5v/N8F
        kIqwfJCaEFTbui6CeaQ1Bu3drl04uOWxM3zpNzL54DDJjZIOrfNFZ9zw5I6B5CXaNRFv3Hnn
        b3sq23TF9q9L74qPcw8WTvz8rQ685jmSto+OYRPT+zpMiqlIx+iFnSndec2NY5bZ04k/ajRl
        5Zb2VRXPHAOR4dsU0rGKH+Lqz3l3HPtSaFzI4Ji1mFHg/gEST985VAMAAA==
X-CMS-MailID: 20190708125714eucas1p1f71616c08694fb91f20a664e59c339d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190628130921eucas1p239935b0771032c331911eacc1a69dd2e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190628130921eucas1p239935b0771032c331911eacc1a69dd2e
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
        <20190621095252.32307-5-vincenzo.frascino@arm.com>
        <CGME20190628130921eucas1p239935b0771032c331911eacc1a69dd2e@eucas1p2.samsung.com>
        <1fd47b0d-f77f-8d07-c039-6ac9072834fc@samsung.com>
        <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
        <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
        <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo, 

On 6/29/19 08:58, Vincenzo Frascino wrote:
> If I may, I would like to ask to you one favor, could you please keep an eye on
> next and once those patches are merged repeat the test?
> 
> I want just to make sure that the regression does not reappear.

My apologies, I forgot about this for a moment. I repeated the test with 
next-20190705 tag and couldn't see any regressions.

-- 
Regards,
Sylwester
