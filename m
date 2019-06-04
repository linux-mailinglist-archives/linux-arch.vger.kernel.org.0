Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D7A3463C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfFDMIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 08:08:40 -0400
Received: from foss.arm.com ([217.140.101.70]:41574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfFDMIk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 08:08:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8922880D;
        Tue,  4 Jun 2019 05:08:39 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4FF3F690;
        Tue,  4 Jun 2019 05:08:36 -0700 (PDT)
Subject: Re: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-3-vincenzo.frascino@arm.com>
 <CAK8P3a3Sr+MNbGQiMYt3RrE6SaYFPO-rXNoNvtOC7=qKE1kuYQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d0ffed27-01eb-c382-a381-975edd021a30@arm.com>
Date:   Tue, 4 Jun 2019 13:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Sr+MNbGQiMYt3RrE6SaYFPO-rXNoNvtOC7=qKE1kuYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 31/05/2019 09:19, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> 
>> +
>> +static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
>> +{
> 
> Rather than marking every single function in here as "notrace",I think it
> would be more robust to remove the '-pg' flag in the CFLAGS used for
> compiling the vdso files.
> 

All the architectures that I added to this patchset are already compiled with
$(CC_FLAGS_FTRACE), hence I think I just forgot to remove the "notrace" around
the code. Will fix in v7.

>        Arnd
> 

-- 
Regards,
Vincenzo
