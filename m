Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60082BEFE5
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfIZKoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 06:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfIZKoU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Sep 2019 06:44:20 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3B17C04AC69
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:44:19 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so856977wme.5
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 03:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Riw/2Ux9OsHBDm8paJcZzsJiBRoPakD2IyewC8/qlH0=;
        b=m32qbjLfgVtKww/fMQV9mWEYsonw2J2EmnqpWhXdPOZz4KqP+rB0uAzwuLYZ4GNofH
         a5xzBezkHznyZwwSyQhULaZ13btotOAJD0oD0VlLyaj3EFRXSnQ6rVNlNh1nJF4G7VZI
         wHJx0Bc2pqGq4Dg9+ILQ9UNCCKmOpBUk48QBKpvPrXln62p8ERh1PI2EQEKOxPFFFok1
         WUrIu4pnOy7M1MbNjQ3YPZwkhnToG7/AmxfSG8U5KkPWxP6lCBU6r8bpENkjIg6uw21q
         v3+NsYqV+/s8+ybnqUX3TrEjsiT+do3TLqIzsghcwysz8c1RGm/2jHHKnKISyjbLqMvL
         ejhQ==
X-Gm-Message-State: APjAAAWohRE8SMwHd90C7e34XsAqntdjccrePpke6rRw83G6Q+83OOt5
        QMqsoWGxQeCcA7jg0arDfOqwx5MNKoZRnKzuTqHQ6odJUivVeal1Id8rxj/aQ9CiyBFBKCuMhBy
        RSyHAEbjyV1QfCW4+mR8uqg==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr2319301wrq.292.1569494658663;
        Thu, 26 Sep 2019 03:44:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxr5GEjW6ka0m4Lpc1OF+XdjpU3XZQ6+sKdP/4G5PYjuXWwBJlGoNZuBr1r4uMLP1CN0JDCCQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr2319287wrq.292.1569494658461;
        Thu, 26 Sep 2019 03:44:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q19sm3835597wra.89.2019.09.26.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 03:44:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd\@arndb.de" <arnd@arndb.de>, "bp\@alien8.de" <bp@alien8.de>,
        "daniel.lezcano\@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "x86\@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
In-Reply-To: <1567723581-29088-2-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com> <1567723581-29088-2-git-send-email-decui@microsoft.com>
Date:   Thu, 26 Sep 2019 12:44:16 +0200
Message-ID: <87ef0372wv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 866dfb3..037b0f3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -20,6 +20,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  
>  void *hv_hypercall_pg;
> @@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
>  	return 1;
>  }
>  
> +static int hv_suspend(void)
> +{
> +	union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +	/* Reset the hypercall page */
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable = 0;
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +

(trying to think out loud, not sure there's a real issue):

When PV IPIs (or PV TLB flush) are enabled we do the following checks:

	if (!hv_hypercall_pg)
		return false;

or
        if (!hv_hypercall_pg)
                goto do_native;

which will pass as we're not invalidating the pointer. Can we actually
be sure that the kernel will never try to send an IPI/do TLB flush
before we resume?

-- 
Vitaly
