Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B377AF68F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIZXJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 19:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIZXHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 19:07:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1719F1F07;
        Tue, 26 Sep 2023 15:09:30 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8203520B74C0;
        Tue, 26 Sep 2023 14:52:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8203520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695765150;
        bh=lBG32VN1WPmUQfi9u2u2mI5suzZ9jPlIJsDL8oCoWFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RUOHflWoCL1yJo7QG8SpRsR0JvJ63uqX6NBElJV56MVeITu5dsEGJsz3hwa2VuaUa
         InGza+C1Ui7v+F6YyVYOVwSOwcC5HN47dcLP61XUtdTvTrZBi8YIFNNoGJ1XXkBNgX
         615SLGTwD3n9Y+JYCaIz0XsLp7lT6Lhb/0bwl0R4=
Message-ID: <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
Date:   Tue, 26 Sep 2023 14:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
 <2023092646-version-series-a7b5@gregkh>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2023092646-version-series-a7b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/26/2023 1:03 AM, Greg KH wrote:
> On Tue, Sep 26, 2023 at 07:00:51AM +0000, Wei Liu wrote:
>> On Tue, Sep 26, 2023 at 08:31:03AM +0200, Greg KH wrote:
>>> On Tue, Sep 26, 2023 at 05:54:34AM +0000, Wei Liu wrote:
>>>> On Tue, Sep 26, 2023 at 06:52:46AM +0200, Greg KH wrote:
>>>>> On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
>>>>>> On 9/23/2023 12:58 AM, Greg KH wrote:
>>>>>>> Also, drivers should never call pr_*() calls, always use the proper
>>>>>>> dev_*() calls instead.
>>>>>>>
>>>>>>
>>>>>> We only use struct device in one place in this driver, I think that is the
>>>>>> only place it makes sense to use dev_*() over pr_*() calls.
>>>>>
>>>>> Then the driver needs to be fixed to use struct device properly so that
>>>>> you do have access to it when you want to print messages.  That's a
>>>>> valid reason to pass around your device structure when needed.
>>>>

What is the tangible benefit of using dev_*() over pr_*()? As I said,
our use of struct device is very limited compared to all the places we
may need to log errors.

pr_*() is used by many, many drivers; it seems to be the norm. We can
certainly add a pr_fmt to improve the logging.

>>>> Greg, ACRN and Nitro drivers do not pass around the device structure.
>>>> Instead, they rely on a global struct device. We can follow the same.
>>>
>>> A single global struct device is wrong, please don't do that.
>>>
>>> Don't copy bad design patterns from other drivers, be better :)
>>>

What makes it a bad pattern? It seems to be well-established, and is
also used by KVM which this driver is loosely modeled after:
https://elixir.bootlin.com/linux/v6.5.5/source/virt/kvm/kvm_main.c#L5128

>>
>> If we're working with real devices like network cards or graphics cards
>> I would agree -- it is easy to imagine that we have several cards of the
>> same model in the system -- but in real world there won't be two
>> hypervisor instances running on the same hardware.
>>
>> We can stash the struct device inside some private data fields, but that
>> doesn't change the fact that we're still having one instance of the
>> structure. Is this what you want? Or do you have something else in mind?
> 
> You have a real device, it's how userspace interacts with your
> subsystem.  Please use that, it is dynamically created and handled and
> is the correct representation here.
> 

Are you referring to the struct device we get from calling
misc_register? If not, please be more specific.

How would you suggest we get a reference to that device via e.g. open()
or ioctl() without keeping a global reference to it?


Thanks,
Nuno
