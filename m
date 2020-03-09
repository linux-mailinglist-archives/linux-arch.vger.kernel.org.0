Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3172017DE2F
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCILGu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 07:06:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgCILGu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 07:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648701FB;
        Mon,  9 Mar 2020 04:06:49 -0700 (PDT)
Received: from [10.37.12.115] (unknown [10.37.12.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BCE13F6CF;
        Mon,  9 Mar 2020 04:06:44 -0700 (PDT)
Subject: Re: [PATCH v2 00/20] Introduce common headers
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
 <3278D604-28F1-47A1-BAB8-D8EB439995E8@amacapital.net>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b18c7ce1-0948-a9e2-2d7e-d019669a71e1@arm.com>
Date:   Mon, 9 Mar 2020 11:07:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3278D604-28F1-47A1-BAB8-D8EB439995E8@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

On 3/6/20 4:04 PM, Andy Lutomirski wrote:

[...]

>>
>> To solve the problem, I decided to use the approach below:
>>  * Extract from include/linux/ the vDSO required kernel interface
>>    and place it in include/common/
> 
> I really like the approach, but I’m wondering if “common” is the right name. This directory is headers that aren’t stable ABI like uapi but are shared between the kernel and the vDSO. Regular user code should *not* include these, right?
> 
> Would “vdso” or perhaps “private-abi” be clearer?
> 

Thanks! These headers are definitely not "uapi" like and they are meant to
evolve in future like any other kernel header. We have just to make sure that
the evolution does not break what we are trying to achieve with this series.

I have to admit that I spent quite some time in choosing the name and I am not
completely satisfied with "common" either. The reason why I ended up with this
is that the headers are common in between the kernel and the vdso (userspace)
but I agree that it does not make completely self explanatory.

Using "vdso" would mean according to me that those are vdso only headers,
probably "private-abi" is the best choice here. If there is enough consensus, I
am happy to rework my patches accordingly. What do you think?

>>  * Make sure that where meaningful the kernel includes "common"
>>  * Limit the vDSO library to include headers coming only from UAPI
>>    and "common" (with 2 exceptions compiler.h for barriers and
>>    param.h for HZ).
>>  * Adapt all the architectures that support the unified vDSO library
>>    to use "common" headers.
> 
[...]

-- 
Regards,
Vincenzo
