Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA62510574
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiDZRed (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiDZRe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 13:34:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F171FA4A;
        Tue, 26 Apr 2022 10:31:19 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A39F1EC04F9;
        Tue, 26 Apr 2022 19:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650994274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+xYV1ChaydvSUgBTfjtQMIuLFvZBBr5YN11vYi9Ld+E=;
        b=mHHpxddAp1KGl7iVSXBqP485BzzHfEiDLirauISvPiHFQA4pKujjt94hu/0G5btJIrAYXs
        AgKOhoTfGuODLk8Pcj96q5/sA/QKxxyESUH1NMiE/NrrGBlMujDp4LDHT+JRqWlnAGsJrc
        IP179lVA+WstNQvMGVBAYBDzybKjVJY=
Date:   Tue, 26 Apr 2022 19:31:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
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
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
Message-ID: <YmgsYvWQchxub8cW@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220426134021.11210-2-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 03:40:20PM +0200, Juergen Gross wrote:
> diff --git a/kernel/platform-feature.c b/kernel/platform-feature.c
> new file mode 100644
> index 000000000000..2d52f8442cd5
> --- /dev/null
> +++ b/kernel/platform-feature.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/cache.h>
> +#include <linux/platform-feature.h>
> +
> +unsigned long __read_mostly platform_features[PLATFORM_FEAT_ARRAY_SZ];

Probably __ro_after_init.

> +EXPORT_SYMBOL_GPL(platform_features);

You probably should make that thing static and use only accessors to
modify it in case you wanna change the underlying data structure in the
future.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
