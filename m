Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB76EFB34
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjDZThW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjDZThT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 15:37:19 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 12:37:18 PDT
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA4198C
        for <linux-arch@vger.kernel.org>; Wed, 26 Apr 2023 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eVeo2+G0wfE7Th9mpMzqAlZwNjPXsqF5qhbG8BjXhfs=;
        b=cAOCLgpYeIgd+SmmPnle/bw2nmkoV/Wcu/JfousxXCWTrIQvRkzjoJkXzUu5C1+v5pjh9PiCe2CkM
         Qhz+tS62TbtvfjoewZNnQsVIohf5Lh6j3eeLb8oGMplSAWtWY4RmGoC8NWdegN1XZLMnR9ogqNkoQQ
         uXc2S1EUvclv9hfY33OezLtHys0IF70fCqjzu+pHztUy/Iv8rfBGvFIDt/l34oUk1uqmoZp0TRedDb
         n3a+nAhUaclrLH2tNkgZu49/49pwlw+NVupLOTPMnq2rs+LzYaCkGqNPvf12SGaHEpL638nDRGgYoM
         zGAQT7MBPP3QhvGMAQLLL8egMyK3MZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=eVeo2+G0wfE7Th9mpMzqAlZwNjPXsqF5qhbG8BjXhfs=;
        b=do/hY8c+tmgFEa4FnPVB0BzaGeCw1ybrSgm/bAII+A4jObIR152O0J//1DGI4vY4Rp4c904oVYBoa
         GD/PMttDA==
X-HalOne-ID: 7fc0ec5f-e467-11ed-9e8c-6f01c1d0a443
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 7fc0ec5f-e467-11ed-9e8c-6f01c1d0a443;
        Wed, 26 Apr 2023 19:21:11 +0000 (UTC)
Date:   Wed, 26 Apr 2023 21:21:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/5] fbdev: Move framebuffer I/O helpers to <asm/fb.h>
Message-ID: <20230426192110.GA3791243@ravnborg.org>
References: <20230426130420.19942-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426130420.19942-1-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas.

On Wed, Apr 26, 2023 at 03:04:15PM +0200, Thomas Zimmermann wrote:
> Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
> fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
> depends on the architecture. It's still all located in fbdev's main
> header file <linux/fb.h>. Move all of it into each archtecture's
> <asm/fb.h>, with shared code in <asm-generic/fb.h>.

For once I think this cleanup is moving things in the wrong direction.

The fb_* helpers predates the generic io.h support and try to
add a generic layer for read read / write operations.

The right fix would be to migrate fb_* to use the io helpers
we have today - so we use the existing way to handle the architecture
specific details.

From a quick look there seems to be some challenges but the current
helpers that re-do part of io.h is not the way forward and hiding them
in arch/include/asm/fb.h seems counter productive.

	Sam
