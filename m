Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9E27840
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfEWIlp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 04:41:45 -0400
Received: from foss.arm.com ([217.140.101.70]:40174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfEWIlp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 04:41:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF388341;
        Thu, 23 May 2019 01:41:44 -0700 (PDT)
Received: from [10.1.39.23] (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0047B3F575;
        Thu, 23 May 2019 01:41:41 -0700 (PDT)
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target
 symbol
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, james.morse@arm.com, will.deacon@arm.com,
        guillaume.gardet@arm.com, mark.rutland@arm.com, mingo@kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, x86@kernel.org
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com>
Message-ID: <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
Date:   Thu, 23 May 2019 09:41:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> 
> 
> On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
>> The following commit
>>
>>    7290d5809571 ("module: use relative references for __ksymtab entries")
>>
>> updated the ksymtab handling of some KASLR capable architectures
>> so that ksymtab entries are emitted as pairs of 32-bit relative
>> references. This reduces the size of the entries, but more
>> importantly, it gets rid of statically assigned absolute
>> addresses, which require fixing up at boot time if the kernel
>> is self relocating (which takes a 24 byte RELA entry for each
>> member of the ksymtab struct).
>>
>> Since ksymtab entries are always part of the same module as the
>> symbol they export (or of the core kernel), it was assumed at the
>> time that a 32-bit relative reference is always sufficient to
>> capture the offset between a ksymtab entry and its target symbol.
>>
>> Unfortunately, this is not always true: in the case of per-CPU
>> variables, a per-CPU variable's base address (which usually differs
>> from the actual address of any of its per-CPU copies) could be at
>> an arbitrary offset from the ksymtab entry, and so it may be out
>> of range for a 32-bit relative reference.
>>

(Apologies for the 3-act monologue)

This turns out to be incorrect. The symbol address of per-CPU variables 
exported by modules is always in the vicinity of __per_cpu_start, and so 
it is simply a matter of making sure that the core kernel is in range 
for module ksymtab entries containing 32-bit relative references.

When running the arm64 with kaslr enabled, we currently randomize the 
module space based on the range of ADRP/ADD instruction pairs, which 
have a -/+ 4 GB range rather than the -/+ 2 GB range of 32-bit place 
relative data relocations. So we can fix this by simply reducing the 
randomization window to 2 GB.

So please disregard this patch (and the followup one against arch/x86/tools)

-- 
Ard.
