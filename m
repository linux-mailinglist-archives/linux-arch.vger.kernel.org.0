Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA93282BA
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhCAPmy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 10:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbhCAPmu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2021 10:42:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D34C06178A
        for <linux-arch@vger.kernel.org>; Mon,  1 Mar 2021 07:42:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u187so11994350wmg.4
        for <linux-arch@vger.kernel.org>; Mon, 01 Mar 2021 07:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TuyEPq+OKYhM5djtv+OIrlO0NdrnxuMD/gDW97dakUc=;
        b=vw0/US/Oqmu9LDZDKsgb9Nrq7hDcRFD6Do0/UJSayXej4KkjsuUZSWfLKHOWMEC2MN
         YuafppUR4rWrR3e1a/dOgdw8MUd8wSD5nCw+Nj6Q/OfAiVlmKT137vpr+DpVVDebfr67
         cWjzAb8H8xkpkeXtHHPeetzhRjaS1+JrLxwqRHcmtIkGBnJxkfQL8Q49HbJYJo99YHIS
         NzVAj/xnd0jKuXDCHdZEQTGBuj9M1DFKpFmRVXM4snN7D1D03Mi5kstG3CKJV8JGFglg
         1TgDdSU8QnDex9lFiQ/ky1SVF+vo0vdh2eUZJfCL6dNgYMkMADR0wQfWbLc04CUCMYB3
         YEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuyEPq+OKYhM5djtv+OIrlO0NdrnxuMD/gDW97dakUc=;
        b=RPKd9xIiyAoXnBZFLzq0ByJdwB0CTD7bLrpEW5Z+3f2TO4QbnDvScBw+EVMKkZm9kp
         w6mXQ2f9DcsKX/kmK0iWEdsg5z6MvuS8GnK2L0BAPg9IK5eUjamuTo1nmajhy6xzxCB7
         PqXw0+IXu59Ydi5Ezww9Q2HYv8LcbYYyTa2HH8Ii+3CZIaDiAm5qTd2V2NrZkvFfw4N/
         J2niyUkTeoop0cqQsu3rRo5al71OEmnh8YZPMwIXAeWs8eoFXYk1UcykVVb1Z3HDBGUj
         Jdx+Hs3wsvKuCq/C/uItRSBxmQ8wmviuXf/fY5G4oK8JzSjbXWj+CF1XuxjHKDxcWb57
         YUaA==
X-Gm-Message-State: AOAM533lKFzDs1XXlDe8nvJBimgcGofW5nWc+Y6OdF5IkcghuWC0vr/Z
        j0rHvD//hsy9nQKEDO0LvOEY6pUTEOI/gA==
X-Google-Smtp-Source: ABdhPJzwJLYKHuwJLPr1iYEZbIkNeXbm9Pe8LUYKejti/ummafqwZBzHeTxRzdRMk+vqU5bD3eL6bA==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr16239716wma.141.1614613326166;
        Mon, 01 Mar 2021 07:42:06 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id a6sm7572577wmm.0.2021.03.01.07.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 07:42:05 -0800 (PST)
Subject: Re: [PATCH v2 09/10] clocksource/drivers/hyper-v: Set clocksource
 rating based on Hyper-V feature
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-10-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6e2f860-d109-25c7-5892-ef9b06daaa7d@linaro.org>
Date:   Mon, 1 Mar 2021 16:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614561332-2523-10-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01/03/2021 02:15, Michael Kelley wrote:
> On x86/x64, the TSC clocksource is available in a Hyper-V VM only if
> Hyper-V provides the TSC_INVARIANT flag. The rating on the Hyper-V
> Reference TSC page clocksource is currently set so that it will not
> override the TSC clocksource in this case.  Alternatively, if the TSC
> clocksource is not available, then the Hyper-V clocksource is used.
> 
> But on ARM64, the Hyper-V Reference TSC page clocksource should
> override the ARM arch counter, since the Hyper-V clocksource provides
> scaling and offsetting during live migrations that is not provided
> for the ARM arch counter.
> 
> To get the needed behavior for both x86/x64 and ARM64, tweak the
> logic by defaulting the Hyper-V Reference TSC page clocksource
> rating to a large value that will always override.  If the Hyper-V
> TSC_INVARIANT flag is set, then reduce the rating so that it will not
> override the TSC.
> 
> While the logic for getting there is slightly different, the net
> result in the normal cases is no functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
