Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E266F18A4
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbjD1NA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1NA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:00:57 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4282268E
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PpcTclKxx1k/EfVG4yQr41oM9QVmOB40SVMjWl/npqE=;
        b=k3xZbk49OVdA8HAM23WQf7QvCAkY6osK5NwKaYOCelNTZEEDAi5JLJORKG53rPRLHF2UsEnaWjci2
         UleSovMJWsiI88ObSwz3BFTTOjC+dvZXpyhqmAh22eCaseqhpMutcTvgyACjthLZQisPTD+USiia7s
         6ImH25NiJgbL2Q/PjF4KyEFzSNpy8jfrpmufZNF/jOHLpQUWwx5qYXdybf4Iwxxx7/NKm+hQtW2Q3P
         cyW5mCcjWaxt6Qws7WctuxhcfLpL4nVXl+aSBhVeYilixYQs5Of8ZBVeTVmtKS710j6TwnXUPrNgeF
         4/I0ffLZ6Zgg+oztlcjlnHxl/TX6E/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=PpcTclKxx1k/EfVG4yQr41oM9QVmOB40SVMjWl/npqE=;
        b=OoYC+n7ssdxw6mi4jodInt4BWBrg7fNY89ixy7jkhAqbElGIdulre1GkkC01oXDeMYsAhMsN5uwCw
         PnTA6SfBw==
X-HalOne-ID: b3232d4d-e5c4-11ed-9b54-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id b3232d4d-e5c4-11ed-9b54-99461c6a3fe8;
        Fri, 28 Apr 2023 13:00:52 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:00:50 +0200
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
Subject: Re: [PATCH v2 1/5] fbdev/matrox: Remove trailing whitespaces
Message-ID: <20230428130050.GA3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-2-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 11:27:07AM +0200, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
