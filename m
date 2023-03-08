Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAD6B1286
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCHUBQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 15:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCHUBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 15:01:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D23BAEF1;
        Wed,  8 Mar 2023 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VHBqNuY0x1wxfPhHVQhisSv8VveYnM+bpNzuUcj7maw=; b=QsbvVsbo95uqiUQ+u8JFvQ518z
        V5F2rcstU9wf3BOZjyhsTy80HKciKLqA7C14qMCSfqBzZ1KHmQfO5BarLsBQjON8VhmhTfD4E8v8N
        Ay1lYX9BjQwNAR/mvrNrDq+5gM49bap//5a/DKAB8Giq6IF3UlDstW9ya8c8i4jerLCVZ9uUtswrx
        dEI6EPvcZckPC6tcmbgoHTJrrf3mrcCuf1ngncIgFqJJuRKlRqW4WKieMX0zO0Nd6mVDErZ2TwWib
        wrqBsyJGkc+C/nbyErpVX/GVqfwMldJMf4Qilms8fJSjmgqZ+2ECdfmTnMHTr3ZmgT99hupAIshNB
        8JBgY0QA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZzyH-006cUe-Bn; Wed, 08 Mar 2023 20:01:09 +0000
Date:   Wed, 8 Mar 2023 12:01:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, mpe@ellerman.id.au,
        geert@linux-m68k.org, hch@infradead.org,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/4] video: fbdev: atyfb: only use ioremap_uc() on
 i386 and ia64
Message-ID: <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308130710.368085-2-bhe@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 08, 2023 at 09:07:07PM +0800, Baoquan He wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior, everywhere else this is the same as ioremap() anyway.
> 
> Change the only driver that still references ioremap_uc() to only do so
> on x86-32/ia64 in order to allow removing that interface at some
> point in the future for the other architectures.
> 
> On some architectures, ioremap_uc() just returns NULL, changing
> the driver to call ioremap() means that they now have a chance
> of working correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Is anyone using this driver these days? How often do fbdev drivers get
audited to see what can be nuked?


  Luis

