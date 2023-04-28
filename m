Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D476F191C
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjD1NNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjD1NNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:13:38 -0400
X-Greylist: delayed 748 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 06:13:36 PDT
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BAB19AC
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=K3hI1/6PyaWFpzEBQJz+6tOnP/hMA6RM+an+N2/SAGU=;
        b=p3ndZrQKMSUlzm/nDAnCwsGo9L0gGsWF75qxTZlsIwroX36ZzR9n/TqOk4Ikh1KZ1uEf801ySHAOB
         yuaU+Ld6Tw73sXVUTCxgTr+rQtcP3cQmoy6O/PS1W8Sw8U9Pz9QGbdm64v/oi2D93X9aS9pWDvQBjj
         1loPbH8TJoA3VwFcCEH3fDeOHvFgiaivV98L8z4aVI/2AqW+CcNGaMH4Ja1wy5lJuo0gXHVO8OyZ+J
         /MQqwNKpEigOaL2YHWV6UAAtq1w9lPACg3xLRKCDc+ma3cU6cZxRVzOTH6WsG+3ThvFok4EbOK+CEe
         srZdeI7kmtl+ASR7D+jcke8Z2koxNkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=K3hI1/6PyaWFpzEBQJz+6tOnP/hMA6RM+an+N2/SAGU=;
        b=MuIZq23kU+epw5Oh27NhFCj+lmErbvHXzjBgCVAf/M7xbtvvXoyNyi3h3ZVbeWRyRg+tHgMDHRmS6
         X388u8sCA==
X-HalOne-ID: 79fad2fe-e5c6-11ed-b78f-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 79fad2fe-e5c6-11ed-b78f-b90637070a9d;
        Fri, 28 Apr 2023 13:13:34 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:13:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] fbdev: Use regular I/O function for framebuffers
Message-ID: <20230428131333.GF3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-1-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Fri, Apr 28, 2023 at 11:27:06AM +0200, Thomas Zimmermann wrote:
> (was: fbdev: Move framebuffer I/O helpers to <asm/fb.h>)
> 
> Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
> fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
> depends on the architecture, but they all come down to regular I/O
> functions of similar names. So use the regular functions instead.
> 
> The first patch a simple whitespace cleanup.
> 
> Until now, <linux/fb.h> contained an include of <asm/io.h>. As this
> will go away patches 2 to 4 prepare include statements in the various
> drivers. Source files that use regular I/O helpers, such as readl(),
> now include <linux/io.h>. Source files that use framebuffer I/O
> helpers, such as fb_readl(), also include <linux/io.h>.
> 
> Patch 5 replaces the architecture-based if-else branching in 
> <linux/fb.h> by define statements that map to Linux' I/O fucntions.
> 
> After this change has been merged and included in a few release
> without complains, we can update the drivers to regular I/O functions
> and remove the fbdev-specific defines.
> 
> The patchset has been built for a variety of platforms, such as x86-64,
> arm, aarch64, ppc64, parisc, m64k, mips and sparc.
> 
> v2:
> 	* use Linux I/O helpers (Sam, Arnd)
Much better, thanks!

	Sam
