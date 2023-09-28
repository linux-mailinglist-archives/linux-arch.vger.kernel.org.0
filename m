Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947167B0FD2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Sep 2023 02:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjI1AR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 20:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1AR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 20:17:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4C41114;
        Wed, 27 Sep 2023 17:17:56 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id C798520B74C0;
        Wed, 27 Sep 2023 17:17:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C798520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695860276;
        bh=apiqyVomDl3eH58Vs8mK0hqcp1k7lISOy2zAU3jCyNU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V8yNq7vak/Kr3K00IoP6fpQzGDvLsvy4Ezk9uAHfe4/mS3eMbtM8AOjTFUAcUd+m8
         Uy7bPwEC59miyqW9bO1K2C0BHSiD0UJAdT4igjnaL80svRDmpqu5ZuDj+DfThLWX/d
         EzQskjEpeqCkesXIudWToBYAWfoOBMOwhSz/l9+M=
Message-ID: <fda2a3dd-b325-4780-bd02-d1fedcaec260@linux.microsoft.com>
Date:   Wed, 27 Sep 2023 17:17:54 -0700
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
References: <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
 <2023092646-version-series-a7b5@gregkh>
 <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
 <2023092737-daily-humility-f01c@gregkh>
 <ZRPiGk9M3aQr99Y5@liuwe-devbox-debian-v2>
 <2023092757-cupbearer-cancel-b314@gregkh>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2023092757-cupbearer-cancel-b314@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/27/2023 1:33 AM, Greg KH wrote:
> On Wed, Sep 27, 2023 at 08:04:42AM +0000, Wei Liu wrote:
>> So, the driver is supposed to stash a pointer to struct device in
>> private_data. That's what I alluded to in my previous reply. The core
>> driver framework or the VFS doesn't give us a reference to struct
>> device. We have to do it ourselves.
> 
> Please read Linux Device Drivers, 3rd edition, chapter 3, for how to do
> this properly.  The book is free online.
> 

Thanks, the issue that confused us was how to get the miscdevice.
I eventually found the answer in the misc_register() documentation:

"By default, an open() syscall to the device sets file->private_data to
point to the structure."

That's good - when we create a guest, we will have the miscdevice
in private_data already. Then we can just put it in our per-guest data
structure. That will let us retrieve the device in the other ioctls so 
we can call dev_*().

Thanks,
Nuno
