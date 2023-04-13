Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54B6E0A02
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 11:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDMJTr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 05:19:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034719AF;
        Thu, 13 Apr 2023 02:19:43 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F5751EC072D;
        Thu, 13 Apr 2023 11:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681377582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BqAeXnAawc7TF4Rwxvw/NwWDmvgHHoXlMoB2DZzkgCw=;
        b=YZSX6N2tBxTUs/I8gCEgIsyOTEvRrZjlQ/ONT8Mvm87ciTtNLDkvAjtpL/KoN3JyJpsxad
        NVIrROJ6gOvyU3qwu+RMAOF8V15eo5sBfE0W5XehfOGxupL1U9QCNza71me13n5QOCtjiM
        NVeRHZDn6D/lX2lNF3g6PgNeI6HSYyo=
Date:   Thu, 13 Apr 2023 11:19:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v5 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <20230413091942.GCZDfJLq52qXRWXKQQ@fat_crate.local>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
 <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
 <ZDdX11GuiTu0uvpW@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDdX11GuiTu0uvpW@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 13, 2023 at 01:16:07AM +0000, Wei Liu wrote:
> On Mon, Apr 10, 2023 at 10:55:28PM -0700, Saurabh Sengar wrote:
> > Make get/set_rtc_noop() to be public so that they can be used
> > in other modules as well.
> > 
> > Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> x86 maintainers, can you please ack or nack this patch?

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
