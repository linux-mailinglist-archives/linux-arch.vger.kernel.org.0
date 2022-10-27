Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42380610166
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiJ0TRF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiJ0TRC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 15:17:02 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA58748D9;
        Thu, 27 Oct 2022 12:17:01 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1946913wmb.2;
        Thu, 27 Oct 2022 12:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJcckZeOTdB25gr4pjliB22U8P9HPBiHkU/B4Huj7SY=;
        b=slvFftCHAMsncxJNYUOYijBJVZDDlekHMbk+pIOltOXQHLAzHWqI+3e3Y2rNkagiqG
         1gwC6RiKzyIQrK32+f95WlxNzF34duTJNCVODDlU7I3r41tXsugFm2ozTe7B15W2D+Pk
         wBBUueQidmKlwRqHe5O8kVRi1N6J8h7B2uIIJfZW9b2vKeAksSvpHGq+ybNf16C6C0tb
         U2IYEt0d8zKv+ye3oBP2xxqm5M9ifp25fPJjVMHI5xDnb9bNnAn+EnLJ0ZhSzTtk/B0z
         teqNWXbe0jP79TK+hRn9Hbws4EAsvnx20E9sDFomCk3mgQIFLDUvau0grB2hxoPlsw3C
         ns3g==
X-Gm-Message-State: ACrzQf2rE7ItOs5A6xa67/GsbjdyM1tK03KUZITsr1jKEXs2XViwJGTP
        V/TAknl5y4pn8qBkiqU/xQE=
X-Google-Smtp-Source: AMsMyM6S7ga9qJvgAIXjFx3qSmDbTrpoJHriyV5xM3ygzlctpeiRve8/yZfzVOrDxAjqLsKhGg8pZQ==
X-Received: by 2002:a05:600c:4f10:b0:3c6:dcc6:51d7 with SMTP id l16-20020a05600c4f1000b003c6dcc651d7mr7055867wmq.91.1666898219923;
        Thu, 27 Oct 2022 12:16:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c2ca500b003b435c41103sm7416395wmc.0.2022.10.27.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:16:52 -0700 (PDT)
Date:   Thu, 27 Oct 2022 19:16:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: Re: [PATCH v2 2/2] x86/hyperv: fix invalid writes to MSRs during
 root partition kexec
Message-ID: <Y1rZIQnLATztxw2G@liuwe-devbox-debian-v2>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-3-anrayabh@linux.microsoft.com>
 <BYAPR21MB168872A298C1CDC140FBF454D7339@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168872A298C1CDC140FBF454D7339@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 27, 2022 at 01:44:40PM +0000, Michael Kelley (LINUX) wrote:
> From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, October 27, 2022 2:57 AM
> > 
> > hv_cleanup resets the hypercall page by setting the MSR to 0. However,
> 
> The function name is hyperv_cleanup(), not hv_cleanup().

I fixed this and applied both patches to hyperv-fixes. Thank you both.
