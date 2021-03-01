Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9F328D7F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhCATMm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 14:12:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:43780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238166AbhCATKX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 14:10:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA07CAE37;
        Mon,  1 Mar 2021 19:09:16 +0000 (UTC)
Date:   Mon, 1 Mar 2021 20:09:09 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, jannh@google.com,
        mpe@ellerman.id.au, carlos@redhat.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Message-ID: <20210301190909.GF32622@zn.tnic>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210227165911.32757-2-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 27, 2021 at 08:59:06AM -0800, Chang S. Bae wrote:
> Define the AT_MINSIGSTKSZ in generic Linux. It is already used as generic
> ABI in glibc's generic elf.h, and this define will prevent future namespace
> conflicts. In particular, x86 is also using this generic definition.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: Carlos O'Donell <carlos@redhat.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: libc-alpha@sourceware.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Change from v5:
> * Reverted the arm64 change. (Dave Martin)
> * Massaged the changelog.
> 
> Change from v4:
> * Added as a new patch (Carlos O'Donell)
> ---
>  include/uapi/linux/auxvec.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
> index abe5f2b6581b..15be98c75174 100644
> --- a/include/uapi/linux/auxvec.h
> +++ b/include/uapi/linux/auxvec.h
> @@ -33,5 +33,8 @@
>  
>  #define AT_EXECFN  31	/* filename of program */
>  
> +#ifndef AT_MINSIGSTKSZ
> +#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery  */

I know glibc's comment says a similar thing but the correct thing to say
here should be "minimal stack size for signal delivery" or so. Even the
variable name alludes to that too.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
