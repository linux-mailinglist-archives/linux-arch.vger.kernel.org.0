Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B945109B7
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 22:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354587AbiDZUNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354619AbiDZUNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 16:13:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CF17B9B7;
        Tue, 26 Apr 2022 13:09:46 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79D091EC013E;
        Tue, 26 Apr 2022 22:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651003781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g+qc3MZ0SQsvosVVg7h3CKtzDX+zr1LTTY7ud+C7p94=;
        b=GUxKH9o77tdVt0rqwRSeU3fUYAlvlTkvhwr15Rs40kD2dZ5yKdFvRJGFXCxpUNV0SFsxwP
        qnW2VQIe8J1Jp1dpOAts0sf+yiOAUT8Ifyc51B8XqFD9D6wCAYxIZvFYhvIJ/MM2DIKunD
        VXk4NdNk5fEXgr1gM1va5FIoRXXStNc=
Date:   Tue, 26 Apr 2022 22:09:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <YmhRgn896loDHofa@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com>
 <YmgsYvWQchxub8cW@zn.tnic>
 <YmhNxnHMe/of4rDD@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmhNxnHMe/of4rDD@osiris>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 09:53:42PM +0200, Heiko Carstens wrote:
> > You probably should make that thing static and use only accessors to
> > modify it in case you wanna change the underlying data structure in the
> > future.
>
> That would add another indirection, which at least I think is not
> necessary and would make it less likely that this infrastructure is
> used.

So if you want to have a single variable which contains platform feature
bits, you don't need any platform_<bla> accessors but use this variable
directly.

I'd prefer the accessors any day of the week, though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
