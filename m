Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD17D1C9A
	for <lists+linux-arch@lfdr.de>; Sat, 21 Oct 2023 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjJUK5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Oct 2023 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJUK5D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Oct 2023 06:57:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA6D5E;
        Sat, 21 Oct 2023 03:56:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85359C433C8;
        Sat, 21 Oct 2023 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697885818;
        bh=lWjx0bstoWSn8O+1+vq3s6PJ4JDA6SyKY8ViX2L7YW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTcaPIRtnQmlyxhrbVQzTkIF6yu1dZwfQH0HKzzZf+IdjhhVDBzohjKljAvRxu6ZC
         +EK0hYdtjcSMWn6+4ncGofksLqwZ6P5+pfIq4uHxdEPiU2xTLxyhLfke0SYjlmgd4x
         HJxhZl7xo4cAk+d9+HLkSGCqfb+thCkty+PvIYNY=
Date:   Sat, 21 Oct 2023 12:56:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 11/35] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <2023102128-banter-circular-85a2@gregkh>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-12-james.morse@arm.com>
 <20230914130126.000069db@Huawei.com>
 <ZTJqOTfDEnL9wgtY@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTJqOTfDEnL9wgtY@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 12:53:29PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 01:01:26PM +0100, Jonathan Cameron wrote:
> > On Wed, 13 Sep 2023 16:37:59 +0000
> > James Morse <james.morse@arm.com> wrote:
> > 
> > > register_cpu_capacity_sysctl() adds a property to sysfs that describes
> > > the CPUs capacity. This is done from a subsys_initcall() that assumes
> > > all possible CPUs are registered.
> > > 
> > > With CPU hotplug, possible CPUs aren't registered until they become
> > > present, (or for arm64 enabled). This leads to messages during boot:
> > > | register_cpu_capacity_sysctl: too early to get CPU1 device!
> > > and once these CPUs are added to the system, the file is missing.
> > > 
> > > Move this to a cpuhp callback, so that the file is created once
> > > CPUs are brought online. This covers CPUs that are added late by
> > > mechanisms like hotplug.
> > > One observable difference is the file is now missing for offline CPUs.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > ---
> > > If the offline CPUs thing is a problem for the tools that consume
> > > this value, we'd need to move cpu_capacity to be part of cpu.c's
> > > common_cpu_attr_groups.
> > 
> > I think we should do that anyway and then use an is_visible() if we want to
> > change whether it is visible in offline cpus.
> > 
> > Dynamic sysfs file creation is horrible - particularly when done
> > from an totally different file from where the rest of the attributes
> > are registered.  I'm curious what the history behind that is.
> > 
> > Whilst here, why is there a common_cpu_attr_groups which is
> > identical to the hotpluggable_cpu_attr_groups in base/cpu.c?
> > 
> > 
> > +CC GregKH
> > Given changes in drivers/base/
> 
> It would be good to have a comment on this from Greg before I post
> an updated series of James' patches with most of the comments
> addressed, possibly later today.

Sorry, I don't see what I am supposed to comment on, so please just send
a new series and I'll look at that.

thanks,

greg k-h
