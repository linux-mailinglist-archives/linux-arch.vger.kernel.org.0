Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF36E50E0
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDQT2Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDQT2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 15:28:15 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD76A63;
        Mon, 17 Apr 2023 12:28:08 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so2616159wms.0;
        Mon, 17 Apr 2023 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759686; x=1684351686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W0xUzGv3bFlwwmNaUOnlow2Y+E2WT5THpDh/RmBiBg=;
        b=fTGgDwmIlzc0u5fgo1RpLaLwBK1t0e9PuUnfyIVBoGkCf629E4DomarncEznaNlGI8
         BENW+YYLHnxQHkBA2+nwkON1hkXSDZ+jwg3sQ1JBm+m3HBF7RQVhC0P7FDhpxRo7ucxi
         oMcMFUlLoqIEUucY/1zQdbVBtqYoSq2pkQkLvrWYqoTOenHocA5psK1HqAD+E858G/RQ
         t7qJ9gz+AHpKuMCs9c5Qmgt9ceA1bTNo9qEhvYVsd/6ccdVJcALM+XmBqkycjkFNMnKQ
         atQ3Cn+Wuf+RMQCyKlO/57nS0y6yUvO/+Ur0S+fBZ0iVRMPrmftbNuD+2Obs0MBaRtJW
         YhTA==
X-Gm-Message-State: AAQBX9f3bqwIupwT5jlA4qjQeFmHCajAcjr4kQAO25sVFMDSopzEjTkX
        65Yw+VYrEvby9ES2CFbhdJ8=
X-Google-Smtp-Source: AKy350YYXu/ISUG/HMPx/7EQwboUx8u1Nwy2hZHmc+5zXx3e3AejFgNqmggs19BTxhkgbeLd4ZSdCQ==
X-Received: by 2002:a05:600c:2244:b0:3f0:7e63:e034 with SMTP id a4-20020a05600c224400b003f07e63e034mr11570091wmm.29.1681759686577;
        Mon, 17 Apr 2023 12:28:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003f09d7b6e20sm12792462wmc.2.2023.04.17.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:28:06 -0700 (PDT)
Date:   Mon, 17 Apr 2023 19:28:04 +0000
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
Message-ID: <ZD2dxHaq8NDzpfYw@liuwe-devbox-debian-v2>
References: <1681435612-19282-1-git-send-email-longli@linuxonhyperv.com>
 <BYAPR21MB1688377B56A9A844EAABEEDAD79E9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688377B56A9A844EAABEEDAD79E9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 15, 2023 at 06:16:11PM +0000, Michael Kelley (LINUX) wrote:
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Thursday, April 13, 2023 6:27 PM
> > 
> > The panic reporting code was added in commit 81b18bce48af
> > ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
> > 
> > It was added to the vmbus driver. The panic reporting has no dependence
> > on vmbus, and can be enabled at an earlier boot time when Hyper-V is
> > initialized.
> > 
> > This patch moves the panic reporting code out of vmbus. There is no
> > functionality changes. During moving, also refactored some cleanup
> > functions into hv_kmsg_dump_unregister(), and removed unused function
> > hv_alloc_hyperv_page().
> > 
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> > 
> > Change log v2:
> > 1. Check on hv_is_isolation_supported() before reporting crash dump
> > 2. Remove hyperv_report_reg(), inline the check condition instead
> > 3. Remove the test NULL on hv_panic_page when freeing it
> > 
> >  drivers/hv/hv.c                |  36 ------
> >  drivers/hv/hv_common.c         | 229 +++++++++++++++++++++++++++++++++
> >  drivers/hv/vmbus_drv.c         | 199 ----------------------------
> >  include/asm-generic/mshyperv.h |   1 -
> >  4 files changed, 229 insertions(+), 236 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
