Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CD2A4F26
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgKCSnA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbgKCSnA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:43:00 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25EFC0617A6
        for <linux-arch@vger.kernel.org>; Tue,  3 Nov 2020 10:42:59 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so19609044wrn.0
        for <linux-arch@vger.kernel.org>; Tue, 03 Nov 2020 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooc/4skm8b41a0c2OVLhlIuGfy2g3W0VRGaKqUSnLp8=;
        b=ctpRq/I4KR2iZH4NQ6gdEh86ePuqpslZPlOn1mdzkX+79TdYTXNdWmtONeK67ocwGN
         pnpFAv/UkMXqgSNTbgfO35gWmZtYuIVWAdwrgjXu9RMB5KxH7c7zATXBzZmaOElSiDzK
         NwvUz6Q7ybj6DW34pIRDPsIQxRJWCajO81s7pGSLsvZdDy4fznW7405Todk5u6FFSd8s
         KufWeN1WYlltVwSLTeOsO/I3lDFOi50n4uyXpU73x1h9OW13mFZ3neTy+WIlQ4D2ERrR
         Phr0M4VzKyHdBJRzm+yQYqHyZiwM7sd9CoSEn8FYbmb5jNyA9AzBl0YZPKLHr68DCKPX
         DbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooc/4skm8b41a0c2OVLhlIuGfy2g3W0VRGaKqUSnLp8=;
        b=uEpmxZVhFp0z0V40SgjWJ5vY4I/8ubAaN554oKXmYBwUBcZ2M/OzHZ6gXjKcaY8djS
         sii/P6OPIa1GCiyvwtYvTRCeuQkm6p2ycXOmLs5DppyC2vM6y3mRByMS76j0nDRRHhRy
         nImYF93eraweXPLmV0rsOO8h+DuF2Zr//U58ZS7h84Va15vovrSbbQ1XatfddeA14IoP
         eJdhlZyK+G33JtAJhCA2DNWqx9ZVB1D7SGGndNJg/p0+7MZ+yJ8TLB7HbgKEuTS3vGD/
         C9IeOX0Mhlcrdpc3VCpZSbzRKPncwkoREr7gwpHfVYikXiP7kINTXOEJ1DZLG4NnOID1
         VNaQ==
X-Gm-Message-State: AOAM533PKZLCyVQ+drlNkCyBhBPID/CgHavevKOU0Jqvq/+EyQmd8MnG
        cQc9qJmFDTgzSHQi5GbKOQq5tCAi1Opt0Q==
X-Google-Smtp-Source: ABdhPJzSCwPs9bpReY1ZvH8McvR4XSDVsk/2lcaduCUpzCaPFMntxFxfCSMOOzAZtvID82wFkespPQ==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr28278104wru.356.1604428977874;
        Tue, 03 Nov 2020 10:42:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f853:3b7b:eb7b:1bf? ([2a01:e34:ed2f:f020:f853:3b7b:eb7b:1bf])
        by smtp.googlemail.com with ESMTPSA id y20sm3731260wma.15.2020.11.03.10.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 10:42:57 -0800 (PST)
Subject: Re: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-4-daniel.lezcano@linaro.org>
 <4484e771-9011-0928-e961-cd3a53be55e9@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <18d2393a-2954-f271-817f-f9f9bf651f25@linaro.org>
Date:   Tue, 3 Nov 2020 19:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4484e771-9011-0928-e961-cd3a53be55e9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Lukasz,

thanks for the review and the comments.

On 23/10/2020 12:29, Lukasz Luba wrote:
> Hi Daniel,

[ ... ]

>> +
>> +config DTPM
>> +    bool "Power capping for dynamic thermal power management"
> 
> Maybe starting with capital letters: Dynamic Thermal Power Management?

Ok, noted.

[ ... ]

>> +++ b/drivers/powercap/dtpm.c
>> @@ -0,0 +1,430 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2020 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * The powercap based Dynamic Thermal Power Management framework
>> + * provides to the userspace a consistent API to set the power limit
>> + * on some devices.
>> + *
>> + * DTPM defines the functions to create a tree of constraints. Each
>> + * parent node is a virtual description of the aggregation of the
>> + * children. It propagates the constraints set at its level to its
>> + * children and collect the children power infomation. The leaves of
> 
> s/infomation/information/

Ok, thanks

[ ... ]

>> +static struct powercap_control_type *pct;
>> +static struct dtpm *root;
> 
> I wonder if it safe to have the tree without a global lock for it, like
> mutex tree_lock ?
> I have put some comments below when the code traverses the tree.

The mutex is a heavy lock and the its purpose is to allow the current
process to be preempted while the spinlock is very fast without preemption.

Putting in place a single lock will simplify the code but I'm not sure
it is worth as it could be a contention. It would be simpler to switch
to a big lock than the opposite.

[ ... ]

