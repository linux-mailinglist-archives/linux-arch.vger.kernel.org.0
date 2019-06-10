Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541973B2E8
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbfFJKTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 06:19:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389195AbfFJKTT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 06:19:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A65B4337;
        Mon, 10 Jun 2019 03:19:18 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350C03F557;
        Mon, 10 Jun 2019 03:20:58 -0700 (PDT)
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
To:     Huw Davies <huw@codeweavers.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
 <20190610093447.GC11076@merlot.physics.ox.ac.uk>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <90329b94-6cac-63dd-acad-a04c0d283a83@arm.com>
Date:   Mon, 10 Jun 2019 11:19:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610093447.GC11076@merlot.physics.ox.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/06/2019 10:34, Huw Davies wrote:
> On Thu, May 30, 2019 at 03:15:15PM +0100, Vincenzo Frascino wrote:
>> With the definition of the unified vDSO library the implementations of
>> update_vsyscall and update_vsyscall_tz became quite similar across
>> architectures.
>>
>> Define a unified implementation of this two functions in kernel/vdso and
> 
> ... of these two functions ...

Thanks for this, I will fix in v7.

> 
>> provide the bindings that can be implemented by every architecture that
>> takes advantage of the unified vDSO library.

-- 
Regards,
Vincenzo
