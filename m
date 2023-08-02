Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B876DBD0
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 01:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjHBXsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 19:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHBXsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 19:48:41 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A64F2;
        Wed,  2 Aug 2023 16:48:40 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-563f4e49ff9so186046a12.3;
        Wed, 02 Aug 2023 16:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020120; x=1691624920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ1+F9Szv7yB0V3LcaTbuABHxm7HW3pKDNUtxuiM0p4=;
        b=OAVAgIp079NN41fiIdY3lSnA22z8Db8YzKgOYhb8CeqYxjONeZbK1Mq7QEBkYrUAOD
         86IbmEr0eeoTcLXsxcxypEMY03gkd18j5PUki5yGV5DuOUt+khUx9P+vaEnYKYUJr7XU
         WQJplhBrioCZJyuR/J5k7KuZmiMZJkUEnA6eALvQshePQHRx0mAxJ+ZyFH/3oRhXGKHc
         Z8jrFvDlT+utKNHZ9rh+BoDfchwfFUpytMjsRFnTy9pHVlYbyq0w9DxSmXcEsVDQYYmq
         9McV5SDoTCZ5JSXXXWt0tUlKBw4HEtVdSY+Qharj8VeEAjDAKQFfStBnULeBtc/hpLL/
         HDqg==
X-Gm-Message-State: ABy/qLa+EmgDyNqfDzSw53DGTGTQ+mWu4mc7M5r6sFH8bFzHWd0lB1ix
        zHALBaxKzYB2O5oxnLvhWVk=
X-Google-Smtp-Source: APBJJlFiDAwc28K3REK9ix8QiUNSAFLgDrsPTE7tf0j3/Bzwywx/YU5iovi8PYJqKPwIFhtjlVsE/Q==
X-Received: by 2002:a05:6a20:a10e:b0:13e:1945:8857 with SMTP id q14-20020a056a20a10e00b0013e19458857mr9746660pzk.37.1691020120115;
        Wed, 02 Aug 2023 16:48:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm12922732plb.195.2023.08.02.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:48:39 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:48:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
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
Subject: Re: [PATCH 04/15] asm-generic/mshyperv: Introduce
 hv_recommend_using_aeoi()
Message-ID: <ZMrrUbL59B4Zdb+P@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-5-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:39PM -0700, Nuno Das Neves wrote:
> Factor out logic for determining if we should set the auto eoi flag in SINT
> register.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
