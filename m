Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376017B42E1
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjI3SL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjI3SLY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 14:11:24 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A7D3;
        Sat, 30 Sep 2023 11:11:22 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-578a62c088cso1269945a12.1;
        Sat, 30 Sep 2023 11:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696097482; x=1696702282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TXn5EVj6LatWgiRJOE6Q8kenZuC5VUG7hu5Ruisxfw=;
        b=TdMqv/HRStG3ywdx/P+gTaMC0aFfAsY34S2YBMmZVnQLNeNbUtcwhxYhgtbc810Pnb
         kEIPswTqx/HEoxzGJYWkVAe5hx1OpOnqy43G96xzyZhMKUz0Oqwy0ty2f5EvX41nXKPx
         qxVcVrld21VMA0iGVf1zaUuSfafYc+KIojBw6HK7VO6g9NRw1XZVv7hsRHfdbdgO6EYp
         U81zG/yC2SVXV8MswS5L5sLGFMXhrUwdE5lmC5r6P/jnwY2jyJohEbD4JypLy68JAFk5
         Z0cJq0BSE3hnlTZlamh2Iohd05xtBMWj3OKr+qo2u9Zvu/NinFBK11RmH39rj0aAHIyp
         F4EQ==
X-Gm-Message-State: AOJu0Yxc6nm3AWtH9cgm/YS6R14wtJc4dMvjBerYoUSYyYEl9t01sEV0
        sMnYA0IV85eChW1tWnZ2afw=
X-Google-Smtp-Source: AGHT+IG8yfBEc/mvB02AlNeuIWF5R6nONr+MMMVd7OPW+QTH0f19znw98ZuhkzsbdpNX71Nf57LDPg==
X-Received: by 2002:a17:90b:1982:b0:279:dae:2d3f with SMTP id mv2-20020a17090b198200b002790dae2d3fmr11586365pjb.22.1696097481748;
        Sat, 30 Sep 2023 11:11:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b00256799877ffsm3398075pjb.47.2023.09.30.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 11:11:21 -0700 (PDT)
Date:   Sat, 30 Sep 2023 18:11:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093004-evoke-snowbird-363b@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > --- /dev/null
> > +++ b/include/uapi/linux/mshv.h
> > @@ -0,0 +1,306 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> Much better.
> 
> > +#ifndef _UAPI_LINUX_MSHV_H
> > +#define _UAPI_LINUX_MSHV_H
> > +
> > +/*
> > + * Userspace interface for /dev/mshv
> > + * Microsoft Hypervisor root partition APIs
> > + * NOTE: This API is not yet stable!
> 
> Sorry, that will not work for obvious reasons.

This can be removed. For practical purposes, the API has been stable for
the past three years.

Thanks,
Wei.

> 
> greg k-h
