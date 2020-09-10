Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5726462D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgIJMi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbgIJMfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 08:35:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6238C061573
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 05:34:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so6516109wrn.6
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ou9injEFK3ynx6TLorApjrz9C+IV+NUJDgRb4FiGCd0=;
        b=JpErupGX9fulmYZvxtdV0U32w7X1pxyfApvEkhWK8zhYuxW1uI+EqU5Fjv9BaF9H/V
         YurieurqjypG7BJAUBnBCH5arbZ3tVER2qmEt+rAqI4sfn3j4bXg9iz0fRz0pKoPNL3y
         YSW2fRVwWb6wg82ODMDH5pUFWZ0GjjH48pGAH5EmstenSokAdTz7Xt7zn4OgIwRIR4l9
         0fLwBGV8McXKD8aluzhihwYePyApjjulnhMvLjwOH3WO1/cwpNtD7nu9TdVZ4OCMjA8S
         c9CQIJkAS0fQVUjZIlIZtaLGjr0eQHoBc0Ml2c5fY6fYDFZIe4MRDXrAX2YVoKmv1DK0
         bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ou9injEFK3ynx6TLorApjrz9C+IV+NUJDgRb4FiGCd0=;
        b=KbO4SwVAALobF/kL4LmF+ItoAw2ZMOSkJF0bpACDW5fqWr2vKZ6dOw8Zmffcm+TmWv
         aO85oxVgOK7mNGnYregf/LRqNN702JMcpBW/nhCKhJ+NGGsP9Q0tpRYex749ezeLoRpZ
         S5RRCoOREoZ8iM1YViYyR7By/qZMOBIAXsR5Vz07vGlKqhWq0kIVbsELUSowQZ/uOxOH
         AGg5lHvgApafP7U1aifyl4ppUoDj0nCVe5HMyIyiJsxutsOrnR6ceIXWJEOWRLuh04sY
         rpr64U4+6svafhBlVF8S8L0qOvlt+sSs9xMH4FvqwMbSqvfjM5oU5Jllcl7MkIUUj9yy
         6Asg==
X-Gm-Message-State: AOAM533om9VDe/YyumrY6/WZbqFw4eB0bAZwr0bwhWbG8RYStiD2JZzH
        ijUM5kmwt4VlUICG3thvk/0d7Q==
X-Google-Smtp-Source: ABdhPJzW0hcZaP/tw8LsHLMPTKiwkkYHFromXeW07uLdryNq4J0OhAM1tb62eb6pB/v/hKExJM8Mhg==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr9066135wru.374.1599741297317;
        Thu, 10 Sep 2020 05:34:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
        by smtp.gmail.com with ESMTPSA id n21sm3532461wmi.21.2020.09.10.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:34:56 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:34:52 +0100
From:   Andrew Scull <ascull@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 04/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200910123452.GD93664@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-5-dbrazdil@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 11:17:06AM +0200, 'David Brazdil' via kernel-team wrote:
> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
> because they always needed to use TPIDR_EL2 for base, while
> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
> _EL1 based on VHE/nVHE.
> 
> Simplify this now that the nVHE hyp mode case can be handled using the
> __KVM_NVHE_HYPERVISOR__ macro. VHE selects _EL2 with alternatives.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Andrew Scull <ascull@google.com>

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 54d181177656..b392a977efb6 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,6 +218,21 @@ lr	.req	x30		// link register
>  	str	\src, [\tmp, :lo12:\sym]
>  	.endm
>  
> +	/*
> +	 * @dst: destination register (32 or 64 bit wide)
> +	 */
> +	.macro	this_cpu_offset, dst
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +	mrs	\dst, tpidr_el2

Another part that might also apply to __KVM_VHE_HYPERVISOR__.

> +#else
> +alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> +	mrs	\dst, tpidr_el1
> +alternative_else
> +	mrs	\dst, tpidr_el2
> +alternative_endif
> +#endif
> +	.endm


