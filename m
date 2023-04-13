Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185FE6E1138
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDMPet (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjDMPer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 11:34:47 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3330A2737;
        Thu, 13 Apr 2023 08:34:40 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so16293457wmb.3;
        Thu, 13 Apr 2023 08:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400078; x=1683992078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo9Mau3eq9meMjoalmE0i9hHx+AL2GKflWJt29h5FAY=;
        b=S7KuPxZ1XuSLdx/x6NPVaXYSLrd/ukDc2F/f6ChLXZZAxim8N1WM/ZEleyACN4MRph
         lZBpRm45rSb0SQnSdrwhhg2DnewIGgiI41mJ1Pb2sA7j8Qkv7i64k6x9pr8qH02q/Uxw
         sGvVagV5XSVKEyeCWY6AQXn5P2TFmtHRYGL1VtZr7soT7FXg8PnwhJI1N8RvA3aLa98j
         dP3Y1pgT1PCBwHfD3/pwlb7aobw09KXDRGTN0ODmSmRdKTZk5qHS/Fz8fWBMjJVz+BTV
         dZLpJNXy33psKCyK/D50/idH5ChdJ9Cyp1B9GapCFoDQW6HBnqH+ra/DyqardBu5CZff
         KIuw==
X-Gm-Message-State: AAQBX9cu7HiQzx0fgsbTN6MglSOuiSE2PebZmbwocuJm+gm7CSC5t6AA
        luMzOF47IUFrcXQjEhF4iPA=
X-Google-Smtp-Source: AKy350Zo2E+zzHYk/5XM2fbPauV9QzDVjzXlY+nMuTMBrhf1am0YAZ53F0qghogcULXlWFpj5Kh9Ug==
X-Received: by 2002:a7b:c008:0:b0:3dc:5b88:e6dd with SMTP id c8-20020a7bc008000000b003dc5b88e6ddmr1931853wmb.10.1681400078427;
        Thu, 13 Apr 2023 08:34:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003ef5e5f93f5sm5761523wms.19.2023.04.13.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:34:38 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:34:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, arnd@arndb.de,
        tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org, jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v5 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <ZDghCRg+QnmutzcJ@liuwe-devbox-debian-v2>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
 <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
 <ZDdX11GuiTu0uvpW@liuwe-devbox-debian-v2>
 <20230413091942.GCZDfJLq52qXRWXKQQ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413091942.GCZDfJLq52qXRWXKQQ@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 13, 2023 at 11:19:42AM +0200, Borislav Petkov wrote:
> On Thu, Apr 13, 2023 at 01:16:07AM +0000, Wei Liu wrote:
> > On Mon, Apr 10, 2023 at 10:55:28PM -0700, Saurabh Sengar wrote:
> > > Make get/set_rtc_noop() to be public so that they can be used
> > > in other modules as well.
> > > 
> > > Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> > > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > x86 maintainers, can you please ack or nack this patch?
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thank you very much!
