Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77B511744
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiD0McA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiD0McA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 08:32:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6FA3CFE1;
        Wed, 27 Apr 2022 05:28:49 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03CBC1EC0535;
        Wed, 27 Apr 2022 14:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651062524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aKBRkdcOUK2pnp+vQSbUvbTqtIXnLKj0VJmSDmt7oC0=;
        b=NHfKIFQJ+SZeRMFRR7iG7AvrorZ4sGeAQW951IHLqZGiIhH8xsnL4MEoCvZdO988HVhjCs
        QiJ/yZkmdzpdCcjdb2XM/Jk4CwXtZtIij26TQdC9Zn+whgo9bcaGJcoQKIQwADOIUE7sTC
        lJ/9+OjkWEUKJjYRxqSk5MOYidSpSXw=
Date:   Wed, 27 Apr 2022 14:28:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Message-ID: <Ymk2/N/DdAyxQnV0@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com>
 <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 27, 2022 at 08:37:31AM +0200, Juergen Gross wrote:
> On 26.04.22 19:35, Borislav Petkov wrote:
> > On Tue, Apr 26, 2022 at 03:40:21PM +0200, Juergen Gross wrote:
> > >   /* protected virtualization */
> > >   static void pv_init(void)
> > >   {
> > >   	if (!is_prot_virt_guest())
> > >   		return;
> > > +	platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > 
> > Kinda long-ish for my taste. I'll probably call it:
> > 
> > 	platform_set()
> > 
> > as it is implicit that it sets a feature bit.
> 
> Okay, fine with me.
> 
> > 
> > > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > > index b43bc24d2bb6..6043ba6cd17d 100644
> > > --- a/arch/x86/mm/mem_encrypt_identity.c
> > > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > > @@ -40,6 +40,7 @@
> > >   #include <linux/mm.h>
> > >   #include <linux/mem_encrypt.h>
> > >   #include <linux/cc_platform.h>
> > > +#include <linux/platform-feature.h>
> > >   #include <asm/setup.h>
> > >   #include <asm/sections.h>
> > > @@ -566,6 +567,10 @@ void __init sme_enable(struct boot_params *bp)
> > >   	} else {
> > >   		/* SEV state cannot be controlled by a command line option */
> > >   		sme_me_mask = me_mask;
> > > +
> > > +		/* Set restricted memory access for virtio. */
> > > +		platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > 
> > Huh, what does that have to do with SME?
> 
> I picked the function where sev_status is being set, as this seemed to be
> the correct place to set the feature bit.

What I don't understand is what does restricted memory access have to do
with AMD SEV and how does play together with what you guys are trying to
do?

The big picture pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
