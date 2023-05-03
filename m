Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8C6F5EC8
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjECTDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjECTDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 15:03:24 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A59E83D6
        for <linux-arch@vger.kernel.org>; Wed,  3 May 2023 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=VwK1Pxwllknm05RC4IcE4UF09296VmV5/KUmDsmc45k=;
        b=XsHl84HrOPhHgBPqV3PW6yB/AvFhQII0nRtKV/8h8T+dCcMr5Tik6QMi/wSHQOzhOhtbUHSqfhZgd
         WSx/Z0hPEz3w+9sT8inTO8HUZ7mXKy80p1Hkngiwyx5WeGAS6L3ICdE9j4k0MYAt439GYTv80H30JL
         Wa3Kt+e0ozxs6GkaFSJ4Ggac50LASOD5G3YVJoy/Rrtbtu+bkuBlS+VFLgSy90XJkkej9/oXpWU/kv
         CxJ9i3AgBzyz7jKenTHVv5rGIZw0qOt+yq1IzXFIz2dG2+JZP65n87Ub2Ux9raWeeAjrFYUvEdc0tG
         etwNu46L2bAupljCsQC8YEYAHO7kJWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=VwK1Pxwllknm05RC4IcE4UF09296VmV5/KUmDsmc45k=;
        b=Lew0Bnll2GhHFcWrhU2ydPTnZ0g2qcfs1S5m/vajLVuTjd48PZ0vIjaL11J3Em1kUt7VNpMclPo45
         R57yfj8Ag==
X-HalOne-ID: 2a0894ca-e9e5-11ed-9ffc-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 2a0894ca-e9e5-11ed-9ffc-13111ccb208d;
        Wed, 03 May 2023 19:03:19 +0000 (UTC)
Date:   Wed, 3 May 2023 21:03:17 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        arnd@arndb.de, deller@gmx.de, chenhuacai@kernel.org,
        javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        linux-parisc@vger.kernel.org, vgupta@kernel.org,
        sparclinux@vger.kernel.org, kernel@xen0n.name,
        linux-snps-arc@lists.infradead.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Message-ID: <20230503190317.GA422961@ravnborg.org>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <20230502200300.GB319489@ravnborg.org>
 <df767237-2bae-f299-9cbb-1543f76c9c3a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df767237-2bae-f299-9cbb-1543f76c9c3a@suse.de>
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

> > But I am missing something somewhere as I cannot see how this builds.
> > asm-generic now provide the fb_read/fb_write helpers.
> > But for example sparc has an architecture specifc fb.h so it will not
> > use the asm-generic variant. So I wonder how sparc get hold of the
> > asm-generic fb.h file?
> 
> All architecture's <asm/fb.h> files include <asm-generic/fb.h>, so that they
> all get the interfaces which they don't define themselves. For Sparc, this
> is at [1].
> 
> Best regards
> Thomas
> 
> 
> [1]
> https://cgit.freedesktop.org/drm/drm-tip/tree/arch/sparc/include/asm/fb.h#n19
> 
> > 
> > Maybe it is obvious, but I miss it.

OK, it was obvious and I missed it.
I looked at the mainline kernel, and not the drm-tip variant.
Sorry for the noise.

	Sam
