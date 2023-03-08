Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A96B1651
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 00:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCHXNr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 18:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCHXNq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 18:13:46 -0500
X-Greylist: delayed 897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 15:13:44 PST
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448F0F760;
        Wed,  8 Mar 2023 15:13:44 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 631267A03E2;
        Wed,  8 Mar 2023 23:48:33 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 1/4] video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Date:   Wed, 8 Mar 2023 23:48:29 +0100
User-Agent: KMail/1.9.10
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        mpe@ellerman.id.au, geert@linux-m68k.org, hch@infradead.org,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230308130710.368085-1-bhe@redhat.com> <20230308130710.368085-2-bhe@redhat.com> <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
In-Reply-To: <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303082348.29416.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday 08 March 2023 21:01:09 Luis Chamberlain wrote:
> On Wed, Mar 08, 2023 at 09:07:07PM +0800, Baoquan He wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> > extension, and on ia64 with its slightly unconventional ioremap()
> > behavior, everywhere else this is the same as ioremap() anyway.
> > 
> > Change the only driver that still references ioremap_uc() to only do so
> > on x86-32/ia64 in order to allow removing that interface at some
> > point in the future for the other architectures.
> > 
> > On some architectures, ioremap_uc() just returns NULL, changing
> > the driver to call ioremap() means that they now have a chance
> > of working correctly.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Is anyone using this driver these days? How often do fbdev drivers get
> audited to see what can be nuked?

Older servers have integrated ATI Rage XL chips and this is the only driver for it.

-- 
Ondrej Zary
