Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62D7B74EC
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 01:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjJCX3x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjJCX3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 19:29:52 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5FCC;
        Tue,  3 Oct 2023 16:29:45 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso290473b3a.0;
        Tue, 03 Oct 2023 16:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375785; x=1696980585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBz0lRi2DC+AHJ394H0d/SpV7ukUS6MAw+MuCkAtqS8=;
        b=TB9QVHXjU8pqXHaGCCHiqyJ22Xdw36nQuL1l5+FMiDKuUbPPkTMFop29rQDWXLyfu1
         /pdBhXxzQC9NQy3ukLEEsGYIAjbOjuogaHCZIBln54UtHsjn/UKsCyZHQLHpBm5BBBEs
         L71AZ1gAzY3yrqcHP7fVqhr1vjejVANX2s4d0X/X1+2SJczNSiyEdminCg111FEy1sqD
         aIilTistQc2YM2VlZifUvphcmX9Y7Uic+pKRQS6/Sx5lis9D4gDA01WxdYZdkSpGu2M/
         Fsc1oCVgMhef18NsA7XUByNxYITIW+DShRb6R/mRHEudOZV6dRhmTIAVX6jrlvmSFyR/
         mOSg==
X-Gm-Message-State: AOJu0YzyOkCLN3EVVE23rkP3kZXPuOwTaZKs2k0Aq6I8I/o74Zen+Q2z
        z+gX5tDXQhqV0x1PwaWwmiQ=
X-Google-Smtp-Source: AGHT+IFDj6feRY+mcyfse2njK81rSw5tfqSmn4MKTfs0z1MOlf+i33E6HbJUJHUY6T5POArEoZjZvQ==
X-Received: by 2002:a05:6a00:1310:b0:68e:2c2a:5172 with SMTP id j16-20020a056a00131000b0068e2c2a5172mr974254pfu.6.1696375784881;
        Tue, 03 Oct 2023 16:29:44 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id ff23-20020a056a002f5700b006875a366acfsm1925061pfb.8.2023.10.03.16.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:29:44 -0700 (PDT)
Date:   Tue, 3 Oct 2023 23:29:42 +0000
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
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100154-ferret-rift-acef@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 01, 2023 at 08:19:27AM +0200, Greg KH wrote:
> On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> > On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > > These must be in uapi because they will be used in the mshv ioctl API.
> > > > 
> > > > Version numbers for each file:
> > > > hvhdk.h		25212
> > > > hvhdk_mini.h	25294
> > > > hvgdk.h		25125
> > > > hvgdk_mini.h	25294
> > > 
> > > what are version numbers?
> > 
> > These are internal version numbers for the hypervisor headers. We keep
> > track of them so that we can detect if there are any breakages in the
> > ABI, and thus either ask them to be fixed or we come up with ways to
> > maintain compatibility. People outside of Microsoft don't need to worry
> > about this. If you don't think this information belongs in the commit
> > message, we can drop it.
> 
> Internal numbers to a single company that have no relevance to anyone
> else do not belong in a changelog comment.  Would you want to see this
> in any other kernel changelog message for any other portion of the
> kernel?
> 

Okay. They shall be removed. I agree with you.

> > > > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > > > new file mode 100644
> > > > index 000000000000..9bcbb7d902b2
> > > > --- /dev/null
> > > > +++ b/include/uapi/hyperv/hvgdk.h
> > > > @@ -0,0 +1,41 @@
> > > > +/* SPDX-License-Identifier: MIT */
> > > 
> > > That's usually not a good license for a new uapi .h file, why did you
> > > choose this one?
> > > 
> > 
> > This is chosen so that other Microsoft developers who don't normally
> > work on Linux can review this code.
> 
> Sorry, but that's not how kernel development is done.  Please fix your
> internal review processes and use the correct uapi header file license.
> 
> If your lawyers insist on this license, that's fine, but please have
> them provide a signed-off-by on the patch that adds it and have it
> documented why it is this license in the changelog AND in a comment in
> the file so we can understand what is going on with it.
> 

We went through an internal review with our legal counsel regarding the
MIT license. We have an approval from them.

Let me ask if using something like "GPL-2.0 WITH Linux-syscall-note OR
MIT" is possible.

Thanks,
Wei.
