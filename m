Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96BD78016F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbjHQXCb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 19:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355891AbjHQXCF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 19:02:05 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B04E48;
        Thu, 17 Aug 2023 16:02:04 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc3d94d40fso2777735ad.3;
        Thu, 17 Aug 2023 16:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692313324; x=1692918124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwtAWZyaQZccFsvrQPELO3aY17uRAQUdwXsYLsWxG84=;
        b=IuvWzEElfJ+wiUBT+a71rux5kompS9TLuhSyoAzS67Vac7ERhMy7QPFqLVWA84T4Pl
         4NxfXzJJTyb6ACUEPaCaTmz1DnF7g3ONT69tZL31Fkh0MkJd86qBV5NXlENDlhGl3Fg6
         GI8hvJf8xCJpUr09hDx4+MGPxWqj190mQX9Gq6bJyPDtfOri7gVMIOwUPLFHQCS39yEI
         qaZrMDF1prhSw1+JdF7tcbv7mGx0hQOrJ/aBPG3+NxHR9FTq1S170krhIRL4L8Xbh0Ss
         1rqk04t1JIaa07rEbveoFmsEkF/0RjB2JBRYdhaPjsDrNPlZsrhLhuIcH49pb8JOljE1
         89iw==
X-Gm-Message-State: AOJu0YyF1bpmNvTZ61efcsBiXd10Rx9saF0Uq+UgtmeeCLtuAClILu3a
        8RgiB9pU0lMMejDdOVcFtro=
X-Google-Smtp-Source: AGHT+IG2BFK2vmrhXuy5TCdio2ggF+9peVt2is7fV6FO/H95rTuj26QpxJj97gw/YuQUb7+KJafrLg==
X-Received: by 2002:a17:902:d510:b0:1b6:c229:c350 with SMTP id b16-20020a170902d51000b001b6c229c350mr1154091plg.18.1692313324012;
        Thu, 17 Aug 2023 16:02:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001bb04755212sm290077plb.228.2023.08.17.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:02:03 -0700 (PDT)
Date:   Thu, 17 Aug 2023 23:01:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
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
        will@kernel.org, catalin.marinas@arm.com,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Message-ID: <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:49PM -0700, Nuno Das Neves wrote:
> Containing hypervisor ABI definitions to use in mshv driver.
> 
> Version numbers for each file:
> hvhdk.h		25212
> hvhdk_mini.h	25294
> hvgdk.h		25125
> hvgdk_mini.h	25294
> 
> These are unstable interfaces and as such must be compiled independently
> from published interfaces found in hyperv-tlfs.h.
> 
> These are in uapi because they will be used in the mshv ioctl API.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>

There were some concerns raised internally about the stability of the
APIs when they are put into UAPI.

I think this is still okay, for a few reasons:

  1. When KVM was first introduced into the kernel tree, it was
     experimental. It was only made stable after some time.
  2. There are other experimental or unstable APIs in UAPI. They
     are clearly marked so.
  3. The coda file system, which has been in tree since 2008, has a
     header file in UAPI which clearly marks as experimental.

All in all introducing a set of unstable / experimental APIs under UAPI
is not unheard of. Rules could've changed now, but I don't find any
document under Documentation/.

I think it will be valuable to have this driver in tree sooner rather
than later, so that it can evolve with Linux kernel, and we can in turn
go back to the hypervisor side to gradually stabilize the APIs.

Greg, I'm told that you may have a strong opinion in this area. Please
let me know what you think about this.

KY, do you have an opinion here?

Thanks,
Wei.
