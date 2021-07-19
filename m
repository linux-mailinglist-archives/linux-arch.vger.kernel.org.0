Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A713CD0A0
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhGSInj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 04:43:39 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46063 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhGSIni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jul 2021 04:43:38 -0400
Received: by mail-wr1-f42.google.com with SMTP id t5so21109300wrw.12;
        Mon, 19 Jul 2021 02:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3+c2ib1Q+/SzUS6dxaIqKRFtrtYa6zrwTRQZyhXL/s=;
        b=SNErU1uzo5XPbbJ379D2iIP2IgpV1Yr60F21uMAoadqgEt5kT49PxRRIW2cw5NBJFm
         x3HaBAsy4KahAWOhJ60bXU69DEpeRjfJp7Dqok7gbctXDyi4Ws/lWKtNKgC08ElRw+3K
         +ie++AjoEJiDVpC+VlnkCdV/hdSiF5XDZZOGTEQWhibFB8ZEAemVTVbW4LhWPMBiEL5C
         dHHMcKY1RYy1+lop4yOTP/9VqsEaJkEhLHpQY26CGlhId8qnboqMNYKt4n2AN8nUKUFf
         CER2lBS+6aDnEWmgnTjvzijLoPzLcdKI6kOTpz/+jkp3ZhKHXGmMsg1xor2/hvK6bsjw
         4EIA==
X-Gm-Message-State: AOAM533zb3HRPnaGU9L4FSG0W0d8lnLEXcwMQsLg7H6ELy9oOOK5et8Q
        etgpQ55EVn9k1GXsczyhTBg=
X-Google-Smtp-Source: ABdhPJxoEfX4pJX2uzno93/+e0vFnAvCo8Sa4iB6M7aAQK75IwQ7dbGyawzTWC3D0m9Is/TMX0yCew==
X-Received: by 2002:a5d:53c5:: with SMTP id a5mr28942225wrw.15.1626686657747;
        Mon, 19 Jul 2021 02:24:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z7sm15190274wmp.34.2021.07.19.02.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 02:24:17 -0700 (PDT)
Date:   Mon, 19 Jul 2021 09:24:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers: hv: Decouple Hyper-V clock/timer code from
 VMbus drivers
Message-ID: <20210719092415.vgx2xsk2vsppojzp@liuwe-devbox-debian-v2>
References: <1626220906-22629-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626220906-22629-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 13, 2021 at 05:01:46PM -0700, Michael Kelley wrote:
> Hyper-V clock/timer code in hyperv_timer.c is mostly independent from
> other VMbus drivers, but building for ARM64 without hyperv_timer.c
> shows some remaining entanglements.  A default implementation of
> hv_read_reference_counter can just read a Hyper-V synthetic register
> and be independent of hyperv_timer.c, so move this code out and into
> hv_common.c. Then it can be used by the timesync driver even if
> hyperv_timer.c isn't built on a particular architecture.  If
> hyperv_timer.c *is* built, it can override with a faster implementation.
> 
> Also provide stubs for stimer functions called by the VMbus driver when
> hyperv_timer.c isn't built.
> 
> No functional changes.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
