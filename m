Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF512CBD26
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 13:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgLBMi3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 07:38:29 -0500
Received: from foss.arm.com ([217.140.110.172]:38408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgLBMi2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 07:38:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1910D101E;
        Wed,  2 Dec 2020 04:37:43 -0800 (PST)
Received: from [10.57.0.85] (unknown [10.57.0.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5473F718;
        Wed,  2 Dec 2020 04:37:40 -0800 (PST)
Subject: Re: [PATCH v4 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201201192801.27607-1-daniel.lezcano@linaro.org>
 <20201201192801.27607-4-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9db21e5e-ede0-87c3-a556-8a5e666d52bc@arm.com>
Date:   Wed, 2 Dec 2020 12:37:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201201192801.27607-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Daniel,

I realized small issue when I went through this new mutex code
(which is safer IMHO).

On 12/1/20 7:28 PM, Daniel Lezcano wrote:

[snip]

> +int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
> +{
> +	struct powercap_zone *pcz;
> +
> +	if (!pct)
> +		return -EAGAIN;
> +
> +	if (root && !parent)
> +		return -EBUSY;
> +
> +	if (!root && parent)
> +		return -EINVAL;
> +
> +	if (parent && parent->ops)
> +		return -EINVAL;
> +

Maybe it worth to add a check of dtpm pointer here, just to play safe?

	if (!dtpm)
		return -EINVAL;

The dtpm->ops might explode when we don't capture this miss-usage during
reviews of future drivers/shim layers. What do you think?


> +	if (dtpm->ops && !(dtpm->ops->set_power_uw &&
> +			   dtpm->ops->get_power_uw &&
> +			   dtpm->ops->release))
> +		return -EINVAL;
> +

I am going to stress test the whole series with hotplug today
and add review for patch 4/4.

Regards,
Lukasz
