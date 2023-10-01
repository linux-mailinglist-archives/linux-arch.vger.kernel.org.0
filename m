Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53A7B4593
	for <lists+linux-arch@lfdr.de>; Sun,  1 Oct 2023 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjJAGUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Oct 2023 02:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjJAGUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Oct 2023 02:20:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B5BE;
        Sat, 30 Sep 2023 23:20:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D636DC433C7;
        Sun,  1 Oct 2023 06:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696141240;
        bh=YDUZdeEXU5GQ21bz2RuNAZE9GXbGGebX5Tc6BWPTwnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxIF61TJ418ssrowJq9Xysr/+cYheFTlfkvk7x7L34U8POn50VYY4Pppjs6DOl6Bz
         tMSnec4n9J+AbAEqJsyDlQybR6Mg3XThRAiZjwahDx4W80WaCAJqQjrWeeA6CjLF+2
         9qZLqQMq5yNfixB8i/KhNfWniPxFWqZJ5Fd7JsJ8=
Date:   Sun, 1 Oct 2023 08:20:37 +0200
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
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023100130-profusely-landside-0f97@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
 <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
 <2023093002-bonfire-petty-c3ca@gregkh>
 <ZRiPY5GzrGvlnPmY@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRiPY5GzrGvlnPmY@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 30, 2023 at 09:13:07PM +0000, Wei Liu wrote:
> On Sat, Sep 30, 2023 at 08:31:13PM +0200, Greg KH wrote:
> > On Sat, Sep 30, 2023 at 06:11:19PM +0000, Wei Liu wrote:
> > > On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> > > > On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/linux/mshv.h
> > > > > @@ -0,0 +1,306 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > 
> > > > Much better.
> > > > 
> > > > > +#ifndef _UAPI_LINUX_MSHV_H
> > > > > +#define _UAPI_LINUX_MSHV_H
> > > > > +
> > > > > +/*
> > > > > + * Userspace interface for /dev/mshv
> > > > > + * Microsoft Hypervisor root partition APIs
> > > > > + * NOTE: This API is not yet stable!
> > > > 
> > > > Sorry, that will not work for obvious reasons.
> > > 
> > > This can be removed. For practical purposes, the API has been stable for
> > > the past three years.
> > 
> > Then who wrote this text?
> 
> I don't think this matter, does it? This patch series had been rewritten
> so many times internally to conform to upstream standard it is very
> difficult to track down who wrote this and when.

The point is someone wrote this for a good reason so figuring out why
that was done would be good for you all to do as maybe it is true!

> If you have concrete concerns about removing the text, please let me
> know.

You need to verify that the comment is not true before removing it,
otherwise you all will have a very hard time in the future when things
change...

thanks,

greg k-h
