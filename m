Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286E6E50D7
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDQT13 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 15:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjDQT12 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 15:27:28 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243376BD;
        Mon, 17 Apr 2023 12:26:58 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so12455935e9.2;
        Mon, 17 Apr 2023 12:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759617; x=1684351617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5RS4OCZjuf4jfezYrqMeVPvp3K61VGB0efnNQZ4z/4=;
        b=Z6yweulJJ4gGcqydP1IMSqfEzCKvMktn5Z5/Jt4ReE9SsQ6f2/BdxqkEI7i0IOudVR
         1VTljQeg/bbXUwRXCNeI0zq4lV32vGIhVNeGPgx0yLuD6aUZsA3RAXs0/3F5l/+Roynq
         GotCIrvURYYsNWLRMFxdcrzKwvgK26Ak11nCVtUOanNoLcRFXi6Empj9/EXxdpCW96ug
         6iGu+0+KyVkxmOHL19X/Ztkb1I086EQ30uYljNSfaPTs/5FRTfsYlvDasi3b+c520zpq
         idZeNt1jDCxq9ZOHr0Crg+Hbweojqr7ZX8v2D9NFk2c2a3vrpqXgzUdS7r1h3Co+7OBM
         pgFw==
X-Gm-Message-State: AAQBX9fT6NXxVEhMdEPRAN0gtCVZzh9fqOKvum3FXC7n4/xp2WvdC52g
        pKwwAEa/VHpzyiN0hzIIUWk=
X-Google-Smtp-Source: AKy350ZFvg5yKuE1DjUbqiVfYlFE4k3Q6gUqHWytAcm0hYz+RbnUbsAqe4q8fpcFgoLQPNg5UJaN9g==
X-Received: by 2002:a5d:6a11:0:b0:2fb:f6ff:e8d2 with SMTP id m17-20020a5d6a11000000b002fbf6ffe8d2mr25346wru.35.1681759616704;
        Mon, 17 Apr 2023 12:26:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b002f459afc809sm11189828wrm.72.2023.04.17.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:26:56 -0700 (PDT)
Date:   Mon, 17 Apr 2023 19:26:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v5 0/5] Hyper-V VTL support
Message-ID: <ZD2dfuHFCJmOkGt9@liuwe-devbox-debian-v2>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 10, 2023 at 10:55:27PM -0700, Saurabh Sengar wrote:
[...]
> Saurabh Sengar (5):
>   x86/init: Make get/set_rtc_noop() public
>   x86/hyperv: Add VTL specific structs and hypercalls
>   x86/hyperv: Make hv_get_nmi_reason public
>   Drivers: hv: Kconfig: Add HYPERV_VTL_MODE
>   x86/hyperv: VTL support for Hyper-V
> 

Applied to hyperv-next. Thanks.
