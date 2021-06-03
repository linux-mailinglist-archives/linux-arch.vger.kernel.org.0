Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07CA399DFE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCJrA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 05:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhFCJq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 05:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622713515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9K77UXySynClHeo9ATtGF2XuH4wNTDBsul1muCAvTwM=;
        b=I27E6utm7Uv3QzjlaRw+R4K8y1f9ZmG/Zdlm0IIWZbngzCEn7d/HgBz/8hvN/jsAIzf53P
        hYS6K/y3Qst4Jc5/wOqMf7nZwQH4ODN30f9wR3PojGguTX7N2L/GFyx4N7y7+YOK+OmI4b
        ucvzTYLpZh74Vu0cu9MNW2Ya8Ty3i2w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-6WrKp7mlMgmt2U96-RK5IQ-1; Thu, 03 Jun 2021 05:45:14 -0400
X-MC-Unique: 6WrKp7mlMgmt2U96-RK5IQ-1
Received: by mail-ed1-f69.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so2967297edw.14
        for <linux-arch@vger.kernel.org>; Thu, 03 Jun 2021 02:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9K77UXySynClHeo9ATtGF2XuH4wNTDBsul1muCAvTwM=;
        b=rM7W+GQZW/NG8V1dcedAmhyS6hR8EYMpmuFbhJUfhPvyV8mELyrgCXJ3GIVSoZSIx1
         AOk8VSjSD5ccZRuBtyEeUx0GqzEUzGRLg+LNjoQSEtNnSjcZnkw+FAAIMW0871DnA/nP
         jGFYc2OWCs4TYzBmr6P4uFYqVuyM7MBP4tv3D9uZ/rxYxam6RyfvqpsprfW3sO5UWdjN
         GDmIAhAsR4HjmRKHF3vAJwhYtQrGt7ERF27/lS7l8zK4g0koheFIypRE7Ttu+QcNkLBP
         zgb7xA5wdPVc+pU9Zwit7HvoQdyDUPD4mZUvaoc6G+MWlbNcOddtlj4cZO1dDs/y0KIf
         fiOQ==
X-Gm-Message-State: AOAM532m7fsu1SGh7DyM7o2tSrT+OLL8pL6vj58WjCb9+W5n1F4VGWOi
        Ng8zmqAyiPY8d3fpWFoFAit7+s7S5LvsJ4NX4XGdR+JWA/uONQ0olyPZisV9wyIRtCvercNTAhP
        oa6/Zep7+zZsNllbo78ecGg==
X-Received: by 2002:a50:fe18:: with SMTP id f24mr3271446edt.271.1622713513001;
        Thu, 03 Jun 2021 02:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyurhkoltCn+jnF+TGZdGnn0Y3agunqtJr98jiLXvymFlzFLbc5tnTmdM8vnVODgLTt86X0kQ==
X-Received: by 2002:a50:fe18:: with SMTP id f24mr3271436edt.271.1622713512810;
        Thu, 03 Jun 2021 02:45:12 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id w14sm1495617edj.6.2021.06.03.02.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 02:45:12 -0700 (PDT)
Subject: Re: [PATCH v8 14/19] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-15-will@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <6594fc22-e99e-ee5e-c3ea-fb522e510b46@redhat.com>
Date:   Thu, 3 Jun 2021 11:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602164719.31777-15-will@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/2/21 6:47 PM, Will Deacon wrote:
> When exec'ing a 32-bit task on a system with mismatched support for
> 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> run it.
> 
> Similarly, when exec'ing a 64-bit task on such a system, try to restore
> the old affinity mask if it was previously restricted.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

[...]

>  
> +#ifdef CONFIG_COMPAT
> +int compat_elf_check_arch(const struct elf32_hdr *hdr)
> +{
> +	if (!system_supports_32bit_el0())
> +		return false;
> +
> +	if ((hdr)->e_machine != EM_ARM)
> +		return false;
> +
> +	if (!((hdr)->e_flags & EF_ARM_EABI_MASK))
> +		return false;
> +
> +	/*
> +	 * Prevent execve() of a 32-bit program from a deadline task
> +	 * if the restricted affinity mask would be inadmissible on an
> +	 * asymmetric system.
> +	 */
> +	return !static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
> +	       task_cpus_dl_admissible(current, system_32bit_el0_cpumask());
> +}
> +#endif

From the DL perspective:

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

