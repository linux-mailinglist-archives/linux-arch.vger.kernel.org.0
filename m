Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75597327D4F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 12:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhCALbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 06:31:23 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44994 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhCALbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2021 06:31:22 -0500
Received: by mail-wr1-f46.google.com with SMTP id h98so15723197wrh.11;
        Mon, 01 Mar 2021 03:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vXj7x4CsI1/ey+iX/WpHh2TTcMnZ292OM9XRomWQN1o=;
        b=DA4+1s9nJx8gaJyPgZiZku/HgxdyKAx7wH4bl3WW6R4MV2D9XSr4pyt0wwm9bBfYqU
         yED54gZ5IaumVZ8QbD5BrpABaGn1fKWBAzwAFGZolcLLJLC6c6XR/gpqrbqjissF/mir
         H9bmSgmgV7PGEeHZQBvdYVEX0Yy0NzeftAAVrHy/kn4SxpwfRGbTL2E5Kk/Tokjdb5GO
         +bPiLEhHhW9Ahtr1m+X4KeVTqBucZx2Rpst3+ycjwU8kuf27dkxLRZecFfvPezSHMsLc
         B7kvE6zu/KlVLdzH+xucXYUF7sPy0fId96Q/VvtFb+VzSpEaNE7hSB45dgV8Vw57bQEB
         I6rw==
X-Gm-Message-State: AOAM530alKX92eaJx098kkxLnRf8oYDDBp7n6qhoEcqJCAyqW2WpJ8pJ
        WJSSPqhlMp/3HpE9i5SEsDw=
X-Google-Smtp-Source: ABdhPJwahJbPnhnXn2peV5WB7aBo9hQMqR0UIhFLvGNtx9+clHYlxfR+/hBaT/+Vm7GmeNeMhQ4G0A==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr15905002wrs.259.1614598236370;
        Mon, 01 Mar 2021 03:30:36 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f2sm22244752wrq.34.2021.03.01.03.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 03:30:35 -0800 (PST)
Date:   Mon, 1 Mar 2021 11:30:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Refactor arch specific Hyper-V code
Message-ID: <20210301113034.hqbrzoap7pz7qmqj@liuwe-devbox-debian-v2>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 28, 2021 at 05:15:22PM -0800, Michael Kelley wrote:
> To support Linux guests on Hyper-V on multiple architectures, the original
> approach factored out all differences between Hyper-V on x86/x64 and
> Hyper-V on ARM64 into functions or #defines under arch/x86 and
> arch/arm64. Some of these differences are truly related to the
> architecture, but others are more properly treated as Linux OS
> differences or just quirks in Hyper-V. Feedback from Arnd Bergmann[1]
> recommended that differences other than architecture should be
> incorporated into the architecture independent Hyper-V code. Each
> difference can be handled with conditions specific to the difference
> instead of tying it to the broader x86/x64 vs. ARM64. This approach
> reduces the amount of code under arch/x86 and arch/arm64 and keeps
> the non-architectural differences localized and more easily understood.
> 
> This patch set implements the new approach by changing the interface
> between the architecture independent code and the architecture dependent
> code for x86/x64. The patches move code from arch/x86 to the
> architecture independent Hyper-V code whenever possible, and add
> architecture independent support needed by other architectures like
> ARM64.  No functionality is changed for x86/x64.  A subsequent patch
> set will provide the Hyper-V support code under arch/arm64.
> 
> This patch set results in an increase in lines of code (though some
> of the increase is additional comments).  But the lines needed under
> arch/arm64 in the upcoming patch set is significantly reduced, resulting
> in a net decrease of about 125 lines.
> 
> [1] https://lore.kernel.org/lkml/CAK8P3a1hDBVembCd+6=ENUWYFz=72JBTFMrKYZ2aFd+_Q04F+g@mail.gmail.com/

This series looks good to me.

Given this series touches mostly Hyper-V code. I will be taking this it
via hyperv-next once the last two patches are reviewed.

Wei.
