Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D525A15E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF1QuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 12:50:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44004 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfF1QuU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jun 2019 12:50:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190628165018euoutp0121f2c82f48fbc8897dc34f2a3ad6ac4e~satF61Su82831028310euoutp01j
        for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2019 16:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190628165018euoutp0121f2c82f48fbc8897dc34f2a3ad6ac4e~satF61Su82831028310euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561740618;
        bh=FWXP4pNRujl1+9dygeRIOsIYNQFFOrstobtjVi96TA0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XO7RX9SR3tBF7Ra6qanxFfQ/5PkXBeDqXQu9RxguzdVTHN9oFuPrYTg/sRwOGempN
         FI8j6JE9jvZfdLAajR0g+ctUKb0TS5zCHsFaaed9sVpEsCXhS2wAvkRbFVuzUcKQca
         SzTE6+wCu75e9qKS0Fh1Hb2le4bLuk1HBtZDAKmY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628165017eucas1p1f0f04698117f80224d5c8f00ba920dc0~satET2Xqg2591325913eucas1p17;
        Fri, 28 Jun 2019 16:50:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.7A.04325.845461D5; Fri, 28
        Jun 2019 17:50:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628165015eucas1p15a2f228181560f882bb184452ff3a9a5~satDRvW4F3190031900eucas1p1i;
        Fri, 28 Jun 2019 16:50:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628165015eusmtrp1937d2b28d23cd75d8f17b7f4ef31773c~satDDbpPf0190901909eusmtrp1s;
        Fri, 28 Jun 2019 16:50:15 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-a5-5d16454861ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.F0.04146.745461D5; Fri, 28
        Jun 2019 17:50:15 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628165014eusmtip2df0102387418b63f3c96b10b46cae10e~satCMNFmU1768817688eusmtip2i;
        Fri, 28 Jun 2019 16:50:14 +0000 (GMT)
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
Message-ID: <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
Date:   Fri, 28 Jun 2019 18:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxj167t9fVRrHhXhA3UuDSawKY7oH1cxRhaN74+ZmGii0TDt9FEJ
        pZIWHLqoqPgDZG2laqUqq4lOaBSTR2lGAdEKVGMkajP8ASqkzFiZihFMGJuO9rGM/875vnPP
        uefmcoy2nk3h8kxFotmkN+pYNfF1jnYtEFYl5nxTNjif2k+/IrS2ZhToP1WdKvru10qgNR/m
        0OraPwk95h8hVAp3K2nIf46lzt53LC2XGoEGTrUCDbtqWHq1/ZmKWgc7GWrrfcTShy2pdFTq
        B3oyUq+i7rqnhDZIpxja+mmU0Mj722RFkuBr9imFKzVXQAh1P2CEsb+qQBj+/YBCaHI9Uwlu
        qViQPOWs0Nvdwgpvu7pUQkfdVYXQcHG/4Lgwrh9s7yfC/Yp8wer1wNr4Tepl20Vj3i7RvHD5
        VvWOzzd62MJfZpbUD0dIKXjiKyCOQ34xXhoJsxWg5rR8LeDTUJNKJsOAbafblTL5AOhxjikq
        gIsd+WhNlueXARsdpUQmbwDDbSNM1HcGvx69ZedJFCfwmdg0eCSWwfCtLFYdLVVGF+z44ucO
        K0Sxhl+O/X9cV0Qx4eeh9KIlZjST34ghr39CE493qgdipnF8FvY9uh2bM3wSHhyuU8p4Lh5q
        PMtEw5Af4vB5vYORr70SPWGDXHoGvg56VTKejXcdlUTWHwKsbO5RycQO+CLoBlmVhbeCD5RR
        I4ZPx2v+hfI4G4/bbBPPMh0fv4mX7zAdq3zOiVgNHjuildWpOOZxKmScgscHPhM76FyTmrkm
        tXFNauP6P9cNxANJYrGlwCBaFpnEHzMs+gJLscmQsW1ngQTjv/jup+DIb3D97x8CwHOgm6Zx
        qxNztEr9LsvuggAgx+gSNMldCTlazXb97j2ieecWc7FRtARgFkd0SZqfpvRt1vIGfZGYL4qF
        ovm/rYKLSymF73O7l+Vak/fvg6GLWdk3+43f5ZVIzZsPD13L1ZyZbfw2v+xej25VKm868cXX
        tm3Jq7cEXi5tu5NR21GyuMe3pulW9pOp5f7VmY7sl/bQpaVH16XtPfwlFG59lWZP9RYh3Oy7
        HNAYKgdctili8IQzcnDDpiXO9OrEMLvywrwV4fSIjlh26DO/YswW/b/0LPp8wQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURiAO7t3d3fS4m7qPC6jWFkRNLt+7Wgm9SO8BUVRlH0MXXrR0LnY
        3SrDyDJERy2zNJo1V1aoTan5UdkqHWZGMMrKoLQyNbKZUi1xZR+bI/Dfw3ueh5cDL4lJHvBl
        5N48PavLU+fKiSD8yZ9Hb5enrJWqVkzWRqKyyk84qrV4Afpd3iVA49dOAGT5Pg+drx3FUUnb
        DxzZB3v56HnbBQKd6xsnUKm9BSBnxT2ABs0WAjV09guQyd2FoVN9rwjU41iEvPYBgM6ONAqQ
        te41jprsFRi698eLo5Gv3fjqMKb1biufsVlsgHne+wxjfv0sB4zn5VEec8fcL2CsdgNjry8l
        mL5eB8GMuVwC5mFdA49punKEOXPJ57s7B3DmqTGHMTXXg03inYokndagZxdkazn9KvkuGkUr
        6ASkiI5NUNAxSlVidJw8Kjkpk83du5/VRSWnK7L/tr8h9lWHHmz0jOCFoF5sBCQJqVg4YQo3
        AiEpoa4C+LrzQGAsg9XH5f4xpILhVK+RMIIgn+IGsMT4gu9/CKa2wubjF3E/h1A0vOMunpYw
        qoOAt24bBYGigQfHK3sIv0X4rJMPTcDPIioZDgzf5/kZpyKh/Z0D83MolQpNxVVEwBHDx+eH
        pjcIqZXw/avu6RajlsApSw8W4DB4zFPHD/B8WNRShZUBiXlGbp6RmGck5hmJFeD1IIQ1cJos
        DUcrOLWGM+RlKTK0GjvwHU9rl7fpNui5ucUJKBLIZ4usQVKVhK/ez+VrnACSmDxEFO4KUUlE
        mer8Q6xOm6Yz5LKcE8T5Pncak4VmaH2nmKdPo+NoJUqglTHKmHgkDxOVUB27JVSWWs/msOw+
        Vve/45FCWSGIkCw+1/ihck/EZ2V60fDownbHmsnUxtL0mjlHN24YGvtyPQoGf5O6NrcmFb51
        eQ5vLxoO717JW16TcQMLmloEpa510SprQkrc/QYx0l6eUB6zFawvjpnL5eQ/rtDFp3ptmbXb
        duxaIt5M1p2ddSAxpcQs/Mgr8NxVRtDm1Uudf+U4l62ml2E6Tv0PUoU+JFIDAAA=
