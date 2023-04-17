Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C636E4B16
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDQONs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 17 Apr 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDQONp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 10:13:45 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D686AC;
        Mon, 17 Apr 2023 07:13:42 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1poPbr-002HuW-Kt; Mon, 17 Apr 2023 16:13:35 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1poPbr-0043co-Cy; Mon, 17 Apr 2023 16:13:35 +0200
Message-ID: <0b07fbadce4512e4696750cf69cf3fbbf38355a3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 16/19] arch/sh: Implement <asm/fb.h> with generic
 helpers
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        daniel.vetter@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Date:   Mon, 17 Apr 2023 16:13:33 +0200
In-Reply-To: <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
References: <20230417125651.25126-1-tzimmermann@suse.de>
         <20230417125651.25126-17-tzimmermann@suse.de>
         <3c188e948506dc97112dcc070cf16e36209c6cc5.camel@physik.fu-berlin.de>
         <132f1185-d61f-b8c7-8d6e-4e4280a1a4ad@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas!

On Mon, 2023-04-17 at 16:06 +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 17.04.23 um 15:02 schrieb John Paul Adrian Glaubitz:
> > Hi Thomas!
> > 
> > On Mon, 2023-04-17 at 14:56 +0200, Thomas Zimmermann wrote:
> > > Replace the architecture's fbdev helpers with the generic
> > > ones from <asm-generic/fb.h>. No functional changes.
> > > 
> > > v2:
> > > 	* use default implementation for fb_pgprotect() (Arnd)
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > Cc: Rich Felker <dalias@libc.org>
> > > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > ---
> > >   arch/sh/include/asm/fb.h | 15 +--------------
> > >   1 file changed, 1 insertion(+), 14 deletions(-)
> > > 
> > > diff --git a/arch/sh/include/asm/fb.h b/arch/sh/include/asm/fb.h
> > > index 9a0bca2686fd..19df13ee9ca7 100644
> > > --- a/arch/sh/include/asm/fb.h
> > > +++ b/arch/sh/include/asm/fb.h
> > > @@ -2,19 +2,6 @@
> > >   #ifndef _ASM_FB_H_
> > >   #define _ASM_FB_H_
> > >   
> > > -#include <linux/fb.h>
> > > -#include <linux/fs.h>
> > > -#include <asm/page.h>
> > > -
> > > -static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> > > -				unsigned long off)
> > > -{
> > > -	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > > -}
> > 
> > Looking at the macro in asm-generic/fb.h, fb_pgprotect() is being replaced with
> > a no-op function. Is that intentional? Can you briefly explain the background
> > for this change?
> 
> Patch 01 of this patchset changes the generic fb_pgprotect() to set 
> pgprot_writecombine(). So on SH, there should be no change at all.
> 

Ah, I missed that, thanks for the explanation. Let me check and Ack your patch
then. I assume you will be taking this patch as part of the whole series through
your own tree?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
