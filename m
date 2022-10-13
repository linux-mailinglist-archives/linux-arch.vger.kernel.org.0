Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619A5FD6E5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJMJVt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJMJVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 05:21:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BECCF53FF;
        Thu, 13 Oct 2022 02:21:47 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e733329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e733:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69BF11EC053B;
        Thu, 13 Oct 2022 11:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665652901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LnnwRuw3rWkfmMreTNatsscTtvI113RGrzj3mDZQgt8=;
        b=IR4M12YIlBzE0MjYoQkPm9YQGawwBKItPFR1A5j38MojCMdB6INXbCzDfJl7BCrCqwvDLk
        vFprQY8OXhEdV/nrLCnqbyE1/PQLJoy0lmRPhi/B8vMtKUOEl6D9FLnPNxQcdw+T18xnB+
        sUmZcBp5AcpqUJo1RmRC9rh5vKxdfEY=
Date:   Thu, 13 Oct 2022 11:21:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Message-ID: <Y0fYoG+BCYncSNmL@zn.tnic>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-3-rick.p.edgecombe@intel.com>
 <Y0cduNYq/ml6vtxB@zn.tnic>
 <d2cb7f4d97d05036608c8b4324de17df2e2acfa7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2cb7f4d97d05036608c8b4324de17df2e2acfa7.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 13, 2022 at 12:31:38AM +0000, Edgecombe, Rick P wrote:
> Yea, I was thinking to maybe just change it to
> CONFIG_X86_USER_SHADOW_STACK in show_smap_vma_flags(). In that function
> there is already CONFIG_ARM64_BTI and CONFIG_ARM64_MTE.

I was thinking exactly the same thing. :-)

> I'm not sure if there is any aversion to having arch CONFIGs in core
> code, but it's kind of nice to have all of the potentially conflicting
> strings in once place.

Yeah, ok.

I guess you can do the CONFIG_X86_USER_SHADOW_STACK thing for the sake
of simplicity. We have *waaay* too many Kconfig symbols and we should
introduce only the least amount of new ones.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
