Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB66F18AF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbjD1NCS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbjD1NCN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:02:13 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755ED30C2
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Hja6mt7zd/g4QdMBdU1sqO6/W7qq91iso0TdUVxgpZQ=;
        b=FxfRtv4FrRk4Em92uXUdUOu+IzM4DLCaYbYTGf0HmoGt55Bw+sEDY7TE7lz25gy/jeDTUEKsXBIZ/
         6+/zEuHGM6MqT00hmyBIg4svWcWHFrXwM8Ddrqtbaonvw9PdH+q0F8N7NYRpiffg+snlE1k52haCEP
         Q5CLkzLprcKd2tpvL5TwuLWb8MO1adRNdXCSqIA1/a3O5zHg7QtYD1c+FIlAyfLETigqdlU+VTKWGI
         FixF6eXVaBb1j4cTQTrA12WO3TjCdZOGf/zxTjk9tA4KClER8AvaYJP1R9DtG68UpLgbxbewXtHQEG
         jrGTR/pTMVQQqT50i1/ZzQ9wb/svLNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Hja6mt7zd/g4QdMBdU1sqO6/W7qq91iso0TdUVxgpZQ=;
        b=xAKiE2HHYG+XEwajJ/cdBLZ5+XTobzra1m18RoIFmhS7CdvnYyld6dy+28/utM3Xy/8iXqxSekCsh
         CbQ0bBPDw==
X-HalOne-ID: baf7db08-e5c4-11ed-b748-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id baf7db08-e5c4-11ed-b748-b90637070a9d;
        Fri, 28 Apr 2023 13:01:06 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:01:04 +0200
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
Subject: Re: [PATCH v2 2/5] ipu-v3: Include <linux/io.h>
Message-ID: <20230428130104.GB3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-3-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 11:27:08AM +0200, Thomas Zimmermann wrote:
> The code uses readl() and writel(). Include the header file to
> get the declarations.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/ipu-v3/ipu-prv.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
> index 291ac1bab66d..d4621b1ea7f1 100644
> --- a/drivers/gpu/ipu-v3/ipu-prv.h
> +++ b/drivers/gpu/ipu-v3/ipu-prv.h
> @@ -8,6 +8,7 @@
>  
>  struct ipu_soc;
>  
> +#include <linux/io.h>
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/clk.h>
> -- 
> 2.40.0
