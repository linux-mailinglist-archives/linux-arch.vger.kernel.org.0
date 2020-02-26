Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3F170ABC
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBZVpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 16:45:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBZVpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 16:45:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so299055pgm.8
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LEOG45oBzsk4VkXLaube4iedb24/mnkHl/uPB4eNLko=;
        b=S7QwoillPymvmUXhSvQ9XeY6dt1lsnuG9Gixb/80AnLRzal3BKqeXehLhN8GeIopi7
         mHIWOeTf7r00dNMZbOY0wy/VeWQM2D1PWjaWm6VqnRhDTJ5RtWMC6V4WiBuONgAurgwS
         e6aKokF7WWW6DX6t/rtidzSu6L5+xiuBi/ihA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LEOG45oBzsk4VkXLaube4iedb24/mnkHl/uPB4eNLko=;
        b=t/ibFS++JuU1hwgJUgzY9UdTWRTajlXKuWds/S/gN5AJLBN0OpvibbfWh+Nez24hdz
         Md/l7Tk+y+cJ/UUmBpH9NqultX23MTmBV4krTvQ9hkK6f3sv2vcHw+8RsYUpgV5Zxbny
         u2AEnFiCrCtKTF8nmOA6UqfCHhyGsmZPPGR/bnGg8/gG+14pqs//9ABUQA/eGdfQYfwf
         CLrSDkpU5APoA0CbVKLh9OQLgbBejXvyUFD4uCOeRqqx7Kurm31CJ+qWQxdsMNF/agaJ
         6eMJEQsFo9DvWtm8QuZKfRsVWM7kAbABskfpQ7PVeSZs0Q95uJNve1VQitmQuE4ujV4M
         TKTg==
X-Gm-Message-State: APjAAAXvP/pj1MLQ1+8B9aJW07c2UtM743x1HQhwxcV7KGpWaZuLqIE2
        MRi+Kf0zVLws3wrk99KApqtoeg==
X-Google-Smtp-Source: APXvYqzAYJxED0DZuNTQH/pPVYk94YN0FwPubJNZYwjzdTSrs2Ri1O5oY0aDkBqS9krAjOJx6fGojA==
X-Received: by 2002:a63:3004:: with SMTP id w4mr854365pgw.164.1582753500965;
        Wed, 26 Feb 2020 13:45:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z16sm4066910pff.125.2020.02.26.13.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:45:00 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:44:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] arm64: Branch Target Identification support
Message-ID: <202002261343.3B2ECE90@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:03PM +0000, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.
> 
> Changes:
> 
> v7:
>  - Rebase onto v5.6-rc3.
>  - Move comment about keeping NT_GNU_PROPERTY_TYPE_0 internal into first
>    patch.
>  - Add an explicit check for system_supports_bti() when parsing BTI ELF
>    property for improved robustness.

Looks good. I sent a few more Reviewed-bys where I could. Who is
expected to pick this up? Catalin? Will?

I'm excited to have both the ELF parser and BTI landed. :)

-Kees

-- 
Kees Cook
