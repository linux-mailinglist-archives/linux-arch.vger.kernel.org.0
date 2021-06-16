Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BE3A9104
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFPFOU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 01:14:20 -0400
Received: from foss.arm.com ([217.140.110.172]:54974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhFPFOT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 01:14:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9374212FC;
        Tue, 15 Jun 2021 22:12:13 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8403F719;
        Tue, 15 Jun 2021 22:12:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
 the interpreter
To:     Dave Martin <Dave.Martin@arm.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210604112450.13344-1-broonie@kernel.org>
 <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
 <20210615152203.GR4187@arm.com> <20210615153341.GI5149@sirena.org.uk>
 <20210615154106.GS4187@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <6a371853-1f48-3a69-6532-ca5c178cb3dc@arm.com>
Date:   Wed, 16 Jun 2021 00:12:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615154106.GS4187@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 6/15/21 10:41 AM, Dave Martin wrote:
> On Tue, Jun 15, 2021 at 04:33:41PM +0100, Mark Brown via Libc-alpha wrote:
>> On Tue, Jun 15, 2021 at 04:22:06PM +0100, Dave Martin wrote:
>>> On Thu, Jun 10, 2021 at 11:28:12AM -0500, Jeremy Linton via Libc-alpha wrote:
>>
>>>> Thus, I expect that with his patch applied to 5.13 the service will fail to
>>>> start regardless of the state of MDWE, but it seems to continue starting
>>>> when I set MDWE=yes. Same behavior with v1 FWTW.
>>
>>> If the failure we're trying to detect is that BTI is undesirably left
>>> off for the main executable, surely replacing BTIs with NOPs will make
>>> no differenece?  The behaviour with PROT_BTI clear is strictly more
>>> permissive than with PROT_BTI set, so I'm not sure we can test the
>>> behaviour this way.
>>
>>> Maybe I'm missing sometihng / confused myself somewhere.
>>
>> The issue this patch series is intended to address is that BTI gets
>> left off since the dynamic linker is unable to enable PROT_BTI on the
>> main executable.  We're looking to see that we end up with the stricter
>> permissions checking of BTI, with the issue present landing pads
>> replaced by NOPs will not fault but once the issue is addressed they
>> should start faulting.
> 
> Ah, right -- I got the test backwards in my head.  Yes, that sounds
> reasonable.

Yes, the good thing about doing both the success and failure cases 
rather than just checking smaps is that one can be assured the emulation 
env and all the pieces are working correctly, not just the mappings,


Anyway, it looks like v3 is behaving as expected, I'm going to let it 
run a few more tests and presumably post a tested-by on the set tomorrow.


Thanks,

> 
>>> Looking at /proc/<pid>/maps after the process starts up may be a more
>>> reliable approach, so see what the actual prot value is on the main
>>> executable's text pages.
>>
>> smaps rather than maps but yes, executable pages show up as "ex" and BTI
>> adds a "bt" tag in VmFlags.
> 
> Fumbled that -- yes, I meant smaps!
> 
> Ignore me...
> 
> Cheers
> ---Dave
> 

