Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516A776DC7B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHCARn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCARn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:17:43 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65E119;
        Wed,  2 Aug 2023 17:17:42 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-563dc551518so197811a12.2;
        Wed, 02 Aug 2023 17:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021861; x=1691626661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7db6IHR4VgW4O1B0LAU9DcUtTze9BS4NCLZNZDmp/K4=;
        b=HzkBqKd7Hx+VNThzg2UMy1KHbVM8jkaGJbxLNSyaWauQSzzCm7mpYuiWYYhFIDQA8i
         W8EgbPhgkikgWNpXbZl7PKbjlvLHTRrN8sBdPySh/nOKOtXOys4DiYELZ1Jjxm0tWyoh
         6D2R5epX6fGfWSSDcJ1xMimHbpg6WXuIWBxOtfU48mCZ3BdFSRBaPOarujv8jWPYdIN8
         ZhpHCBSKSFfHdJKkitV1UOMw0Ut3EXGYQZ1tB0sWZRXhCGH5MXkXSBjTF33jc0qE8kUR
         nEeuLXtK+QgfyDKvlyhFe9C77kEwicfxsA4WwAh+jouLTBm5qkIJikfp3UTBpCyB7r8/
         HkEw==
X-Gm-Message-State: ABy/qLYEVFl+2QFmzMDUOTlLqpL+XrlgsqK4EQ5cND9yydkyEZLQ2j0p
        RJbQsuS6Awta1a0KE10XMQg=
X-Google-Smtp-Source: APBJJlGAikLzs5rznPbc1HMLxW2mzP3T84uayHyWFvfQpIXch48oKdSx/YpdU1ZYC6EnXyOFW9tf5A==
X-Received: by 2002:a05:6a20:430b:b0:13a:52ce:13cc with SMTP id h11-20020a056a20430b00b0013a52ce13ccmr19297029pzk.51.1691021861700;
        Wed, 02 Aug 2023 17:17:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j13-20020a633c0d000000b0056416526a5csm10533218pga.59.2023.08.02.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:17:41 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:17:35 +0000
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
Subject: Re: [PATCH 10/15] x86: hyperv: Add mshv_handler irq handler and
 setup function
Message-ID: <ZMryH+IqkudHqcrF@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-11-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-11-git-send-email-nunodasneves@linux.microsoft.com>
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

On Thu, Jul 27, 2023 at 12:54:45PM -0700, Nuno Das Neves wrote:
> This will handle SYNIC interrupts such as intercepts, doorbells, and
> scheduling messages intended for the mshv driver.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
