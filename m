Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E470276DC8C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHCAXk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHCAXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:23:39 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE511D;
        Wed,  2 Aug 2023 17:23:38 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686f090310dso371878b3a.0;
        Wed, 02 Aug 2023 17:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691022218; x=1691627018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmVePWus/D2ZSIv2TlvDrcFpCMCiW/1/xN8nusTSum4=;
        b=co76xerCqMWH8tdYDT/w0Kp01+ZGeOztoF+Kf0QrXJgbCakhjq44LC5CGjbDwDZSQC
         mRYnP7G5qCSdPM7f/H/8dumoYtmeIKQoXEjcdurklfi5umgzaF0N1mvF4xO6ZMzoWmrU
         J/7tUuW8IoBQ3gtSKVWXUg2BLFojHvs+gYoQmLmPj1q2YFuxTD016Gkg+Cl45MxH+Nwn
         PLC/Ji2MHButkWG3fVTciICbi5I9wD46hY1MQygfCFXrIpkQxeYfI087Xq/m/rpmVK2e
         ZGNsEeQw3eNwgHkcnAXiwb6SF1vCoOhnj6qnqjdzFyQyO8J9KaPCfq70yziwQ7EFKXQW
         lA0g==
X-Gm-Message-State: ABy/qLaLOUO0tgRwcIMENUpP9xwCTKeBo4eKIkz7xIsZ0zqgcjD9yXne
        JM7m8RSxaAQDXGMU35yGWWnv91rp6H8=
X-Google-Smtp-Source: APBJJlElxh1W6wNXf7GhFS8b/QMqghSfbgpkibvNXkhK40jke5XiUp1npsujtjeyRUZK+f64tfqstw==
X-Received: by 2002:a05:6a20:85:b0:13b:cc09:a547 with SMTP id 5-20020a056a20008500b0013bcc09a547mr15593305pzg.36.1691022218125;
        Wed, 02 Aug 2023 17:23:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id p26-20020a63741a000000b0056433b1b996sm7696281pgc.45.2023.08.02.17.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:23:37 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:23:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>, corbet@lwn.net
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 12/15] Documentation: Reserve ioctl number for mshv driver
Message-ID: <ZMrzgeETgsn1iTfe@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-13-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This needs an ack from Jonathan.

On Thu, Jul 27, 2023 at 12:54:47PM -0700, Nuno Das Neves wrote:
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 0a1882e296ae..ca6b82419118 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -355,6 +355,8 @@ Code  Seq#    Include File                                           Comments
>  0xB6  all    linux/fpga-dfl.h
>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
> +0xB8  all    uapi/linux/mshv.h                                       Microsoft Hypervisor VM management APIs
> +                                                                     <mailto:linux-hyperv@vger.kernel.org>
>  0xC0  00-0F  linux/usb/iowarrior.h
>  0xCA  00-0F  uapi/misc/cxl.h
>  0xCA  10-2F  uapi/misc/ocxl.h
> -- 
> 2.25.1
> 
