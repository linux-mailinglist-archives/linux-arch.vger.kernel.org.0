Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB55508973
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiDTNmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378590AbiDTNmQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 09:42:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6B774338F
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 06:39:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899AA23A;
        Wed, 20 Apr 2022 06:39:29 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388FF3F5A1;
        Wed, 20 Apr 2022 06:39:29 -0700 (PDT)
Message-ID: <d6c4e1ca-b485-48e5-ede9-d346bd0af599@arm.com>
Date:   Wed, 20 Apr 2022 08:39:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, hjl.tools@gmail.com,
        libc-alpha@sourceware.org, szabolcs.nagy@arm.com,
        yu-cheng.yu@intel.com, ebiederm@xmission.com,
        linux-arch@vger.kernel.org
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
 <20220420093612.GB6954@willie-the-truck> <Yl/ZCvPB2Qx98+OG@arm.com>
 <Yl/1KertC3/UtwR4@sirena.org.uk>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <Yl/1KertC3/UtwR4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 4/20/22 06:57, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 10:57:30AM +0100, Catalin Marinas wrote:
>> On Wed, Apr 20, 2022 at 10:36:13AM +0100, Will Deacon wrote:
> 
>>> Kees, please can you drop this series while Catalin's alternative solution
>>> is under discussion (his Reviewed-by preceded the other patches)?
> 
>>> https://lore.kernel.org/r/20220413134946.2732468-1-catalin.marinas@arm.com
> 
>>> Both series expose new behaviours to userspace and we don't need both.
> 
>> I agree. Even though the patches have my reviewed-by, I think we should
>> postpone them until we figure out a better W^X solution that does not
>> affect BTI (and if we can't, we revisit these patches).
> 
> Indeed.  I had been expecting this to follow the pattern of the previous
> nine months or so and be mostly ignored for the time being while
> Catalin's new series goes forward.  Now that it's applied it might be
> worth keeping the first patch still in case someone else needs it but
> the second patch can probably wait.
> 
>> Arguably, the two approaches are complementary but the way this series
>> turned out is for the BTI on main executable to be default off. I have a
>> worry that the feature won't get used, so we just carry unnecessary code
>> in the kernel. Jeremy also found this approach less than ideal:
> 
>> https://lore.kernel.org/r/59fc8a58-5013-606b-f544-8277cda18e50@arm.com
> 
> I'm not sure there was a fundamental concern with the approach there but
> rather some pushback on the instance on turning it off by default.

Right, this one seems to have the smallest impact on systemd as it 
exists today. I would have expected the default to be on, because IMHO 
this set corrects what at first glance just looks like a small 
oversight. I find the ABI questions a bit theoretical, given that this 
should only affect environments that don't exist outside of 
labs/development orgs at this point (aka systemd services on HW that 
implements BTI).


The other approach works, and if the systemd folks are on board with it 
also should solve the underlying problem, but it creates a bit of a 
compatibility problem with existing containers/etc that might exist 
today (although running systemd/services in a container is itself a 
discussion).

So, frankly, I don't see why they aren't complementary. This fixes a bug 
we have today, the other set creates a generic mechanism for the future.

Thanks,

