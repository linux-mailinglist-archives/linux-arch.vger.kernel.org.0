Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B1781907
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjHSKnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjHSKnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 06:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8649303;
        Sat, 19 Aug 2023 03:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56FA602E2;
        Sat, 19 Aug 2023 10:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CE6C433C7;
        Sat, 19 Aug 2023 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692440776;
        bh=Kriub9SChhgOzXQ4vf2OlbcqHqfEVe40noLKWwwtcBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEmSj0343j7QKyGwCVSxsldxuh+LkW/wbX2vCSO5fekicWYIMzSHo1yCEbCq0aA7b
         kVW/a8H2jF7iu13U2gjKm4PcObyEcTjO5+WDRwXI2nHmKjgBnslKQibFDFCo3nN+q6
         5oQCaXeEseuYfR/IbmwnlWeRzNiKRYV/SEZ3+uiY=
Date:   Sat, 19 Aug 2023 12:26:13 +0200
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
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Message-ID: <2023081923-crown-cake-79f7@gregkh>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
 <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 11:01:46PM +0000, Wei Liu wrote:
> On Thu, Aug 17, 2023 at 03:01:49PM -0700, Nuno Das Neves wrote:
> > Containing hypervisor ABI definitions to use in mshv driver.
> > 
> > Version numbers for each file:
> > hvhdk.h		25212
> > hvhdk_mini.h	25294
> > hvgdk.h		25125
> > hvgdk_mini.h	25294
> > 
> > These are unstable interfaces and as such must be compiled independently
> > from published interfaces found in hyperv-tlfs.h.
> > 
> > These are in uapi because they will be used in the mshv ioctl API.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > Acked-by: Wei Liu <wei.liu@kernel.org>
> 
> There were some concerns raised internally about the stability of the
> APIs when they are put into UAPI.
> 
> I think this is still okay, for a few reasons:
> 
>   1. When KVM was first introduced into the kernel tree, it was
>      experimental. It was only made stable after some time.
>   2. There are other experimental or unstable APIs in UAPI. They
>      are clearly marked so.
>   3. The coda file system, which has been in tree since 2008, has a
>      header file in UAPI which clearly marks as experimental.
> 
> All in all introducing a set of unstable / experimental APIs under UAPI
> is not unheard of. Rules could've changed now, but I don't find any
> document under Documentation/.
> 
> I think it will be valuable to have this driver in tree sooner rather
> than later, so that it can evolve with Linux kernel, and we can in turn
> go back to the hypervisor side to gradually stabilize the APIs.
> 
> Greg, I'm told that you may have a strong opinion in this area. Please
> let me know what you think about this.

My "strong" opinion is the one kernel development rule that we have,
"you can not break userspace".  So, if you change these
values/structures/whatever in the future, and userspace tools break,
that's not ok and the changes have to be reverted.

If you can control both sides of the API here (with open tools that you
can guarantee everyone will always update to), then yes, you can change
the api in the future.

It's really really hard to make a stable api the first time around, but
we have "tricks" for how to do it well, and ensure that you can slowly
change it over time (proper use of flags and zero-checked padding), but
almost always the simplest way is to just add new apis and keep
supporting the old ones by internally calling the new functions instead.

So, what do you think will change here in the future and why can't you
say "this is stable" now?  You have working userspace code for this api,
right?  What is left to be developed for it?

thanks,

greg k-h
