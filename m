Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134617B43DE
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjI3VNN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjI3VNM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 17:13:12 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF2DD;
        Sat, 30 Sep 2023 14:13:09 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c5cd27b1acso137792005ad.2;
        Sat, 30 Sep 2023 14:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696108389; x=1696713189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4/9Jh9erOblVD03PMD3I+nDmotORbmI0YDClcDj3hs=;
        b=YtgAbWKWDATEueTyrHWbAU6CPv7y8wC1a3T5bm4zzkLXsGZULlKSz/cxfjgaDV+HaF
         aBap8G5b5BjjrAbCgCNjeDtyebZQCJLjwI/Ary42TV0RYfPK20yXkR3gxrPc9L2L5IBN
         /q1muAWwQstvI96NwMjsB9JKP6J1sCGacofvL4/jXxmpI8SJX4+1P7iDMt9+jnHm6A8t
         aTaNfxnSNWsUmKwbs2Y6sGFO4RcQGWKhddLUMg/OdWgQ2adr3+4off1jkgtumO7RhzBH
         P96Mv1LY592CLZTB5Qx7CulH2SK1zAw1Nux/OrPcu2ujcnCzTzTIQjm+VWzlv4ePJMKb
         WjxA==
X-Gm-Message-State: AOJu0YwOMSH1qQXuixlhToFbFpBnGcYNRBzclt+2MgVfXjfuI0Ahng6Z
        X+jLX6+mzSquFvpXOSBOhqtApUr6tTY=
X-Google-Smtp-Source: AGHT+IE7H7jSQLljAYdqE3TR+wtXf6R1QTE+Vlo6MOV6oJH9kKG3SYX9PRUPpjfsLTKd+YWkUayYhw==
X-Received: by 2002:a17:903:120e:b0:1bc:7001:6e5e with SMTP id l14-20020a170903120e00b001bc70016e5emr8963254plh.32.1696108389106;
        Sat, 30 Sep 2023 14:13:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id iy19-20020a170903131300b001c627413e87sm11023591plb.290.2023.09.30.14.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:13:08 -0700 (PDT)
Date:   Sat, 30 Sep 2023 21:13:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZRiPY5GzrGvlnPmY@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
 <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
 <2023093002-bonfire-petty-c3ca@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093002-bonfire-petty-c3ca@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 30, 2023 at 08:31:13PM +0200, Greg KH wrote:
> On Sat, Sep 30, 2023 at 06:11:19PM +0000, Wei Liu wrote:
> > On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> > > On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > > > --- /dev/null
> > > > +++ b/include/uapi/linux/mshv.h
> > > > @@ -0,0 +1,306 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > 
> > > Much better.
> > > 
> > > > +#ifndef _UAPI_LINUX_MSHV_H
> > > > +#define _UAPI_LINUX_MSHV_H
> > > > +
> > > > +/*
> > > > + * Userspace interface for /dev/mshv
> > > > + * Microsoft Hypervisor root partition APIs
> > > > + * NOTE: This API is not yet stable!
> > > 
> > > Sorry, that will not work for obvious reasons.
> > 
> > This can be removed. For practical purposes, the API has been stable for
> > the past three years.
> 
> Then who wrote this text?

I don't think this matter, does it? This patch series had been rewritten
so many times internally to conform to upstream standard it is very
difficult to track down who wrote this and when.

If you have concrete concerns about removing the text, please let me
know.

Thanks,
Wei.

> 
> confused,
> 
> greg k-h
