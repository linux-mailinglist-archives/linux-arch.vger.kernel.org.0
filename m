Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC290167E34
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgBUNPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:15:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58076 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgBUNPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:15:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200221131536euoutp0190cff42d53bec9f4969628354d1797be~1bTkjxqN_1773117731euoutp019
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 13:15:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200221131536euoutp0190cff42d53bec9f4969628354d1797be~1bTkjxqN_1773117731euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582290936;
        bh=ggi36fcyGcRdCu1tgC2NKjFogu0IUBoC26Y0OLUUqxI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a1XGhuigPS97pxY6VlHrGBiWblH0bTcQM8BUv2v0JWJ7loSQDdnLPTtQyOY/cCBnV
         VUPj6bu764jtyaBN0d0WNQd5ZdJqHe/j8Ok1ccnsBxnEiRh9lwTxhQ7mzFrDCJlAVF
         9LOSj+0u3cStUEMe5z6cFUQkuGC+tqMojdk+ljHU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200221131536eucas1p1f3d5f62244c43ec509b9ea6f6b154798~1bTkVOvO12832228322eucas1p1K;
        Fri, 21 Feb 2020 13:15:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 82.B0.60698.7F7DF4E5; Fri, 21
        Feb 2020 13:15:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200221131535eucas1p23a75f58c73a7352f616b24e668ed4a47~1bTj8Birj1495114951eucas1p25;
        Fri, 21 Feb 2020 13:15:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200221131535eusmtrp2f7d63ab8bbab7770247278f4e4cdcd85~1bTj7WOlx1394013940eusmtrp23;
        Fri, 21 Feb 2020 13:15:35 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e5-5e4fd7f7aa6e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.A7.08375.7F7DF4E5; Fri, 21
        Feb 2020 13:15:35 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200221131535eusmtip14d786ee3dc9a56b4b0837b3371c12e12~1bTjj3QX81468414684eusmtip1n;
        Fri, 21 Feb 2020 13:15:35 +0000 (GMT)
