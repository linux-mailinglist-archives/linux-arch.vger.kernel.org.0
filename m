Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F18740318
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF0SVE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjF0SVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 14:21:03 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B15510FB
        for <linux-arch@vger.kernel.org>; Tue, 27 Jun 2023 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kcOM4/Wbu+ytgUTsuXGCBTLUq9C4K7TLK3Sk/wcjAaA=;
        b=q/BW6qwUmG/DBoBAJH9ZLHEWeOHY+VrN7laFR4Vrd9HPwW1zykNYORqnfyd44r3Q+ncDrbE7icGEI
         d1uWAUaw7t6bisk8FY8eLYbrWOHCMGZwOeSwvsMt+djmSeKXHRNJ+N46bzWTix0KUsHg2prPs0HmqZ
         2d7Dj6pxKVAY3fMXvUqVGL22pGb5Kbr1ZLrqvamwyHnAxA0wXid3D/i8RtUUsAHwwT96+30anx4a8a
         jz6hnQe04klv35aU215cRM5Xq7WhjUuNzBbK/QKJ6AIpQ1OVvrQgU/PnB7zHPFflHRzG3JLRPHcCRu
         osRLDwr8BOrwNIOW/DMk5G4dnIXn4pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kcOM4/Wbu+ytgUTsuXGCBTLUq9C4K7TLK3Sk/wcjAaA=;
        b=70X7t5hJxYRaTpiZRm6uZhYE0omt4ewkVRUZ+hLcIxuNWRDPj+glykMqi6lkFgWD/z+G5DAF5UTAV
         jNAWiGiDg==
X-HalOne-ID: 5babceb7-1517-11ee-92ec-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 5babceb7-1517-11ee-92ec-b90637070a9d;
        Tue, 27 Jun 2023 18:20:57 +0000 (UTC)
Date:   Tue, 27 Jun 2023 20:20:56 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     davem@davemloft.net, arnd@arndb.de, linux@roeck-us.net,
        deller@gmx.de, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] arch/sparc: Add module license and description for fbdev
 helpers
Message-ID: <20230627182056.GA110138@ravnborg.org>
References: <20230627145843.31794-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627145843.31794-1-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023 at 04:58:20PM +0200, Thomas Zimmermann wrote:
> Add MODULE_LICENSE() and MODULE_DESCRIPTION() for fbdev helpers
> on sparc. Fixes the following error:
> 
> ERROR: modpost: missing MODULE_LICENSE() in arch/sparc/video/fbdev.o
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/dri-devel/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4eec0b3048fc ("arch/sparc: Implement fb_is_primary_device() in source file")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
