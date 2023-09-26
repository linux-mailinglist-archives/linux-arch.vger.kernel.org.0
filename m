Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198F7AE65C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIZHBB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 03:01:00 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECBEF3;
        Tue, 26 Sep 2023 00:00:54 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso6222627b3a.2;
        Tue, 26 Sep 2023 00:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695711653; x=1696316453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR0xWP82gOq4UfhGc/Rjgf6bHjjZPrvgKTMMsFTyoXc=;
        b=D9Hdwq0uH0ax7wyAhsl8J8Y73/cgRTVDaFqmKWc628AEIGqysmkXd8X38/a21vpoy5
         ZYKFbNLEQtZ9VVztdK3/LQ7JbS5DVQZRE4Hf6WiY1m22Hd4kaJuI5qe0SOZIgFJb1hdi
         50OKmAfAuREWvluvrZs05YrMrFmFqDstoFWkqax3CH4pafYB2x2Q17hztnezx/S0cvoH
         V/9SBCmBos/VIB9eqI6L1NL4+VKINlT4myoB5mAklm25CUO1gEyL3nXINJavafcKs/lT
         iqb6H15Qj+D8tjyjvkaL/mRhR56OAgROiqUcM5OD2MjTJXLuo2a/EOo8tw7uoy3zVKWF
         zYPQ==
X-Gm-Message-State: AOJu0YwSHylYQUARUOYWTZL/nVjTX2ZoWBhqMDEKd4/2zKrw308mfElB
        4uyzA8k4jyTiwnXZcXRaBBU=
X-Google-Smtp-Source: AGHT+IG7reiq4YR2nW+K3Ubyh0wSSTKINIDXIAk+Q1Yd5ato0Gf272jWIsPO/R5L/eqwd1TqnYIetw==
X-Received: by 2002:a05:6a20:8e08:b0:15a:836:7239 with SMTP id y8-20020a056a208e0800b0015a08367239mr8319847pzj.11.1695711653490;
        Tue, 26 Sep 2023 00:00:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jk13-20020a170903330d00b001b9da8b4eb7sm4710872plb.35.2023.09.26.00.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 00:00:53 -0700 (PDT)
Date:   Tue, 26 Sep 2023 07:00:51 +0000
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
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092614-tummy-dwelling-7063@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 26, 2023 at 08:31:03AM +0200, Greg KH wrote:
> On Tue, Sep 26, 2023 at 05:54:34AM +0000, Wei Liu wrote:
> > On Tue, Sep 26, 2023 at 06:52:46AM +0200, Greg KH wrote:
> > > On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> > > > On 9/23/2023 12:58 AM, Greg KH wrote:
> > > > > Also, drivers should never call pr_*() calls, always use the proper
> > > > > dev_*() calls instead.
> > > > > 
> > > > 
> > > > We only use struct device in one place in this driver, I think that is the
> > > > only place it makes sense to use dev_*() over pr_*() calls.
> > > 
> > > Then the driver needs to be fixed to use struct device properly so that
> > > you do have access to it when you want to print messages.  That's a
> > > valid reason to pass around your device structure when needed.
> > 
> > Greg, ACRN and Nitro drivers do not pass around the device structure.
> > Instead, they rely on a global struct device. We can follow the same.
> 
> A single global struct device is wrong, please don't do that.
> 
> Don't copy bad design patterns from other drivers, be better :)
> 

If we're working with real devices like network cards or graphics cards
I would agree -- it is easy to imagine that we have several cards of the
same model in the system -- but in real world there won't be two
hypervisor instances running on the same hardware.

We can stash the struct device inside some private data fields, but that
doesn't change the fact that we're still having one instance of the
structure. Is this what you want? Or do you have something else in mind?

Thanks,
Wei.

> thanks,
> 
> greg k-h
> 
