Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF251FB97
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 13:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiEILwu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiEILwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 07:52:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B7227048;
        Mon,  9 May 2022 04:48:54 -0700 (PDT)
Received: from [127.0.0.1] (unknown [46.183.103.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 601E71EC0529;
        Mon,  9 May 2022 13:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652096927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBcNvdGojA+kgezS1jEjzLjyoytYIqi04DLdwTBilBk=;
        b=jS4tFDIHbr7C3Uu/RAAiy+WGqeZJHXRjw/EI6aNobbXRodJ0Tb4PfSNpoOHW+KbqVJeaHw
        cv0CqgBMT/MbupN4iHymfPvSKpYZkSx6O42ICf+XF0of+KIBHBQgjFpRjluZ0Nz7tlLUS1
        0hHrdCu2/GVq2VEhhdnUoA07R5Levug=
Date:   Mon, 09 May 2022 13:48:44 +0200
From:   Boris Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
CC:     Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH v3 1/2] kernel: add platform_has() infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <20220504155703.13336-2-jgross@suse.com>
References: <20220504155703.13336-1-jgross@suse.com> <20220504155703.13336-2-jgross@suse.com>
Message-ID: <FBBBF0AE-05CD-4DE2-B656-C09C976600DA@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On May 4, 2022 5:57:02 PM GMT+02:00, Juergen Gross <jgross@suse=2Ecom> wro=
te:
>Add a simple infrastructure for setting, resetting and querying
>platform feature flags=2E
>
>Flags can be either global or architecture specific=2E
>
>Signed-off-by: Juergen Gross <jgross@suse=2Ecom>
>---
>V2:
>- rename set/reset functions to platform_[set|clear]() (Boris Petkov,
>  Heiko Carstens)
>- move function implementations to c file (Boris Petkov)
>---
> MAINTAINERS                            |  8 ++++++++
> include/asm-generic/Kbuild             |  1 +
> include/asm-generic/platform-feature=2Eh |  8 ++++++++
> include/linux/platform-feature=2Eh       | 15 ++++++++++++++
> kernel/Makefile                        |  2 +-
> kernel/platform-feature=2Ec              | 27 ++++++++++++++++++++++++++
> 6 files changed, 60 insertions(+), 1 deletion(-)
> create mode 100644 include/asm-generic/platform-feature=2Eh
> create mode 100644 include/linux/platform-feature=2Eh
> create mode 100644 kernel/platform-feature=2Ec

Nice and simple, I like=2E

Acked-by: Borislav Petkov <bp@suse=2Ede>
--=20
Sent from a device which is good for reading mail but awful for writing=2E=
 Please excuse any shortcomings=2E
