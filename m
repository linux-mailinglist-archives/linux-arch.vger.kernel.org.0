Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26E14D44D
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgA3AFy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jan 2020 19:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgA3AFy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 19:05:54 -0500
Received: from localhost (unknown [155.52.187.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF932064C;
        Thu, 30 Jan 2020 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580342753;
        bh=RD8R5bhq+y+f8c78zueZCIQP8RCMe+yn+jAfV18Fky4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJsllgdh0TWJtm6QZ4oPiE+5OfXumM59nxHWumYBFlGvZc6jzgV7ScA/4rj9mBo32
         GBZm1OJluswj8F+i3zsLabZGHCBVPzFVxyer1ZxP2zMj5f8SmJS5DHQij/zNasqH65
         7vCmDk/xWJ6oZq951PQ7SGkUf7RyWNB/2bCZVagg=
Date:   Wed, 29 Jan 2020 19:05:52 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Message-ID: <20200130000552.GD2896@sasha-vm>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
 <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 25, 2020 at 01:44:31AM +0000, Dexuan Cui wrote:
>> From: Dexuan Cui <decui@microsoft.com>
>> Sent: Monday, January 6, 2020 2:43 PM
>>
>> This is needed for hibernation, e.g. when we resume the old kernel, we need
>> to disable the "current" kernel's hypercall page and then resume the old
>> kernel's.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>
>> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
>>
>> Please review.
>>
>> If it looks good, can you please pick it up through the tip.git tree?
>>
>>  arch/x86/hyperv/hv_init.c | 48
>> +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>
>Hi, Vitaly and x86 maintainers,
>Can you please take a look at this patch?

Ping?

This patch has been floating around in it's current form for the past 2
months. I'll happily take Hyper-V patches under arch/x86/hyperv/ via the
Hyper-V tree rather than tip if the x86 folks don't want to deal with
them.

-- 
Thanks,
Sasha
