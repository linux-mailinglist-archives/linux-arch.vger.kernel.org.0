Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A67AE749
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIZIDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZIDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 04:03:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D55C0;
        Tue, 26 Sep 2023 01:03:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC72C433C8;
        Tue, 26 Sep 2023 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695715415;
        bh=HB5KB8HsIMAvF0aDCyMdk9BLWivG2eE+dsYkN33J79Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbXbni+lGMF3g1j2jwtHFtZHs33LvSNNcfraLYV7pJN3g0snV3SPMQQyEgJLIQWdo
         MH+AmCK1gv4G0VfF6EZkH9ncvTNc9NANSgjkY17oaUzw6lJyuDrqk7K0kI+aAdKWjH
         NUlTbld9+L9fhwTiFRt6jZ+pKeNlvZCqzX9nlAOM=
Date:   Tue, 26 Sep 2023 10:03:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
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
Message-ID: <2023092646-version-series-a7b5@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 26, 2023 at 07:00:51AM +0000, Wei Liu wrote:
> On Tue, Sep 26, 2023 at 08:31:03AM +0200, Greg KH wrote:
> > On Tue, Sep 26, 2023 at 05:54:34AM +0000, Wei Liu wrote:
> > > On Tue, Sep 26, 2023 at 06:52:46AM +0200, Greg KH wrote:
> > > > On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> > > > > On 9/23/2023 12:58 AM, Greg KH wrote:
> > > > > > Also, drivers should never call pr_*() calls, always use the proper
> > > > > > dev_*() calls instead.
> > > > > > 
> > > > > 
> > > > > We only use struct device in one place in this driver, I think that is the
> > > > > only place it makes sense to use dev_*() over pr_*() calls.
> > > > 
> > > > Then the driver needs to be fixed to use struct device properly so that
> > > > you do have access to it when you want to print messages.  That's a
> > > > valid reason to pass around your device structure when needed.
> > > 
> > > Greg, ACRN and Nitro drivers do not pass around the device structure.
> > > Instead, they rely on a global struct device. We can follow the same.
> > 
> > A single global struct device is wrong, please don't do that.
> > 
> > Don't copy bad design patterns from other drivers, be better :)
> > 
> 
> If we're working with real devices like network cards or graphics cards
> I would agree -- it is easy to imagine that we have several cards of the
> same model in the system -- but in real world there won't be two
> hypervisor instances running on the same hardware.
> 
> We can stash the struct device inside some private data fields, but that
> doesn't change the fact that we're still having one instance of the
> structure. Is this what you want? Or do you have something else in mind?

You have a real device, it's how userspace interacts with your
subsystem.  Please use that, it is dynamically created and handled and
is the correct representation here.

thanks,

greg k-h
