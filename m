Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC6C781CEF
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 10:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHTIZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHTIZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 04:25:51 -0400
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 01:24:52 PDT
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A89128
        for <linux-arch@vger.kernel.org>; Sun, 20 Aug 2023 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=mo2YDv+ovlF2nVfFfdhR2ZsisZkCOXFJRfLQgf7gU70=;
        b=oPDj7eeTLZNat7oFWPgKtTlMaBtxAnihJfGaFqy8/7POyvhIIpuxiuPK9LRia9YhnMGfQRR+JENET
         QE0UwABhiJjGbdtwzNx/UqJVVTkU3BrWmyZueq03p37h12EswRO1gUiu4g0znhUgKpZFF/6qf0ESpQ
         21Uyg3TZzOx+5I0gYoYPwmUCtEfJJ8gjeawklXY/rlmL1JddnLpyP7Aaye8J7ahomMjorUlpg+E+zN
         1r2nLBin26IeqO0KG/R+JIrE04L4RD0mw/yWGhsnd62br+Frl9XRLg00NDSMUfNKmUsJTuyPGGrEBU
         5d2C0EwF0N6ZRQMd6/k6X9Ukqgbjs/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=mo2YDv+ovlF2nVfFfdhR2ZsisZkCOXFJRfLQgf7gU70=;
        b=/P6fOU74/HqLKgyCkv/nwwB3RvY4shUENoqwAlAiMzHMus3tPNyeNgFlaJLVWKlSr2juyBb2l7Z8t
         ZOAek51Dw==
X-HalOne-ID: c8a2bf8f-3f30-11ee-9473-55333ba73462
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id c8a2bf8f-3f30-11ee-9473-55333ba73462;
        Sun, 20 Aug 2023 08:08:46 +0000 (UTC)
Date:   Sun, 20 Aug 2023 10:08:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/6] sparc: remove <asm/export.h>
Message-ID: <20230820080845.GB206827@ravnborg.org>
References: <20230819233353.3683813-1-masahiroy@kernel.org>
 <20230819233353.3683813-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819233353.3683813-2-masahiroy@kernel.org>
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 20, 2023 at 08:33:49AM +0900, Masahiro Yamada wrote:
> All *.S files under arch/sparc/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
> 
> Remove <asm/export.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
