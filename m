Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CA30B0E1
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 20:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBATyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 14:54:44 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:32969 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbhBATyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2021 14:54:23 -0500
Received: by mail-wr1-f48.google.com with SMTP id 7so17991980wrz.0;
        Mon, 01 Feb 2021 11:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCjhNmegL5cty51UJJiVLzoT3IZRsyqfK3odFUkK4z8=;
        b=FIi09leopkGtYp/mCaSB3wIWcGzgubDYzeDJOUAbNMa2o8QfR/GV0TyV1UsF0Gk/st
         PDkVAJYh6QSvYSfJI3SnupXQa5XaaOi1wt4e03hB3g89h6dvWEkhUwMW2jy8rgDSs+VW
         lobi4qkQHLpndY6OgXFisutCfHDTCnR+yR6UyaNJnEjJ0CIRlbWteD165ijILNmVBEnd
         6smpxioO0d9YmbAYnKhB195hP9vYaeLlLYOX+kq1hDBxn2zPF7ug3u5kzs76CS+/1N7v
         MojKGwocRdXOxCINO5IjbDQGDBzk4k68455qvkoH97v9/xWDggMyemQe7dwJaQj1pMPT
         826Q==
X-Gm-Message-State: AOAM533Dwak9x3csQIywrzmUiy8lH8LVHGZNF1UVUHtiyN3IizWHIAER
        WSVPNsOes4i84g8txbMNQ5c=
X-Google-Smtp-Source: ABdhPJww1TvLldgLGFf0r7SZNri+3W5aYbD06nxT/kZ6LKQbZOATXExXYWTbE0ltqdgS/HE8QDXArg==
X-Received: by 2002:adf:a11d:: with SMTP id o29mr20016981wro.45.1612209209605;
        Mon, 01 Feb 2021 11:53:29 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y6sm328678wma.19.2021.02.01.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:53:29 -0800 (PST)
Date:   Mon, 1 Feb 2021 19:53:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 10/10] clocksource/drivers/hyper-v: Move handling of
 STIMER0 interrupts
Message-ID: <20210201195327.2bkhu6sig53prwwg@liuwe-devbox-debian-v2>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
 <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611779025-21503-11-git-send-email-mikelley@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 27, 2021 at 12:23:45PM -0800, Michael Kelley wrote:
[...]
> +static int hv_setup_stimer0_irq(void)
> +{
> +	int ret;
> +
> +	ret = acpi_register_gsi(NULL, HYPERV_STIMER0_VECTOR,
> +			ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);

When IO-APIC is enabled on x86, acpi_register_gsi calls
mp_map_gsi_to_irq. That function then calls mp_find_ioapic. Is
HYPERV_STIMER0_VECTOR, when used as a GSI, associated with an IO-APIC?
If not, wouldn't mp_find_ioapic return an error causing
acpi_register_gsi to fail?

Ah, it appears that this function is not called on x86. I haven't
checked how ARM handles GSI, but presumably this works for you.  It
would be good if a comment can be added to clarify things.

Wei.
