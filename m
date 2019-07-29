Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADEC789FE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 12:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfG2K7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 06:59:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53284 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbfG2K7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 06:59:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so53422491wmj.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 03:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZofcKDycB29XhDLuv66ThbXp2pcFI/cJTwXP21ke4VY=;
        b=bjifzqx8MEvj311ybopWHASN6wvxMe1sE2s7NBtsFmH5mijFkvggHcz2rorqADMZao
         1PbEcZJWy88zSz/x7n5nkoI8mrCedUCMhBBG6L/PKo0mbhqznNU8EPQridjZUTDOmZLp
         1uN3IDFXAiDVP1/afffN8p++LDMGSEziMlxoIAsuphkVC9chvT87q+eTWa2eqW9Ct0A8
         ZTVVeKzNHe+anmar0dT8jZiy4DhHZ0KyWTLc8a3gEG6TKXX+9OwtNnr3AJn+q6vg3bsH
         hzX1SbmthTmLlJrumsZ47v19d4u1ZbzNGossrAB1ULKqRz1Y/kZPioQ6wcU2aaYmFSu+
         CHrQ==
X-Gm-Message-State: APjAAAXaUpERJ9ct7DibkgE39QJScmNXelNDpxbserHBuhwYvEe/QM0I
        WNgzIN+lWxby5wkmn53ovUeHJw==
X-Google-Smtp-Source: APXvYqz9v8tCt46RmejEdVRBDjbdRLOyKVUpwyHmlB+2XfNpS4AtquhMMTujdQfnT/E1zDJNlBGawA==
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr102770113wme.67.1564397968266;
        Mon, 29 Jul 2019 03:59:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o126sm56535812wmo.1.2019.07.29.03.59.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 03:59:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
Date:   Mon, 29 Jul 2019 12:59:26 +0200
Message-ID: <87zhkxksxd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> on x86.  But native_sched_clock() directly uses the raw TSC value, which
> can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> to set the sched clock function appropriately.  On x86, this sets
> pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> scaled and adjusted to be continuous.

Hypervisor can, in theory, disable TSC page and then we're forced to use
MSR-based clocksource but using it as sched_clock() can be very slow,
I'm afraid.

On the other hand, what we have now is probably worse: TSC can,
actually, jump backwards (e.g. on migration) and we're breaking the
requirements for sched_clock().

-- 
Vitaly
