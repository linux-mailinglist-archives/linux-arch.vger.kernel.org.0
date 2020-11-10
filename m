Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0962D2AD9A2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgKJPEi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 10:04:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJPEh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 10:04:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49EE412FC;
        Tue, 10 Nov 2020 07:04:37 -0800 (PST)
Received: from [10.57.21.178] (unknown [10.57.21.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A1FE3F718;
        Tue, 10 Nov 2020 07:04:35 -0800 (PST)
Subject: Re: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-4-daniel.lezcano@linaro.org>
 <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
 <313a92c5-3c45-616f-1fe8-9837721f9889@arm.com>
 <2495f9b8-327d-bf92-a159-ac3202d30ee0@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f002fb7b-b66f-fca5-06ea-e9ead319cdcc@arm.com>
Date:   Tue, 10 Nov 2020 15:04:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2495f9b8-327d-bf92-a159-ac3202d30ee0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/10/20 2:59 PM, Daniel Lezcano wrote:
> On 10/11/2020 12:05, Lukasz Luba wrote:
>>
>> Actually I've found one issue when I have been trying to clean
>> my testing branch with modified scmi-cpufreq.c.
> 
> IMO, those errors are not the dtpm framework fault but the scmi-cpufreq.

True, I have added this proposed macro directly into driver, but it's
not strictly the framework.

> 
> You should add a component in the drivers/powercap which does the glue
> between the scmi-cpufreq and the dtpm. No stub will be needed in this
> case as the component will depend on CONFIG_DTPM.
> 
> 
> 
> 

Make sense, the glue stick should take care in this scenario.

In this case, please keep the Reviewed-by and Tested-by and ignore
the previous email.
