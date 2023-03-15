Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4526BA449
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 01:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCOAvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCOAvC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 20:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F62C67E
        for <linux-arch@vger.kernel.org>; Tue, 14 Mar 2023 17:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678841411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+V2OenhBTZO+D4X2yTvwE20arRuy3dfWbSmOimZmE0=;
        b=TbryaQDdfaCOaAOzHsA3B/ZE1TqESrTcMpCxN6k6udZP9RZLUSPU0A7Z5KqwAb5KqEUkLf
        W0XwgvKYTQjaY8eeiMmS/Gt7kjkk4Y1h+8toe8KKRIrlLLMJlpMObdSPw9RXzoFw6BReir
        qe1Krc9EuohzuPh4G8PtGds9tuNYuwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-lAQsurbtNuCcZXpZ9h2LkQ-1; Tue, 14 Mar 2023 20:50:06 -0400
X-MC-Unique: lAQsurbtNuCcZXpZ9h2LkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 151B3857A87;
        Wed, 15 Mar 2023 00:50:05 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19BE0400F52;
        Wed, 15 Mar 2023 00:49:57 +0000 (UTC)
Date:   Wed, 15 Mar 2023 08:49:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Message-ID: <ZBEWMSdzzvsYCAnd@MiWiFi-R3L-srv>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
 <20230313175521.GA14404@alpha.franken.de>
 <ZA/iZHEHaQ2WR+HL@MiWiFi-R3L-srv>
 <20230314153421.GA13322@alpha.franken.de>
 <7f39daad-05b0-46f8-bc89-185b336d8fd4@gmail.com>
 <3fd94bd7-ab10-4d50-bcb6-7c13a3346d6a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd94bd7-ab10-4d50-bcb6-7c13a3346d6a@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/14/23 at 06:19pm, Arnd Bergmann wrote:
> On Tue, Mar 14, 2023, at 17:31, Florian Fainelli wrote:
> > On 3/14/23 08:34, Thomas Bogendoerfer wrote:
> >> On Tue, Mar 14, 2023 at 10:56:36AM +0800, Baoquan He wrote:
> >>>> In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
> >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
> >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
> >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
> >>>>                   from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
> >>>>                   from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
> >>>>                   from /local/tbogendoerfer/korg/linux/init/version.c:17:
> >> 
> >> already tried it, but it doesn't fix the issue. I've attached the
> >> config.
> >
> > I had attempted a similar approach before as Baoquan did, but met the 
> > same build issue as Thomas that was not immediately clear to me why it 
> > popped up. I would be curious to see how this can be resolved.
> 
> I think this is the result of recursive header inclusion:
> spinlock.h includes lockdep.h, but its header guard is already
> there from the include chain.
> 
> There is probably something in one of the mips asm/*.h headers that
> causes this recursion that is not present elsewhere.
> 
> I think this should fix it, but is likely to cause another problem elsewhere:
> 
> --- a/arch/mips/include/asm/smp-ops.h
> +++ b/arch/mips/include/asm/smp-ops.h
> @@ -13,8 +13,6 @@
>  
>  #include <linux/errno.h>
>  
> -#include <asm/mips-cps.h>
> -
>  #ifdef CONFIG_SMP
>  
>  #include <linux/cpumask.h>

Will meet below compiling error after appllying above patch. Adding
asm/mips-cps.h including in arch/mips/kernel/setup.c will fix it as below.

arch/mips/kernel/setup.c: In function ‘setup_arch’:
arch/mips/kernel/setup.c:781:9: error: implicit declaration of function ‘mips_cm_probe’ [-Werror=implicit-function-declaration]
  781 |         mips_cm_probe();
      |         ^~~~~~~~~~~~~
cc1: all warnings being treated as errors


diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f1c88f8a1dc5..e8c4020ef367 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/smp-ops.h>
 #include <asm/prom.h>
 #include <asm/fw/fw.h>
+#include <asm/mips-cps.h>
 
 #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
 char __section(".appended_dtb") __appended_dtb[0x100000];

