Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75B7AE4BD
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 06:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjIZEw5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Sep 2023 00:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZEw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Sep 2023 00:52:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E27E6;
        Mon, 25 Sep 2023 21:52:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255CC433C8;
        Tue, 26 Sep 2023 04:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695703969;
        bh=iGK9D3ZNtj+5ANQTbtas8J/bXpKtY1WHDqCBdj2Av4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLgtvJyF861iGKa4EHORO573v2aAToqpZePuQMDajTxqmvCLikWKkE2c0n+6XbKbx
         qM8XZH3qkZOfDsne4xtW8l6LDB0d7g594/IeRt4Ed1WirTJMW8uO4hXslyZXpNJZ9C
         1xm9TgUlfgSYHgWCafxidm53sCZfxcTmsvQlDpAU=
Date:   Tue, 26 Sep 2023 06:52:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092630-masculine-clinic-19b6@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> On 9/23/2023 12:58 AM, Greg KH wrote:
> > Also, drivers should never call pr_*() calls, always use the proper
> > dev_*() calls instead.
> > 
> 
> We only use struct device in one place in this driver, I think that is the
> only place it makes sense to use dev_*() over pr_*() calls.

Then the driver needs to be fixed to use struct device properly so that
you do have access to it when you want to print messages.  That's a
valid reason to pass around your device structure when needed.

thanks,

greg k-h
