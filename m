Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDD3313BB
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 17:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCHQsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 11:48:18 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44130 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHQsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 11:48:07 -0500
Received: by mail-wr1-f45.google.com with SMTP id h98so12134713wrh.11;
        Mon, 08 Mar 2021 08:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U1adqiv4BHRB40tWnfMansEdoQfQQILbbIeOdC9S6tk=;
        b=FwXkidD3iKmwPKHnszqnr+lZfTDenzXay83XPPyVKgsuEIJM38eCyomN4Suc3Cc5/U
         Lhj8OwlQOnoSJxYVBlt904I38FvhU6RQpMAX4hydSYWTW73xszAsT1OLgb23Xoen9CQB
         0R75xhYB0iRYCag9KqsqTIhVCXA7EuRuhgV8PXpQW1pFiovbt7dqRs/e4QSfMI0vGwHJ
         1+onJzqaiPl7JfzM9oB6gh3OvjulbvX9Tw0Pai4+ZLWgNzg6CB/WYz3h9EepqHqKWvO7
         q2ukNvKW+2Mk4MX59uCvA650xPxOThaChNAPpeVaWPGRlWleKfvp43pgyspiwybAxYVH
         ozUw==
X-Gm-Message-State: AOAM530YjsvoNh4ymn4OFltAsSqWvt3tHUVYPr7Q+VXSp2Gp9ieiZJ7x
        zjcPr9wzMr3jwEkDr+B958o=
X-Google-Smtp-Source: ABdhPJwl5jsEF+UPUa+28gAA6fYemoVBWxjguS13D/KVUrDj7mt+Ui8LdJgIi90qXpb/S2MAeQOnGA==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr23676794wrw.277.1615222085838;
        Mon, 08 Mar 2021 08:48:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a8sm15336375wmm.46.2021.03.08.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 08:48:05 -0800 (PST)
Date:   Mon, 8 Mar 2021 16:48:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Refactor arch specific Hyper-V code
Message-ID: <20210308164804.eehva2snlwxxworc@liuwe-devbox-debian-v2>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 01:38:12PM -0800, Michael Kelley wrote:
[...]
> Michael Kelley (10):
>   Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
>   x86/hyper-v: Move hv_message_type to architecture neutral module
>   Drivers: hv: Redo Hyper-V synthetic MSR get/set functions
>   Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
>   Drivers: hv: vmbus: Handle auto EOI quirk inline
>   Drivers: hv: vmbus: Move handling of VMbus interrupts
>   clocksource/drivers/hyper-v: Handle vDSO differences inline
>   clocksource/drivers/hyper-v: Handle sched_clock differences inline
>   clocksource/drivers/hyper-v: Set clocksource rating based on Hyper-V
>     feature
>   clocksource/drivers/hyper-v: Move handling of STIMER0 interrupts

Applied to hyperv-next.

Wei.