Subject: Re: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c2ee91f1-2951-1fc4-d549-106d7b1798e7@samsung.com>
Date:   Fri, 21 Feb 2020 14:15:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221130355.21373-1-vincenzo.frascino@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl9d5td8vZdTN8srBaJRikiQpXTVMM2o9KKUII1JbeVHJTdtU0
        giSxdElFtKwpJdP8WE5jptnAyFmbZk1TU7EP+1BEa4XZkFloblfLf+c5z3Pecw68BCZq5/gQ
        GYocWqmQZUq4ArzN7OjbPT8Sl7Tn43Q49aO2DFElRjtOGb4Mc6hBYyWXMqk7ENVn1HOoFoMa
        ozoWHTg1PduNR/OljXcakXRw+DUmNehKudLvVitP2lJzXjpn8I3nHhfsTaUzM/JoZWDUCUG6
        dmEczx4S5VfdH8EKkW69CvEJIEPAVHeJ68Qish7BwlCsCgmW8S8EJa+63dhhDkG5egitKirf
        TK4s6hD0lhoxdrAheGl+wFMhghCTR6G6S+nkvUj1svpyMXLyGKmARus650NcMghUNpXLWkhG
        QZXhp8sAJ3eCVX8Tc+INZCJUNHTh7I0n9NyecGE+uQ9sao3rHiO3QFFrBcZibxibuOsKB+QL
        HhQvNeFs6v3wfsq20kAMM5aHPBZvhqXHq4IiBJ+seh47lCEYvHBrRREB76wLXLaBPzQbA1k6
        BhymRVcxID1g1ObJhvCA623lGEsLoeSiiL32A42l6Z9tZ/8Adg1JNGuqadbU0aypo/nvW4Vw
        HfKmcxl5Gs0EK+gzAYxMzuQq0gJSsuQGtPyfehct9nb05M9JEyIJJHEXRpvjkkQcWR5TIDch
        IDCJl9DP/XCSSJgqKzhLK7OSlbmZNGNCmwhc4i0M1k4nisg0WQ59mqazaeXq1o3g+xQirzjt
        jUPJKfAsNHPsd4OOPMUMNzSPz+bqfCN4CYc4PsZQ/29uYVffem/lPDfVF92rq/DLH80zJ7cO
        x9IO+kOC/Ui6+HNJZMJUWNaVDEuR+zaPAzOC8IbqSP25mH7j03mtWOqRj2+3q/QHH3V+rREf
        C6ncqK+djJft6Bno0jr4EpxJlwXtwpSM7C9lmw8dSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7rfr/vHGWz5r2TxflkPo0XHrq8s
        FpseX2O1uLxrDpvFoal7GS3O71rLarF501Rmi73/frJYvPx4gsWB02PNvDWMHpevXWT22LSq
        k83j3blz7B6bl9R7fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqk
        b2eTkpqTWZZapG+XoJex6Nd9loIrQhULVl9nbmBcxd/FyMkhIWAiMefqUyYQW0hgKaNE159S
        iLiMxMlpDawQtrDEn2tdbF2MXEA1rxkl9p45zdLFyMEhLBAssfhwEUiNiMBURokZRzRBbGaB
        PInf01ezQNRPYpT4f+Ys2CA2AUOJrrcggzg5eAXsJBZs+sQIYrMIqEqcWzuNGcQWFYiVuDGz
        gwmiRlDi5MwnLCA2p4C9xNupsxghFphJzNv8kBnClpdo3jobyhaXuPVkPtMERqFZSNpnIWmZ
        haRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjcduxn5t3MF7aGHyIUYCDUYmH
        1+GYf5wQa2JZcWXuIUYJDmYlEV41Hr84Id6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hpoq8
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MGWGN3+oiSjR1mR7/
        cY1X27tHZN+3wIl/3s3Osbo4K3Op6zX3lqOKroIHuGVzVnve8fmx3tu54rqCSUq+0zSh7W1L
        HoYxJOXEOt5Qz3RhYq7R/XwwcpGwpOb+uBV71D/ENbjOjW/k4vzzJ/resnUVNa90qj50l0Ys
        mXNc/vjNdaovPtQVTHqhxFKckWioxVxUnAgAtEmzz90CAAA=
X-CMS-MailID: 20200221131535eucas1p23a75f58c73a7352f616b24e668ed4a47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200221130455eucas1p2aa4312aad606b53add889811d8e9fbc7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200221130455eucas1p2aa4312aad606b53add889811d8e9fbc7
References: <CGME20200221130455eucas1p2aa4312aad606b53add889811d8e9fbc7@eucas1p2.samsung.com>
        <20200221130355.21373-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 21.02.2020 14:03, Vincenzo Frascino wrote:
> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
>
>   $ make ARCH=arm multi_v7_defconfig
>   $ ./scripts/config -d VDSO
>   $ make
>
> drivers/clocksource/arm_arch_timer.c:73:44: error:
> ‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
>    static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
>                                               ^
> scripts/Makefile.build:267: recipe for target
> 'drivers/clocksource/arm_arch_timer.o' failed
> make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> scripts/Makefile.build:505: recipe for target 'drivers/clocksource' failed
> make[1]: *** [drivers/clocksource] Error 2
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1683: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
>
> Define VDSO_CLOCKMODE_ARCHTIMER as VDSO_CLOCKMODE_NONE when the vDSOs are
> not enabled to address the issue.
>
> Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode storage")
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks, this fixes the issue.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/clocksource/arm_arch_timer.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..619839221f94 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -49,6 +49,11 @@
>   #define CNTV_TVAL	0x38
>   #define CNTV_CTL	0x3c
>   
> +#ifndef CONFIG_GENERIC_GETTIMEOFDAY
> +/* The define below is required because on arm the VDSOs can be disabled */
> +#define VDSO_CLOCKMODE_ARCHTIMER	VDSO_CLOCKMODE_NONE
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
> +
>   static unsigned arch_timers_present __initdata;
>   
>   static void __iomem *arch_counter_base;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

