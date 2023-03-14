Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47A6B88C9
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 03:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCNC5h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNC5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 22:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45EF8F71F
        for <linux-arch@vger.kernel.org>; Mon, 13 Mar 2023 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678762606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyrIGLqX2YJPW6IWpAt0DsDXF+2ApyDZOpSw0P/BqXc=;
        b=OMFkJ47sRBwQ4O8UyM2y33KFJ49rtNCRVBLZU1RIJq4Pru3eZJS8tLDwC/oZvADLfOmEaZ
        hhHsgcRqbCGjLeFUUEQhIs3zB22ssTOn3AUesw1qoTDpp5r8tVEFNyWtLTthmWqAQqfqQi
        Ngki/b1eug7V68LQBBXdThHpppfpk2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-YTYGE28YOkKWi1CSSHqk2g-1; Mon, 13 Mar 2023 22:56:42 -0400
X-MC-Unique: YTYGE28YOkKWi1CSSHqk2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A64B4100F909;
        Tue, 14 Mar 2023 02:56:41 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51E402A68;
        Tue, 14 Mar 2023 02:56:39 +0000 (UTC)
Date:   Tue, 14 Mar 2023 10:56:36 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, mcgrof@kernel.org, hch@infradead.org,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Message-ID: <ZA/iZHEHaQ2WR+HL@MiWiFi-R3L-srv>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-3-bhe@redhat.com>
 <20230313175521.GA14404@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313175521.GA14404@alpha.franken.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/13/23 at 06:55pm, Thomas Bogendoerfer wrote:
......
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
>   LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>   ^~~~~~~~~~~~~~
>   GEN     Makefile
>   Checking missing-syscalls for N32
>   CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>   Checking missing-syscalls for O32
>   CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>   CALL    /local/tbogendoerfer/korg/linux/scripts/checksyscalls.sh
>   CC      init/version.o
> In file included from /local/tbogendoerfer/korg/linux/include/linux/spinlock.h:311:0,
>                  from /local/tbogendoerfer/korg/linux/include/linux/vmalloc.h:5,
>                  from /local/tbogendoerfer/korg/linux/include/asm-generic/io.h:994,
>                  from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/io.h:618,
>                  from /local/tbogendoerfer/korg/linux/include/linux/io.h:13,
>                  from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/mips-cps.h:11,
>                  from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp-ops.h:16,
>                  from /local/tbogendoerfer/korg/linux/arch/mips/include/asm/smp.h:21,
>                  from /local/tbogendoerfer/korg/linux/include/linux/smp.h:113,
>                  from /local/tbogendoerfer/korg/linux/include/linux/lockdep.h:14,
>                  from /local/tbogendoerfer/korg/linux/include/linux/rcupdate.h:29,
>                  from /local/tbogendoerfer/korg/linux/include/linux/rculist.h:11,
>                  from /local/tbogendoerfer/korg/linux/include/linux/pid.h:5,
>                  from /local/tbogendoerfer/korg/linux/include/linux/sched.h:14,
>                  from /local/tbogendoerfer/korg/linux/include/linux/utsname.h:6,
>                  from /local/tbogendoerfer/korg/linux/init/version.c:17:
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_trylock’:
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function ‘spin_acquire’ [-Werror=implicit-function-declaration]
>    spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>    ^~~~~~~~~~~~
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:90:21: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
>    spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
>                      ^~
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h: In function ‘__raw_spin_lock_irqsave’:
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:110:20: error: ‘raw_spinlock_t {aka struct raw_spinlock}’ has no member named ‘dep_map’
>   spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>                     ^~
> /local/tbogendoerfer/korg/linux/include/linux/spinlock_api_smp.h:111:2: error: implicit declaration of function ‘LOCK_CONTENDED’ [-Werror=implicit-function-declaration]
>   LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>   ^~~~~~~~~~~~~~
> [...]
> 
> I've cut the compiler output. Removing the asm-generic doesn't show this
> problem, but so far I fail to see the reason...

Thanks for trying this.

Do you have the kernel config file, I can try to reproduce on my local
machine. And by the way, it could be fixed with below patch, not very
sure. Earlier, Arnd suggested this to fix a similar case.


From b3310e58c063b695ba7ab3966c57269f57f16585 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 14 Mar 2023 08:53:15 +0800
Subject: [PATCH] mips: use wmb() instead to replace iobarrier_w()
Content-type: text/plain

Otherwise nested including of asm/io.h and asm/mmiowb.h will cause
compiling error.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/mips/include/asm/mmiowb.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
index a40824e3ef8e..dd206792abed 100644
--- a/arch/mips/include/asm/mmiowb.h
+++ b/arch/mips/include/asm/mmiowb.h
@@ -2,9 +2,7 @@
 #ifndef _ASM_MMIOWB_H
 #define _ASM_MMIOWB_H
 
-#include <asm/io.h>
-
-#define mmiowb()	iobarrier_w()
+#define mmiowb()	wmb()
 
 #include <asm-generic/mmiowb.h>
 
-- 
2.34.1

