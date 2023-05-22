Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5A70C160
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEVOom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 10:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVOol (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 10:44:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB899;
        Mon, 22 May 2023 07:44:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23A2A21D3D;
        Mon, 22 May 2023 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684766679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jujgzsASF6xi60CjIDkx8JGmNGm4j6MXDTWCGTNfWg=;
        b=JrCmHe8s9GErEBKDbq3ON7dcqwQm3uhhYAskZEG8Om77uI4/P3mPYJFm+w/PQmJoSZAIwJ
        c3iNZi98C5WKhHbUBdfZDgVbxelSmH3bErb2+e/KHVVRnP8oxRtwGNHHX3l+4C7NSPqTlc
        20X4z8HpA0E8YV4yQoXWEjUjFSw/XAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684766679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jujgzsASF6xi60CjIDkx8JGmNGm4j6MXDTWCGTNfWg=;
        b=7B6qZzZRnEdbUDvFagPTMiXcS9zZZeKh/LG8MFFB4oCpW6PQ6ItAYyV1XDug1paT5iblKb
        Xy2IF2M/BwtT2yDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C320913776;
        Mon, 22 May 2023 14:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rp2eLtZ/a2T2KAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 22 May 2023 14:44:38 +0000
Date:   Mon, 22 May 2023 16:44:38 +0200
Message-ID: <87a5xwifxl.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 32/44] sound: add HAS_IOPORT dependencies
In-Reply-To: <c63aaec4da1d9e8b8b48cf037b3d859c62ee1a59.camel@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
        <20230522105049.1467313-33-schnelle@linux.ibm.com>
        <87cz2sy3t3.wl-tiwai@suse.de>
        <c63aaec4da1d9e8b8b48cf037b3d859c62ee1a59.camel@linux.ibm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 May 2023 15:54:36 +0200,
Niklas Schnelle wrote:
> 
> On Mon, 2023-05-22 at 13:59 +0200, Takashi Iwai wrote:
> > On Mon, 22 May 2023 12:50:37 +0200,
> > Niklas Schnelle wrote:
> > > 
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > > 
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > Looks good to me.  Would you like the patch picked up through
> > sound.git tree, or rather apply all through a different tree?
> > In the latter case:
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > 
> > thanks,
> > 
> > Takashi
> 
> With the Kconfig addition of HAS_IOPORT merged in v6.4-rc1 this patch
> can now go independently via the the sound.git tree. Our plan is to get
> as many of these per-subsystem patches merged for v6.5 as possible such
> that then only a small number (ideally zero) of patches remain before
> the last one can be merged removing inb()/outb() etc for HAS_IOPORT=n.

OK, then I applied the patch now on for-next branch.


Thanks!

Takashi
