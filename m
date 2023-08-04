Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9C876F72D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 03:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHDBtj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 21:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHDBti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 21:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6D35B5;
        Thu,  3 Aug 2023 18:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C907B61EFE;
        Fri,  4 Aug 2023 01:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3399CC433AB;
        Fri,  4 Aug 2023 01:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691113776;
        bh=c6a+4eVuqCEy+L3hkW2HNXMEXxRrGJGb5fl7lqzbOAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szYXw+V3wysuNpyUa9azAA9ozy6luw4l1RRxiCjhjv4tdHE2b8Y8mRenCXobk/upE
         9Iy0+dfj8B8wKAHoHpf79pMqLu2Seu+t9gTSgBRzDaVRuvS7YvBxrdj1f/f0lDQh7e
         giEU6P4IN6MwhFix3UwCOqI5jp88LHqY3Zn+2u0ibd1A/xvNPpzjMKYcPvZkVMXOps
         Z6K2s0VV9Iljeoo4Zy+jrZ7pqCqMcmFpILSGVwBq/zcgUH4hEkvtQ4F/kvQ0yFKMUT
         hxQDFfSaB88NYBeKOa3xgyoMYZ54ijUKBgTx3LExwtgAj2ep253eEVEEyLmjdII9U9
         6Lc3uBgIziBxw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so2066982a12.0;
        Thu, 03 Aug 2023 18:49:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCerqW1XFG+nMfUHlcfbiiuh5hNA8JPxDcw8xQRougFgMXLPtu
        83t9gOdyEk7AAGui6YiZrnBfzi49snbI6P30b9Q=
X-Google-Smtp-Source: AGHT+IGWQ7zRgd6LjGXcymJf1tgsSVQncpoygHY2DOxmH1yIur2ktn4Ug6YHgzVLRJT90bh/GAq1GQxdCGUiO3/lfB0=
X-Received: by 2002:aa7:d948:0:b0:523:102f:3cde with SMTP id
 l8-20020aa7d948000000b00523102f3cdemr378786eds.23.1691113774244; Thu, 03 Aug
 2023 18:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210514200743.3026725-1-alex.kogan@oracle.com>
 <20210514200743.3026725-4-alex.kogan@oracle.com> <20210922192528.ob22pu54oeqsoeno@offworld>
In-Reply-To: <20210922192528.ob22pu54oeqsoeno@offworld>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 09:49:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTLJ3h8drkoTcV_V9AaNsNBkvg9G9Fi3+w_srJzcZG3=g@mail.gmail.com>
Message-ID: <CAJF2gTTLJ3h8drkoTcV_V9AaNsNBkvg9G9Fi3+w_srJzcZG3=g@mail.gmail.com>
Subject: Re: [PATCH v15 3/6] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 23, 2021 at 3:26=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Fri, 14 May 2021, Alex Kogan wrote:
>
> >diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
> >index a816935d23d4..94d35507560c 100644
> >--- a/Documentation/admin-guide/kernel-parameters.txt
> >+++ b/Documentation/admin-guide/kernel-parameters.txt
> >@@ -3515,6 +3515,16 @@
> >                       NUMA balancing.
> >                       Allowed values are enable and disable
> >
> >+      numa_spinlock=3D  [NUMA, PV_OPS] Select the NUMA-aware variant
> >+                      of spinlock. The options are:
> >+                      auto - Enable this variant if running on a multi-=
node
> >+                      machine in native environment.
> >+                      on  - Unconditionally enable this variant.
>
> Is there any reason why the user would explicitly pass the on option
> when the auto thing already does the multi-node check? Perhaps strange
> numa topologies? Otherwise I would say it's not needed and the fewer
> options we give the user for low level locking the better.
>
> >+                      off - Unconditionally disable this variant.
> >+
> >+                      Not specifying this option is equivalent to
> >+                      numa_spinlock=3Dauto.
> >+
> >       numa_zonelist_order=3D [KNL, BOOT] Select zonelist order for NUMA=
.
> >                       'node', 'default' can be specified
> >                       This can be set from sysctl after boot.
> >diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >index 0045e1b44190..819c3dad8afc 100644
> >--- a/arch/x86/Kconfig
> >+++ b/arch/x86/Kconfig
> >@@ -1564,6 +1564,26 @@ config NUMA
> >
> >         Otherwise, you should say N.
> >
> >+config NUMA_AWARE_SPINLOCKS
> >+      bool "Numa-aware spinlocks"
> >+      depends on NUMA
> >+      depends on QUEUED_SPINLOCKS
> >+      depends on 64BIT
> >+      # For now, we depend on PARAVIRT_SPINLOCKS to make the patching w=
ork.
> >+      # This is awkward, but hopefully would be resolved once static_ca=
ll()
> >+      # is available.
> >+      depends on PARAVIRT_SPINLOCKS
>
> We now have static_call() - see 9183c3f9ed7.
>
>
> >+      default y
> >+      help
> >+        Introduce NUMA (Non Uniform Memory Access) awareness into
> >+        the slow path of spinlocks.
> >+
> >+        In this variant of qspinlock, the kernel will try to keep the l=
ock
> >+        on the same node, thus reducing the number of remote cache miss=
es,
> >+        while trading some of the short term fairness for better perfor=
mance.
> >+
> >+        Say N if you want absolute first come first serve fairness.
>
> This would also need a depends on !PREEMPT_RT, no? Raw spinlocks really w=
ant
> the determinism.
I hope we shouldn't force disable it in the Kconfig. Could we put this
idea in numa_spinlock=3Dauto?

>
> Thanks,
> Davidlohr



--=20
Best Regards
 Guo Ren
