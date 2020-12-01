Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0D2CA592
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgLAO1z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 09:27:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50392 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLAO1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 09:27:55 -0500
Received: from zn.tnic (p200300ec2f0e6a00797954e951a06088.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:6a00:7979:54e9:51a0:6088])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF1341EC04D1;
        Tue,  1 Dec 2020 15:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606832833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jASWDk32Z/IY+a6hoVkThz3R94OZ3u3xXFaDDRkTrYA=;
        b=Gyy0HPN8jECjtuzlUA22ZxsV5AmeNWjr8UMM+adaeqLz05oD4BihgPa1XlOgFbrzh+Tm3/
        SfKjbVKzlymFpJ78SqudF2NQRpGI9slZPLzsJzV23LUDpYymLBRgJD4MlDJiIQkoTsGI09
        3POnmdUfVbIncIpm8JULF5pdXsAxnjw=
Date:   Tue, 1 Dec 2020 15:27:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Message-ID: <20201201142709.GB22927@zn.tnic>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-2-chang.seok.bae@intel.com>
 <20201125111630.GA10378@zn.tnic>
 <FFC7041A-2CCA-4C7E-A9C9-6C2C30CE7D28@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FFC7041A-2CCA-4C7E-A9C9-6C2C30CE7D28@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 30, 2020 at 08:40:32PM +0000, Bae, Chang Seok wrote:
> In general, putting #ifdef in a C file is advised to avoid.

Well, in this case it is arguably better to have the ifdeffery there,
where it is being used.

> I wonder whether it is okay to include #ifdef in the C file in this
> case.

Yes, it's not like this will be the only place where you have #ifdef in
a .c file:

[ ~/kernel/linux> git grep "#ifdef" *.c | wc -l
29401

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
