Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69F251563
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgHYJa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 05:30:26 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:33956 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgHYJa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 05:30:26 -0400
X-Greylist: delayed 2596 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 05:30:23 EDT
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=[192.168.0.10])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kAUbe-0002Te-3f; Tue, 25 Aug 2020 09:47:02 +0100
Subject: Re: [PATCH v7 10/10] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
To:     Ard Biesheuvel <ardb@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, wei.liu@kernel.org,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-11-git-send-email-mikelley@microsoft.com>
 <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <5e8af3c3-fe08-0a56-fe05-0527a6cae0dd@codethink.co.uk>
Date:   Tue, 25 Aug 2020 09:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHKDD5+Na7t=bbkqo2OaiidmnJg+RqermV-2=exj-P77A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24/08/2020 18:24, Ard Biesheuvel wrote:
> On Mon, 24 Aug 2020 at 18:48, Michael Kelley <mikelley@microsoft.com> wrote:
>>
>> Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
>> ARM64, causing the Hyper-V specific code to be built.
>>
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>   drivers/hv/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 79e5356..1113e49 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
>>
>>   config HYPERV
>>          tristate "Microsoft Hyper-V client drivers"
>> -       depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
>> +       depends on ACPI && \
>> +                       ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
>>          select PARAVIRT
>>          select X86_HV_CALLBACK_VECTOR
>>          help
> 
> Given the comment in a previous patch
> 
> +/*
> + * All data structures defined in the TLFS that are shared between Hyper-V
> + * and a guest VM use Little Endian byte ordering.  This matches the default
> + * byte ordering of Linux running on ARM64, so no special handling is required.
> + */
> 
> shouldn't this depend on !CONFIG_CPU_BIG_ENDIAN ?

or mark the data __le and have the appropriate accessor functions do
the swapping.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
