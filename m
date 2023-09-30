Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800B77B4307
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjI3SbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjI3SbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 14:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843CE1;
        Sat, 30 Sep 2023 11:31:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2140C433C8;
        Sat, 30 Sep 2023 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696098676;
        bh=gPSt2DVfnZHEWNHwWx6rdcYJzFL/8huE+2zVEzu3HzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCxGV53/kBfbr1GUpC5e/i9KXl5o7XVW0tcnTT1KwiBw4mRDy6sqeUIiaKpWMyMmh
         71dbmjeyf2gRyNh1E+xT2rH6H1genxj9yX4EL+SNAWKzMe3IDdMDxLVi+gjIMu5HIc
         Yy8X3iOpXOGLMRlr495lhglerpgD+4y/rq5Sq5Jo=
Date:   Sat, 30 Sep 2023 20:31:13 +0200
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
Message-ID: <2023093002-bonfire-petty-c3ca@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
 <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 30, 2023 at 06:11:19PM +0000, Wei Liu wrote:
> On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> > On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/linux/mshv.h
> > > @@ -0,0 +1,306 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > Much better.
> > 
> > > +#ifndef _UAPI_LINUX_MSHV_H
> > > +#define _UAPI_LINUX_MSHV_H
> > > +
> > > +/*
> > > + * Userspace interface for /dev/mshv
> > > + * Microsoft Hypervisor root partition APIs
> > > + * NOTE: This API is not yet stable!
> > 
> > Sorry, that will not work for obvious reasons.
> 
> This can be removed. For practical purposes, the API has been stable for
> the past three years.

Then who wrote this text?

confused,

greg k-h
