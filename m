Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF17B3E99
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjI3GLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 02:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjI3GLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 02:11:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74401AB;
        Fri, 29 Sep 2023 23:11:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A82AC433C8;
        Sat, 30 Sep 2023 06:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696054300;
        bh=1EphpFWnU/6lrIe7UpyGV+C1tQHUDqUUsCrgVBuTw64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFY4WqNIJlRXHSIHR2qN9YOceoWUE6d5MUL+EisewvqwdxsY/k1Iw+mejf80UAw3a
         n1xbJv3Iv+bJwy/Dzm1zQ9kaLqL6FMpZCIzIXGUz1OWbknde3uin6PCyzprs1IQqc0
         8vpCglLu9qFkcWgnyjkrR6+VLfVZieLjc1zMxQ6k=
Date:   Sat, 30 Sep 2023 08:11:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023093004-evoke-snowbird-363b@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> --- /dev/null
> +++ b/include/uapi/linux/mshv.h
> @@ -0,0 +1,306 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

Much better.

> +#ifndef _UAPI_LINUX_MSHV_H
> +#define _UAPI_LINUX_MSHV_H
> +
> +/*
> + * Userspace interface for /dev/mshv
> + * Microsoft Hypervisor root partition APIs
> + * NOTE: This API is not yet stable!

Sorry, that will not work for obvious reasons.

greg k-h
