Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25255792615
	for <lists+linux-arch@lfdr.de>; Tue,  5 Sep 2023 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjIEQVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Sep 2023 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbjIECrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 22:47:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C871CC7;
        Mon,  4 Sep 2023 19:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693882031;
        bh=u10/VToy+E/OPi9XjZP4n2I6K6AMC3YNx3lXqqyKrWA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J0UyS+WIgQoJYbA9dbawO9edyrVtzWysZpXCEe9VqoDfs69TC9XyVtpilDMb0DEdo
         axw/o1IALllIcMtWiaXWPx2zGTpR7663jgxJF0b2wkAXldKnXW3f7Cit6zC8eQlq5W
         zxrCjsTS3nw4p4rSekMEqCCJ3X2Es8bFh+9hvA9nIvYbKQSVD3PA5ruIot2oAAap5E
         HvFJj7T0be9dQ0NvrLr0/NzJmayyh2b5KWasZixoItg0Ptm1DeHlC7hhO2b213URb3
         gAfV86Nq7wJZpMhKiDyKmU5ssXQRSkyv/QhuKEp9AjNySr/h2XsGejVTsQZaXbEGJT
         AbXUqd44M/lMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfqfP1SNYz4wZn;
        Tue,  5 Sep 2023 12:47:09 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Zimmermann <tzimmermann@suse.de>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/4] ppc, fbdev: Clean up fbdev mmap helper
In-Reply-To: <20230901142659.31787-1-tzimmermann@suse.de>
References: <20230901142659.31787-1-tzimmermann@suse.de>
Date:   Tue, 05 Sep 2023 12:47:08 +1000
Message-ID: <874jk9ibf7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:
> Refactor fb_pgprotect() in PowerPC to work without struct file. Then
> clean up and rename fb_pgprotect(). This change has been discussed at
> [1] in the context of refactoring fbdev's mmap code.
>
> The first three patches adapt PowerPC's internal interfaces to
> provide a phys_mem_access_prot() that works without struct file. Neither
> the architecture code or fbdev helpers need the parameter.
>
> Patch 4 replaces fbdev's fb_pgprotect() with fb_pgprot_device() on
> all architectures. The new helper with its stream-lined interface
> enables more refactoring within fbdev's mmap implementation.

The content of this series is OK, but the way it's structured makes it a
real headache to merge, because it's mostly powerpc changes and then a
dependant cross architecture patch at the end.

It would be simpler if patch 4 was first and just passed file=NULL to
the powerpc helper, with an explanation that it's unused and will be
dropped in a future cleanup.

We could then put the first patch (previously patch 4) in a topic branch
that is shared between the powerpc tree and the fbdev tree, and then the
powerpc changes could be staged on top of that through the powerpc tree.

cheers
