Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5077AFA93
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 08:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjI0GCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjI0GCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 02:02:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A9CDB;
        Tue, 26 Sep 2023 23:01:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD420C433C7;
        Wed, 27 Sep 2023 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695794464;
        bh=5bU3gzx6D/KCU0/C5mz2JXiNA41aaEP8U6oXybPm8gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2LRf4pJ6rPQn6ySzyf20SC7ew+5hiHg0ZgTGztrtSHsf+ONc0fSbPWBjlR9BQEcF
         T9u0I6IHdfCXvEtS+qRFuUJFBEdCb9gUa1iDa3NEL90zruzcMkXboJd04FQft3n+wA
         JDYbRNptapF/6wySxZlqHvmS2oV11NdlYt4NoVdQ=
Date:   Wed, 27 Sep 2023 08:01:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092737-daily-humility-f01c@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
 <2023092630-masculine-clinic-19b6@gregkh>
 <ZRJyGrm4ufNZvN04@liuwe-devbox-debian-v2>
 <2023092614-tummy-dwelling-7063@gregkh>
 <ZRKBo5Nbw+exPkAj@liuwe-devbox-debian-v2>
 <2023092646-version-series-a7b5@gregkh>
 <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05119cbc-155d-47c5-ab21-e6a08eba5dc4@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 26, 2023 at 02:52:36PM -0700, Nuno Das Neves wrote:
> On 9/26/2023 1:03 AM, Greg KH wrote:
> > On Tue, Sep 26, 2023 at 07:00:51AM +0000, Wei Liu wrote:
> > > On Tue, Sep 26, 2023 at 08:31:03AM +0200, Greg KH wrote:
> > > > On Tue, Sep 26, 2023 at 05:54:34AM +0000, Wei Liu wrote:
> > > > > On Tue, Sep 26, 2023 at 06:52:46AM +0200, Greg KH wrote:
> > > > > > On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> > > > > > > On 9/23/2023 12:58 AM, Greg KH wrote:
> > > > > > > > Also, drivers should never call pr_*() calls, always use the proper
> > > > > > > > dev_*() calls instead.
> > > > > > > > 
> > > > > > > 
> > > > > > > We only use struct device in one place in this driver, I think that is the
> > > > > > > only place it makes sense to use dev_*() over pr_*() calls.
> > > > > > 
> > > > > > Then the driver needs to be fixed to use struct device properly so that
> > > > > > you do have access to it when you want to print messages.  That's a
> > > > > > valid reason to pass around your device structure when needed.
> > > > > 
> 
> What is the tangible benefit of using dev_*() over pr_*()?

Unified reporting and handling of userspace of kernel log messages so
they can be classified properly as well as dealing correctly with the
dynamic debugging kernel infrastructure.

Why wouldn't you want to use it?

> As I said,
> our use of struct device is very limited compared to all the places we
> may need to log errors.

Then please fix that.

> pr_*() is used by many, many drivers; it seems to be the norm.

Not at all, it is not.

> We can certainly add a pr_fmt to improve the logging.

Please do it correctly so you don't have to go and add support for it
later when your tools people ask you why they can't properly parse your
driver's kernel log messages.

> > > If we're working with real devices like network cards or graphics cards
> > > I would agree -- it is easy to imagine that we have several cards of the
> > > same model in the system -- but in real world there won't be two
> > > hypervisor instances running on the same hardware.
> > > 
> > > We can stash the struct device inside some private data fields, but that
> > > doesn't change the fact that we're still having one instance of the
> > > structure. Is this what you want? Or do you have something else in mind?
> > 
> > You have a real device, it's how userspace interacts with your
> > subsystem.  Please use that, it is dynamically created and handled and
> > is the correct representation here.
> > 
> 
> Are you referring to the struct device we get from calling
> misc_register?

Yes.

> How would you suggest we get a reference to that device via e.g. open()
> or ioctl() without keeping a global reference to it?

You explicitly have it in your open() and ioctl() call, you never need a
global reference for it the kernel gives it to you!

thanks,

greg k-h
