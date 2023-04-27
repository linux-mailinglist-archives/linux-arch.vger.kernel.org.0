Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F56F0AAB
	for <lists+linux-arch@lfdr.de>; Thu, 27 Apr 2023 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbjD0RSw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Apr 2023 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbjD0RSl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Apr 2023 13:18:41 -0400
X-Greylist: delayed 78983 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 10:18:39 PDT
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78827197
        for <linux-arch@vger.kernel.org>; Thu, 27 Apr 2023 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=3aPWmuilP5wLRilofoqbOrLGxKBwB7pAtJ4SXkaLvoc=;
        b=TLJMIi0RX8F2D4MECviwMXYvEcVb0lEsEy3+u8aUlSP8SU8rlCRGlNNmsB/nVOCzgK5pBrkqJQZ1F
         4Pk0P0hLFN1/gQl0wOoX80yo5LMFFkY8AFk8tIjenbcNtBTjLcrXTVOu35BU0ZgXdWnnSf7qi6nZ3E
         orNHCnRqwI7LiLkgzVpEQaOMbxTZLeop5dV4q915EpZK5kidlhmu8EBhfMffenaiZSY9k7inpdXkTU
         Jqtqf/GAdMoncZ0gbyd6bbDaxV/c7d0xakYFi8MhdcA4DCSizJdUq7VgNEnQ2ErW0+f+L1lpNilWl3
         /TH/k1Te5r34DMQFVMUEym1QgkeLrjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=3aPWmuilP5wLRilofoqbOrLGxKBwB7pAtJ4SXkaLvoc=;
        b=G5LZPAqKFgpnZqaJfT/ouJ07IZWuTH9E70Iw4lwAnH6U6PTleuFBBWfBI+H0sNsJGesQJZYrDGZOe
         rwUJGIwDg==
X-HalOne-ID: 62b9268b-e51f-11ed-ad1f-231b2edd0ed2
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 62b9268b-e51f-11ed-ad1f-231b2edd0ed2;
        Thu, 27 Apr 2023 17:17:31 +0000 (UTC)
Date:   Thu, 27 Apr 2023 19:17:29 +0200
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
Message-ID: <20230427171729.GA3899979@ravnborg.org>
References: <20230426130420.19942-1-tzimmermann@suse.de>
 <20230426192110.GA3791243@ravnborg.org>
 <3e33ab1d-b478-fdf5-6fbe-6580000182d1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e33ab1d-b478-fdf5-6fbe-6580000182d1@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Thu, Apr 27, 2023 at 09:22:47AM +0200, Thomas Zimmermann wrote:
> Hi Sam
> 
> Am 26.04.23 um 21:21 schrieb Sam Ravnborg:
> > Hi Thomas.
> > 
> > On Wed, Apr 26, 2023 at 03:04:15PM +0200, Thomas Zimmermann wrote:
> > > Fbdev provides helpers for framebuffer I/O, such as fb_readl(),
> > > fb_writel() or fb_memcpy_to_fb(). The implementation of each helper
> > > depends on the architecture. It's still all located in fbdev's main
> > > header file <linux/fb.h>. Move all of it into each archtecture's
> > > <asm/fb.h>, with shared code in <asm-generic/fb.h>.
> > 
> > For once I think this cleanup is moving things in the wrong direction.
> > 
> > The fb_* helpers predates the generic io.h support and try to
> > add a generic layer for read read / write operations.
> > 
> > The right fix would be to migrate fb_* to use the io helpers
> > we have today - so we use the existing way to handle the architecture
> > specific details.
> 
> I looked through the existing versions of the fb_() I/O helpers. They can
> apparently be implemented with the regular helpers of similar names.
> 
> I'm not sure, but even Sparc looks compatible. At least these sbus_
> functions seem to be equivalent to the __raw_() I/O helpers of similar
> names.

> Do you still have that Sparc emulator?
I used qemu the last time I played with sparc and saved the instructions
somewhere how to redo it - but that would use to bohcs driver only I think.
I have saprc machines, but none of these are easy to get operational.
We can always ask on sparclinux to get some testing feedback.

> 
> > 
> >  From a quick look there seems to be some challenges but the current
> > helpers that re-do part of io.h is not the way forward and hiding them
> > in arch/include/asm/fb.h seems counter productive.
> 
> Which challenges did you see?
sparc was the main thing - but maybe I did not look close enough.
And then I tried to map the macros to some of the more highlevel ones
from io.h, but as Arnd says the __raw* is the way to go here.

	Sam
