Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9193715AC
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhECNHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhECNHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 09:07:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C6C06174A;
        Mon,  3 May 2021 06:06:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f268e00dd8a2da2f8721c37.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:8e00:dd8a:2da2:f872:1c37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD0D91EC0246;
        Mon,  3 May 2021 15:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620047169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+p5vQrYHKEfZHEbLXzB+VcWiRS/KsvNyGUDiBG7mxVk=;
        b=WSrGXPII9l1c0TyyvH15YPAQ93WvPEQ0SdpBXOlF+BoxTgpUDyq7fEdZyyxXBPxMNQ5SBH
        n/NRkthit9DsjvZJ3iUFz6FGvntalh54Xj2bh0UJQysQs0vVlk4i+GGhlt1i3T7/8aJN/q
        yanQ+50Mh9b3DJOCD9RyOVi+K6l/d3w=
Date:   Mon, 3 May 2021 15:06:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, jannh@google.com,
        mpe@ellerman.id.au, carlos@redhat.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] x86/signal: Introduce helpers to get the maximum
 signal frame size
Message-ID: <YI/1P1fBix5HWBki@zn.tnic>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210422044856.27250-3-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 09:48:52PM -0700, Chang S. Bae wrote:
> +void __init init_sigframe_size(void)
> +{
> +	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
> +
> +	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
> +
> +	/* Userspace expects an aligned size. */
> +	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);

I guess we want

	pr_info("max sigframe size: %lu\n", max_frame_size);

here so that we can keep an eye on how much this becomes, in practice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
