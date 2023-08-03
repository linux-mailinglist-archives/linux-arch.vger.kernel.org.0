Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D085676DD1D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHCBZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHCBZm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 21:25:42 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E9273C;
        Wed,  2 Aug 2023 18:25:41 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so3438255ad.2;
        Wed, 02 Aug 2023 18:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691025941; x=1691630741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWBAuG3c06Da9ELH4rE5nxlRVcg2TZcFu5fJ+OOQAks=;
        b=Ve6qFtWN2nnwmHGSTU0+Ba2p/1c/CwQsa39gfEFvIqHEqPzu7/vEEwtv7BGvl4ukfL
         H++7fGMaHlcek/3uesecl3Xmvp0HKfRWiYb9MfyKOZGEH9LlJB2/b3dsfmu3mzRfmifI
         +g3l+BSq2aaSxQviaLrunCmDLsSky93WV9ZmuxEW2r4h5fkTq5IzUpphg1BfUORkClu4
         8P+XyuilbPer2FXWESB7L50ZcMkGaMN0X3zQ6pgirjzosmZ0ZmhCxM9d/0y1p1PJi5cJ
         3/p1q+ujiaKXIxF+JmNjHf+wER6k/prdUwOZI0Lv1NHBhuduC/k/GTT0kWLIQU2GGENI
         WEyg==
X-Gm-Message-State: ABy/qLZAfhO0QFhKmw/m/keUP7iJDxhJdPL8c0uuuhtEeRbNtF40n1NJ
        0m42ugrso7WjRs79i54lYXg=
X-Google-Smtp-Source: APBJJlGg3g/NxUbke1+MzTLDtzvJmK3VM5Kg5CjoArXQVKLrRZlgMjpcmKC82Ectrxe/wO+cgZIZVg==
X-Received: by 2002:a17:903:1cb:b0:1b8:2ba0:c9c0 with SMTP id e11-20020a17090301cb00b001b82ba0c9c0mr18130270plh.59.1691025941149;
        Wed, 02 Aug 2023 18:25:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001bc39aa63ebsm176829plg.121.2023.08.02.18.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 18:25:40 -0700 (PDT)
Date:   Thu, 3 Aug 2023 01:25:34 +0000
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
Subject: Re: [PATCH 01/15] hyperv-tlfs: Change shared HV_REGISTER_* defines
 to HV_MSR_*
Message-ID: <ZMsCDk68qo3WDcUo@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-2-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-2-git-send-email-nunodasneves@linux.microsoft.com>
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

On Thu, Jul 27, 2023 at 12:54:36PM -0700, Nuno Das Neves wrote:
> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
> VP registers accessed via get/set vp registers hypercall.
> 
> This is due to HV_REGISTER_* names being used by hv_set/get_register,
> with the arch-specific version delegating to the appropriate mechanism.
> 
> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
> VP registers when they are introduced for x86 in future.
> 
> This patch solves the issue by:
> 
> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
>    This is so HV_REGISTER_ can be reserved for VP registers.
> 
> 2. Change the non-arch-specific alias used by hv_set/get_register to
>    HV_MSR_. This is also happens to be the same name HyperV uses for this
>    purpose.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Assuming the prior (private?) discussion with Michael led to this patch:

Acked-by: Wei Liu <wei.liu@kernel.org>
