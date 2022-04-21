Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECC50A4B5
	for <lists+linux-arch@lfdr.de>; Thu, 21 Apr 2022 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390298AbiDUPzt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 11:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbiDUPzs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 11:55:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C4B15722
        for <linux-arch@vger.kernel.org>; Thu, 21 Apr 2022 08:52:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7F46153B;
        Thu, 21 Apr 2022 08:52:57 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 839853F73B;
        Thu, 21 Apr 2022 08:52:57 -0700 (PDT)
Message-ID: <52a79b24-deec-108e-4b7f-5bc33500c802@arm.com>
Date:   Thu, 21 Apr 2022 10:52:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, szabolcs.nagy@arm.com,
        yu-cheng.yu@intel.com, ebiederm@xmission.com,
        linux-arch@vger.kernel.org
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck> <Yl/ZCvPB2Qx98+OG@arm.com>
 <Yl/1KertC3/UtwR4@sirena.org.uk>
 <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com> <YmElD5AghKP4Zgdd@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <YmElD5AghKP4Zgdd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 4/21/22 04:34, Catalin Marinas wrote:
> On Wed, Apr 20, 2022 at 08:39:14AM -0500, Jeremy Linton wrote:
>> On 4/20/22 06:57, Mark Brown wrote:
>>> On Wed, Apr 20, 2022 at 10:57:30AM +0100, Catalin Marinas wrote:
>>>> On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
>>>>> Kees, please can you drop this series while Catalin's alternative solution
>>>>> is under discussion (his Reviewed-by preceded the other patches)?
>>>
>>>>> https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
>>>
>>>>> Both series expose new behaviours to userspace and we don't need both.
> [...]
>>>> Arguably, the two approaches are complementary but the way this series
>>>> turned out is for the BTI on main executable to be default off. I have a
>>>> worry that the feature won't get used, so we just carry unnecessary code
>>>> in the kernel. Jeremy also found this approach less than ideal:
>>>
>>>> https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com
>>>
>>> I'm not sure there was a fundamental concern with the approach there but
>>> rather some pushback on the instance on turning it off by default.
>>
>> Right, this one seems to have the smallest impact on systemd as it exists
>> today.
> 
> It had a bigger impact on glibc which had to rework the dynamic library
> mapping to use munmap/mmap() instead of an mprotect() (though that's
> already done). I think glibc still prefers the mprotect() approach for
> dynamic libraries.
> 
>> I would have expected the default to be on, because IMHO this set
>> corrects what at first glance just looks like a small oversight.
> 
> This was a design decision at the time, maybe not the best but it gives
> us some flexibility (and we haven't thought of MDWE).
> 
>> I find the ABI questions a bit theoretical, given that this should
>> only affect environments that don't exist outside of labs/development
>> orgs at this point (aka systemd services on HW that implements BTI).
> 
> The worry is not what breaks now but rather what happens when today's
> distros will eventually be deployed on large-scale BTI-capable hardware.
> It's a very small risk but non-zero. The idea is that if we come across
> some weird problem, a fixed-up dynamic loader could avoid enabling BTI
> on a per-process basis without the need to do this at the system level.
> 
> Personally I'm fine with this risk. Will is not and I respect his
> position, hence I started the other thread to come up with a MDWE
> alternative.

To clarify though, there is already a way to restore process 
functionality to the small subset of services with the MDWE enabled, 
which is simply to flip off MDWE on the service and let some future 
loader flag clear PROT_BTI in the code path it would normally be setting 
PROT_EXE|PROT_BIT on.

Or maybe simpler yet, we provide a tool which wipes out the gnu BTI note 
on binaries that are found to have BTI bugs, thereby (correctly) fixing 
the problem at its source. This is at least presumably doable if we are 
also assuming we can update glibc/etc in any environment with the problem.

But again, systemd MDWE + BTI are less than a dozen processes, and if we 
are worried about the big hammer of disabling BTI system wide, we 
probably should have the ability to disable it per-process rather than 
worrying about this obscure edge case.





> 
>> The other approach works, and if the systemd folks are on board with it also
>> should solve the underlying problem, but it creates a bit of a compatibility
>> problem with existing containers/etc that might exist today (although
>> running systemd/services in a container is itself a discussion).
>>
>> So, frankly, I don't see why they aren't complementary.
> 
> They are complementary, though if we change the MDWE approach, there's
> less of a need for this patchset.
> 

