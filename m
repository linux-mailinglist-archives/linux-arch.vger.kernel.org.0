Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066EB77FC3C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353675AbjHQQjk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353720AbjHQQjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:39:37 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207D273F
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2023 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vIZEApjN48v7cjxMWecDniUYGxJ1pBYdlqtVcwGIpD4=;
        b=afbiIZBkDs4heKfhbghMmeD4NDauTO4zHYXx7GwvDSoUudh5dRzdfzzzZ9TKJYNq5o2Zg9gPPzx/2
         pO1mBnTUHH68D10xoCEu/g/ELHOKcwA42C5FOdHCySvCwKAHDebv8MqGiWexGlAcBu57+ejcULfnjt
         psejozQNn0kflhd4mUCCOVy1UGLKwe1oK9Eq6FxqQFHjpAZAQqFgXDq4NcLE5HBd7opM9kFrnU6/sG
         FDik21/qNeoWx9b651AEYuM9i2W6oZB/9CoSVodFUEQBfZkonFXsRbw1NcNqUqLFVrJfu1KiTvWU5U
         jU48fKXHb2ME7TvDFkcX0nn6TsxXioQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vIZEApjN48v7cjxMWecDniUYGxJ1pBYdlqtVcwGIpD4=;
        b=aU7GlH1EhJat8ieYjr1tdfY1IaPGhPENN3XtgpOGEdP2VKMUUpnLUAsd17kC/5B3icem4A1j4Pt4I
         BGw03biAg==
X-HalOne-ID: a3bc9125-3d1c-11ee-8c77-c5367ef0e45e
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id a3bc9125-3d1c-11ee-8c77-c5367ef0e45e;
        Thu, 17 Aug 2023 16:39:33 +0000 (UTC)
Date:   Thu, 17 Aug 2023 18:39:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] sparc: Remove <asm/ide.h>
Message-ID: <20230817163931.GA93297@ravnborg.org>
References: <cover.1692288018.git.geert@linux-m68k.org>
 <d26247f29e65b017c06e993f8aedece13a100369.1692288018.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26247f29e65b017c06e993f8aedece13a100369.1692288018.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 06:07:35PM +0200, Geert Uytterhoeven wrote:
> As of commit b7fb14d3ac63117e ("ide: remove the legacy ide driver") in
> v5.14, there are no more generic users of <asm/ide.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
