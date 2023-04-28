Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45F6F1D01
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346436AbjD1Qym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjD1Qyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 12:54:37 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216E5BBE
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=4h2Y9ZZQ14tdvAGC5hFpqIKQWvmB0qe68pQRnQlSShc=;
        b=IrdAXdZPKho0zoQxG/scktRALZpl2c237XlKLT5EIx0ja7nZb83hqvUgOuyY55pNvHYqH3FsErtl1
         5jx6Clb6lkPL8TkUqCtTnSvfCnAc1GKTQxpoyL9YYmuFWy6pRl3ovRobT6YFtqeLlVGxUM3+fK10GW
         26P+hLCnm+zpPHV7tOv/ibW1ECpjZ4qETcRhhPvrkIFIONhGHQGcxNm6MxcY5BEqj85CuJqzXS5rce
         1Inl5d47E3sR2kFuS+NTw8OWDudvX6hThvyhlLeRI9ruUhs5QS1y61KsI01ISxy6adAYh2hLAOXbIt
         t6mRhKxKsnm9awtbASezT6BrkUMBpFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=4h2Y9ZZQ14tdvAGC5hFpqIKQWvmB0qe68pQRnQlSShc=;
        b=2sOyzdZRm0G5akePNgNy9pFImOAXPUTPUHEcB6iUeB7W+50cDIuX1agx3ldJaHWZog9XyDftdQu09
         P8qxcwNCA==
X-HalOne-ID: 4d02a9c5-e5e5-11ed-9bd2-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 4d02a9c5-e5e5-11ed-9bd2-13111ccb208d;
        Fri, 28 Apr 2023 16:54:14 +0000 (UTC)
Date:   Fri, 28 Apr 2023 18:54:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
Message-ID: <20230428165412.GA4010212@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <20230428131221.GE3995435@ravnborg.org>
 <900eaf1c-4d29-2c26-c220-6b4e089d9b94@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900eaf1c-4d29-2c26-c220-6b4e089d9b94@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Fri, Apr 28, 2023 at 04:18:38PM +0200, Thomas Zimmermann wrote:
> I'd be happy to have fb_() wrappers that are I/O helpers without
> ordering guarantees. I'd just wouldn't want them in <linux/fb.h>

How about throwing them into a new drm_fb.h header file.
This header file could be the home for all the fb stuff that is
shared between drm and the legacy fbdev.

Then we may slowly migrate more fbdev stuff to drm and let the legacy
fbdev stuff use the maintained drm stuff.
Dunno, the pain may not be worth it.

	Sam
