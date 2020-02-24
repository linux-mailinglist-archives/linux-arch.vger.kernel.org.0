Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618AC16A397
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgBXKMk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 05:12:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXKMk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 05:12:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7FB430E;
        Mon, 24 Feb 2020 02:12:39 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CF83F703;
        Mon, 24 Feb 2020 02:12:37 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Fix arm_arch_timer clockmode when vDSO disabled
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux@armlinux.org.uk, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
 <20200222104005.6fc4019d@why> <87h7zg4adw.fsf@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8d93d59b-f7fd-ec88-f915-0460c823992e@arm.com>
Date:   Mon, 24 Feb 2020 10:12:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87h7zg4adw.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/24/20 9:12 AM, Thomas Gleixner wrote:
> Marc Zyngier <maz@kernel.org> writes:
>> On Fri, 21 Feb 2020 18:18:46 +0000
>> Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
>>>
>>> This patch series addresses the issue defining a default arch clockmode
>>> for arm and arm64 and using it to initialize the arm_arch_timer.
>>
>> arm only. arm64 is just fine.
> 
> Right. ARM64 unconditionaly enables VDSO
> 
>>
>> This doesn't apply to -rc2, and is rather against next.
> 
> More precise it's against tip timers/core which has the VDSO changes
> which caused this fallout.
>

Agree, I will fix it in the next iteration.

>>> Vincenzo Frascino (3):
>>>   arm: clocksource: Add VDSO default clockmode
>>>   arm64: clocksource: Add VDSO default clockmode
>>>   clocksource: Fix arm_arch_timer clockmode when vDSO disabled
>>
>> Please squash the three patches into a single one. There is zero point
>> in having 3 patches for something that small.
> 
> I really don't see why we need all this redefine foo. What's wrong with
> the obvious?
> 
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -69,7 +69,12 @@ static enum arch_timer_ppi_nr arch_timer
>  static bool arch_timer_c3stop;
>  static bool arch_timer_mem_use_virtual;
>  static bool arch_counter_suspend_stop;
> +
> +#ifdef CONFIG_GENERIC_GETTIMEOFDAY
>  static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
> +#else
> +static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
> +#endif
>  
>  static cpumask_t evtstrm_available = CPU_MASK_NONE;
>  static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
> 

Nothing, I agree :) I think we over engineered here a bit.

-- 
Regards,
Vincenzo