X-CMS-MailID: 20190628165015eucas1p15a2f228181560f882bb184452ff3a9a5
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On 6/28/19 16:32, Vincenzo Frascino wrote:
> On 6/28/19 2:09 PM, Marek Szyprowski wrote:
>> On 2019-06-21 11:52, Vincenzo Frascino wrote:
>>> To take advantage of the commonly defined vdso interface for
>>> gettimeofday the architectural code requires an adaptation.
>>>
>>> Re-implement the gettimeofday vdso in C in order to use lib/vdso.
>>>
>>> With the new implementation arm64 gains support for CLOCK_BOOTTIME
>>> and CLOCK_TAI.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> Tested-by: Shijith Thotton <sthotton@marvell.com>
>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>> This patch causes serious regression on Samsung Exynos5433 SoC based 
>> TM2(e) boards. The time in userspace is always set to begin of the epoch:
>>
>> # date 062813152019
>> Fri Jun 28 13:15:00 UTC 2019
>> # date
>> Thu Jan  1 00:00:00 UTC 1970
>> # date
>> Thu Jan  1 00:00:00 UTC 1970
>>
>> I've noticed that since the patch landed in Linux next-20190625 and 
>> bisect indeed pointed to this patch.
>>
> Thank you for reporting this, seems that the next that you posted is missing
> some fixes for arm64.
> 
> Could you please try the tree below?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> 
> Let us know if the functionality is restored. Otherwise the issue will require
> further investigation.
 
Marek is already out for holidays, I gave your tree a try but kernel from 
that branch was failing to boot on TM2(e).  

Then I have cherry-picked 5 patches from the branch that seemed to 
be missing in next-20190628:

28028f3174cf1 (HEAD) MAINTAINERS: Fix Andy's surname and the directory entries of VDSO
ec8f8e4bf2206 arm64: vdso: Fix compilation with clang older than 8
721882ebb5729 arm64: compat: Fix __arch_get_hw_counter() implementation
7027fea977a3d arm64: Fix __arch_get_hw_counter() implementation
10b305853fe22 lib/vdso: Make delta calculation work correctly
48568d8c7f479 (tag: next-20190628, linux-next/master) Add linux-next specific files for 20190628

With those 5 additional patches on top of next-20190628 the problem
is not observed any more. date, ping, etc. seems to be working well.

# date
Fri Jun 28 16:39:22 UTC 2019
#
# systemctl stop systemd-timesyncd
#  
# date 062818392019
Fri Jun 28 18:39:00 UTC 2019
# date
Fri Jun 28 18:39:01 UTC 2019
# 
# date 062818432019; date
Fri Jun 28 18:43:00 UTC 2019
Fri Jun 28 18:43:00 UTC 2019
# date
Fri Jun 28 18:43:04 UTC 2019

--
Regards,
Sylwester
