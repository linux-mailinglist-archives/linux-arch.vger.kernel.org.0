Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC96E03BB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDMBeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMBeI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 21:34:08 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F840CA;
        Wed, 12 Apr 2023 18:34:07 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v27so3429117wra.13;
        Wed, 12 Apr 2023 18:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681349646; x=1683941646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkkAWpv+bJF+AboAIxIZQ4EDrnZtM77QoTy0DkdbdLs=;
        b=dyCFSw9Qai+vMnS6nr2T4nkKo7olWorHF9A2Hfx0GWJoERq+/J62PBVH3nRizaJ1UL
         nPOCRX467+llYVq/AlV8nWXh0wqalZUX1ltlHvm8qkwe16SmZ5oZbaCoBcCqUb0s0q8G
         LKMDVqrRakBJfOr5mnPimOKqx9OzkCJphIUXZSz7oGSdMp81ouaBvQU2nh7D/TRliiKS
         fu085/MQ3P7z9G3KXzAMylsWARnncNZ7n3PPcT/XBj02u7WPnmfX2+LHiqHy+/hO7ho1
         fco4Qpjb1/0mYqvJnlDnjmtpBhe0rd5k4BrnXYaamwlwc1KhpWPaP57WluoxUcAxe0q5
         yOhg==
X-Gm-Message-State: AAQBX9fGqam4+FBn5k9XIbCdjnFj/JMap3tBCWO9ZaKXLwkUayCLCLd8
        lNmTVgpXNEx0hcZn5aELDSY=
X-Google-Smtp-Source: AKy350bsEZNjJIHsAQi0+2zVrgpWCSrZkokWzBv62k2Rd5Te+vHpW1DF8+raIirYcfxSALiKGQwWlQ==
X-Received: by 2002:a5d:4b12:0:b0:2ee:e47e:9014 with SMTP id v18-20020a5d4b12000000b002eee47e9014mr173101wrq.1.1681349646008;
        Wed, 12 Apr 2023 18:34:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4984000000b002db1b66ea8fsm133667wrq.57.2023.04.12.18.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:34:05 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:34:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/hyperv: Exclude lazy TLB mode CPUs from
 enlightened TLB flushes
Message-ID: <ZDdcCd/KtOGnwKMv@liuwe-devbox-debian-v2>
References: <1679922967-26582-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679922967-26582-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 27, 2023 at 06:16:05AM -0700, Michael Kelley wrote:
> The Hyper-V enlightened TLB remote flush function does not exclude
> lazy TLB mode CPUs like the equivalent native function. Limited
> telemetry shows that up to 80% of the CPUs being flushed are in
> lazy mode, so flushing them is unnecessary and wasteful.
> 
> The best place to exclude the lazy TLB mode CPUs is when copying
> the Linux cpumask to the Hyper-V VPset data structure, since the
> copying already processes CPUs one-by-one. Currently this copying
> function has the capabilty to exclude the calling CPU. Generalize
> this exclusion functionality to exclude CPUs based on a callback
> function that is invoked for each CPU.  Then for TLB flushing,
> use this callback function to check the lazy TLB mode status of
> each targeted CPU.
> 
> Patch 1 of this series does the generalization, and fixes up the
> one caller of the existing "exclude self" capability.
> 
> Patch 2 then implements the exclusion based on lazy TLB mode,
> using the generalization from Patch 1.
> 
> Michael Kelley (2):
>   x86/hyperv: Add callback filter to cpumask_to_vpset()
>   x86/hyperv: Exclude lazy TLB mode CPUs from enlightened TLB flushes
> 
>  arch/x86/hyperv/hv_apic.c      | 12 ++++++++----
>  arch/x86/hyperv/mmu.c          | 11 ++++++++++-
>  include/asm-generic/mshyperv.h | 22 ++++++++++++++--------
>  3 files changed, 32 insertions(+), 13 deletions(-)

Applied to hyperv-next. Thanks.

> 
> -- 
> 1.8.3.1
> 
