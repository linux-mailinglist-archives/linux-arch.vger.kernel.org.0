Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D36E6C1C
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDRScz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjDRScy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 14:32:54 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EA659FE;
        Tue, 18 Apr 2023 11:32:53 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id he13so21000890wmb.2;
        Tue, 18 Apr 2023 11:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842772; x=1684434772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38LQJYPWUqk2wm2FrKkjM2roC+rzVyedYiQ0NaT9neg=;
        b=bn80a51UNOU9X3oxGpV3gMt8BgvgDLRkVyZThki4n4q09veFIasQ9/gP5kS4cvvrBQ
         djZ+T7K6n7x56lK84xSBW6otzO/pTHS5JDHwjRPM1XGhYJbkpRtcTWS37fZPCu/Uooh5
         CghFm9coYIWT8SCI6/zrEUjEWgUjUe+r9wZ8atHNSRTIRviA5C8IC6V7frR5gB17HxnY
         1an4c9hsJGIo5gbA6+eWQSfI3tFbr/k+kWPHYvtbx51Mfagm7isXOl/J/43xWBtPtDmK
         1aqUwowq4wXZ9CRjX7G9OLdwspFDaoyoMg2XUj74MQZ76t0QQDCx1lzxKfustZGw2q6+
         kBXQ==
X-Gm-Message-State: AAQBX9dx/2hiZF9T0xW80dCL/oaTTTPMnOfz1BzGZCYmLty2MJy7rSyx
        U9u+j+avVaPLLgGLPdB2CV5QQW3V0lMj4Q==
X-Google-Smtp-Source: AKy350Z2klkrkHGSTZin2XZE1doQmXIcxeHcXQuTn8gy15VXTc5xFj/K/Z7yXUb3r6k/PiKKqNW4Rw==
X-Received: by 2002:a05:600c:3797:b0:3f1:7a18:942e with SMTP id o23-20020a05600c379700b003f17a18942emr2198775wmr.6.1681842771727;
        Tue, 18 Apr 2023 11:32:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bcd18000000b003f09a9151c1sm15719667wmj.30.2023.04.18.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:32:50 -0700 (PDT)
Date:   Tue, 18 Apr 2023 18:32:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2] Drivers: hv: move panic report code from vmbus to hv
 early init code
Message-ID: <ZD7iT/+Uil3jTuNO@liuwe-devbox-debian-v2>
References: <1681435612-19282-1-git-send-email-longli@linuxonhyperv.com>
 <BYAPR21MB1688377B56A9A844EAABEEDAD79E9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ZD2dxHaq8NDzpfYw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD2dxHaq8NDzpfYw@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 17, 2023 at 07:28:04PM +0000, Wei Liu wrote:
> On Sat, Apr 15, 2023 at 06:16:11PM +0000, Michael Kelley (LINUX) wrote:
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, April 13, 2023 6:27 PM
> > > 
> > > The panic reporting code was added in commit 81b18bce48af
> > > ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
> > > 
> > > It was added to the vmbus driver. The panic reporting has no dependence
> > > on vmbus, and can be enabled at an earlier boot time when Hyper-V is
> > > initialized.
> > > 
> > > This patch moves the panic reporting code out of vmbus. There is no
> > > functionality changes. During moving, also refactored some cleanup
> > > functions into hv_kmsg_dump_unregister(), and removed unused function
> > > hv_alloc_hyperv_page().
> > > 
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > > 
> > > Change log v2:
> > > 1. Check on hv_is_isolation_supported() before reporting crash dump
> > > 2. Remove hyperv_report_reg(), inline the check condition instead
> > > 3. Remove the test NULL on hv_panic_page when freeing it
> > > 
> > >  drivers/hv/hv.c                |  36 ------
> > >  drivers/hv/hv_common.c         | 229 +++++++++++++++++++++++++++++++++
> > >  drivers/hv/vmbus_drv.c         | 199 ----------------------------
> > >  include/asm-generic/mshyperv.h |   1 -
> > >  4 files changed, 229 insertions(+), 236 deletions(-)
> > 
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> Applied to hyperv-next. Thanks.

This broke allmodconfig. I've removed it from the tree. Please fix and
resend.

Thanks,
Wei.