>> +static void dtpm_rebalance_weight(void)
>> +{
>> +    __dtpm_rebalance_weight(root);
>> +}
>> +
>> +static void dtpm_sub_power(struct dtpm *dtpm)
>> +{
>> +    struct dtpm *parent = dtpm->parent;
>> +
>> +    while (parent) {
> 
> I am not sure if it is safe for a corner case when the
> nodes are removing from bottom to top. We don't hold a tree
> lock, so these two (above line and below) operations might
> be split/preempted and 'parent' freed before taking the lock.
> Is it possible? (Note: I might missed something like double
> locking using this local node spinlock).

The parent can not be freed until it has children, the check is done in
the release node function.

>> +        spin_lock(&parent->lock);
>> +        parent->power_min -= dtpm->power_min;
>> +        parent->power_max -= dtpm->power_max;
>> +        spin_unlock(&parent->lock);
>> +        parent = parent->parent;
>> +    }
>> +
>> +    dtpm_rebalance_weight();
>> +}
>> +
>> +static void dtpm_add_power(struct dtpm *dtpm)
>> +{
>> +    struct dtpm *parent = dtpm->parent;
>> +
>> +    while (parent) {
> 
> Similar here?
> 
>> +        spin_lock(&parent->lock);
>> +        parent->power_min += dtpm->power_min;
>> +        parent->power_max += dtpm->power_max;
>> +        spin_unlock(&parent->lock);
>> +        parent = parent->parent;
>> +    }
>> +
>> +    dtpm_rebalance_weight();
>> +}
>> +
>> +/**
>> + * dtpm_update_power - Update the power on the dtpm
>> + * @dtpm: a pointer to a dtpm structure to update
>> + * @power_min: a u64 representing the new power_min value
>> + * @power_max: a u64 representing the new power_max value
>> + *
>> + * Function to update the power values of the dtpm node specified in
>> + * parameter. These new values will be propagated to the tree.
>> + *
>> + * Return: zero on success, -EINVAL if the values are inconsistent
>> + */
>> +int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
>> +{
>> +    if (power_min == dtpm->power_min && power_max == dtpm->power_max)
>> +        return 0;
>> +
>> +    if (power_max < power_min)
>> +        return -EINVAL;
>> +
>> +    dtpm_sub_power(dtpm);
>> +    spin_lock(&dtpm->lock);
>> +    dtpm->power_min = power_min;
>> +    dtpm->power_max = power_max;
>> +    spin_unlock(&dtpm->lock);
>> +    dtpm_add_power(dtpm);
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * dtpm_release_zone - Cleanup when the node is released
>> + * @pcz: a pointer to a powercap_zone structure
>> + *
>> + * Do some housecleaning and update the weight on the tree. The
>> + * release will be denied if the node has children. This function must
>> + * be called by the specific release callback of the different
>> + * backends.
>> + *
>> + * Return: 0 on success, -EBUSY if there are children
>> + */
>> +int dtpm_release_zone(struct powercap_zone *pcz)
>> +{
>> +    struct dtpm *dtpm = to_dtpm(pcz);
>> +    struct dtpm *parent = dtpm->parent;
>> +
> 
> I would lock the whole tree, just to play safe.
> What do you think?

I would like to keep the fine grain locking to prevent a potential
contention. If it appears we hit a locking incorrectness or a race
putting in question the fine grain locking scheme, then we can consider
switching to a tree lock.

>> +    if (!list_empty(&dtpm->children))
>> +        return -EBUSY;
>> +
>> +    if (parent) {
>> +        spin_lock(&parent->lock);
>> +        list_del(&dtpm->sibling);
>> +        spin_unlock(&parent->lock);
>> +    }
>> +
>> +    dtpm_sub_power(dtpm);
>> +
>> +    kfree(dtpm);
>> +
>> +    return 0;
>> +}

[ ... ]

>> +struct dtpm *dtpm_alloc(void)
>> +{
>> +    struct dtpm *dtpm;
>> +
>> +    dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
>> +    if (dtpm) {
>> +        INIT_LIST_HEAD(&dtpm->children);
>> +        INIT_LIST_HEAD(&dtpm->sibling);
>> +        spin_lock_init(&dtpm->lock);
> 
> Why do we use spinlock and not mutex?

The mutex will force the calling process to be preempted, that is useful
when the critical sections contains blocking calls.

Here we are just changing values without blocking calls, so using the
spinlock is more adequate as they are faster.

[ ... ]

>> +static int __init dtpm_init(void)
>> +{
>> +    struct dtpm_descr **dtpm_descr;
>> +
>> +    pct = powercap_register_control_type(NULL, "dtpm", NULL);
>> +    if (!pct) {
>> +        pr_err("Failed to register control type\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    for_each_dtpm_table(dtpm_descr)
>> +        (*dtpm_descr)->init(*dtpm_descr);
> 
> We don't check the returned value here. It is required that the
> devices should already be up and running (like cpufreq).
> But if for some reason the init() failed, maybe it's worth to add a
> field inside the dtpm_desc or dtpm struct like 'bool ready' ?
> It could be retried to init later.

It would be make sense to check the init return value if we want to
rollback what we have done. Here we don't want to do that. If one
subsystem fails to insert itself in the tree, it will log an error but
the tree should continue to give access to what have been successfully
initialized.

The rollback is important in the init() ops, not in dtpm_init().

>> +
>> +    return 0;
>> +}
>> +late_initcall(dtpm_init);
> 
> The framework would start operating at late boot. We don't control
> the thermal/power issues in earier stages.
> Although, at this late stage all other things like cpufreq should be
> ready, so the ->init() on them is likely to success.

Right, the dtpm is accessible through sysfs for an userspace thermal
daemon doing the smart mitigation. So do the initcall can be really late.

[ ... ]

Thanks for the review.

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
