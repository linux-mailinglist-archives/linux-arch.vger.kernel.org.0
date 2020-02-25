Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4135E16BA79
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 08:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgBYHRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 02:17:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36855 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgBYHRN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 02:17:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200225071711euoutp02393390631d833d25542a782d0275abc2~2k-yDj4o22728027280euoutp024
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 07:17:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200225071711euoutp02393390631d833d25542a782d0275abc2~2k-yDj4o22728027280euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582615031;
        bh=Bojt6DKlC7Lzwtf06r54tTUllKU5i9UGy8RX11FRzVo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VZLIHq/M5FnARW8q6915EjZfge+z+HlfGk5oEEoKVTC1rrtHkJUCGfGJw9H5VYYhb
         0tq12IoFyHZqTdHB8drjJ00MwA3eNmyWhXbsWTQhIDdO7Xb1+rHD6KwiAUbXlg7RB6
         WAsPEGzKbziHP5muUe0HKfRWp1zbwCm269M8/dpE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200225071711eucas1p20d9822a03d85955f01a9e074761ed5e0~2k-x1LB4r0695706957eucas1p2b;
        Tue, 25 Feb 2020 07:17:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.AD.60698.7F9C45E5; Tue, 25
        Feb 2020 07:17:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200225071711eucas1p1c91a3df0b578bdf14cbd1fa3432553d7~2k-xYsL5o0726307263eucas1p1_;
        Tue, 25 Feb 2020 07:17:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200225071711eusmtrp237ddec7c479fa631d97ca876dd418432~2k-xX8T7l2759227592eusmtrp2Z;
        Tue, 25 Feb 2020 07:17:11 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-8b-5e54c9f77b62
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.79.08375.7F9C45E5; Tue, 25
        Feb 2020 07:17:11 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200225071710eusmtip10f8f9e9df04817865fa3ca3abb9c94d5~2k-wy6VN20421204212eusmtip1k;
        Tue, 25 Feb 2020 07:17:10 +0000 (GMT)
Subject: Re: [PATCH v3] clocksource: Fix arm_arch_timer clockmode when vDSO
 disabled
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        maz@kernel.org, Mark.Rutland@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <368f9cf7-5d9c-c671-8355-82f0f6e549aa@samsung.com>
Date:   Tue, 25 Feb 2020 08:17:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224151552.57274-1-vincenzo.frascino@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b3brtbsbho+qBSMCpLSxMirhSaEDSKKin5Is6ZeVHJqu2ra
        jzK/WyZ+DXWKZpim+JGbii6UnORc2kxnJvbFUgKNWWlSmmhuV8t/55znPO9zDrwEJhrguhEx
        cYm0Ik4WK+Y54p0Dy6bDv4yXwo6YtR7Ut7o8ROXqlnBKMz3Bpcy6Sh6lV/UgakTXzKUevx3l
        UN2VRi6l1agwqmdtGadmfwziJ3dImqqakMQ8MYpJNI33eJJ5k4kv0dbekSxq9pznhTqeiKRj
        Y5JphXfgNcdopakPS/jjkjL6+RlKQzqhEjkQQB6FV99HOErkSIjIJwg+dM1tkp8IMi1fN8ki
        gg5jGW9r5eVEB8YO6hHUP0jbJFYE5uelyOZyJi/DwBs9bhu4kCoEpfezkI1gZAmCactDrs3F
        I31AaVXa3xWQgdCUm23XcXI/pC/08m14NymFioZ+nPUIwVg+Y8cOZBC8yNHb/Ri5FzI6KjAW
        u8LUTLU9OJATfCjuqsfZ4KfAtP5lEzvDnKGdz2IPWO/eWshAYDE181mSt1EovQyxruPw3rSy
        EZXYOHEQWnXerBwMKksOxyYD6QSTViEbwgmKOksxVhZAbraIdR8AtaHl39m+12NYARKrt1VT
        b6uj3lZH/f/uQ4Q3Ilc6iZFH0YxvHH3Ti5HJmaS4KK+IeLkGbfyuoTXDUhfqXQ3XI5JA4p0C
        6LkYJuLKkplUuR4BgYldBGfQhTCRIFKWeotWxF9VJMXSjB65E7jYVeD7aFYqIqNkifR1mk6g
        FVtTDuHglob83c/1LfgNtzBZIdPrJQU1vdW1WXWf+BWRuwKGbpNuAeNSoX/6aMJcxmS4zOeG
        tlCRspofGGGomm5QtXkO8/fhuisVfqGZdeXz5sbyYm1r+xT3Y7fknVfQ2KFi6BVak9vG7z5d
        Dz4WsqqLlcqDajLPFjJTg0Wno7L7f+fPL62IcSZa5uOJKRjZX04ZU6NZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7rfT4bEGVzpZrZ4v6yH0aJj11cW
        i02Pr7FaXN41h83i0NS9jBbnd61ltVh6/SKTxc45J1ktNm+aymyx999PFouXH0+wOHB7rJm3
        htHj8rWLzB6bVnWyebw7d47dY/OSeo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxM
        LPUMjc1jrYxMlfTtbFJSczLLUov07RL0MrrOHWQu+C1ScfHRbsYGxl2CXYycHBICJhKnrm1l
        7mLk4hASWMoo8ftJGwtEQkbi5LQGVghbWOLPtS42iKLXjBKnbnxhBkkIC4RJHLt6CKxBRGAq
        o8SMI5ogRcwCUxglZq7qZ4LomMQosWN9H1gVm4ChRNdbkFGcHLwCdhJrOtrAVrAIqEo0fdrH
        DmKLCsRK3JjZwQRRIyhxcuYTsF5OAXuJo+2HwOqZBcwk5m1+yAxhy0s0b50NZYtL3Hoyn2kC
        o9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGRuu3Yz807GC9t
        DD7EKMDBqMTDK7E3OE6INbGsuDL3EKMEB7OSCK83Y1CcEG9KYmVValF+fFFpTmrxIUZToOcm
        MkuJJucDk0heSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGmbfe
        dRwr+r/7m7VuSOrONS9l1sVO1Vg/ST/jt2AX57UPc+uKk/57iYUe9P3Cu9vHf6Lb5stb9x/5
        /2bSu45tOmsfZWSZ7lgyIdCzUI25mS32sNvRCa/8HmS869/SHyLR6HWw+2jIsnifTp6v4fWp
        l7nOWhilGEYcYd/qXXFYt3Yez8Y8pkWblFiKMxINtZiLihMBYLGeC+oCAAA=
X-CMS-MailID: 20200225071711eucas1p1c91a3df0b578bdf14cbd1fa3432553d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200224151611eucas1p2d5e9492e4497edd18a322fdfc33547bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200224151611eucas1p2d5e9492e4497edd18a322fdfc33547bf
References: <CGME20200224151611eucas1p2d5e9492e4497edd18a322fdfc33547bf@eucas1p2.samsung.com>
        <20200224151552.57274-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 24.02.2020 16:15, Vincenzo Frascino wrote:
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
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/clocksource/arm_arch_timer.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> This patch has been rebased and tested on tip/timers/core.
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index ee2420d56f67..d53f4c7ccaae 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -69,7 +69,11 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
>   static bool arch_timer_c3stop;
>   static bool arch_timer_mem_use_virtual;
>   static bool arch_counter_suspend_stop;
> +#ifdef CONFIG_GENERIC_GETTIMEOFDAY
>   static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
> +#else
> +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
> +#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
>   
>   static cpumask_t evtstrm_available = CPU_MASK_NONE;
>   static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

